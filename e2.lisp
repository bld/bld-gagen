(defpackage :bld-e2
  (:use :common-lisp :bld-ga :bld-gagen))

(in-package :bld-e2)

(defga e2 2 :spec ((se2 #(#b0)) ; scalar
		   (ve2 #(#b1 #b10)) ; vector
		   (bve2 #(#b11)) ; bivector/pseudoscalar
		   (mve2 #(#b0 #b1 #b10 #b11)) ; multivector
		   (re2 #(#b0 #b11)))) ; spinor/rotor

(defgamethodsall e2 ve2 re2)

