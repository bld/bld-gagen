(in-package :bld-gagen)

(export '(defga
	  defgamethod
	  defgamethods1
	  defgamethods2
	  defgamethods3
	  defgamethodsall1
	  defgamethodsall2
	  defgamethodsall))

(defun make-gaobj (parent sym class)
  "Make symbolic GA object of given symbol and specialized child class"
  (let* ((ptmp (make-instance parent))
	 (bitmap (second (assoc class (spec ptmp)))))
    (if (or (equal class 'float) (equal class 'integer) (equal class 'number))
	sym
	(loop for b across bitmap
	   do (setf (gref ptmp b) `(gref ,sym ,b))))
    ptmp))

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

(defun find-spec (g)
  "Given a parent GA object and hash-table of bitmaps, return the hash-table key with corresponding bitmap of minimum length that matched non-zero/symbolic coefficients of the GA object. This is the name of a specialized GA class."
  (with-slots (spec) g
    (loop for name in (find-specs (non-zero-basis-bitmaps g) spec)
       for namemin = name
       then (if (< (length (second (assoc name spec)))
		   (length (second (assoc namemin spec))))
		name
		namemin)
       finally (return namemin))))

(defun make-args (num)
  "Make argument symbols as 'g appended to number"
  (loop for n from 1 upto num
     collect (build-symbol g (:< n))))

(defmacro defgamethod (parent fun &rest classes)
  "Define a geometric algebra method given name of generic function and list of classes for each argument"
  (let* ((args (make-args (length classes)))
	 (gaobjs (mapcar #'(lambda (arg class) (make-gaobj parent arg class)) args classes))
	 (res (apply fun gaobjs))
	 (resclass (when (typep res 'g)
		     (find-spec res)))
	 (reslist (when resclass
		    (loop for b across (second (assoc resclass (spec res)))
		       collect (gref res b)))))
    `(defmethod ,fun (,@(mapcar #'list args classes))
       ,(if resclass
	    `(make-instance ',resclass :coef (vector ,@reslist))
	    res))))

(defmacro defgamethods1 (fun classes)
  "Define geometric algebra methods of one argument for the given list of classes"
  `(progn
     ,@(loop for class in classes
	  collect `(defgamethod ,fun ,class))))

(defmacro defgamethods2 (fun classes1 classes2)
  "Define geometric algebra methods of two arguments for the given two lists of classes"
  `(progn
     ,@(loop for class1 in classes1
	  append (loop for class2 in classes2
		    collect `(defgamethod ,fun ,class1 ,class2)))))

(defmacro defgamethods3 (fun classes1 classes2 classes3)
  "Define geometric algebra methods of three arguments for the given three lists of classes"
  `(progn
     ,@(loop for class1 in classes1
	  append (loop for class2 in classes2
		    append (loop for class3 in classes3
			      collect `(defgamethod ,fun ,class1 ,class2 ,class3))))))

(defmacro defgamethods (fun &rest classlists)
  "Define geometric algebra methods of any number of arguments"
  `(,(build-symbol defgamethods (:< (length classlists))) ,fun ,@classlists))

(defun spec-classes (class)
  "Return list of classes in the spec of object of given class"
  (mapcar #'first (spec (make-instance class))))

(defun spec-bitmaps (class)
  "Return list of bitmaps of classes in the spec of object of given class"
  (mapcar #'second (spec (make-instance class))))

(defmacro defgamethodsall1 (fun parent)
  "Define geometric algebra methods of all child classes of given function and parent class"
  `(defgamethods1 ,fun ,(spec-classes parent)))

(defmacro defgamethodsall2 (fun parent)
  "Define all geometric methods between all child classes of given function and parent class"
  (let ((classes (spec-classes parent)))
    `(defgamethods2 ,fun ,classes ,classes)))

;; Table of BLD-GA methods that can be auto-generated
(defparameter *gamethods-table*
  '((g2+ all all)
    (g2+ all all)
    (*gs all float)
    (/gs all float)
    (*o2 all all)
    (*g2 all all)
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
    (norme all)))

(defun find-versors (parent)
  "Return a list of versor child-classes given a parent class"
  (loop for spec in (spec-classes parent)
     for grades = (grades (make-gaobj parent 'a spec))
     when (or (every #'evenp grades)
	      (every #'oddp grades))
     collect spec))

(defun simp (expr)
  "Redefine SIMP to call SIMP-SOCKET for speed of code generation"
  (simp-socket expr))

(defun subst-unless-nil (new old tree)
  "Just return a tree if NEW argument to SUBST is NIL"
  (if new
      (subst new old tree)
      tree))

(defmacro defgamethodsall (parent &key vector spinor)
  "Define all GA methods according to the table in *GAMETHODS-TABLE* given the vector and spinor classes in the algebra"
  (let ((versors (find-versors parent))) ; find all versor classes in parent
    `(progn
       (maxima-start)
       ,@(loop for methdef in *gamethods-table* ; loop through method definitions
	    for method = (first methdef)
	    for classlists = (subst '(float) 'float ; replacing keywords with appropriate definitions
				    (subst (spec-classes parent) 'all
					   (subst-unless-nil ; only substitute spinors & vectors if provided
					    (list spinor) 'spinor
					    (subst-unless-nil 
					     (list vector) 'vector
					     (subst versors 'versor 
						    (rest methdef))))))
	    collect `(defgamethods ,method ,@classlists))
       (maxima-shutdown))))
