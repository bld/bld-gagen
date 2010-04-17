
(DEFCLASS SE2 (E2 CHILD)
          ((COEF :INITFORM (MAKE-ARRAY 1 :ELEMENT-TYPE 'DOUBLE-FLOAT) :TYPE
                 (SIMPLE-ARRAY DOUBLE-FLOAT (1)))
           (SIZE :ALLOCATION :CLASS :INITFORM 1)
           (BITMAP :ALLOCATION :CLASS :INITFORM #(0))
           (LOOKUP :ALLOCATION :CLASS :INITFORM #(0 NIL NIL NIL))
           (PARENT :ALLOCATION :CLASS :INITFORM 'E2))) 
(DEFUN SE2 (&KEY (C0 0))
  (MAKE-INSTANCE 'SE2 :COEF
                 (MAKE-ARRAY 1 :ELEMENT-TYPE 'DOUBLE-FLOAT :INITIAL-CONTENTS
                             (MAPCAR #'(LAMBDA (X) (COERCE X 'DOUBLE-FLOAT))
                                     (LIST C0))))) 
(DEFCLASS VE2 (E2 CHILD)
          ((COEF :INITFORM (MAKE-ARRAY 2 :ELEMENT-TYPE 'DOUBLE-FLOAT) :TYPE
                 (SIMPLE-ARRAY DOUBLE-FLOAT (2)))
           (SIZE :ALLOCATION :CLASS :INITFORM 2)
           (BITMAP :ALLOCATION :CLASS :INITFORM #(1 2))
           (LOOKUP :ALLOCATION :CLASS :INITFORM #(NIL 0 1 NIL))
           (PARENT :ALLOCATION :CLASS :INITFORM 'E2))) 
(DEFUN VE2 (&KEY (C1 0) (C10 0))
  (MAKE-INSTANCE 'VE2 :COEF
                 (MAKE-ARRAY 2 :ELEMENT-TYPE 'DOUBLE-FLOAT :INITIAL-CONTENTS
                             (MAPCAR #'(LAMBDA (X) (COERCE X 'DOUBLE-FLOAT))
                                     (LIST C1 C10))))) 
(DEFCLASS BVE2 (E2 CHILD)
          ((COEF :INITFORM (MAKE-ARRAY 1 :ELEMENT-TYPE 'DOUBLE-FLOAT) :TYPE
                 (SIMPLE-ARRAY DOUBLE-FLOAT (1)))
           (SIZE :ALLOCATION :CLASS :INITFORM 1)
           (BITMAP :ALLOCATION :CLASS :INITFORM #(3))
           (LOOKUP :ALLOCATION :CLASS :INITFORM #(NIL NIL NIL 0))
           (PARENT :ALLOCATION :CLASS :INITFORM 'E2))) 
(DEFUN BVE2 (&KEY (C11 0))
  (MAKE-INSTANCE 'BVE2 :COEF
                 (MAKE-ARRAY 1 :ELEMENT-TYPE 'DOUBLE-FLOAT :INITIAL-CONTENTS
                             (MAPCAR #'(LAMBDA (X) (COERCE X 'DOUBLE-FLOAT))
                                     (LIST C11))))) 
(DEFCLASS MVE2 (E2 CHILD)
          ((COEF :INITFORM (MAKE-ARRAY 4 :ELEMENT-TYPE 'DOUBLE-FLOAT) :TYPE
                 (SIMPLE-ARRAY DOUBLE-FLOAT (4)))
           (SIZE :ALLOCATION :CLASS :INITFORM 4)
           (BITMAP :ALLOCATION :CLASS :INITFORM #(0 1 2 3))
           (LOOKUP :ALLOCATION :CLASS :INITFORM #(0 1 2 3))
           (PARENT :ALLOCATION :CLASS :INITFORM 'E2))) 
(DEFUN MVE2 (&KEY (C0 0) (C1 0) (C10 0) (C11 0))
  (MAKE-INSTANCE 'MVE2 :COEF
                 (MAKE-ARRAY 4 :ELEMENT-TYPE 'DOUBLE-FLOAT :INITIAL-CONTENTS
                             (MAPCAR #'(LAMBDA (X) (COERCE X 'DOUBLE-FLOAT))
                                     (LIST C0 C1 C10 C11))))) 
(DEFCLASS RE2 (E2 CHILD)
          ((COEF :INITFORM (MAKE-ARRAY 2 :ELEMENT-TYPE 'DOUBLE-FLOAT) :TYPE
                 (SIMPLE-ARRAY DOUBLE-FLOAT (2)))
           (SIZE :ALLOCATION :CLASS :INITFORM 2)
           (BITMAP :ALLOCATION :CLASS :INITFORM #(0 3))
           (LOOKUP :ALLOCATION :CLASS :INITFORM #(0 NIL NIL 1))
           (PARENT :ALLOCATION :CLASS :INITFORM 'E2))) 
(DEFUN RE2 (&KEY (C0 0) (C11 0))
  (MAKE-INSTANCE 'RE2 :COEF
                 (MAKE-ARRAY 2 :ELEMENT-TYPE 'DOUBLE-FLOAT :INITIAL-CONTENTS
                             (MAPCAR #'(LAMBDA (X) (COERCE X 'DOUBLE-FLOAT))
                                     (LIST C0 C11))))) 
(DEFMETHOD GREF ((G SE2) (BB INTEGER))
           (CASE BB (0 (AREF (COEF G) 0)) (1 0) (2 0) (3 0))) 
(DEFMETHOD GREF ((G VE2) (BB INTEGER))
           (CASE BB (0 0) (1 (AREF (COEF G) 0)) (2 (AREF (COEF G) 1)) (3 0))) 
(DEFMETHOD GREF ((G BVE2) (BB INTEGER))
           (CASE BB (0 0) (1 0) (2 0) (3 (AREF (COEF G) 0)))) 
(DEFMETHOD GREF ((G MVE2) (BB INTEGER))
           (CASE BB
             (0 (AREF (COEF G) 0))
             (1 (AREF (COEF G) 1))
             (2 (AREF (COEF G) 2))
             (3 (AREF (COEF G) 3)))) 
(DEFMETHOD GREF ((G RE2) (BB INTEGER))
           (CASE BB (0 (AREF (COEF G) 0)) (1 0) (2 0) (3 (AREF (COEF G) 1)))) 
(DEFMETHOD GSET ((G SE2) (BB INTEGER) VAL)
           (CASE BB
             (0 (SETF (AREF (COEF G) 0) VAL))
             (T
              (ERROR
               (FORMAT NIL
                       "Basis bitmap ~b doesn't exist in GA object of type ~a."
                       BB 'SE2))))) 
(DEFMETHOD GSET ((G VE2) (BB INTEGER) VAL)
           (CASE BB
             (1 (SETF (AREF (COEF G) 0) VAL))
             (2 (SETF (AREF (COEF G) 1) VAL))
             (T
              (ERROR
               (FORMAT NIL
                       "Basis bitmap ~b doesn't exist in GA object of type ~a."
                       BB 'VE2))))) 
(DEFMETHOD GSET ((G BVE2) (BB INTEGER) VAL)
           (CASE BB
             (3 (SETF (AREF (COEF G) 0) VAL))
             (T
              (ERROR
               (FORMAT NIL
                       "Basis bitmap ~b doesn't exist in GA object of type ~a."
                       BB 'BVE2))))) 
(DEFMETHOD GSET ((G MVE2) (BB INTEGER) VAL)
           (CASE BB
             (0 (SETF (AREF (COEF G) 0) VAL))
             (1 (SETF (AREF (COEF G) 1) VAL))
             (2 (SETF (AREF (COEF G) 2) VAL))
             (3 (SETF (AREF (COEF G) 3) VAL))
             (T
              (ERROR
               (FORMAT NIL
                       "Basis bitmap ~b doesn't exist in GA object of type ~a."
                       BB 'MVE2))))) 
(DEFMETHOD GSET ((G RE2) (BB INTEGER) VAL)
           (CASE BB
             (0 (SETF (AREF (COEF G) 0) VAL))
             (3 (SETF (AREF (COEF G) 1) VAL))
             (T
              (ERROR
               (FORMAT NIL
                       "Basis bitmap ~b doesn't exist in GA object of type ~a."
                       BB 'RE2))))) 
(DEFMETHOD G2+ ((G1 SE2) (G2 SE2))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (+ (GREF G1 0) (GREF G2 0))))) 
(DEFMETHOD G2+ ((G1 SE2) (G2 VE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (GREF G1 0) (GREF G2 1) (GREF G2 2) 0))) 
(DEFMETHOD G2+ ((G1 SE2) (G2 BVE2))
           (MAKE-INSTANCE 'RE2 :COEF (VECTOR (GREF G1 0) (GREF G2 3)))) 
(DEFMETHOD G2+ ((G1 SE2) (G2 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0)) (GREF G2 1)
                                  (GREF G2 2) (GREF G2 3)))) 
(DEFMETHOD G2+ ((G1 SE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0)) (GREF G2 3)))) 
(DEFMETHOD G2+ ((G1 VE2) (G2 SE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (GREF G2 0) (GREF G1 1) (GREF G1 2) 0))) 
(DEFMETHOD G2+ ((G1 VE2) (G2 VE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (+ (GREF G1 1) (GREF G2 1))
                                  (+ (GREF G1 2) (GREF G2 2))))) 
(DEFMETHOD G2+ ((G1 VE2) (G2 BVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR 0 (GREF G1 1) (GREF G1 2) (GREF G2 3)))) 
(DEFMETHOD G2+ ((G1 VE2) (G2 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (GREF G2 0) (+ (GREF G1 1) (GREF G2 1))
                                  (+ (GREF G1 2) (GREF G2 2)) (GREF G2 3)))) 
(DEFMETHOD G2+ ((G1 VE2) (G2 RE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (GREF G2 0) (GREF G1 1) (GREF G1 2)
                                  (GREF G2 3)))) 
(DEFMETHOD G2+ ((G1 BVE2) (G2 SE2))
           (MAKE-INSTANCE 'RE2 :COEF (VECTOR (GREF G2 0) (GREF G1 3)))) 
(DEFMETHOD G2+ ((G1 BVE2) (G2 VE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR 0 (GREF G2 1) (GREF G2 2) (GREF G1 3)))) 
(DEFMETHOD G2+ ((G1 BVE2) (G2 BVE2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 BVE2) (G2 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (GREF G2 0) (GREF G2 1) (GREF G2 2)
                                  (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 BVE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (GREF G2 0) (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 MVE2) (G2 SE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0)) (GREF G1 1)
                                  (GREF G1 2) (GREF G1 3)))) 
(DEFMETHOD G2+ ((G1 MVE2) (G2 VE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (GREF G1 0) (+ (GREF G1 1) (GREF G2 1))
                                  (+ (GREF G1 2) (GREF G2 2)) (GREF G1 3)))) 
(DEFMETHOD G2+ ((G1 MVE2) (G2 BVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (GREF G1 0) (GREF G1 1) (GREF G1 2)
                                  (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 MVE2) (G2 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0))
                                  (+ (GREF G1 1) (GREF G2 1))
                                  (+ (GREF G1 2) (GREF G2 2))
                                  (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 MVE2) (G2 RE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0)) (GREF G1 1)
                                  (GREF G1 2) (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 RE2) (G2 SE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0)) (GREF G1 3)))) 
(DEFMETHOD G2+ ((G1 RE2) (G2 VE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (GREF G1 0) (GREF G2 1) (GREF G2 2)
                                  (GREF G1 3)))) 
(DEFMETHOD G2+ ((G1 RE2) (G2 BVE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (GREF G1 0) (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 RE2) (G2 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0)) (GREF G2 1)
                                  (GREF G2 2) (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 RE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0))
                                  (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 SE2) (G2 SE2))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (+ (GREF G1 0) (GREF G2 0))))) 
(DEFMETHOD G2+ ((G1 SE2) (G2 VE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (GREF G1 0) (GREF G2 1) (GREF G2 2) 0))) 
(DEFMETHOD G2+ ((G1 SE2) (G2 BVE2))
           (MAKE-INSTANCE 'RE2 :COEF (VECTOR (GREF G1 0) (GREF G2 3)))) 
(DEFMETHOD G2+ ((G1 SE2) (G2 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0)) (GREF G2 1)
                                  (GREF G2 2) (GREF G2 3)))) 
(DEFMETHOD G2+ ((G1 SE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0)) (GREF G2 3)))) 
(DEFMETHOD G2+ ((G1 VE2) (G2 SE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (GREF G2 0) (GREF G1 1) (GREF G1 2) 0))) 
(DEFMETHOD G2+ ((G1 VE2) (G2 VE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (+ (GREF G1 1) (GREF G2 1))
                                  (+ (GREF G1 2) (GREF G2 2))))) 
(DEFMETHOD G2+ ((G1 VE2) (G2 BVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR 0 (GREF G1 1) (GREF G1 2) (GREF G2 3)))) 
(DEFMETHOD G2+ ((G1 VE2) (G2 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (GREF G2 0) (+ (GREF G1 1) (GREF G2 1))
                                  (+ (GREF G1 2) (GREF G2 2)) (GREF G2 3)))) 
(DEFMETHOD G2+ ((G1 VE2) (G2 RE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (GREF G2 0) (GREF G1 1) (GREF G1 2)
                                  (GREF G2 3)))) 
(DEFMETHOD G2+ ((G1 BVE2) (G2 SE2))
           (MAKE-INSTANCE 'RE2 :COEF (VECTOR (GREF G2 0) (GREF G1 3)))) 
(DEFMETHOD G2+ ((G1 BVE2) (G2 VE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR 0 (GREF G2 1) (GREF G2 2) (GREF G1 3)))) 
(DEFMETHOD G2+ ((G1 BVE2) (G2 BVE2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 BVE2) (G2 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (GREF G2 0) (GREF G2 1) (GREF G2 2)
                                  (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 BVE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (GREF G2 0) (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 MVE2) (G2 SE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0)) (GREF G1 1)
                                  (GREF G1 2) (GREF G1 3)))) 
(DEFMETHOD G2+ ((G1 MVE2) (G2 VE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (GREF G1 0) (+ (GREF G1 1) (GREF G2 1))
                                  (+ (GREF G1 2) (GREF G2 2)) (GREF G1 3)))) 
(DEFMETHOD G2+ ((G1 MVE2) (G2 BVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (GREF G1 0) (GREF G1 1) (GREF G1 2)
                                  (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 MVE2) (G2 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0))
                                  (+ (GREF G1 1) (GREF G2 1))
                                  (+ (GREF G1 2) (GREF G2 2))
                                  (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 MVE2) (G2 RE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0)) (GREF G1 1)
                                  (GREF G1 2) (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 RE2) (G2 SE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0)) (GREF G1 3)))) 
(DEFMETHOD G2+ ((G1 RE2) (G2 VE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (GREF G1 0) (GREF G2 1) (GREF G2 2)
                                  (GREF G1 3)))) 
(DEFMETHOD G2+ ((G1 RE2) (G2 BVE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (GREF G1 0) (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 RE2) (G2 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0)) (GREF G2 1)
                                  (GREF G2 2) (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD G2+ ((G1 RE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (+ (GREF G1 0) (GREF G2 0))
                                  (+ (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD *GS ((G1 SE2) (G2 FLOAT))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (* (GREF G1 0) G2)))) 
(DEFMETHOD *GS ((G1 VE2) (G2 FLOAT))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 1) G2) (* (GREF G1 2) G2)))) 
(DEFMETHOD *GS ((G1 BVE2) (G2 FLOAT))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* (GREF G1 3) G2)))) 
(DEFMETHOD *GS ((G1 MVE2) (G2 FLOAT))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (* (GREF G1 0) G2) (* (GREF G1 1) G2)
                                  (* (GREF G1 2) G2) (* (GREF G1 3) G2)))) 
(DEFMETHOD *GS ((G1 RE2) (G2 FLOAT))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (* (GREF G1 0) G2) (* (GREF G1 3) G2)))) 
(DEFMETHOD /GS ((G1 SE2) (G2 FLOAT))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (* (GREF G1 0) (EXPT G2 -1))))) 
(DEFMETHOD /GS ((G1 VE2) (G2 FLOAT))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 1) (EXPT G2 -1))
                                  (* (GREF G1 2) (EXPT G2 -1))))) 
(DEFMETHOD /GS ((G1 BVE2) (G2 FLOAT))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* (GREF G1 3) (EXPT G2 -1))))) 
(DEFMETHOD /GS ((G1 MVE2) (G2 FLOAT))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (* (GREF G1 0) (EXPT G2 -1))
                                  (* (GREF G1 1) (EXPT G2 -1))
                                  (* (GREF G1 2) (EXPT G2 -1))
                                  (* (GREF G1 3) (EXPT G2 -1))))) 
(DEFMETHOD /GS ((G1 RE2) (G2 FLOAT))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (* (GREF G1 0) (EXPT G2 -1))
                                  (* (GREF G1 3) (EXPT G2 -1))))) 
(DEFMETHOD *O2 ((G1 SE2) (G2 SE2))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (* (GREF G1 0) (GREF G2 0))))) 
(DEFMETHOD *O2 ((G1 SE2) (G2 VE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2))))) 
(DEFMETHOD *O2 ((G1 SE2) (G2 BVE2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *O2 ((G1 SE2) (G2 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2))
                                  (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *O2 ((G1 SE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *O2 ((G1 VE2) (G2 SE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 0))))) 
(DEFMETHOD *O2 ((G1 VE2) (G2 VE2))
           (MAKE-INSTANCE 'BVE2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 1) (GREF G2 2))
                              (* -1 (GREF G1 2) (GREF G2 1)))))) 
(DEFMETHOD *O2 ((G1 VE2) (G2 BVE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *O2 ((G1 VE2) (G2 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR 0 (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 0))
                                  (+ (* (GREF G1 1) (GREF G2 2))
                                     (* -1 (GREF G1 2) (GREF G2 1)))))) 
(DEFMETHOD *O2 ((G1 VE2) (G2 RE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 0))))) 
(DEFMETHOD *O2 ((G1 BVE2) (G2 SE2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* (GREF G1 3) (GREF G2 0))))) 
(DEFMETHOD *O2 ((G1 BVE2) (G2 VE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *O2 ((G1 BVE2) (G2 BVE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *O2 ((G1 BVE2) (G2 MVE2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* (GREF G1 3) (GREF G2 0))))) 
(DEFMETHOD *O2 ((G1 BVE2) (G2 RE2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* (GREF G1 3) (GREF G2 0))))) 
(DEFMETHOD *O2 ((G1 MVE2) (G2 SE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 0))
                                  (* (GREF G1 3) (GREF G2 0))))) 
(DEFMETHOD *O2 ((G1 MVE2) (G2 VE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR 0 (* (GREF G1 0) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2))
                                  (+ (* (GREF G1 1) (GREF G2 2))
                                     (* -1 (GREF G1 2) (GREF G2 1)))))) 
(DEFMETHOD *O2 ((G1 MVE2) (G2 BVE2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *O2 ((G1 MVE2) (G2 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (+ (* (GREF G1 0) (GREF G2 1))
                                     (* (GREF G1 1) (GREF G2 0)))
                                  (+ (* (GREF G1 0) (GREF G2 2))
                                     (* (GREF G1 2) (GREF G2 0)))
                                  (+ (* (GREF G1 0) (GREF G2 3))
                                     (* (GREF G1 1) (GREF G2 2))
                                     (* -1 (GREF G1 2) (GREF G2 1))
                                     (* (GREF G1 3) (GREF G2 0)))))) 
(DEFMETHOD *O2 ((G1 MVE2) (G2 RE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 0))
                                  (+ (* (GREF G1 0) (GREF G2 3))
                                     (* (GREF G1 3) (GREF G2 0)))))) 
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
(DEFMETHOD *O2 ((G1 RE2) (G2 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2))
                                  (+ (* (GREF G1 0) (GREF G2 3))
                                     (* (GREF G1 3) (GREF G2 0)))))) 
(DEFMETHOD *O2 ((G1 RE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (+ (* (GREF G1 0) (GREF G2 3))
                                     (* (GREF G1 3) (GREF G2 0)))))) 
(DEFMETHOD *G2 ((G1 SE2) (G2 SE2))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (* (GREF G1 0) (GREF G2 0))))) 
(DEFMETHOD *G2 ((G1 SE2) (G2 VE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2))))) 
(DEFMETHOD *G2 ((G1 SE2) (G2 BVE2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *G2 ((G1 SE2) (G2 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2))
                                  (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *G2 ((G1 SE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *G2 ((G1 VE2) (G2 SE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 0))))) 
(DEFMETHOD *G2 ((G1 VE2) (G2 VE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 1) (GREF G2 1))
                              (* (GREF G1 2) (GREF G2 2)))
                           (+ (* (GREF G1 1) (GREF G2 2))
                              (* -1 (GREF G1 2) (GREF G2 1)))))) 
(DEFMETHOD *G2 ((G1 VE2) (G2 BVE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* -1 (GREF G1 2) (GREF G2 3))
                                  (* (GREF G1 1) (GREF G2 3))))) 
(DEFMETHOD *G2 ((G1 VE2) (G2 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 1) (GREF G2 1))
                              (* (GREF G1 2) (GREF G2 2)))
                           (+ (* (GREF G1 1) (GREF G2 0))
                              (* -1 (GREF G1 2) (GREF G2 3)))
                           (+ (* (GREF G1 1) (GREF G2 3))
                              (* (GREF G1 2) (GREF G2 0)))
                           (+ (* (GREF G1 1) (GREF G2 2))
                              (* -1 (GREF G1 2) (GREF G2 1)))))) 
(DEFMETHOD *G2 ((G1 VE2) (G2 RE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 1) (GREF G2 0))
                              (* -1 (GREF G1 2) (GREF G2 3)))
                           (+ (* (GREF G1 1) (GREF G2 3))
                              (* (GREF G1 2) (GREF G2 0)))))) 
(DEFMETHOD *G2 ((G1 BVE2) (G2 SE2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* (GREF G1 3) (GREF G2 0))))) 
(DEFMETHOD *G2 ((G1 BVE2) (G2 VE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 3) (GREF G2 2))
                                  (* -1 (GREF G1 3) (GREF G2 1))))) 
(DEFMETHOD *G2 ((G1 BVE2) (G2 BVE2))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (* -1 (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD *G2 ((G1 BVE2) (G2 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (* -1 (GREF G1 3) (GREF G2 3))
                                  (* (GREF G1 3) (GREF G2 2))
                                  (* -1 (GREF G1 3) (GREF G2 1))
                                  (* (GREF G1 3) (GREF G2 0))))) 
(DEFMETHOD *G2 ((G1 BVE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (* -1 (GREF G1 3) (GREF G2 3))
                                  (* (GREF G1 3) (GREF G2 0))))) 
(DEFMETHOD *G2 ((G1 MVE2) (G2 SE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 0))
                                  (* (GREF G1 3) (GREF G2 0))))) 
(DEFMETHOD *G2 ((G1 MVE2) (G2 VE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 1) (GREF G2 1))
                              (* (GREF G1 2) (GREF G2 2)))
                           (+ (* (GREF G1 0) (GREF G2 1))
                              (* (GREF G1 3) (GREF G2 2)))
                           (+ (* (GREF G1 0) (GREF G2 2))
                              (* -1 (GREF G1 3) (GREF G2 1)))
                           (+ (* (GREF G1 1) (GREF G2 2))
                              (* -1 (GREF G1 2) (GREF G2 1)))))) 
