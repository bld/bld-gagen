(in-package :bld-gagen)

;; e.g. E2, E3

(defga e2 2 :spec ((se2 #(0))
		   (ve2 #(1 2))
		   (bve2 #(3))
		   (mve2 #(0 1 2 3))
		   (re2 #(0 3))))
;;(defgamethods e2)
;;(defrefl e2 ve2)
;;(defrot e2 re2)
;;(defspin e2 re2)

(defga e3 3 :spec ((se3 #(0))
		   (ve3 #(#b1 #b10 #b100))
		   (bve3 #(#b110 #b101 #b11))
		   (ie3 #(#b111))
		   (mve3 #(0 #b1 #b10 #b100 #b110 #b101 #b11))
		   (re3 #(0 #b110 #b101 #b11))))
;;(defgamethods e3)
;;(defrefl e3 ve3)
;;(defrot e3 re3)
;;(defspin e3 re3)

(defga c2 4 
  :metric #2a((0d0 0d0 0d0 -1d0)
	      (0d0 1d0 0d0 0d0)
	      (0d0 0d0 1d0 0d0)
	      (-1d0 0d0 0d0 0d0))
  :spec ((mvc2 #(0
		 #b1 #b10 #b100 #b1000
		 #b11 #b101 #b110 #b1010 #b1100 #b1001
		 #b1110 #b1011 #b1101 #b111
		 #b1111))
	 (noc2 #(#b1))
	 (e1c2 #(#b10))
	 (e2c2 #(#b100))
	 (nic2 #(#b1000))
	 (pointc2 #(#b1 #b10 #b100 #b1000))
	 (flatpointpc2 #(#b1010 #b1100 #b1001))
	 (pointpairc2 #(#b11 #b101 #b110 #b1010 #b1100 #b1001))))
