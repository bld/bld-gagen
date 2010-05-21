(defpackage :bld-gagen
  (:use :cl :bld-utils :bld-ga :bld-sym))

(in-package :bld-gagen)

(defun specref (class spec)
  (let ((tmp (assoc class spec)))
    (when tmp (second tmp))))

(defun find-specs (g spec)
  (loop with gbitmap = (bitmaps g)
     for (class bitmap) in spec
     when (every #'(lambda (x) (find x bitmap)) gbitmap)
     collect class))

(defun find-spec (g spec)
  (loop for class in (find-specs g spec)
     for classmin = class then
       (if (< (length (specref class spec))
	      (length (specref classmin spec)))
	   class
	   classmin)
     finally (return classmin)))

(defun make-gaobj (parent sym class bitmap)
  "Make symbolic GA object of given symbol and specialized child class"
  (let ((gaout (make-instance parent)))
    (loop for b across bitmap
       do (setf (gref gaout b) `(gref ,sym ,b)))
    gaout))

(defun make-gaobjs (parent syms spec classes)
  (loop for class in classes
     for bitmap = (specref class spec)
     for sym in syms
     collect (if bitmap
		 (make-gaobj parent sym class bitmap)
		 sym)))

(defun make-args (num &optional (sym 'g))
  "Make argument symbols as 'g appended to number"
  (loop for n from 1 upto num
     collect (build-symbol (:< sym) (:< n))))

(defun writegamethod (parent fun spec &rest classes)
  (let* ((args (make-args (length classes)))
	 (gaobjs (make-gaobjs parent args spec classes))
	 (res (apply fun gaobjs))
	 (class (when (typep res 'g)
		  (find-spec res spec)))
	 (reslist (when class
		    (loop for b across (specref class spec)
		       collect (gref res b)))))
    `(defmethod ,fun (,@(mapcar #'list args classes))
       ,(if class
	    `(make-instance ',class :coef (vector ,@reslist))
	    res))))

(defun writegamethods1 (parent fun spec classes)
  (loop for class in classes
     collect (writegamethod parent fun spec class)))

(defun writegamethods2 (parent fun spec classes1 classes2)
  (loop for class1 in classes1
     append (loop for class2 in classes2
	       collect (writegamethod parent fun spec class1 class2))))

(defun writegamethods3 (parent fun spec classes1 classes2 classes3)
  (loop for class1 in classes1
     append (loop for class2 in classes2
	       append (loop for class3 in classes3
			 collect (writegamethod parent fun spec class1 class2 class3)))))

(defun writegamethods (parent fun spec classes1 &optional classes2 classes3)
  (cond
    (classes3 (write-gamethods3 parent fun spec classes1 classes2 classes3))
    (classes2 (write-gamethods2 parent fun spec classes1 classes2))
    (classes1 (write-gamethods1 parent fun spec classes1)))) 

(defun make-lookup (psize bitmap)
  "Make lookup table for specialized GA sub-class"
  (apply #'vector (loop for i below psize
                     collect (position i bitmap))))

(defmacro defchild (child parent dim bitmap &aux (psize (expt 2 dim)) (size (length bitmap)))
  `(defclass ,child (,parent)
     ((coef :initform (make-array ,size :initial-element 0))
      (size :allocation :class
	    :initform ,size)
      (bitmap :allocation :class
	      :initform ,bitmap)
      (lookup :allocation :class
	      :reader lookup
	      :initform ,(make-lookup psize bitmap)))))

(defmacro defchildren (parent dim spec &aux (psize (expt 2 dim)))
  `(progn
     ,@(loop for (child bitmap) in spec
	  collect (macroexpand-1 `(defchild ,child ,parent ,dim ,bitmap)))))

(defparameter *e2spec*
  '((se2 #(0))
    (ve2 #(1 2))
    (ie2 #(3))
    (re2 #(0 3))
    (mve2 #(0 1 2 3))))

(defparameter *e3spec*
  '((se3 #(0))
    (ve3 #(#b1 #b10 #b100))
    (bve3 #(#b11 #b101 #b110))
    (ie3 #(#b111))
    (re3 #(0 #b11 #b101 #b110))
    (mve3 #(0 1 2 3 4 5 6 7))))

(defg e2 2)
(defgfun e2 2)
(defg e3 3)
(defgfun e3 3)