(DEFMETHOD *G2 ((G1 MVE2) (G2 BVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (* -1 (GREF G1 3) (GREF G2 3))
                                  (* -1 (GREF G1 2) (GREF G2 3))
                                  (* (GREF G1 1) (GREF G2 3))
                                  (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *G2 ((G1 MVE2) (G2 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 0) (GREF G2 0))
                              (* (GREF G1 1) (GREF G2 1))
                              (* (GREF G1 2) (GREF G2 2))
                              (* -1 (GREF G1 3) (GREF G2 3)))
                           (+ (* (GREF G1 0) (GREF G2 1))
                              (* (GREF G1 1) (GREF G2 0))
                              (* -1 (GREF G1 2) (GREF G2 3))
                              (* (GREF G1 3) (GREF G2 2)))
                           (+ (* (GREF G1 0) (GREF G2 2))
                              (* (GREF G1 1) (GREF G2 3))
                              (* (GREF G1 2) (GREF G2 0))
                              (* -1 (GREF G1 3) (GREF G2 1)))
                           (+ (* (GREF G1 0) (GREF G2 3))
                              (* (GREF G1 1) (GREF G2 2))
                              (* -1 (GREF G1 2) (GREF G2 1))
                              (* (GREF G1 3) (GREF G2 0)))))) 
