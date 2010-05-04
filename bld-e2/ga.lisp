
(IN-PACKAGE :BLD-E2) 
(DEFMETHOD GS+ ((G1 E2) (G2 FLOAT))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (+ (GREF G1 0) G2) (GREF G1 1) (GREF G1 2)
                                  (GREF G1 3)))) 
(DEFMETHOD GS+ ((G1 SE2) (G2 FLOAT))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (+ (GREF G1 0) G2)))) 
(DEFMETHOD GS+ ((G1 VE2) (G2 FLOAT))
           (MAKE-INSTANCE 'E2 :COEF (VECTOR G2 (GREF G1 1) (GREF G1 2) 0))) 
(DEFMETHOD GS+ ((G1 BVE2) (G2 FLOAT))
           (MAKE-INSTANCE 'RE2 :COEF (VECTOR G2 (GREF G1 3)))) 
(DEFMETHOD GS+ ((G1 RE2) (G2 FLOAT))
           (MAKE-INSTANCE 'RE2 :COEF (VECTOR (+ (GREF G1 0) G2) (GREF G1 3)))) 
(DEFMETHOD G2+ ((G1 E2) (G2 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0))
                                  (+ (GREF G1 1) (GREF G2 1))
                                  (+ (GREF G1 2) (GREF G2 2))
                                  (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 E2) (G2 SE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0)) (GREF G1 1)
                                  (GREF G1 2) (GREF G1 3)))) 
(DEFMETHOD G2+ ((G1 E2) (G2 VE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (GREF G1 0) (+ (GREF G1 1) (GREF G2 1))
                                  (+ (GREF G1 2) (GREF G2 2)) (GREF G1 3)))) 
(DEFMETHOD G2+ ((G1 E2) (G2 BVE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (GREF G1 0) (GREF G1 1) (GREF G1 2)
                                  (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 E2) (G2 RE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0)) (GREF G1 1)
                                  (GREF G1 2) (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 SE2) (G2 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0)) (GREF G2 1)
                                  (GREF G2 2) (GREF G2 3)))) 
(DEFMETHOD G2+ ((G1 SE2) (G2 SE2))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (+ (GREF G1 0) (GREF G2 0))))) 
(DEFMETHOD G2+ ((G1 SE2) (G2 VE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (GREF G1 0) (GREF G2 1) (GREF G2 2) 0))) 
(DEFMETHOD G2+ ((G1 SE2) (G2 BVE2))
           (MAKE-INSTANCE 'RE2 :COEF (VECTOR (GREF G1 0) (GREF G2 3)))) 
(DEFMETHOD G2+ ((G1 SE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0)) (GREF G2 3)))) 
(DEFMETHOD G2+ ((G1 VE2) (G2 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (GREF G2 0) (+ (GREF G1 1) (GREF G2 1))
                                  (+ (GREF G1 2) (GREF G2 2)) (GREF G2 3)))) 
(DEFMETHOD G2+ ((G1 VE2) (G2 SE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (GREF G2 0) (GREF G1 1) (GREF G1 2) 0))) 
(DEFMETHOD G2+ ((G1 VE2) (G2 VE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (+ (GREF G1 1) (GREF G2 1))
                                  (+ (GREF G1 2) (GREF G2 2))))) 
(DEFMETHOD G2+ ((G1 VE2) (G2 BVE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR 0 (GREF G1 1) (GREF G1 2) (GREF G2 3)))) 
(DEFMETHOD G2+ ((G1 VE2) (G2 RE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (GREF G2 0) (GREF G1 1) (GREF G1 2)
                                  (GREF G2 3)))) 
(DEFMETHOD G2+ ((G1 BVE2) (G2 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (GREF G2 0) (GREF G2 1) (GREF G2 2)
                                  (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 BVE2) (G2 SE2))
           (MAKE-INSTANCE 'RE2 :COEF (VECTOR (GREF G2 0) (GREF G1 3)))) 
(DEFMETHOD G2+ ((G1 BVE2) (G2 VE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR 0 (GREF G2 1) (GREF G2 2) (GREF G1 3)))) 
(DEFMETHOD G2+ ((G1 BVE2) (G2 BVE2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 BVE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (GREF G2 0) (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 RE2) (G2 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0)) (GREF G2 1)
                                  (GREF G2 2) (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 RE2) (G2 SE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0)) (GREF G1 3)))) 
(DEFMETHOD G2+ ((G1 RE2) (G2 VE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (GREF G1 0) (GREF G2 1) (GREF G2 2)
                                  (GREF G1 3)))) 
(DEFMETHOD G2+ ((G1 RE2) (G2 BVE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (GREF G1 0) (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 RE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0))
                                  (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 E2) (G2 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0))
                                  (+ (GREF G1 1) (GREF G2 1))
                                  (+ (GREF G1 2) (GREF G2 2))
                                  (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 E2) (G2 SE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0)) (GREF G1 1)
                                  (GREF G1 2) (GREF G1 3)))) 
(DEFMETHOD G2+ ((G1 E2) (G2 VE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (GREF G1 0) (+ (GREF G1 1) (GREF G2 1))
                                  (+ (GREF G1 2) (GREF G2 2)) (GREF G1 3)))) 
(DEFMETHOD G2+ ((G1 E2) (G2 BVE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (GREF G1 0) (GREF G1 1) (GREF G1 2)
                                  (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 E2) (G2 RE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0)) (GREF G1 1)
                                  (GREF G1 2) (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 SE2) (G2 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0)) (GREF G2 1)
                                  (GREF G2 2) (GREF G2 3)))) 
(DEFMETHOD G2+ ((G1 SE2) (G2 SE2))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (+ (GREF G1 0) (GREF G2 0))))) 
(DEFMETHOD G2+ ((G1 SE2) (G2 VE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (GREF G1 0) (GREF G2 1) (GREF G2 2) 0))) 
(DEFMETHOD G2+ ((G1 SE2) (G2 BVE2))
           (MAKE-INSTANCE 'RE2 :COEF (VECTOR (GREF G1 0) (GREF G2 3)))) 
(DEFMETHOD G2+ ((G1 SE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0)) (GREF G2 3)))) 
(DEFMETHOD G2+ ((G1 VE2) (G2 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (GREF G2 0) (+ (GREF G1 1) (GREF G2 1))
                                  (+ (GREF G1 2) (GREF G2 2)) (GREF G2 3)))) 
(DEFMETHOD G2+ ((G1 VE2) (G2 SE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (GREF G2 0) (GREF G1 1) (GREF G1 2) 0))) 
(DEFMETHOD G2+ ((G1 VE2) (G2 VE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (+ (GREF G1 1) (GREF G2 1))
                                  (+ (GREF G1 2) (GREF G2 2))))) 
