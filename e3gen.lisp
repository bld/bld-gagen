(in-package :bld-gagen)

(defg e3 3)

(defmethod *x2 ((g1 g) (g2 g))
  (dual (*o2 g1 g2)))

(let ((package 'bld-e3)
      (parent 'e3)
      (dim 3)
      (spec  '((e3 #(0 1 2 3 4 5 6 7)) ; multivector (i.e. parent) class
	       (se3 #(#b0)) ; scalar
	       (ve3 #(#b1 #b10 #b100)) ; vector
	       (bve3 #(#b11 #b101 #b110)) ; bivector/pseudoscalar
	       (ie3 #(#b111)) ; trivector/pseudoscalar
	       (re3 #(#b0 #b11 #b101 #b110)))) ; spinor/rotor
      (path "bld-e3")
      (vector 've3)
      (spinor 're3)
      (author "Benjamin L. Diedrich")
      (version "0.0.1")
      (maintainer "Benjamin L. Diedrich")
      (license "MIT")
      (description "Euclidean 2D geometric algebra"))
  (write-ga-files package parent dim spec path
		  :vector vector
		  :spinor spinor
		  :author author
		  :version version
		  :maintainer maintainer
		  :license license
		  :description description
		  :gacode (list (write-gamethod 'e3 '*x2 spec 've3 've3))
		  :exports (list 
