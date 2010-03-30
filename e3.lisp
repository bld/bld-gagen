(defpackage :bld-e3
  (:use :common-lisp :bld-ga :bld-gagen))

(in-package :bld-e3)

(defga e3 3 :spec ((se3 #(#b0)) ; scalar
		   (ve3 #(#b1 #b10 #b100)) ; vector
		   (bve3 #(#b11 #b101 #b110)) ; bivector
		   (ie3 #(#b111)) ; pseudoscalar
		   (mve3 #(#b0 #b1 #b10 #b100 #b11 #b101 #b110 #b111)) ; multivector
		   (re3 #(#b0 #b11 #b101 #b110)))) ; spinor/rotor

(defgamethodsall e3 :vector ve3 :spinor re3)