(DEFMETHOD G2+ ((G1 VE2) (G2 BVE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR 0 (GREF G1 1) (GREF G1 2) (GREF G2 3)))) 
(DEFMETHOD G2+ ((G1 VE2) (G2 RE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (GREF G2 0) (GREF G1 1) (GREF G1 2)
                                  (GREF G2 3)))) 
(DEFMETHOD G2+ ((G1 BVE2) (G2 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (GREF G2 0) (GREF G2 1) (GREF G2 2)
                                  (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 BVE2) (G2 SE2))
           (MAKE-INSTANCE 'RE2 :COEF (VECTOR (GREF G2 0) (GREF G1 3)))) 
(DEFMETHOD G2+ ((G1 BVE2) (G2 VE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR 0 (GREF G2 1) (GREF G2 2) (GREF G1 3)))) 
(DEFMETHOD G2+ ((G1 BVE2) (G2 BVE2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 BVE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (GREF G2 0) (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 RE2) (G2 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0)) (GREF G2 1)
                                  (GREF G2 2) (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 RE2) (G2 SE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0)) (GREF G1 3)))) 
(DEFMETHOD G2+ ((G1 RE2) (G2 VE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (GREF G1 0) (GREF G2 1) (GREF G2 2)
                                  (GREF G1 3)))) 
(DEFMETHOD G2+ ((G1 RE2) (G2 BVE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (GREF G1 0) (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 RE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0))
                                  (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD *GS ((G1 E2) (G2 FLOAT))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (* (GREF G1 0) G2) (* (GREF G1 1) G2)
                                  (* (GREF G1 2) G2) (* (GREF G1 3) G2)))) 
(DEFMETHOD *GS ((G1 SE2) (G2 FLOAT))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (* (GREF G1 0) G2)))) 
(DEFMETHOD *GS ((G1 VE2) (G2 FLOAT))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 1) G2) (* (GREF G1 2) G2)))) 
(DEFMETHOD *GS ((G1 BVE2) (G2 FLOAT))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* (GREF G1 3) G2)))) 
(DEFMETHOD *GS ((G1 RE2) (G2 FLOAT))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (* (GREF G1 0) G2) (* (GREF G1 3) G2)))) 
(DEFMETHOD /GS ((G1 E2) (G2 FLOAT))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (* (GREF G1 0) (EXPT G2 -1))
                                  (* (GREF G1 1) (EXPT G2 -1))
                                  (* (GREF G1 2) (EXPT G2 -1))
                                  (* (GREF G1 3) (EXPT G2 -1))))) 
(DEFMETHOD /GS ((G1 SE2) (G2 FLOAT))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (* (GREF G1 0) (EXPT G2 -1))))) 
(DEFMETHOD /GS ((G1 VE2) (G2 FLOAT))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 1) (EXPT G2 -1))
                                  (* (GREF G1 2) (EXPT G2 -1))))) 
(DEFMETHOD /GS ((G1 BVE2) (G2 FLOAT))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* (GREF G1 3) (EXPT G2 -1))))) 
(DEFMETHOD /GS ((G1 RE2) (G2 FLOAT))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (* (GREF G1 0) (EXPT G2 -1))
                                  (* (GREF G1 3) (EXPT G2 -1))))) 
(DEFMETHOD *O2 ((G1 E2) (G2 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (+ (* (GREF G1 1) (GREF G2 0))
                                     (* (GREF G1 0) (GREF G2 1)))
                                  (+ (* (GREF G1 2) (GREF G2 0))
                                     (* (GREF G1 0) (GREF G2 2)))
                                  (+ (* (GREF G1 3) (GREF G2 0))
                                     (* -1 (GREF G1 2) (GREF G2 1))
                                     (* (GREF G1 1) (GREF G2 2))
                                     (* (GREF G1 0) (GREF G2 3)))))) 
(DEFMETHOD *O2 ((G1 E2) (G2 SE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 0))
                                  (* (GREF G1 3) (GREF G2 0))))) 
(DEFMETHOD *O2 ((G1 E2) (G2 VE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR 0 (* (GREF G1 0) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2))
                                  (+ (* -1 (GREF G1 2) (GREF G2 1))
                                     (* (GREF G1 1) (GREF G2 2)))))) 
(DEFMETHOD *O2 ((G1 E2) (G2 BVE2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *O2 ((G1 E2) (G2 RE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 0))
                                  (+ (* (GREF G1 3) (GREF G2 0))
                                     (* (GREF G1 0) (GREF G2 3)))))) 
(DEFMETHOD *O2 ((G1 SE2) (G2 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2))
                                  (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *O2 ((G1 SE2) (G2 SE2))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (* (GREF G1 0) (GREF G2 0))))) 
(DEFMETHOD *O2 ((G1 SE2) (G2 VE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2))))) 
(DEFMETHOD *O2 ((G1 SE2) (G2 BVE2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *O2 ((G1 SE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *O2 ((G1 VE2) (G2 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR 0 (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 0))
                                  (+ (* -1 (GREF G1 2) (GREF G2 1))
                                     (* (GREF G1 1) (GREF G2 2)))))) 
(DEFMETHOD *O2 ((G1 VE2) (G2 SE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 0))))) 
(DEFMETHOD *O2 ((G1 VE2) (G2 VE2))
           (MAKE-INSTANCE 'BVE2 :COEF
                          (VECTOR
                           (+ (* -1 (GREF G1 2) (GREF G2 1))
                              (* (GREF G1 1) (GREF G2 2)))))) 
(DEFMETHOD *O2 ((G1 VE2) (G2 BVE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *O2 ((G1 VE2) (G2 RE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 0))))) 
(DEFMETHOD *O2 ((G1 BVE2) (G2 E2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* (GREF G1 3) (GREF G2 0))))) 
(DEFMETHOD *O2 ((G1 BVE2) (G2 SE2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* (GREF G1 3) (GREF G2 0))))) 
(DEFMETHOD *O2 ((G1 BVE2) (G2 VE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *O2 ((G1 BVE2) (G2 BVE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *O2 ((G1 BVE2) (G2 RE2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* (GREF G1 3) (GREF G2 0))))) 
(DEFMETHOD *O2 ((G1 RE2) (G2 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2))
                                  (+ (* (GREF G1 3) (GREF G2 0))
                                     (* (GREF G1 0) (GREF G2 3)))))) 
(DEFMETHOD *O2 ((G1 RE2) (G2 SE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (* (GREF G1 3) (GREF G2 0))))) 
(DEFMETHOD *O2 ((G1 RE2) (G2 VE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2))))) 
(DEFMETHOD *O2 ((G1 RE2) (G2 BVE2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *O2 ((G1 RE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (+ (* (GREF G1 3) (GREF G2 0))
                                     (* (GREF G1 0) (GREF G2 3)))))) 
(DEFMETHOD *G2 ((G1 E2) (G2 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 0) (GREF G2 0))
                              (* (GREF G1 1) (GREF G2 1))
                              (* (GREF G1 2) (GREF G2 2))
                              (* -1 (GREF G1 3) (GREF G2 3)))
                           (+ (* (GREF G1 1) (GREF G2 0))
                              (* (GREF G1 0) (GREF G2 1))
                              (* (GREF G1 3) (GREF G2 2))
                              (* -1 (GREF G1 2) (GREF G2 3)))
                           (+ (* (GREF G1 2) (GREF G2 0))
                              (* -1 (GREF G1 3) (GREF G2 1))
                              (* (GREF G1 0) (GREF G2 2))
                              (* (GREF G1 1) (GREF G2 3)))
                           (+ (* (GREF G1 3) (GREF G2 0))
                              (* -1 (GREF G1 2) (GREF G2 1))
                              (* (GREF G1 1) (GREF G2 2))
                              (* (GREF G1 0) (GREF G2 3)))))) 
