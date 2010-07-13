;; Use BLD-GAGEN to WRITE lisp code that can be standalone compiled without Maxima or all the dependencies

(defpackage :bld-gagen
  (:use :cl :bld-ga :bld-sym :bld-utils))

(in-package :bld-gagen)

;; Helper function

(defun specref (class spec)
  (second (assoc class spec)))

;; System definition file

(defun write-asd-code (package &key author version maintainer license description)
  (let ((syspackage (make-keyword (build-symbol (:< package) .system))))
    `((defpackage ,syspackage
	(:use :asdf :cl))
      (in-package ,syspackage)
      (defsystem ,(make-keyword package)
	:name ,(format nil "~a" package)
	,@(when author `(:author ,author))
	,@(when version `(:version ,version))
	,@(when maintainer `(:maintainer ,maintainer))
	,@(when license `(:license ,license))
	,@(when description `(:description ,description))
	:depends-on ("bld-ga")
	:components
	((:file "package")
	 (:file "mv" :depends-on ("package"))
	 (:file "ga" :depends-on ("mv")))))))

;; Package file code

(defun write-package-code (package parent spec &optional exports)
  `((defpackage ,package
      (:use :cl :bld-ga)
      (:export ,(make-keyword parent)
	       ,@(mapcar #'(lambda (line) (make-keyword (first line))) spec)
	       ,@(when exports (mapcar #'make-keyword exports))))))

;; Multivector definition file code

(defun write-parent (parent dim &key metric spec 
		     &aux (size (expt 2 dim)) (bitmap (specref parent spec)))
  `(defclass ,parent (g)
     ((coef :initform (make-array ,size :initial-element 0))
      (metric :allocation :class
	      :initform ,(when metric `(make-metric ,metric)))
      (dimension :allocation :class
		 :initform ,dim)
      (size :allocation :class
	    :initform ,size)
      (revtable :allocation :class
		:initform ,(genrevtable dim))
      (bitmap :allocation :class
	      :initform ,bitmap))))

(defun write-gfun (class bitmap)
  (let* ((args (loop for b across bitmap
		  collect (build-symbol c (:< (format nil "~b" b)))))
	 (args-key (loop for arg in args collect (list arg 0))))
    `(defun ,class (&key ,@args-key)
       (make-instance ',class :coef (vector ,@args)))))

(defun write-child-gfuns (spec)
  (loop for (child bitmap) in spec
     collect (write-gfun child bitmap)))

(defun make-lookup (psize bitmap)
  "Make lookup table for specialized GA sub-class"
  (apply #'vector (loop for i below psize
                     collect (position i bitmap))))

(defun write-child (child parent dim bitmap 
		    &aux (psize (expt 2 dim)) (size (length bitmap)))
  `(defclass ,child (,parent)
     ((coef :initform (make-array ,size :initial-element 0))
      (size :allocation :class
	    :initform ,size)
      (bitmap :allocation :class
	      :initform ,bitmap))))

(defun write-children (parent dim spec)
  (loop for (child bitmap) in spec
     unless (equal child parent)
     collect (write-child child parent dim bitmap)))

(defun write-gref (child lookup)
  `(defmethod gref ((g ,child) (bb integer))
     (case bb
       ,@(loop for posbb across lookup 
	    for i = 0 then (1+ i)
	    if posbb
	    collect `(,i (aref (coef g) ,posbb))
	    else collect `(,i 0)))))

(defun write-grefs (psize spec)
  (loop for (child bitmap) in spec
     collect (write-gref child (make-lookup psize bitmap))))

(defun write-gset (child lookup)
  `(defmethod gset ((g ,child) (bb integer) (val number))
     (case bb
       ,@(loop for posbb across lookup
	    for i = 0 then (1+ i)
	    when posbb
	    collect `(,i (setf (aref (coef g) ,posbb) val)))
       (t (error (format nil ,(format nil "Basis bitmap ~~b doesn't exist in GA object of type ~a." child) bb))))))

(defun write-gsets (psize spec)
  (loop for (child bitmap) in spec
     collect (write-gset child (make-lookup psize bitmap))))

(defun write-mv-code (parent dim pkgname spec &key metric &aux (psize (expt 2 dim)))
  `((in-package ,(make-keyword pkgname))
    ,(write-parent parent dim :metric metric :spec spec)
    ,@(write-children parent dim spec)
    ,@(write-child-gfuns spec)
    ,@(write-grefs psize spec)
    ,@(write-gsets psize spec)))

(defun write-ga-file (filespec code)
  (with-open-file (stream filespec :direction :output)
    (dolist (line code)
      (print line stream))))

;; Geometric algebra method code

(defun make-gaobj (parent sym class spec)
  "Make symbolic GA object of given symbol and specialized child class"
#|  (if (or (equal class 'float) (equal class 'integer) (equal class 'number))
      sym
      (let ((ptmp (make-instance parent))
	    (bitmap (specref class spec)))
        (loop for b across bitmap
           do (setf (gref ptmp b) `(gref ,sym ,b)))
	ptmp)))|#
  (cond
    ((or (equal class 'float) (equal class 'integer) (equal class 'number)) sym)
    ((and (listp class)
	  (equal (first class) 'list)
	  (numberp (second class)))
     (let ((len (second class)))
       (loop for i below len
	  collect `(elt ,sym ,i))))
    ((and (listp class)
	  (equal (first class) 'hash-table))
     (apply #'make-hash (loop for k in (rest class)
			   collect k
			   collect `(gethash ,k ,sym))))))

(defun make-gaobjs (parent args classes spec)
  (mapcar #'(lambda (arg class) (make-gaobj parent arg class spec)) args classes))

(defun find-bitmap-test (bbl bitmap)
  "Test if a list of basis bitmaps is in a bitmap"
  (every #'(lambda (bb) (find bb bitmap)) bbl))

(defun non-zero-basis-bitmaps (g)
  "Given parent GA object, return a list of basis bitmaps corresponding to non-zero or symbolic coefficients"
  (loop for b across (bitmap g)
     for c across (coef g)
     unless (and (numberp c) (zerop c))
     collect b))

(defun find-specs (bbl spec)
  "Given a list of basis-bitmaps and an alist of specialized GA sub-classes & their bitmaps, return a list of the subclass names contain them"
  (loop for (name bitmap) in spec
     when (find-bitmap-test bbl bitmap)
     collect name))

(defun find-spec (g spec)
  "Given a parent GA object and hash-table of bitmaps, return the hash-table key with corresponding bitmap of minimum length that matched non-zero/symbolic coefficients of the GA object. This is the name of a specialized GA class."
  (loop for name in (find-specs (non-zero-basis-bitmaps g) spec)
     for namemin = name
     then (if (< (length (specref name spec))
		 (length (specref namemin spec)))
	      name
	      namemin)
     finally (return namemin )))

(defun make-args (num &optional (sym 'g))
  "Make argument symbols as 'g appended to number"
  (loop for n from 1 upto num
     collect (build-symbol (:< sym) (:< n))))

(defun write-gamethod (parent fun spec &rest classes)
  "Define a geometric algebra method given name of generic function and list of classes for each argument"
  (let* ((args (make-args (length classes)))
	 (gaobjs (make-gaobjs parent args classes spec))
	 (res (apply fun gaobjs))
	 (resclass (when (typep res 'g)
		     (find-spec res spec)))
	 (reslist (when resclass
		    (loop for b across (specref resclass spec)
		       collect (gref res b)))))
    `(defmethod ,fun (,@(mapcar #'list args classes))
       ,(if resclass
	    `(make-instance ',resclass :coef (vector ,@reslist))
	    res))))

(defun write-gamethod2 (parent fun spec &rest classes)
  "Write code for optimized GA method of GA objects and scalars, including results that are GA objects, hash tables, lists, and atoms"
  (let* ((args (make-args (length classes)))
	 (gaobjs (make-gaobjs parent args classes spec))
	 (res (apply fun gaobjs))
	 (resclass (if (typep res 'g)
		       (find-spec res spec)
		       (type-of res)))
	 (reslist (when (typep res 'g)
		    (loop for b across (specref resclass spec)
		       collect (gref res b)))))
    `(defmethod ,fun (,@(mapcar #'list args classes))
       ,(typecase res
	 (g `(make-instance ',resclass :coef (vector ,@reslist)))
	 (hash-table
	  `(make-hash ,@(loop for k being the hash-keys in res
			   for v being the hash-values in res
			   collect k
			   collect v)))
	 (list `(list ,@res))
	 (t res)))))

(defun write-gamethods1 (parent fun spec classes)
  "Write geometric algebra methods of one argument for the given list of classes"
  (loop for class in classes
     collect (write-gamethod parent fun spec class)))

(defun write-gamethods2 (parent fun spec classes1 classes2)
  (loop for class1 in classes1
     append (loop for class2 in classes2
	       collect (write-gamethod parent fun spec class1 class2))))

(defun write-gamethods3 (parent fun spec classes1 classes2 classes3)
  (loop for class1 in classes1
     append (loop for class2 in classes2
	       append (loop for class3 in classes3 
			 collect (write-gamethod parent fun spec class1 class2 class3)))))

(defun write-gamethods (parent fun spec classes1 &optional classes2 classes3)
  (cond
    (classes3 (write-gamethods3 parent fun spec classes1 classes2 classes3))
    (classes2 (write-gamethods2 parent fun spec classes1 classes2))
    (classes1 (write-gamethods1 parent fun spec classes1))))    

(defun spec-classes (spec)
  (mapcar #'first spec))

(defun spec-bitmaps (spec)
  (mapcar #'second spec))

(defun write-gamethodsall1 (parent fun spec)
  (write-gamethods1 parent fun spec (spec-classes spec)))

(defun write-gamethodsall2 (parent fun spec)
  (let ((classes (spec-classes spec)))
    (write-gamethods2 parent fun spec classes classes)))

(defparameter *gamethods-table*
  '((gs+ all float)
    (g2+ all all)
    (g2+ all all)
    (*gs all float)
    (/gs all float)
    (*o2 all all)
;;    (*o3 all all all)
    (*g2 all all)
;;    (*g3 all all all)
    (*i2 all all)
;;    (*i3 all all all)
    (*c2 all all)
;;    (*c3 all all all)
    (*s2 all all)
;;    (*s3 all all all)
    (revg all)
    (invv versor)
    (refl all vector)
    (rot all spinor)
    (spin all spinor)
    (normr2 all)
    (normr all)
    (norme2 all)
    (norme all)
    (norminf all)
    (pseudoscalar all)
    (dual all)
    (unitg all)
    (oneg all)
    (square all)
    (cube all)))

(defun find-versors (parent spec)
  "Return a list of versor child-classes given a parent class"
  (loop for class in (spec-classes spec)
     for grades = (grades (make-gaobj parent 'a class spec))
     when (or (every #'evenp grades)
	      (every #'oddp grades))
     collect class))

(defun subst-unless-nil (new old tree)
  "Just return a tree if NEW argument to SUBST is NIL"
  (if new
      (subst new old tree)
      tree))

(defun write-gamethodsall (parent spec &key vector spinor)
  (let ((versors (find-versors parent spec)))
    (loop for (method . def) in *gamethods-table*
       for classlists = (subst '(float) 'float
			       (subst (spec-classes spec) 'all
				      (subst-unless-nil
				       (list spinor) 'spinor
				       (subst-unless-nil
					(list vector) 'vector
					(subst versors 'versor
					       def)))))
       append (apply #'write-gamethods parent method spec classlists))))

(defun write-ga-code (parent spec pkgname &key vector spinor)
  `((in-package ,(make-keyword pkgname))
    ,@(write-gamethodsall parent spec :vector vector :spinor spinor)))

;; Put it all together

(defun write-ga-files (package parent dim spec path &key vector spinor metric author version maintainer license description gacode exports)
  (let ((asd (write-asd-code package :author author :version version :maintainer maintainer :license license :description description))
	(pkg (write-package-code package parent spec exports))
	(mv (write-mv-code parent dim package spec :metric metric))
	(ga (write-ga-code parent spec package :vector vector :spinor spinor))
	(asdfile (concatenate 'string (string-downcase (string package)) ".asd"))
	(pkgfile "package.lisp")
	(mvfile "mv.lisp")
	(gafile "ga.lisp"))
    (write-ga-file (format nil "~a/~a" path asdfile) asd)
    (write-ga-file (format nil "~a/~a" path pkgfile) pkg)
    (write-ga-file (format nil "~a/~a" path mvfile) mv)
    (write-ga-file (format nil "~a/~a" path gafile) (append ga gacode))))
