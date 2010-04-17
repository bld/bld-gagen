(in-package :bld-gagen)

(export '(parent
	  spec
	  child
	  lookup
	  defga))

(defclass parent (g)
  ((spec :reader spec)))

(defmacro defparent (name dim &key metric spec)
  (let* ((size (expt 2 dim))
	 (bitmap (apply #'vector (loop for b below size collect b))))
    `(defclass ,name (parent)
       ((coef :initform (make-array ,size :initial-element 0))
	(metric :allocation :class
		:initform ,(when metric `(make-metric ,metric)))
	(dimension :allocation :class
		   :initform ,dim)
	(size :allocation :class
	      :initform ,size)
	(revtable :allocation :class
		  :initform (genrevtable ,dim))
	(bitmap :allocation :class
		:initform ,bitmap)
	(spec :allocation :class
	      :initform ,(when spec `',spec))))))
(defmacro defparentfun (name dim)
  (let* ((size (expt 2 dim))
	 (bitmap (apply #'vector (loop for b below size collect b))))
    `(defgfun ,name ,bitmap)))

(defun make-lookup (psize bitmap)
  "Make lookup table for specialized GA sub-class"
  (apply #'vector (loop for i below psize
		     collect (position i bitmap))))

(defclass child ()
  ((lookup :reader lookup)
   (parent :reader parent)))

(defmacro defchildfun (child bitmap)
  (let* ((args (loop for b across bitmap
		  collect (build-symbol c (:< (format nil "~b" b)))))
	 (args-key (mapcar #'(lambda (arg) (list arg 0)) args)))
    `(defun ,child (&key ,@args-key)
       (make-instance ',child :coef
		      (make-array ,(length bitmap)
				  :element-type 'double-float
				  :initial-contents (mapcar #'(lambda (x)
								(coerce x 'double-float))
							    (list ,@args)))))))

(defmacro defchild (child parent dim bitmap)
  "Define a specialized GA class instance given name & parent class. Parent must have name as a key in it's spec hash table."
  (let ((psize (expt 2 dim))
	(size (length bitmap)))
    `(defclass ,child (,parent child)
       ((coef :initform (make-array ,size :element-type 'double-float)
	      :type (simple-array double-float (,size))) 
	(size :allocation :class
	      :initform ,size)
	(bitmap :allocation :class
		:initform ,bitmap)
	(lookup :allocation :class
		:initform ,(make-lookup psize bitmap))
	(parent :allocation :class
		:initform ',parent)))))


(defmacro defgref (child lookup)
  "Define GREF method for a child class"
  `(defmethod gref ((g ,child) (bb integer))
     (case bb
       ,@(loop for posbb across lookup
	    for i = 0 then (incf i)
	    if posbb
	    collect `(,i (aref (coef g) ,posbb))
	    else collect `(,i 0)))))

(defmacro defgrefs (dim spec)
  (let ((psize (expt 2 dim)))
    `(progn
       ,@(loop for (child bitmap) in spec
	    collect `(defgref ,child ,(make-lookup psize bitmap))))))

(defmacro defgset (child lookup)
  "Define GSET method for a child class"
  `(defmethod gset ((g ,child) (bb integer) val)
     (case bb
       ,@(loop for posbb across lookup
	    for i = 0 then (incf i)
	    when posbb
	    collect `(,i (setf (aref (coef g) ,posbb) val)))
       (t (error (format nil "Basis bitmap ~b doesn't exist in GA object of type ~a." bb ',child))))))

(defmacro defgsets (dim spec)
  (let ((psize (expt 2 dim)))
    `(progn
       ,@(loop for (child bitmap) in spec
	    collect `(defgset ,child ,(make-lookup psize bitmap))))))

(defmacro defchildren (parent dim &key spec)
  "Define a specialized GA subspec of symbolic parent class given bitmap"
  `(progn
     ,@(loop for (child bitmap) in spec
	  collect `(defchild ,child ,parent ,dim ,bitmap)
	  collect `(defchildfun ,child ,bitmap))))


(defmacro defga (parent dim &key metric spec)
  `(progn
     (defparent ,parent ,dim :metric ,metric :spec ,spec)
     (defparentfun ,parent ,dim)
     (defchildren ,parent ,dim :spec ,spec)
     (defgrefs ,dim ,spec)
     (defgsets ,dim ,spec)))
