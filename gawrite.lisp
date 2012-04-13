;; Use BLD-GAGEN to WRITE lisp code that can be standalone compiled without Maxima or all the dependencies

(in-package :bld-gagen)

;; Helper function

(defun specref (class spec)
  "Reference a spec by class, returning the corresponding vector of basis bitmaps."
  (second (assoc class spec)))

;; System definition file

(defun write-asd-code (package &key author version maintainer license description)
  "Generate code for the .asd file given package name and, optionally, other fields."
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
	:depends-on ("bld-gen" "bld-ga")
	:components
	((:file "package")
	 (:file "mv" :depends-on ("package"))
	 (:file "ga" :depends-on ("mv")))))))

;; Package file code

(defun write-package-code (package parent spec &optional exports)
  "Generate package.lisp file given package name, parent class, spec, and optionally list of functions to export."
  `((defpackage ,package
      (:use :cl :bld-ga)
      (:shadowing-import-from :bld-gen
			      + - * / expt
			      sin cos tan
			      atan asin acos
			      sinh cosh tanh
			      asinh acosh atanh
			      log exp sqrt abs
			      min max signum)
      (:export ,(make-keyword parent)
	       ,@(mapcar #'(lambda (line) (make-keyword (first line))) spec)
	       ,@(when exports (mapcar #'make-keyword exports))))))

;; Multivector definition file code

(defun write-parent (parent dim &key metric spec 
		     &aux (size (expt 2 dim)) (bitmap (specref parent spec)))
  "Generate parent class definition."
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
  "Generate function to create parent class."
  (let* ((args (loop for b across bitmap
		  collect (build-symbol c (:< (format nil "~b" b)))))
	 (args-key (loop for arg in args collect (list arg 0))))
    `(defun ,class (&key ,@args-key)
       (make-instance ',class :coef (vector ,@args)))))

(defun write-child-gfuns (spec)
  "Generate function to create child classes."
  (loop for (child bitmap) in spec
     collect (write-gfun child bitmap)))

(defun write-child (child parent dim bitmap 
		    &aux (psize (expt 2 dim)) (size (length bitmap)))
  "Generate one child class definition."
  `(defclass ,child (,parent)
     ((coef :initform (make-array ,size :initial-element 0))
      (size :allocation :class
	    :initform ,size)
      (bitmap :allocation :class
	      :initform ,bitmap))))

(defun write-children (parent dim spec)
  "Generate class definitions for child classes."
  (loop for (child bitmap) in spec
     unless (equal child parent)
     collect (write-child child parent dim bitmap)))

(defun write-gref (child dim bitmap &aux (psize (expt 2 dim)))
  "Define gref method for a child class."
  `(defmethod gref ((g ,child) (bb integer))
     (case bb
       ,@(loop for i below psize
	    for posbb = (position i bitmap)
	    if posbb
	    collect `(,i (aref (coef g) ,posbb))
	    else collect `(,i 0)))))

(defun write-grefs (dim spec)
  "Define gref methods for child classes."
  (loop for (child bitmap) in spec
     collect (write-gref child dim bitmap)))

(defun write-gset (child dim bitmap &aux (psize (expt 2 dim)))
  "Define gset method for child class."
  `(defmethod gset ((g ,child) (bb integer) val)
     (case bb
       ,@(loop for i below psize
	    for posbb = (position i bitmap)
	    when posbb
	    collect `(,i (setf (aref (coef g) ,posbb) val)))
       (t (error (format nil ,(format nil "Basis bitmap ~~b doesn't exist in GA object of type ~a." child) bb))))))

(defun write-gsets (dim spec)
  "Define gset methods for child classes."
  (loop for (child bitmap) in spec
     collect (write-gset child dim bitmap)))

(defun write-mv-code (parent dim pkgname spec &key metric &aux (psize (expt 2 dim)))
  "Generate mv.lisp code."
  `((in-package ,(make-keyword pkgname))
    ,(write-parent parent dim :metric metric :spec spec)
    ,@(write-children parent dim spec)
    ,@(write-child-gfuns spec)
    ,@(write-grefs dim spec)
    ,@(write-gsets dim spec)))

(defun write-ga-file (filespec code)
  "Write a list of code definitions to specified file spec."
  (with-open-file (stream filespec :direction :output)
    (dolist (line code)
      (print line stream))))

;; Geometric algebra method code

(defun make-gaobj (parent sym class spec)
  "Make symbolic GA object of given symbol and specialized child class"
  (if (or (equal class 'integer) (equal class 'number))
      sym
      (let ((ptmp (make-instance parent))
	    (bitmap (specref class spec)))
        (loop for b across bitmap
           do (setf (gref ptmp b) `(gref ,sym ,b)))
	ptmp)))