(DEFMETHOD *G2 ((G1 E2) (G2 SE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 0))
                                  (* (GREF G1 3) (GREF G2 0))))) 
(DEFMETHOD *G2 ((G1 E2) (G2 VE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 1) (GREF G2 1))
                              (* (GREF G1 2) (GREF G2 2)))
                           (+ (* (GREF G1 0) (GREF G2 1))
                              (* (GREF G1 3) (GREF G2 2)))
                           (+ (* -1 (GREF G1 3) (GREF G2 1))
                              (* (GREF G1 0) (GREF G2 2)))
                           (+ (* -1 (GREF G1 2) (GREF G2 1))
                              (* (GREF G1 1) (GREF G2 2)))))) 
(DEFMETHOD *G2 ((G1 E2) (G2 BVE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (* -1 (GREF G1 3) (GREF G2 3))
                                  (* -1 (GREF G1 2) (GREF G2 3))
                                  (* (GREF G1 1) (GREF G2 3))
                                  (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *G2 ((G1 E2) (G2 RE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 0) (GREF G2 0))
                              (* -1 (GREF G1 3) (GREF G2 3)))
                           (+ (* (GREF G1 1) (GREF G2 0))
                              (* -1 (GREF G1 2) (GREF G2 3)))
                           (+ (* (GREF G1 2) (GREF G2 0))
                              (* (GREF G1 1) (GREF G2 3)))
                           (+ (* (GREF G1 3) (GREF G2 0))
                              (* (GREF G1 0) (GREF G2 3)))))) 
(DEFMETHOD *G2 ((G1 SE2) (G2 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2))
                                  (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *G2 ((G1 SE2) (G2 SE2))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (* (GREF G1 0) (GREF G2 0))))) 
(DEFMETHOD *G2 ((G1 SE2) (G2 VE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2))))) 
(DEFMETHOD *G2 ((G1 SE2) (G2 BVE2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *G2 ((G1 SE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *G2 ((G1 VE2) (G2 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 1) (GREF G2 1))
                              (* (GREF G1 2) (GREF G2 2)))
                           (+ (* (GREF G1 1) (GREF G2 0))
                              (* -1 (GREF G1 2) (GREF G2 3)))
                           (+ (* (GREF G1 2) (GREF G2 0))
                              (* (GREF G1 1) (GREF G2 3)))
                           (+ (* -1 (GREF G1 2) (GREF G2 1))
                              (* (GREF G1 1) (GREF G2 2)))))) 
(DEFMETHOD *G2 ((G1 VE2) (G2 SE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 0))))) 
(DEFMETHOD *G2 ((G1 VE2) (G2 VE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 1) (GREF G2 1))
                              (* (GREF G1 2) (GREF G2 2)))
                           (+ (* -1 (GREF G1 2) (GREF G2 1))
                              (* (GREF G1 1) (GREF G2 2)))))) 
(DEFMETHOD *G2 ((G1 VE2) (G2 BVE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* -1 (GREF G1 2) (GREF G2 3))
                                  (* (GREF G1 1) (GREF G2 3))))) 
(DEFMETHOD *G2 ((G1 VE2) (G2 RE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 1) (GREF G2 0))
                              (* -1 (GREF G1 2) (GREF G2 3)))
                           (+ (* (GREF G1 2) (GREF G2 0))
                              (* (GREF G1 1) (GREF G2 3)))))) 
(DEFMETHOD *G2 ((G1 BVE2) (G2 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (* -1 (GREF G1 3) (GREF G2 3))
                                  (* (GREF G1 3) (GREF G2 2))
                                  (* -1 (GREF G1 3) (GREF G2 1))
                                  (* (GREF G1 3) (GREF G2 0))))) 
(DEFMETHOD *G2 ((G1 BVE2) (G2 SE2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* (GREF G1 3) (GREF G2 0))))) 
(DEFMETHOD *G2 ((G1 BVE2) (G2 VE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 3) (GREF G2 2))
                                  (* -1 (GREF G1 3) (GREF G2 1))))) 
(DEFMETHOD *G2 ((G1 BVE2) (G2 BVE2))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (* -1 (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD *G2 ((G1 BVE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (* -1 (GREF G1 3) (GREF G2 3))
                                  (* (GREF G1 3) (GREF G2 0))))) 
(DEFMETHOD *G2 ((G1 RE2) (G2 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 0) (GREF G2 0))
                              (* -1 (GREF G1 3) (GREF G2 3)))
                           (+ (* (GREF G1 0) (GREF G2 1))
                              (* (GREF G1 3) (GREF G2 2)))
                           (+ (* -1 (GREF G1 3) (GREF G2 1))
                              (* (GREF G1 0) (GREF G2 2)))
                           (+ (* (GREF G1 3) (GREF G2 0))
                              (* (GREF G1 0) (GREF G2 3)))))) 
(DEFMETHOD *G2 ((G1 RE2) (G2 SE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (* (GREF G1 3) (GREF G2 0))))) 
(DEFMETHOD *G2 ((G1 RE2) (G2 VE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 0) (GREF G2 1))
                              (* (GREF G1 3) (GREF G2 2)))
                           (+ (* -1 (GREF G1 3) (GREF G2 1))
                              (* (GREF G1 0) (GREF G2 2)))))) 
