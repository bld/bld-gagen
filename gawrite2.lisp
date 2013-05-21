;; Use BLD-GAGEN to WRITE lisp code that can be standalone compiled without Maxima or all the dependencies

(in-package :bld-gagen)

;; Helper function

(defun specref (class spec)
  "Reference a spec by class, returning the corresponding vector of basis bitmaps."
  (cdr (assoc class spec)))

(defun intern-list (l)
  (mapcar #'(lambda (li) (intern (string li))) l))

(defun bitmap-from-basisblades (basisblades parent)
  (let ((pbitmap (bitmap (make-instance parent)))
	(pbasisblades (intern-list (basisblades parent))))
    (apply #'vector (loop for bb in basisblades
		       collect (aref pbitmap (position bb pbasisblades))))))

(defun numberzerop (n)
  "Test if argument is the number 0"
  (and (numberp n) (zerop n)))

;; System definition file

(defun write-asd-code (package &key author version maintainer license description)
  "Generate code for the .asd file given package name and, optionally, other fields."
  `((asdf:defsystem ,(make-keyword package)
      :name ,(format nil "~a" package)
      ,@(when author `(:author ,author))
      ,@(when version `(:version ,version))
      ,@(when maintainer `(:maintainer ,maintainer))
      ,@(when license `(:license ,license))
      ,@(when description `(:description ,description))
      :depends-on ("bld-gen" "bld-ga")
      :serial t
      :components
      ((:file "package")
       (:file "mv")
       (:file "ga")))))

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

