;; Generate Euclidean 3 dimensional geometric algebra ASDF files

(in-package :bld-gagen)

(defg e3 3)

(defparameter *e3spec* 
  '((e3 #(0 1 2 3 4 5 6 7)) ; multivector (i.e. parent) class
    (se3 #(#b0)) ; scalar
    (ve3 #(#b1 #b10 #b100)) ; vector
    (bve3 #(#b11 #b101 #b110)) ; bivector/pseudoscalar
    (ie3 #(#b111)) ; trivector/pseudoscalar
    (re3 #(#b0 #b11 #b101 #b110)))) ; spinor/rotor

(defmethod *x2 ((g1 g) (g2 g)) ; Cross product
  (dual (*o2 g1 g2)))

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
	       (write-gamethod 'e3 '*x2 *e3spec* 've3 've3))
 :exports '(*x2))