(DEFMETHOD *G2 ((G1 RE2) (G2 BVE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (* -1 (GREF G1 3) (GREF G2 3))
                                  (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *G2 ((G1 RE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 0) (GREF G2 0))
                              (* -1 (GREF G1 3) (GREF G2 3)))
                           (+ (* (GREF G1 3) (GREF G2 0))
                              (* (GREF G1 0) (GREF G2 3)))))) 
(DEFMETHOD *I2 ((G1 E2) (G2 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 0) (GREF G2 0))
                              (* (GREF G1 1) (GREF G2 1))
                              (* (GREF G1 2) (GREF G2 2))
                              (* -1 (GREF G1 3) (GREF G2 3)))
                           (+ (* (GREF G1 0) (GREF G2 1))
                              (* -1 (GREF G1 2) (GREF G2 3)))
                           (+ (* (GREF G1 0) (GREF G2 2))
                              (* (GREF G1 1) (GREF G2 3)))
                           (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *I2 ((G1 E2) (G2 SE2))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (* (GREF G1 0) (GREF G2 0))))) 
(DEFMETHOD *I2 ((G1 E2) (G2 VE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 1) (GREF G2 1))
                              (* (GREF G1 2) (GREF G2 2)))
                           (* (GREF G1 0) (GREF G2 1))
                           (* (GREF G1 0) (GREF G2 2)) 0))) 
(DEFMETHOD *I2 ((G1 E2) (G2 BVE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (* -1 (GREF G1 3) (GREF G2 3))
                                  (* -1 (GREF G1 2) (GREF G2 3))
                                  (* (GREF G1 1) (GREF G2 3))
                                  (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *I2 ((G1 E2) (G2 RE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 0) (GREF G2 0))
                              (* -1 (GREF G1 3) (GREF G2 3)))
                           (* -1 (GREF G1 2) (GREF G2 3))
                           (* (GREF G1 1) (GREF G2 3))
                           (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *I2 ((G1 SE2) (G2 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2))
                                  (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *I2 ((G1 SE2) (G2 SE2))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (* (GREF G1 0) (GREF G2 0))))) 
(DEFMETHOD *I2 ((G1 SE2) (G2 VE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2))))) 
(DEFMETHOD *I2 ((G1 SE2) (G2 BVE2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *I2 ((G1 SE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *I2 ((G1 VE2) (G2 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 1) (GREF G2 1))
                              (* (GREF G1 2) (GREF G2 2)))
                           (* -1 (GREF G1 2) (GREF G2 3))
                           (* (GREF G1 1) (GREF G2 3)) 0))) 
(DEFMETHOD *I2 ((G1 VE2) (G2 SE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *I2 ((G1 VE2) (G2 VE2))
           (MAKE-INSTANCE 'SE2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 1) (GREF G2 1))
                              (* (GREF G1 2) (GREF G2 2)))))) 
(DEFMETHOD *I2 ((G1 VE2) (G2 BVE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* -1 (GREF G1 2) (GREF G2 3))
                                  (* (GREF G1 1) (GREF G2 3))))) 
(DEFMETHOD *I2 ((G1 VE2) (G2 RE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* -1 (GREF G1 2) (GREF G2 3))
                                  (* (GREF G1 1) (GREF G2 3))))) 
