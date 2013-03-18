;; Generate Euclidean 2 dimensional geometric algebra ASDF files

(in-package :bld-gagen)

(defg e2 2)

(defparameter *e2spec*
  '((e2 #(0 1 2 3)) ; multivector (i.e. parent) class
    (se2 #(#b0)) ; scalar
    (ve2 #(#b1 #b10)) ; vector
    (bve2 #(#b11)) ; bivector/pseudoscalar
    (re2 #(#b0 #b11))))

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
 :description "Euclidean 2D geometric algebra")