(defun make-gaobjs (parent args classes spec)
  "Make list of GA objects given parent class, list of arg symbols, child classes, and GA spec."
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
  (let* ((args (make-args (length classes))) ; argument list
	 (gaobjs (make-gaobjs parent args classes spec)) ; GA objects corresponding to arg list
	 (res-tmp (delay (apply fun gaobjs))) ; result before simplification
	 (res (if (typep res-tmp 'g) ; result after simplification
		  (make-instance ; result is GA object...
		   (type-of res-tmp)
		   :coef (apply #'vector (apply #'simp-exprs (coerce (coef res-tmp) 'list))))
		  (simp res-tmp))) ; ...otherwise scalar
	 (resclass (when (typep res 'g) ; class of the result, nil if non-GA object (scalar)
		     (find-spec res spec)))
	 (reslist (when resclass ; list of coefficients corresponding to result class
		    (loop for b across (specref resclass spec)
		       collect (gref res b)))))
    `(defmethod ,fun (,@(mapcar #'list args classes))
       ,(if resclass
	    `(make-instance ',resclass :coef (vector ,@reslist))
	    res))))

(defun write-gamethods1 (parent fun spec classes)
  "Write geometric algebra methods of one argument for the given list of classes"
  (loop for class in classes
     collect (write-gamethod parent fun spec class)))

(defun write-gamethods2 (parent fun spec classes1 classes2)
  "Generate GA methods for function of 2 arguments."
  (loop for class1 in classes1
     append (loop for class2 in classes2
	       collect (write-gamethod parent fun spec class1 class2))))

(defun write-gamethods3 (parent fun spec classes1 classes2 classes3)
  "Generate GA methods for functions of 3 arguments."
  (loop for class1 in classes1
     append (loop for class2 in classes2
	       append (loop for class3 in classes3 
			 collect (write-gamethod parent fun spec class1 class2 class3)))))

(defun write-gamethods (parent fun spec classes1 &optional classes2 classes3)
  "Generate GA methods for a function."
  (cond
    (classes3 (write-gamethods3 parent fun spec classes1 classes2 classes3))
    (classes2 (write-gamethods2 parent fun spec classes1 classes2))
    (classes1 (write-gamethods1 parent fun spec classes1))))    

(defun spec-classes (spec)
  "Return list of classes in a spec."
  (mapcar #'first spec))

(defun spec-bitmaps (spec)
  "Return list of bitmap vectors from a spec."
  (mapcar #'second spec))

(defun write-gamethodsall1 (parent fun spec)
  "Generate all one-argument methods for given parent class, function, and spec."
  (write-gamethods1 parent fun spec (spec-classes spec)))

(defun write-gamethodsall2 (parent fun spec)
  "Generate all two-argument methods for given parent class, function, and spec."
  (let ((classes (spec-classes spec)))
    (write-gamethods2 parent fun spec classes classes)))

(defparameter *gamethods-table*
  '((*o2 all all)
    (*g2 all all)
    (*g3 all all all)
    (*i2 all all)
    (*c2 all all)
    (*s2 all all)
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
    (cube all)
    (bld-gen::two+ all all)
    (bld-gen::two+ all number)
    (bld-gen::two+ number all)
    (bld-gen::one- all)
    (bld-gen::two- all all)
    (bld-gen::two- all number)
    (bld-gen::two- number all)
    (bld-gen::two* all number)
    (bld-gen::two* number all)
    (bld-gen::two/ all number))
  "List of geometric algebra methods for automatically generating GA methods
Format for each definition is: (method class &optional class)
class is one of all for all GA types (including scalars), number for scalar number, and versor/spinor/vector for one of those.
Second class is given for functions with more than 1 argument.
Generic arithmetic methods from BLD-GEN are also listed.")

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
  "Generate code for all GA methods in *gamethods-table* given parent class, sub-class spec, vector class, and spinor class."
  (let ((versors (find-versors parent spec)))
    (loop for (method . def) in *gamethods-table*
       for classlists = (subst '(number) 'number
			       (subst (spec-classes spec) 'all
				      (subst-unless-nil
				       (list spinor) 'spinor
				       (subst-unless-nil
					(list vector) 'vector
					(subst versors 'versor
					       def)))))
       append (apply #'write-gamethods parent method spec classlists))))

(defun write-graden-n (parent spec grade)
  "Write method for GRADEN specialized on the grade N to return a GA object from SPEC"
  (let* ((gaobj (make-gaobj parent 'g parent spec))
	 (res (graden gaobj grade))
	 (resclass (find-spec res spec))
	 (reslist (when resclass
		    (loop for b across (specref resclass spec)
		       collect (gref res b)))))
    `(defmethod graden ((g ,parent) (n (eql ,grade)))
       (make-instance ',resclass :coef (vector ,@reslist)))))

(defun write-graden (parent spec)
  "Write GRADEN methods given PARENT class and SPEC"
  (loop for grade upto (dimension (make-instance parent))
     collect (write-graden-n parent spec grade)))

(defun write-ga-code (parent spec pkgname &key vector spinor)
  "Generate ga.lisp code"
  `((in-package ,(make-keyword pkgname))
    ,@(write-gamethodsall parent spec :vector vector :spinor spinor)
    ,@(write-graden parent spec)))

;; Put it all together

(defun write-ga-files (&key package parent dim spec path vector spinor metric author version maintainer license description gacode exports)
  "Write geometric algebra files given:
PACKAGE: package/system name
PARENT: parent GA class
DIM: dimension
SPEC: sub-GA class specifications to define methods for
PATH: directory to write files to
VECTOR (optional): vector class
SPINOR (optional): spinor class
METRIC (optional): if non-Euclidean, metric vector or 2D array
AUTHOR (optional)
VERSION (optional)
MAINTAINER (optional)
LICENSE (optional)
DESCRIPTION (optional)
GACODE (optional): list of additional code to append to ga.lisp file
EXPORTS (optional): export list of additional code"
  (assert (and package parent dim spec path)) ; these args MUST be specified
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