(DEFMETHOD *I2 ((G1 BVE2) (G2 E2))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (* -1 (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD *I2 ((G1 BVE2) (G2 SE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *I2 ((G1 BVE2) (G2 VE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *I2 ((G1 BVE2) (G2 BVE2))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (* -1 (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD *I2 ((G1 BVE2) (G2 RE2))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (* -1 (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD *I2 ((G1 RE2) (G2 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 0) (GREF G2 0))
                              (* -1 (GREF G1 3) (GREF G2 3)))
                           (* (GREF G1 0) (GREF G2 1))
                           (* (GREF G1 0) (GREF G2 2))
                           (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *I2 ((G1 RE2) (G2 SE2))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (* (GREF G1 0) (GREF G2 0))))) 
(DEFMETHOD *I2 ((G1 RE2) (G2 VE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2))))) 
(DEFMETHOD *I2 ((G1 RE2) (G2 BVE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (* -1 (GREF G1 3) (GREF G2 3))
                                  (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *I2 ((G1 RE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 0) (GREF G2 0))
                              (* -1 (GREF G1 3) (GREF G2 3)))
                           (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *C2 ((G1 E2) (G2 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR 0
                                  (+ (* (GREF G1 3) (GREF G2 2))
                                     (* -1 (GREF G1 2) (GREF G2 3)))
                                  (+ (* -1 (GREF G1 3) (GREF G2 1))
                                     (* (GREF G1 1) (GREF G2 3)))
                                  (+ (* -1 (GREF G1 2) (GREF G2 1))
                                     (* (GREF G1 1) (GREF G2 2)))))) 
(DEFMETHOD *C2 ((G1 E2) (G2 SE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *C2 ((G1 E2) (G2 VE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR 0 (* (GREF G1 3) (GREF G2 2))
                                  (* -1 (GREF G1 3) (GREF G2 1))
                                  (+ (* -1 (GREF G1 2) (GREF G2 1))
                                     (* (GREF G1 1) (GREF G2 2)))))) 
(DEFMETHOD *C2 ((G1 E2) (G2 BVE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* -1 (GREF G1 2) (GREF G2 3))
                                  (* (GREF G1 1) (GREF G2 3))))) 
(DEFMETHOD *C2 ((G1 E2) (G2 RE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* -1 (GREF G1 2) (GREF G2 3))
                                  (* (GREF G1 1) (GREF G2 3))))) 
(DEFMETHOD *C2 ((G1 SE2) (G2 E2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *C2 ((G1 SE2) (G2 SE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *C2 ((G1 SE2) (G2 VE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *C2 ((G1 SE2) (G2 BVE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *C2 ((G1 SE2) (G2 RE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *C2 ((G1 VE2) (G2 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR 0 (* -1 (GREF G1 2) (GREF G2 3))
                                  (* (GREF G1 1) (GREF G2 3))
                                  (+ (* -1 (GREF G1 2) (GREF G2 1))
                                     (* (GREF G1 1) (GREF G2 2)))))) 
(DEFMETHOD *C2 ((G1 VE2) (G2 SE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *C2 ((G1 VE2) (G2 VE2))
           (MAKE-INSTANCE 'BVE2 :COEF
                          (VECTOR
                           (+ (* -1 (GREF G1 2) (GREF G2 1))
                              (* (GREF G1 1) (GREF G2 2)))))) 
(DEFMETHOD *C2 ((G1 VE2) (G2 BVE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* -1 (GREF G1 2) (GREF G2 3))
                                  (* (GREF G1 1) (GREF G2 3))))) 
(DEFMETHOD *C2 ((G1 VE2) (G2 RE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* -1 (GREF G1 2) (GREF G2 3))
                                  (* (GREF G1 1) (GREF G2 3))))) 
(DEFMETHOD *C2 ((G1 BVE2) (G2 E2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 3) (GREF G2 2))
                                  (* -1 (GREF G1 3) (GREF G2 1))))) 
(DEFMETHOD *C2 ((G1 BVE2) (G2 SE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *C2 ((G1 BVE2) (G2 VE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 3) (GREF G2 2))
                                  (* -1 (GREF G1 3) (GREF G2 1))))) 
(DEFMETHOD *C2 ((G1 BVE2) (G2 BVE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *C2 ((G1 BVE2) (G2 RE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *C2 ((G1 RE2) (G2 E2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 3) (GREF G2 2))
                                  (* -1 (GREF G1 3) (GREF G2 1))))) 
(DEFMETHOD *C2 ((G1 RE2) (G2 SE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *C2 ((G1 RE2) (G2 VE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 3) (GREF G2 2))
                                  (* -1 (GREF G1 3) (GREF G2 1))))) 
(DEFMETHOD *C2 ((G1 RE2) (G2 BVE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *C2 ((G1 RE2) (G2 RE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *S2 ((G1 E2) (G2 E2))
           (+ (* (GREF G1 0) (GREF G2 0)) (* (GREF G1 1) (GREF G2 1))
              (* (GREF G1 2) (GREF G2 2)) (* -1 (GREF G1 3) (GREF G2 3)))) 
(DEFMETHOD *S2 ((G1 E2) (G2 SE2)) (* (GREF G1 0) (GREF G2 0))) 
(DEFMETHOD *S2 ((G1 E2) (G2 VE2))
           (+ (* (GREF G1 1) (GREF G2 1)) (* (GREF G1 2) (GREF G2 2)))) 
(DEFMETHOD *S2 ((G1 E2) (G2 BVE2)) (* -1 (GREF G1 3) (GREF G2 3))) 
(DEFMETHOD *S2 ((G1 E2) (G2 RE2))
           (+ (* (GREF G1 0) (GREF G2 0)) (* -1 (GREF G1 3) (GREF G2 3)))) 
(DEFMETHOD *S2 ((G1 SE2) (G2 E2)) (* (GREF G1 0) (GREF G2 0))) 
(DEFMETHOD *S2 ((G1 SE2) (G2 SE2)) (* (GREF G1 0) (GREF G2 0))) 
(DEFMETHOD *S2 ((G1 SE2) (G2 VE2)) 0) 
(DEFMETHOD *S2 ((G1 SE2) (G2 BVE2)) 0) 
(DEFMETHOD *S2 ((G1 SE2) (G2 RE2)) (* (GREF G1 0) (GREF G2 0))) 
(DEFMETHOD *S2 ((G1 VE2) (G2 E2))
           (+ (* (GREF G1 1) (GREF G2 1)) (* (GREF G1 2) (GREF G2 2)))) 
(DEFMETHOD *S2 ((G1 VE2) (G2 SE2)) 0) 
(DEFMETHOD *S2 ((G1 VE2) (G2 VE2))
           (+ (* (GREF G1 1) (GREF G2 1)) (* (GREF G1 2) (GREF G2 2)))) 
(DEFMETHOD *S2 ((G1 VE2) (G2 BVE2)) 0) 
(DEFMETHOD *S2 ((G1 VE2) (G2 RE2)) 0) 
(DEFMETHOD *S2 ((G1 BVE2) (G2 E2)) (* -1 (GREF G1 3) (GREF G2 3))) 
(DEFMETHOD *S2 ((G1 BVE2) (G2 SE2)) 0) 
(DEFMETHOD *S2 ((G1 BVE2) (G2 VE2)) 0) 
(DEFMETHOD *S2 ((G1 BVE2) (G2 BVE2)) (* -1 (GREF G1 3) (GREF G2 3))) 
(DEFMETHOD *S2 ((G1 BVE2) (G2 RE2)) (* -1 (GREF G1 3) (GREF G2 3))) 
(DEFMETHOD *S2 ((G1 RE2) (G2 E2))
           (+ (* (GREF G1 0) (GREF G2 0)) (* -1 (GREF G1 3) (GREF G2 3)))) 
(DEFMETHOD *S2 ((G1 RE2) (G2 SE2)) (* (GREF G1 0) (GREF G2 0))) 
(DEFMETHOD *S2 ((G1 RE2) (G2 VE2)) 0) 
(DEFMETHOD *S2 ((G1 RE2) (G2 BVE2)) (* -1 (GREF G1 3) (GREF G2 3))) 
(DEFMETHOD *S2 ((G1 RE2) (G2 RE2))
           (+ (* (GREF G1 0) (GREF G2 0)) (* -1 (GREF G1 3) (GREF G2 3)))) 
(DEFMETHOD REVG ((G1 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (GREF G1 0) (GREF G1 1) (GREF G1 2)
                                  (* -1 (GREF G1 3))))) 
(DEFMETHOD REVG ((G1 SE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR (GREF G1 0)))) 
(DEFMETHOD REVG ((G1 VE2))
           (MAKE-INSTANCE 'VE2 :COEF (VECTOR (GREF G1 1) (GREF G1 2)))) 
(DEFMETHOD REVG ((G1 BVE2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* -1 (GREF G1 3))))) 
(DEFMETHOD REVG ((G1 RE2))
           (MAKE-INSTANCE 'RE2 :COEF (VECTOR (GREF G1 0) (* -1 (GREF G1 3))))) 
(DEFMETHOD INVV ((G1 SE2))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (EXPT (GREF G1 0) -1)))) 
(DEFMETHOD INVV ((G1 VE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR
                           (* (GREF G1 1)
                              (EXPT
                               (+ (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2))
                               -1))
                           (* (GREF G1 2)
                              (EXPT
                               (+ (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2))
                               -1))))) 
(DEFMETHOD INVV ((G1 BVE2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* -1 (EXPT (GREF G1 3) -1))))) 
(DEFMETHOD INVV ((G1 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR
                           (* (GREF G1 0)
                              (EXPT
                               (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 3) 2))
                               -1))
                           (* -1 (GREF G1 3)
                              (EXPT
                               (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 3) 2))
                               -1))))) 
(DEFMETHOD REFL ((G1 E2) (G2 VE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR
                           (+
                            (* (GREF G2 2)
                               (+ (* (GREF G1 3) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1))
                            (* (GREF G2 1)
                               (+ (* (GREF G1 0) (GREF G2 1))
                                  (* -1 (GREF G1 3) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1)))
                           (+
                            (* (GREF G2 2)
                               (+ (* (GREF G1 2) (GREF G2 1))
                                  (* -1 (GREF G1 1) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1))
                            (* (GREF G2 1)
                               (+ (* (GREF G1 1) (GREF G2 1))
                                  (* (GREF G1 2) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1)))
                           (+
                            (* -1 (GREF G2 1)
                               (+ (* (GREF G1 2) (GREF G2 1))
                                  (* -1 (GREF G1 1) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1))
                            (* (GREF G2 2)
                               (+ (* (GREF G1 1) (GREF G2 1))
                                  (* (GREF G1 2) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1)))
                           (+
                            (* -1 (GREF G2 1)
                               (+ (* (GREF G1 3) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1))
                            (* (GREF G2 2)
                               (+ (* (GREF G1 0) (GREF G2 1))
                                  (* -1 (GREF G1 3) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1)))))) 
(DEFMETHOD REFL ((G1 SE2) (G2 VE2))
           (MAKE-INSTANCE 'SE2 :COEF
                          (VECTOR
                           (+
                            (* (GREF G1 0) (EXPT (GREF G2 1) 2)
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1))
                            (* (GREF G1 0) (EXPT (GREF G2 2) 2)
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1)))))) 
(DEFMETHOD REFL ((G1 VE2) (G2 VE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR
                           (+
                            (* (GREF G2 2)
                               (+ (* (GREF G1 2) (GREF G2 1))
                                  (* -1 (GREF G1 1) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1))
                            (* (GREF G2 1)
                               (+ (* (GREF G1 1) (GREF G2 1))
                                  (* (GREF G1 2) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1)))
                           (+
                            (* -1 (GREF G2 1)
                               (+ (* (GREF G1 2) (GREF G2 1))
                                  (* -1 (GREF G1 1) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1))
                            (* (GREF G2 2)
                               (+ (* (GREF G1 1) (GREF G2 1))
                                  (* (GREF G1 2) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1)))))) 
(DEFMETHOD REFL ((G1 BVE2) (G2 VE2))
           (MAKE-INSTANCE 'BVE2 :COEF
                          (VECTOR
                           (+
                            (* -1 (GREF G1 3) (EXPT (GREF G2 1) 2)
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1))
                            (* -1 (GREF G1 3) (EXPT (GREF G2 2) 2)
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1)))))) 
(DEFMETHOD REFL ((G1 RE2) (G2 VE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR
                           (+
                            (* (GREF G2 2)
                               (+ (* (GREF G1 3) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1))
                            (* (GREF G2 1)
                               (+ (* (GREF G1 0) (GREF G2 1))
                                  (* -1 (GREF G1 3) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1)))
                           (+
                            (* -1 (GREF G2 1)
                               (+ (* (GREF G1 3) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1))
                            (* (GREF G2 2)
                               (+ (* (GREF G1 0) (GREF G2 1))
                                  (* -1 (GREF G1 3) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1)))))) 
(DEFMETHOD ROT ((G1 E2) (G2 RE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR
                           (+
                            (* (GREF G2 3)
                               (+ (* (GREF G1 3) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1))
                            (* (GREF G2 0)
                               (+ (* (GREF G1 0) (GREF G2 0))
                                  (* -1 (GREF G1 3) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1)))
                           (+
                            (* (GREF G2 3)
                               (+ (* (GREF G1 2) (GREF G2 0))
                                  (* -1 (GREF G1 1) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1))
                            (* (GREF G2 0)
                               (+ (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1)))
                           (+
                            (* (GREF G2 0)
                               (+ (* (GREF G1 2) (GREF G2 0))
                                  (* -1 (GREF G1 1) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1))
                            (* -1 (GREF G2 3)
                               (+ (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1)))
                           (+
                            (* (GREF G2 0)
                               (+ (* (GREF G1 3) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1))
                            (* -1 (GREF G2 3)
                               (+ (* (GREF G1 0) (GREF G2 0))
                                  (* -1 (GREF G1 3) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1)))))) 
(DEFMETHOD ROT ((G1 SE2) (G2 RE2))
           (MAKE-INSTANCE 'SE2 :COEF
                          (VECTOR
                           (+
                            (* (GREF G1 0) (EXPT (GREF G2 0) 2)
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1))
                            (* (GREF G1 0) (EXPT (GREF G2 3) 2)
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1)))))) 
(DEFMETHOD ROT ((G1 VE2) (G2 RE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR
                           (+
                            (* (GREF G2 3)
                               (+ (* (GREF G1 2) (GREF G2 0))
                                  (* -1 (GREF G1 1) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1))
                            (* (GREF G2 0)
                               (+ (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1)))
                           (+
                            (* (GREF G2 0)
                               (+ (* (GREF G1 2) (GREF G2 0))
                                  (* -1 (GREF G1 1) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1))
                            (* -1 (GREF G2 3)
                               (+ (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1)))))) 
(DEFMETHOD ROT ((G1 BVE2) (G2 RE2))
           (MAKE-INSTANCE 'BVE2 :COEF
                          (VECTOR
                           (+
                            (* (GREF G1 3) (EXPT (GREF G2 0) 2)
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1))
                            (* (GREF G1 3) (EXPT (GREF G2 3) 2)
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1)))))) 
(DEFMETHOD ROT ((G1 RE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR
                           (+
                            (* (GREF G2 3)
                               (+ (* (GREF G1 3) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1))
                            (* (GREF G2 0)
                               (+ (* (GREF G1 0) (GREF G2 0))
                                  (* -1 (GREF G1 3) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1)))
                           (+
                            (* (GREF G2 0)
                               (+ (* (GREF G1 3) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1))
                            (* -1 (GREF G2 3)
                               (+ (* (GREF G1 0) (GREF G2 0))
                                  (* -1 (GREF G1 3) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1)))))) 
(DEFMETHOD SPIN ((G1 E2) (G2 RE2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR
                           (+
                            (* (GREF G2 3)
                               (+ (* (GREF G1 3) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 3))))
                            (* (GREF G2 0)
                               (+ (* (GREF G1 0) (GREF G2 0))
                                  (* -1 (GREF G1 3) (GREF G2 3)))))
                           (+
                            (* (GREF G2 3)
                               (+ (* (GREF G1 2) (GREF G2 0))
                                  (* -1 (GREF G1 1) (GREF G2 3))))
                            (* (GREF G2 0)
                               (+ (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 3)))))
                           (+
                            (* (GREF G2 0)
                               (+ (* (GREF G1 2) (GREF G2 0))
                                  (* -1 (GREF G1 1) (GREF G2 3))))
                            (* -1 (GREF G2 3)
                               (+ (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 3)))))
                           (+
                            (* (GREF G2 0)
                               (+ (* (GREF G1 3) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 3))))
                            (* -1 (GREF G2 3)
                               (+ (* (GREF G1 0) (GREF G2 0))
                                  (* -1 (GREF G1 3) (GREF G2 3)))))))) 
(DEFMETHOD SPIN ((G1 SE2) (G2 RE2))
           (MAKE-INSTANCE 'SE2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 0) (EXPT (GREF G2 0) 2))
                              (* (GREF G1 0) (EXPT (GREF G2 3) 2)))))) 
(DEFMETHOD SPIN ((G1 VE2) (G2 RE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR
                           (+
                            (* (GREF G2 3)
                               (+ (* (GREF G1 2) (GREF G2 0))
                                  (* -1 (GREF G1 1) (GREF G2 3))))
                            (* (GREF G2 0)
                               (+ (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 3)))))
                           (+
                            (* (GREF G2 0)
                               (+ (* (GREF G1 2) (GREF G2 0))
                                  (* -1 (GREF G1 1) (GREF G2 3))))
                            (* -1 (GREF G2 3)
                               (+ (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 3)))))))) 
(DEFMETHOD SPIN ((G1 BVE2) (G2 RE2))
           (MAKE-INSTANCE 'BVE2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 3) (EXPT (GREF G2 0) 2))
                              (* (GREF G1 3) (EXPT (GREF G2 3) 2)))))) 
(DEFMETHOD SPIN ((G1 RE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR
                           (+
                            (* (GREF G2 3)
                               (+ (* (GREF G1 3) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 3))))
                            (* (GREF G2 0)
                               (+ (* (GREF G1 0) (GREF G2 0))
                                  (* -1 (GREF G1 3) (GREF G2 3)))))
                           (+
                            (* (GREF G2 0)
                               (+ (* (GREF G1 3) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 3))))
                            (* -1 (GREF G2 3)
                               (+ (* (GREF G1 0) (GREF G2 0))
                                  (* -1 (GREF G1 3) (GREF G2 3)))))))) 
(DEFMETHOD NORMR2 ((G1 E2))
           (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2)
              (EXPT (GREF G1 3) 2))) 
(DEFMETHOD NORMR2 ((G1 SE2)) (EXPT (GREF G1 0) 2)) 
(DEFMETHOD NORMR2 ((G1 VE2)) (+ (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2))) 
(DEFMETHOD NORMR2 ((G1 BVE2)) (EXPT (GREF G1 3) 2)) 
(DEFMETHOD NORMR2 ((G1 RE2)) (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 3) 2))) 
(DEFMETHOD NORMR ((G1 E2))
           (*
            (EXPT
             (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2)
                (EXPT (GREF G1 3) 2))
             (/ 1 2))
            (SIGNUM
             (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2)
                (EXPT (GREF G1 3) 2))))) 
(DEFMETHOD NORMR ((G1 SE2)) (* (ABS (GREF G1 0)) (SIGNUM (EXPT (GREF G1 0) 2)))) 
(DEFMETHOD NORMR ((G1 VE2))
           (* (EXPT (+ (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2)) (/ 1 2))
              (SIGNUM (+ (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2))))) 
(DEFMETHOD NORMR ((G1 BVE2))
           (* (ABS (GREF G1 3)) (SIGNUM (EXPT (GREF G1 3) 2)))) 
(DEFMETHOD NORMR ((G1 RE2))
           (* (EXPT (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 3) 2)) (/ 1 2))
              (SIGNUM (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 3) 2))))) 
(DEFMETHOD NORME2 ((G1 E2))
           (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2)
              (EXPT (GREF G1 3) 2))) 
(DEFMETHOD NORME2 ((G1 SE2)) (EXPT (GREF G1 0) 2)) 
(DEFMETHOD NORME2 ((G1 VE2)) (+ (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2))) 
(DEFMETHOD NORME2 ((G1 BVE2)) (EXPT (GREF G1 3) 2)) 
(DEFMETHOD NORME2 ((G1 RE2)) (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 3) 2))) 
(DEFMETHOD NORME ((G1 E2))
           (EXPT
            (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2)
               (EXPT (GREF G1 3) 2))
            (/ 1 2))) 
(DEFMETHOD NORME ((G1 SE2)) (ABS (GREF G1 0))) 
(DEFMETHOD NORME ((G1 VE2))
           (EXPT (+ (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2)) (/ 1 2))) 
(DEFMETHOD NORME ((G1 BVE2)) (ABS (GREF G1 3))) 
(DEFMETHOD NORME ((G1 RE2))
           (EXPT (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 3) 2)) (/ 1 2))) 
(DEFMETHOD NORMINF ((G1 E2))
           (MAX
            (MAX (MAX (ABS (GREF G1 0)) (ABS (GREF G1 1))) (ABS (GREF G1 2)))
            (ABS (GREF G1 3)))) 
(DEFMETHOD NORMINF ((G1 SE2)) (MAX (MAX (MAX (ABS (GREF G1 0)) 0) 0) 0)) 
(DEFMETHOD NORMINF ((G1 VE2))
           (MAX (MAX (MAX 0 (ABS (GREF G1 1))) (ABS (GREF G1 2))) 0)) 
(DEFMETHOD NORMINF ((G1 BVE2)) (MAX 0 (ABS (GREF G1 3)))) 
(DEFMETHOD NORMINF ((G1 RE2))
           (MAX (MAX (MAX (ABS (GREF G1 0)) 0) 0) (ABS (GREF G1 3)))) 
(DEFMETHOD PSEUDOSCALAR ((G1 E2)) (MAKE-INSTANCE 'BVE2 :COEF (VECTOR 1))) 
(DEFMETHOD PSEUDOSCALAR ((G1 SE2)) (MAKE-INSTANCE 'BVE2 :COEF (VECTOR 1))) 
(DEFMETHOD PSEUDOSCALAR ((G1 VE2)) (MAKE-INSTANCE 'BVE2 :COEF (VECTOR 1))) 
(DEFMETHOD PSEUDOSCALAR ((G1 BVE2)) (MAKE-INSTANCE 'BVE2 :COEF (VECTOR 1))) 
(DEFMETHOD PSEUDOSCALAR ((G1 RE2)) (MAKE-INSTANCE 'BVE2 :COEF (VECTOR 1))) 
(DEFMETHOD DUAL ((G1 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR (GREF G1 3) (GREF G1 2) (* -1 (GREF G1 1))
                                  (* -1 (GREF G1 0))))) 
(DEFMETHOD DUAL ((G1 SE2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* -1 (GREF G1 0))))) 
(DEFMETHOD DUAL ((G1 VE2))
           (MAKE-INSTANCE 'VE2 :COEF (VECTOR (GREF G1 2) (* -1 (GREF G1 1))))) 
(DEFMETHOD DUAL ((G1 BVE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR (GREF G1 3)))) 
(DEFMETHOD DUAL ((G1 RE2))
           (MAKE-INSTANCE 'RE2 :COEF (VECTOR (GREF G1 3) (* -1 (GREF G1 0))))) 
(DEFMETHOD UNITG ((G1 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR
                           (* (GREF G1 0)
                              (EXPT
                               (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 1) 2)
                                  (EXPT (GREF G1 2) 2) (EXPT (GREF G1 3) 2))
                               (/ -1 2)))
                           (* (GREF G1 1)
                              (EXPT
                               (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 1) 2)
                                  (EXPT (GREF G1 2) 2) (EXPT (GREF G1 3) 2))
                               (/ -1 2)))
                           (* (GREF G1 2)
                              (EXPT
                               (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 1) 2)
                                  (EXPT (GREF G1 2) 2) (EXPT (GREF G1 3) 2))
                               (/ -1 2)))
                           (* (GREF G1 3)
                              (EXPT
                               (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 1) 2)
                                  (EXPT (GREF G1 2) 2) (EXPT (GREF G1 3) 2))
                               (/ -1 2)))))) 
(DEFMETHOD UNITG ((G1 SE2))
           (MAKE-INSTANCE 'SE2 :COEF
                          (VECTOR (* (GREF G1 0) (EXPT (ABS (GREF G1 0)) -1))))) 
(DEFMETHOD UNITG ((G1 VE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR
                           (* (GREF G1 1)
                              (EXPT
                               (+ (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2))
                               (/ -1 2)))
                           (* (GREF G1 2)
                              (EXPT
                               (+ (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2))
                               (/ -1 2)))))) 
(DEFMETHOD UNITG ((G1 BVE2))
           (MAKE-INSTANCE 'BVE2 :COEF
                          (VECTOR (* (GREF G1 3) (EXPT (ABS (GREF G1 3)) -1))))) 
(DEFMETHOD UNITG ((G1 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR
                           (* (GREF G1 0)
                              (EXPT
                               (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 3) 2))
                               (/ -1 2)))
                           (* (GREF G1 3)
                              (EXPT
                               (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 3) 2))
                               (/ -1 2)))))) 
(DEFMETHOD ONEG ((G1 E2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 1))) 
(DEFMETHOD ONEG ((G1 SE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 1))) 
(DEFMETHOD ONEG ((G1 VE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 1))) 
(DEFMETHOD ONEG ((G1 BVE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 1))) 
(DEFMETHOD ONEG ((G1 RE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 1))) 
(DEFMETHOD SQUARE ((G1 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR
                           (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 1) 2)
                              (EXPT (GREF G1 2) 2) (* -1 (EXPT (GREF G1 3) 2)))
                           (* 2 (GREF G1 0) (GREF G1 1))
                           (* 2 (GREF G1 0) (GREF G1 2))
                           (* 2 (GREF G1 0) (GREF G1 3))))) 
(DEFMETHOD SQUARE ((G1 SE2))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (EXPT (GREF G1 0) 2)))) 
(DEFMETHOD SQUARE ((G1 VE2))
           (MAKE-INSTANCE 'SE2 :COEF
                          (VECTOR
                           (+ (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2))))) 
(DEFMETHOD SQUARE ((G1 BVE2))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (* -1 (EXPT (GREF G1 3) 2))))) 
(DEFMETHOD SQUARE ((G1 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR
                           (+ (EXPT (GREF G1 0) 2) (* -1 (EXPT (GREF G1 3) 2)))
                           (* 2 (GREF G1 0) (GREF G1 3))))) 
(DEFMETHOD CUBE ((G1 E2))
           (MAKE-INSTANCE 'E2 :COEF
                          (VECTOR
                           (+ (* 2 (GREF G1 0) (EXPT (GREF G1 1) 2))
                              (* 2 (GREF G1 0) (EXPT (GREF G1 2) 2))
                              (* (GREF G1 0)
                                 (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 1) 2)
                                    (EXPT (GREF G1 2) 2)
                                    (* -1 (EXPT (GREF G1 3) 2))))
                              (* -2 (GREF G1 0) (EXPT (GREF G1 3) 2)))
                           (+ (* 2 (EXPT (GREF G1 0) 2) (GREF G1 1))
                              (* (GREF G1 1)
                                 (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 1) 2)
                                    (EXPT (GREF G1 2) 2)
                                    (* -1 (EXPT (GREF G1 3) 2)))))
                           (+ (* 2 (EXPT (GREF G1 0) 2) (GREF G1 2))
                              (* (GREF G1 2)
                                 (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 1) 2)
                                    (EXPT (GREF G1 2) 2)
                                    (* -1 (EXPT (GREF G1 3) 2)))))
                           (+ (* 2 (EXPT (GREF G1 0) 2) (GREF G1 3))
                              (* (GREF G1 3)
                                 (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 1) 2)
                                    (EXPT (GREF G1 2) 2)
                                    (* -1 (EXPT (GREF G1 3) 2)))))))) 
(DEFMETHOD CUBE ((G1 SE2))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (EXPT (GREF G1 0) 3)))) 
(DEFMETHOD CUBE ((G1 VE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR
                           (* (GREF G1 1)
                              (+ (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2)))
                           (* (GREF G1 2)
                              (+ (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2)))))) 
(DEFMETHOD CUBE ((G1 BVE2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* -1 (EXPT (GREF G1 3) 3))))) 
(DEFMETHOD CUBE ((G1 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR
                           (+
                            (* (GREF G1 0)
                               (+ (EXPT (GREF G1 0) 2)
                                  (* -1 (EXPT (GREF G1 3) 2))))
                            (* -2 (GREF G1 0) (EXPT (GREF G1 3) 2)))
                           (+ (* 2 (EXPT (GREF G1 0) 2) (GREF G1 3))
                              (* (GREF G1 3)
                                 (+ (EXPT (GREF G1 0) 2)
                                    (* -1 (EXPT (GREF G1 3) 2)))))))) 