(defun write-parent (parent spec)
  "Generate parent class definition."
  (with-slots ((pmetric metric) 
	       dimension 
	       size 
	       revtable 
	       bitmap 
	       (punitvectors unitvectors)
	       (pbasisblades basisblades) 
	       basisbladekeys) (make-instance parent)
    (let ((metric (if (typep pmetric 'metric)
		      (slot-value pmetric 'matrix)
		      pmetric))
	  (unitvectors (mapcar #'(lambda (uv) (intern (string uv))) punitvectors))
	  (basisblades (mapcar #'(lambda (uv) (intern (string uv))) pbasisblades)))
      `(defclass ,parent (g)
	 ((coef :initform (make-array ,size :initial-element 0))
	  (metric :allocation :class
		  :initform (make-metric ,metric))
	  (dimension :allocation :class
		   :initform ,dimension)
	  (size :allocation :class
		:initform ,size)
	  (revtable :allocation :class
		    :initform ,revtable)
	  (bitmap :allocation :class
		  :initform ,bitmap)
	  (unitvectors :allocation :class
		       :initform ,unitvectors)
	  (basisblades :allocation :class
		       :initform ,basisblades)
	  (basisbladekeys :allocation :class
			  :initform ,basisbladekeys)
	  (spec :allocation :class
		:initform ',spec
		:reader spec))))))

(defun write-gfun (class &optional (bbs (basisblades (make-instance class))))
  "Generate function to create class given vector of basis blades"
  (let* ((args (map 'list #'(lambda (bb) (intern (string bb))) bbs))
	 (args-key (map 'list #'(lambda (bb) (list bb 0)) args)))
    `(defun ,class (&key ,@args-key)
       (make-instance ',class :coef (vector ,@args)))))

(defun write-gfuns (spec)
  "Generate function to create child classes."
  (loop for (class . basisblades) in spec
     collect (write-gfun class basisblades)))

(defun write-child (child parent bitmap basisblades)
  "Generate one child class definition."
  (let ((size (length bitmap)))
    `(defclass ,child (,parent)
       ((coef :initform (make-array ,size :initial-element 0))
	(size :allocation :class
	      :initform ,size)
	(bitmap :allocation :class
		:initform ,bitmap)
	(basisblades :allocation :class
		     :initform ',basisblades)))))

(defun write-children (parent spec)
  "Generate class definitions for child classes."
  (let* ((pobj (make-instance parent))
	 (pbitmap (bitmap pobj))
	 (pbasisblades (mapcar #'(lambda (bb) (intern (string bb))) (basisblades pobj))))
    (loop for (child . basisblades) in spec
       for bitmap = (apply #'vector 
			   (loop for bb in basisblades
			      collect (aref pbitmap (position bb pbasisblades))))
       unless (equal child parent)
       collect (write-child child parent bitmap basisblades))))

(defun write-gref (class basisblades)
  "Define gref method for a GA class"
  `(defmethod gref ((g ,class) (bb symbol))
     (case bb
       ,@(loop for bb in basisblades
	    for i = 0 then (incf i)
	    collect `(,(make-keyword bb) (aref (coef g) ,i)))
       (t 0))))

(defun write-grefs (spec)
  "Define gref methods for child classes."
  (loop for (class . basisblades) in spec
     collect (write-gref class basisblades)))

(defun write-gset (class basisblades)
  `(defmethod gset ((g ,class) (bb symbol) val)
     (case bb
       ,@(loop for bb in basisblades
	    for i = 0 then (incf i)
	    collect `(,(make-keyword bb) (setf (aref (coef g) ,i) val)))
       (t (error (format nil ,(format nil "Basis bitmap ~~b doesn't exist in GA object of type ~a." class) bb))))))

(defun write-gsets (spec)
  "Define gset methods for child classes."
  (loop for (class . basisblades) in spec
     collect (write-gset class basisblades)))

(defun write-mv-code (parent dim pkgname spec &key metric &aux (psize (expt 2 dim)))
  "Generate mv.lisp code."
  `((in-package ,(make-keyword pkgname))
    ,(write-parent parent spec)
    ,@(write-children parent spec)
    ,@(write-gfuns spec)
    ,@(write-grefs spec)
    ,@(write-gsets spec)))

(defun write-ga-file (filespec code)
  "Write a list of code definitions to specified file spec."
  (with-open-file (stream filespec :direction :output)
    (dolist (line code)
      (print line stream))))

;; Geometric algebra method code

(defun make-gaobj (parent sym class spec)
  "Make symbolic GA object of given symbol and specialized child class"
  (if (or (equal class 'integer) (equal class 'number) (equal class t))
      sym
      (let* ((ptmp (make-instance parent))
	     (basisblades (specref class spec)))
        (loop for bb in basisblades
	   for bbk = (make-keyword bb)
           do (gset ptmp bbk `(gref ,sym ,bbk)))
	ptmp)))

(defun make-gaobjs (parent args classes spec)
  "Make list of GA objects given parent class, list of arg symbols, child classes, and GA spec."
  (mapcar #'(lambda (arg class) (make-gaobj parent arg class spec)) args classes))

(defun find-bitmap-test (bbl bitmap)
  "Test if a list of basis bitmaps is in a bitmap"
  (every #'(lambda (bb) (find bb bitmap)) bbl))

(defun find-basisblades-test (bbl basisblades)
  "Test if one list of basis blades in contained in another"
  (every #'(lambda (bb) (find bb basisblades)) bbl))

(defun non-zero-basis-bitmaps (g)
  "Given parent GA object, return a list of basis bitmaps corresponding to non-zero or symbolic coefficients"
  (loop for b across (bitmap g)
     for c across (coef g)
     unless (and (numberp c) (zerop c))
     collect b))

(defun non-zero-basisblades (g)
  "Collect basisblades that are non-zero"
  (loopg b c g
     unless (numberzerop c)
     collect (intern (string (nth b (basisblades g))))))

(defun find-specs (bbl spec)
  "Given a list of basis blades and the specialized GA sub-classes, return a list of the subclass names contain them"
  (loop for (name . basisblades) in spec
     when (find-basisblades-test bbl basisblades)
     collect name))

(defun find-spec (g spec)
  "Given a parent GA object and spec, find the specialized GA class is matches."
  (loop for name in (find-specs (non-zero-basisblades g) spec)
     for namemin = name
     then (if (< (length (specref name spec))
		 (length (specref namemin spec)))
	      name
	      namemin)
     finally (return namemin)))

(defun make-args (num &optional (sym 'g))
  "Make argument symbols as 'g appended to number"
  (loop for n from 1 upto num
     collect (build-symbol (:< sym) (:< n))))

(defun make-result (result-temp)
  "Generate resulting object from temporary"
  (cond
    ((typep result-temp 'g) ; result is a GA object
     (make-instance
      (type-of result-temp)
      :coef (apply #'vector (apply #'simp-exprs (coerce (coef result-temp) 'list)))))
    (t (simp result-temp)))) ; otherwise scalar

(defun write-gamethod (parent fun spec &rest classes)
  "Define a geometric algebra method given name of generic function and list of classes for each argument"
  (let* ((args (make-args (length classes))) ; argument list
	 (gaobjs (make-gaobjs parent args classes spec)) ; GA objects corresponding to arg list
	 (res-tmp (delay (apply fun gaobjs))) ; result before simplification
	 (res (make-result  res-tmp)) ; result after simplification
	 (resclass (when (typep res 'g) ; class of the result, nil if non-GA object (scalar)
		     (if (find fun *transformers*) ; if FUN is a transformer, result class is class of 1st argument
			 (first classes)
			 (find-spec res spec))))
	 (reslist (when resclass ; list of coefficients corresponding to result class
		    (loop for b in (specref resclass spec)
		       collect (gref res (make-keyword b))))))
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
  (mapcar #'cdr spec))

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
    (reflectline all vector)
    (reflectplane all vector)
    (rotate all spinor)
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

(defparameter *transformers* '(rot spin refl) "Transformation methods, which return objects of the same class as the 1st argument")

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
       for classlists = (subst '(t) 'number
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
		    (loop for b in (specref resclass spec)
		       collect (gref res (make-keyword b))))))
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
  (print "Writing ASD file")
  (let ((asd (write-asd-code package :author author :version version :maintainer maintainer :license license :description description))
	(asdfile (concatenate 'string (string-downcase (string package)) ".asd")))
    (write-ga-file (format nil "~a/~a" path asdfile) asd))
  (print "Writing package file")
  (let ((pkg (write-package-code package parent spec exports))
	(pkgfile "package.lisp"))
    (write-ga-file (format nil "~a/~a" path pkgfile) pkg))
  (print "Writing MV file")
  (let ((mv (write-mv-code parent dim package spec :metric metric))
	(mvfile "mv.lisp"))
    (write-ga-file (format nil "~a/~a" path mvfile) mv))
  (print "Writing GA file")
  (let ((ga (write-ga-code parent spec package :vector vector :spinor spinor))
	(gafile "ga.lisp"))
    (write-ga-file (format nil "~a/~a" path gafile) (append ga gacode))))