(DEFMETHOD *G2 ((G1 MVE2) (G2 RE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 0) (GREF G2 0))
                              (* -1 (GREF G1 3) (GREF G2 3)))
                           (+ (* (GREF G1 1) (GREF G2 0))
                              (* -1 (GREF G1 2) (GREF G2 3)))
                           (+ (* (GREF G1 1) (GREF G2 3))
                              (* (GREF G1 2) (GREF G2 0)))
                           (+ (* (GREF G1 0) (GREF G2 3))
                              (* (GREF G1 3) (GREF G2 0)))))) 
(DEFMETHOD *G2 ((G1 RE2) (G2 SE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (* (GREF G1 3) (GREF G2 0))))) 
(DEFMETHOD *G2 ((G1 RE2) (G2 VE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 0) (GREF G2 1))
                              (* (GREF G1 3) (GREF G2 2)))
                           (+ (* (GREF G1 0) (GREF G2 2))
                              (* -1 (GREF G1 3) (GREF G2 1)))))) 
(DEFMETHOD *G2 ((G1 RE2) (G2 BVE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (* -1 (GREF G1 3) (GREF G2 3))
                                  (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *G2 ((G1 RE2) (G2 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 0) (GREF G2 0))
                              (* -1 (GREF G1 3) (GREF G2 3)))
                           (+ (* (GREF G1 0) (GREF G2 1))
                              (* (GREF G1 3) (GREF G2 2)))
                           (+ (* (GREF G1 0) (GREF G2 2))
                              (* -1 (GREF G1 3) (GREF G2 1)))
                           (+ (* (GREF G1 0) (GREF G2 3))
                              (* (GREF G1 3) (GREF G2 0)))))) 
