(in-package :bld-gagen)

(defg e2 2)

(write-ga-files
 'bld-e2 ; package
 'e2 ; parent class
 2 ; dimension
 '((e2 #(0 1 2 3)) ; multivector (i.e. parent) class
   (se2 #(#b0)) ; scalar
   (ve2 #(#b1 #b10)) ; vector
   (bve2 #(#b11)) ; bivector/pseudoscalar
   (re2 #(#b0 #b11))) ; spinor/rotor
 "bld-e2" ; directory to write files to
 :vector 've2
 :spinor 're2
 :author "Benjamin L. Diedrich" 
 :version "0.0.1" 
 :maintainer "Benjamin L. Diedrich" 
 :license "MIT" 
 :description "Euclidean 2D geometric algebra")
