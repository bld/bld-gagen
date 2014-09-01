;; Generate Euclidean 2 dimensional geometric algebra ASDF files

(in-package :bld-gagen)

(defg e2 (e1 e2))

(defparameter *e2spec*
  (cons (parentspec 'e2)
	'((se2 s) ; scalar
	  (ve2 e1 e2) ; vector
	  (bve2 e1e2) ; bivector/pseudoscalar
	  (re2 s e1e2))))
(with-maxima
  (write-ga-files
   :package 'bld-e2
   :parent 'e2
   :dim 2
   :spec *e2spec*
   :path "bld-e2" ; directory to write files to
   :vector 've2
   :spinor 're2
   :author "Benjamin L. Diedrich" 
   :license "MIT" 
   :description "Euclidean 2D geometric algebra"))
