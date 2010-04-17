(in-package :bld-gagen)

(defparent e2 2 :spec ((se2 #(#b0)) ; scalar
		       (ve2 #(#b1 #b10)) ; vector
		       (bve2 #(#b11)) ; bivector/pseudoscalar
		       (mve2 #(#b0 #b1 #b10 #b11)) ; multivector
		       (re2 #(#b0 #b11)))) ; spinor/rotor
(defparentfun e2 2)

;;(write-ga-file "e2.lisp" 'e2 2 :spec (spec (e2)) :vector 've2 :spinor 're2)