(DEFMETHOD *G2 ((G1 RE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 0) (GREF G2 0))
                              (* -1 (GREF G1 3) (GREF G2 3)))
                           (+ (* (GREF G1 0) (GREF G2 3))
                              (* (GREF G1 3) (GREF G2 0)))))) 
(DEFMETHOD *I2 ((G1 SE2) (G2 SE2))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (* (GREF G1 0) (GREF G2 0))))) 
(DEFMETHOD *I2 ((G1 SE2) (G2 VE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2))))) 
(DEFMETHOD *I2 ((G1 SE2) (G2 BVE2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *I2 ((G1 SE2) (G2 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2))
                                  (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *I2 ((G1 SE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR (* (GREF G1 0) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 3))))) 
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
(DEFMETHOD *I2 ((G1 VE2) (G2 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 1) (GREF G2 1))
                              (* (GREF G1 2) (GREF G2 2)))
                           (* -1 (GREF G1 2) (GREF G2 3))
                           (* (GREF G1 1) (GREF G2 3)) 0))) 
(DEFMETHOD *I2 ((G1 VE2) (G2 RE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* -1 (GREF G1 2) (GREF G2 3))
                                  (* (GREF G1 1) (GREF G2 3))))) 
(DEFMETHOD *I2 ((G1 BVE2) (G2 SE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *I2 ((G1 BVE2) (G2 VE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *I2 ((G1 BVE2) (G2 BVE2))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (* -1 (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD *I2 ((G1 BVE2) (G2 MVE2))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (* -1 (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD *I2 ((G1 BVE2) (G2 RE2))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (* -1 (GREF G1 3) (GREF G2 3))))) 
(DEFMETHOD *I2 ((G1 MVE2) (G2 SE2))
           (MAKE-INSTANCE 'SE2 :COEF (VECTOR (* (GREF G1 0) (GREF G2 0))))) 
(DEFMETHOD *I2 ((G1 MVE2) (G2 VE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 1) (GREF G2 1))
                              (* (GREF G1 2) (GREF G2 2)))
                           (* (GREF G1 0) (GREF G2 1))
                           (* (GREF G1 0) (GREF G2 2)) 0))) 
(DEFMETHOD *I2 ((G1 MVE2) (G2 BVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (* -1 (GREF G1 3) (GREF G2 3))
                                  (* -1 (GREF G1 2) (GREF G2 3))
                                  (* (GREF G1 1) (GREF G2 3))
                                  (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *I2 ((G1 MVE2) (G2 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
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
(DEFMETHOD *I2 ((G1 MVE2) (G2 RE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 0) (GREF G2 0))
                              (* -1 (GREF G1 3) (GREF G2 3)))
                           (* -1 (GREF G1 2) (GREF G2 3))
                           (* (GREF G1 1) (GREF G2 3))
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
(DEFMETHOD *I2 ((G1 RE2) (G2 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 0) (GREF G2 0))
                              (* -1 (GREF G1 3) (GREF G2 3)))
                           (* (GREF G1 0) (GREF G2 1))
                           (* (GREF G1 0) (GREF G2 2))
                           (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *I2 ((G1 RE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 0) (GREF G2 0))
                              (* -1 (GREF G1 3) (GREF G2 3)))
                           (* (GREF G1 0) (GREF G2 3))))) 
(DEFMETHOD *C2 ((G1 SE2) (G2 SE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *C2 ((G1 SE2) (G2 VE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *C2 ((G1 SE2) (G2 BVE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *C2 ((G1 SE2) (G2 MVE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *C2 ((G1 SE2) (G2 RE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *C2 ((G1 VE2) (G2 SE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *C2 ((G1 VE2) (G2 VE2))
           (MAKE-INSTANCE 'BVE2 :COEF
                          (VECTOR
                           (+ (* (GREF G1 1) (GREF G2 2))
                              (* -1 (GREF G1 2) (GREF G2 1)))))) 
(DEFMETHOD *C2 ((G1 VE2) (G2 BVE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* -1 (GREF G1 2) (GREF G2 3))
                                  (* (GREF G1 1) (GREF G2 3))))) 
(DEFMETHOD *C2 ((G1 VE2) (G2 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR 0 (* -1 (GREF G1 2) (GREF G2 3))
                                  (* (GREF G1 1) (GREF G2 3))
                                  (+ (* (GREF G1 1) (GREF G2 2))
                                     (* -1 (GREF G1 2) (GREF G2 1)))))) 
(DEFMETHOD *C2 ((G1 VE2) (G2 RE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* -1 (GREF G1 2) (GREF G2 3))
                                  (* (GREF G1 1) (GREF G2 3))))) 
(DEFMETHOD *C2 ((G1 BVE2) (G2 SE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *C2 ((G1 BVE2) (G2 VE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 3) (GREF G2 2))
                                  (* -1 (GREF G1 3) (GREF G2 1))))) 
(DEFMETHOD *C2 ((G1 BVE2) (G2 BVE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *C2 ((G1 BVE2) (G2 MVE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 3) (GREF G2 2))
                                  (* -1 (GREF G1 3) (GREF G2 1))))) 
(DEFMETHOD *C2 ((G1 BVE2) (G2 RE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *C2 ((G1 MVE2) (G2 SE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *C2 ((G1 MVE2) (G2 VE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR 0 (* (GREF G1 3) (GREF G2 2))
                                  (* -1 (GREF G1 3) (GREF G2 1))
                                  (+ (* (GREF G1 1) (GREF G2 2))
                                     (* -1 (GREF G1 2) (GREF G2 1)))))) 
(DEFMETHOD *C2 ((G1 MVE2) (G2 BVE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* -1 (GREF G1 2) (GREF G2 3))
                                  (* (GREF G1 1) (GREF G2 3))))) 
(DEFMETHOD *C2 ((G1 MVE2) (G2 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR 0
                                  (+ (* -1 (GREF G1 2) (GREF G2 3))
                                     (* (GREF G1 3) (GREF G2 2)))
                                  (+ (* (GREF G1 1) (GREF G2 3))
                                     (* -1 (GREF G1 3) (GREF G2 1)))
                                  (+ (* (GREF G1 1) (GREF G2 2))
                                     (* -1 (GREF G1 2) (GREF G2 1)))))) 
(DEFMETHOD *C2 ((G1 MVE2) (G2 RE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* -1 (GREF G1 2) (GREF G2 3))
                                  (* (GREF G1 1) (GREF G2 3))))) 
(DEFMETHOD *C2 ((G1 RE2) (G2 SE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *C2 ((G1 RE2) (G2 VE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 3) (GREF G2 2))
                                  (* -1 (GREF G1 3) (GREF G2 1))))) 
(DEFMETHOD *C2 ((G1 RE2) (G2 BVE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *C2 ((G1 RE2) (G2 MVE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR (* (GREF G1 3) (GREF G2 2))
                                  (* -1 (GREF G1 3) (GREF G2 1))))) 
(DEFMETHOD *C2 ((G1 RE2) (G2 RE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR 0))) 
(DEFMETHOD *S2 ((G1 SE2) (G2 SE2)) (* (GREF G1 0) (GREF G2 0))) 
(DEFMETHOD *S2 ((G1 SE2) (G2 VE2)) 0) 
(DEFMETHOD *S2 ((G1 SE2) (G2 BVE2)) 0) 
(DEFMETHOD *S2 ((G1 SE2) (G2 MVE2)) (* (GREF G1 0) (GREF G2 0))) 
(DEFMETHOD *S2 ((G1 SE2) (G2 RE2)) (* (GREF G1 0) (GREF G2 0))) 
(DEFMETHOD *S2 ((G1 VE2) (G2 SE2)) 0) 
(DEFMETHOD *S2 ((G1 VE2) (G2 VE2))
           (+ (* (GREF G1 1) (GREF G2 1)) (* (GREF G1 2) (GREF G2 2)))) 
(DEFMETHOD *S2 ((G1 VE2) (G2 BVE2)) 0) 
(DEFMETHOD *S2 ((G1 VE2) (G2 MVE2))
           (+ (* (GREF G1 1) (GREF G2 1)) (* (GREF G1 2) (GREF G2 2)))) 
(DEFMETHOD *S2 ((G1 VE2) (G2 RE2)) 0) 
(DEFMETHOD *S2 ((G1 BVE2) (G2 SE2)) 0) 
(DEFMETHOD *S2 ((G1 BVE2) (G2 VE2)) 0) 
(DEFMETHOD *S2 ((G1 BVE2) (G2 BVE2)) (* -1 (GREF G1 3) (GREF G2 3))) 
(DEFMETHOD *S2 ((G1 BVE2) (G2 MVE2)) (* -1 (GREF G1 3) (GREF G2 3))) 
(DEFMETHOD *S2 ((G1 BVE2) (G2 RE2)) (* -1 (GREF G1 3) (GREF G2 3))) 
(DEFMETHOD *S2 ((G1 MVE2) (G2 SE2)) (* (GREF G1 0) (GREF G2 0))) 
(DEFMETHOD *S2 ((G1 MVE2) (G2 VE2))
           (+ (* (GREF G1 1) (GREF G2 1)) (* (GREF G1 2) (GREF G2 2)))) 
(DEFMETHOD *S2 ((G1 MVE2) (G2 BVE2)) (* -1 (GREF G1 3) (GREF G2 3))) 
(DEFMETHOD *S2 ((G1 MVE2) (G2 MVE2))
           (+ (* (GREF G1 0) (GREF G2 0)) (* (GREF G1 1) (GREF G2 1))
              (* (GREF G1 2) (GREF G2 2)) (* -1 (GREF G1 3) (GREF G2 3)))) 
(DEFMETHOD *S2 ((G1 MVE2) (G2 RE2))
           (+ (* (GREF G1 0) (GREF G2 0)) (* -1 (GREF G1 3) (GREF G2 3)))) 
(DEFMETHOD *S2 ((G1 RE2) (G2 SE2)) (* (GREF G1 0) (GREF G2 0))) 
(DEFMETHOD *S2 ((G1 RE2) (G2 VE2)) 0) 
(DEFMETHOD *S2 ((G1 RE2) (G2 BVE2)) (* -1 (GREF G1 3) (GREF G2 3))) 
(DEFMETHOD *S2 ((G1 RE2) (G2 MVE2))
           (+ (* (GREF G1 0) (GREF G2 0)) (* -1 (GREF G1 3) (GREF G2 3)))) 
(DEFMETHOD *S2 ((G1 RE2) (G2 RE2))
           (+ (* (GREF G1 0) (GREF G2 0)) (* -1 (GREF G1 3) (GREF G2 3)))) 
(DEFMETHOD REVG ((G1 SE2)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR (GREF G1 0)))) 
(DEFMETHOD REVG ((G1 VE2))
           (MAKE-INSTANCE 'VE2 :COEF (VECTOR (GREF G1 1) (GREF G1 2)))) 
(DEFMETHOD REVG ((G1 BVE2))
           (MAKE-INSTANCE 'BVE2 :COEF (VECTOR (* -1 (GREF G1 3))))) 
(DEFMETHOD REVG ((G1 MVE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR (GREF G1 0) (GREF G1 1) (GREF G1 2)
                                  (* -1 (GREF G1 3))))) 
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
                            (* (GREF G2 1)
                               (+ (* (GREF G1 1) (GREF G2 1))
                                  (* (GREF G1 2) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1))
                            (* (GREF G2 2)
                               (+ (* (GREF G1 2) (GREF G2 1))
                                  (* -1 (GREF G1 1) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1)))
                           (+
                            (* (GREF G2 2)
                               (+ (* (GREF G1 1) (GREF G2 1))
                                  (* (GREF G1 2) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1))
                            (* -1 (GREF G2 1)
                               (+ (* (GREF G1 2) (GREF G2 1))
                                  (* -1 (GREF G1 1) (GREF G2 2)))
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
(DEFMETHOD REFL ((G1 MVE2) (G2 VE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR
                           (+
                            (* (GREF G2 1)
                               (+ (* (GREF G1 0) (GREF G2 1))
                                  (* -1 (GREF G1 3) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1))
                            (* (GREF G2 2)
                               (+ (* (GREF G1 3) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1)))
                           (+
                            (* (GREF G2 1)
                               (+ (* (GREF G1 1) (GREF G2 1))
                                  (* (GREF G1 2) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1))
                            (* (GREF G2 2)
                               (+ (* (GREF G1 2) (GREF G2 1))
                                  (* -1 (GREF G1 1) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1)))
                           (+
                            (* (GREF G2 2)
                               (+ (* (GREF G1 1) (GREF G2 1))
                                  (* (GREF G1 2) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1))
                            (* -1 (GREF G2 1)
                               (+ (* (GREF G1 2) (GREF G2 1))
                                  (* -1 (GREF G1 1) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1)))
                           (+
                            (* (GREF G2 2)
                               (+ (* (GREF G1 0) (GREF G2 1))
                                  (* -1 (GREF G1 3) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1))
                            (* -1 (GREF G2 1)
                               (+ (* (GREF G1 3) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1)))))) 
(DEFMETHOD REFL ((G1 RE2) (G2 VE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR
                           (+
                            (* (GREF G2 1)
                               (+ (* (GREF G1 0) (GREF G2 1))
                                  (* -1 (GREF G1 3) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1))
                            (* (GREF G2 2)
                               (+ (* (GREF G1 3) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1)))
                           (+
                            (* (GREF G2 2)
                               (+ (* (GREF G1 0) (GREF G2 1))
                                  (* -1 (GREF G1 3) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
                                -1))
                            (* -1 (GREF G2 1)
                               (+ (* (GREF G1 3) (GREF G2 1))
                                  (* (GREF G1 0) (GREF G2 2)))
                               (EXPT
                                (+ (EXPT (GREF G2 1) 2) (EXPT (GREF G2 2) 2))
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
                            (* (GREF G2 0)
                               (+ (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1))
                            (* (GREF G2 3)
                               (+ (* (GREF G1 2) (GREF G2 0))
                                  (* -1 (GREF G1 1) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1)))
                           (+
                            (* -1 (GREF G2 3)
                               (+ (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1))
                            (* (GREF G2 0)
                               (+ (* (GREF G1 2) (GREF G2 0))
                                  (* -1 (GREF G1 1) (GREF G2 3)))
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
(DEFMETHOD ROT ((G1 MVE2) (G2 RE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR
                           (+
                            (* (GREF G2 0)
                               (+ (* (GREF G1 0) (GREF G2 0))
                                  (* -1 (GREF G1 3) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1))
                            (* (GREF G2 3)
                               (+ (* (GREF G1 3) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1)))
                           (+
                            (* (GREF G2 0)
                               (+ (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1))
                            (* (GREF G2 3)
                               (+ (* (GREF G1 2) (GREF G2 0))
                                  (* -1 (GREF G1 1) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1)))
                           (+
                            (* -1 (GREF G2 3)
                               (+ (* (GREF G1 1) (GREF G2 0))
                                  (* (GREF G1 2) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1))
                            (* (GREF G2 0)
                               (+ (* (GREF G1 2) (GREF G2 0))
                                  (* -1 (GREF G1 1) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1)))
                           (+
                            (* -1 (GREF G2 3)
                               (+ (* (GREF G1 0) (GREF G2 0))
                                  (* -1 (GREF G1 3) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1))
                            (* (GREF G2 0)
                               (+ (* (GREF G1 3) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1)))))) 
(DEFMETHOD ROT ((G1 RE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR
                           (+
                            (* (GREF G2 0)
                               (+ (* (GREF G1 0) (GREF G2 0))
                                  (* -1 (GREF G1 3) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1))
                            (* (GREF G2 3)
                               (+ (* (GREF G1 3) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1)))
                           (+
                            (* -1 (GREF G2 3)
                               (+ (* (GREF G1 0) (GREF G2 0))
                                  (* -1 (GREF G1 3) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1))
                            (* (GREF G2 0)
                               (+ (* (GREF G1 3) (GREF G2 0))
                                  (* (GREF G1 0) (GREF G2 3)))
                               (EXPT
                                (+ (EXPT (GREF G2 0) 2) (EXPT (GREF G2 3) 2))
                                -1)))))) 
(DEFMETHOD SPIN ((G1 SE2) (G2 RE2))
           (MAKE-INSTANCE 'SE2 :COEF
                          (VECTOR
                           (+ (* (EXPT (GREF G2 0) 2) (GREF G1 0))
                              (* (GREF G1 0) (EXPT (GREF G2 3) 2)))))) 
(DEFMETHOD SPIN ((G1 VE2) (G2 RE2))
           (MAKE-INSTANCE 'VE2 :COEF
                          (VECTOR
                           (+
                            (* (GREF G2 0)
                               (+ (* (GREF G2 0) (GREF G1 1))
                                  (* (GREF G1 2) (GREF G2 3))))
                            (* (GREF G2 3)
                               (+ (* (GREF G2 0) (GREF G1 2))
                                  (* -1 (GREF G1 1) (GREF G2 3)))))
                           (+
                            (* -1 (GREF G2 3)
                               (+ (* (GREF G2 3) (GREF G1 2))
                                  (* (GREF G1 1) (GREF G2 0))))
                            (* (GREF G2 0)
                               (+ (* -1 (GREF G2 3) (GREF G1 1))
                                  (* (GREF G1 2) (GREF G2 0)))))))) 
(DEFMETHOD SPIN ((G1 BVE2) (G2 RE2))
           (MAKE-INSTANCE 'BVE2 :COEF
                          (VECTOR
                           (+ (* (EXPT (GREF G2 3) 2) (GREF G1 3))
                              (* (GREF G1 3) (EXPT (GREF G2 0) 2)))))) 
(DEFMETHOD SPIN ((G1 MVE2) (G2 RE2))
           (MAKE-INSTANCE 'MVE2 :COEF
                          (VECTOR
                           (+
                            (* (GREF G2 0)
                               (+ (* (GREF G2 0) (GREF G1 0))
                                  (* -1 (GREF G1 3) (GREF G2 3))))
                            (* (GREF G2 3)
                               (+ (* (GREF G2 0) (GREF G1 3))
                                  (* (GREF G1 0) (GREF G2 3)))))
                           (+
                            (* (GREF G2 0)
                               (+ (* (GREF G2 0) (GREF G1 1))
                                  (* (GREF G1 2) (GREF G2 3))))
                            (* (GREF G2 3)
                               (+ (* (GREF G2 0) (GREF G1 2))
                                  (* -1 (GREF G1 1) (GREF G2 3)))))
                           (+
                            (* -1 (GREF G2 3)
                               (+ (* (GREF G2 3) (GREF G1 2))
                                  (* (GREF G1 1) (GREF G2 0))))
                            (* (GREF G2 0)
                               (+ (* -1 (GREF G2 3) (GREF G1 1))
                                  (* (GREF G1 2) (GREF G2 0)))))
                           (+
                            (* -1 (GREF G2 3)
                               (+ (* -1 (GREF G2 3) (GREF G1 3))
                                  (* (GREF G1 0) (GREF G2 0))))
                            (* (GREF G2 0)
                               (+ (* (GREF G2 3) (GREF G1 0))
                                  (* (GREF G1 3) (GREF G2 0)))))))) 
(DEFMETHOD SPIN ((G1 RE2) (G2 RE2))
           (MAKE-INSTANCE 'RE2 :COEF
                          (VECTOR
                           (+
                            (* (GREF G2 0)
                               (+ (* (GREF G2 0) (GREF G1 0))
                                  (* -1 (GREF G1 3) (GREF G2 3))))
                            (* (GREF G2 3)
                               (+ (* (GREF G2 0) (GREF G1 3))
                                  (* (GREF G1 0) (GREF G2 3)))))
                           (+
                            (* -1 (GREF G2 3)
                               (+ (* -1 (GREF G2 3) (GREF G1 3))
                                  (* (GREF G1 0) (GREF G2 0))))
                            (* (GREF G2 0)
                               (+ (* (GREF G2 3) (GREF G1 0))
                                  (* (GREF G1 3) (GREF G2 0)))))))) 
(DEFMETHOD NORMR2 ((G1 SE2)) (EXPT (GREF G1 0) 2)) 
(DEFMETHOD NORMR2 ((G1 VE2)) (+ (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2))) 
(DEFMETHOD NORMR2 ((G1 BVE2)) (EXPT (GREF G1 3) 2)) 
(DEFMETHOD NORMR2 ((G1 MVE2))
           (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2)
              (EXPT (GREF G1 3) 2))) 
(DEFMETHOD NORMR2 ((G1 RE2)) (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 3) 2))) 
(DEFMETHOD NORMR ((G1 SE2)) (* (ABS (GREF G1 0)) (SIGNUM (EXPT (GREF G1 0) 2)))) 
(DEFMETHOD NORMR ((G1 VE2))
           (*
            (EXPT (+ (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2))
                  ((RAT SIMP) 1 2))
            (SIGNUM (+ (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2))))) 
(DEFMETHOD NORMR ((G1 BVE2))
           (* (ABS (GREF G1 3)) (SIGNUM (EXPT (GREF G1 3) 2)))) 
(DEFMETHOD NORMR ((G1 MVE2))
           (*
            (EXPT
             (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2)
                (EXPT (GREF G1 3) 2))
             ((RAT SIMP) 1 2))
            (SIGNUM
             (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2)
                (EXPT (GREF G1 3) 2))))) 
(DEFMETHOD NORMR ((G1 RE2))
           (*
            (EXPT (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 3) 2))
                  ((RAT SIMP) 1 2))
            (SIGNUM (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 3) 2))))) 
(DEFMETHOD NORME2 ((G1 SE2)) (EXPT (GREF G1 0) 2)) 
(DEFMETHOD NORME2 ((G1 VE2)) (+ (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2))) 
(DEFMETHOD NORME2 ((G1 BVE2)) (EXPT (GREF G1 3) 2)) 
(DEFMETHOD NORME2 ((G1 MVE2))
           (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2)
              (EXPT (GREF G1 3) 2))) 
(DEFMETHOD NORME2 ((G1 RE2)) (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 3) 2))) 
(DEFMETHOD NORME ((G1 SE2)) (ABS (GREF G1 0))) 
(DEFMETHOD NORME ((G1 VE2))
           (EXPT (+ (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2))
                 ((RAT SIMP) 1 2))) 
(DEFMETHOD NORME ((G1 BVE2)) (ABS (GREF G1 3))) 
(DEFMETHOD NORME ((G1 MVE2))
           (EXPT
            (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 1) 2) (EXPT (GREF G1 2) 2)
               (EXPT (GREF G1 3) 2))
            ((RAT SIMP) 1 2))) 
(DEFMETHOD NORME ((G1 RE2))
           (EXPT (+ (EXPT (GREF G1 0) 2) (EXPT (GREF G1 3) 2))
                 ((RAT SIMP) 1 2))) 