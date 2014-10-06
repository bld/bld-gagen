;; Generate Euclidean 3 dimensional geometric algebra ASDF files

(in-package :bld-gagen)

(defg e3 (e1 e2 e3))

(defparameter *e3spec*
  (cons (parentspec 'e3)
	'((se3 s) ; scalar
	  (ve3 e1 e2 e3) ; vector
	  (bve3 e1e2 e2e3 e1e3) ; bivector/pseudoscalar
	  (ie3 e1e2e3) ; trivector/pseudoscalar
	  (re3 s e1e2 e2e3 e1e3)))) ; spinor/rotor

(defmethod *x2 ((g1 g) (g2 g)) ; Cross product
  (dual (*o2 g1 g2)))

(with-maxima
  (write-ga-files 
   :package 'bld-e3
   :parent 'e3
   :dim 3
   :spec *e3spec*
   :path "bld-e3"
   :vector 've3
   :spinor 're3
   :author "Benjamin L. Diedrich"
   :license "MIT"
   :description "Euclidean 2D geometric algebra"
   :gacode (list '(defgeneric *x2 (v1 v2)) ; Add cross product definition to E3
		 (write-gamethod 'e3 '*x2 *e3spec* 've3 've3)
		 '(defun *x (&rest vs) (reduce #'*x2 vs))
		 (write-gamethod 'e3 '*g3-v *e3spec* 've3 've3 've3)
		 (write-gamethod 'e3 '*g3-v *e3spec* 'bve3 've3 'bve3))
   :exports '(*x2 *x)))
