
(IN-PACKAGE :BLD-E2) 
(DEFCLASS E2 (G)
          ((COEF :INITFORM (MAKE-ARRAY 4 :INITIAL-ELEMENT 0))
           (METRIC :ALLOCATION :CLASS :INITFORM NIL)
           (DIMENSION :ALLOCATION :CLASS :INITFORM 2)
           (SIZE :ALLOCATION :CLASS :INITFORM 4)
           (REVTABLE :ALLOCATION :CLASS :INITFORM #(1 1 1 -1))
           (BITMAP :ALLOCATION :CLASS :INITFORM #(0 1 2 3))
           (SPEC :ALLOCATION :CLASS :READER SPEC :INITFORM
            '((E2 #(0 1 2 3)) (SE2 #(0)) (VE2 #(1 2)) (BVE2 #(3))
              (RE2 #(0 3)))))) 
(DEFCLASS SE2 (E2)
          ((COEF :INITFORM (MAKE-ARRAY 1 :INITIAL-ELEMENT 0))
           (SIZE :ALLOCATION :CLASS :INITFORM 1)
           (BITMAP :ALLOCATION :CLASS :INITFORM #(0))
           (LOOKUP :ALLOCATION :CLASS :INITFORM #(0 NIL NIL NIL)))) 
(DEFCLASS VE2 (E2)
          ((COEF :INITFORM (MAKE-ARRAY 2 :INITIAL-ELEMENT 0))
           (SIZE :ALLOCATION :CLASS :INITFORM 2)
           (BITMAP :ALLOCATION :CLASS :INITFORM #(1 2))
           (LOOKUP :ALLOCATION :CLASS :INITFORM #(NIL 0 1 NIL)))) 
(DEFCLASS BVE2 (E2)
          ((COEF :INITFORM (MAKE-ARRAY 1 :INITIAL-ELEMENT 0))
           (SIZE :ALLOCATION :CLASS :INITFORM 1)
           (BITMAP :ALLOCATION :CLASS :INITFORM #(3))
           (LOOKUP :ALLOCATION :CLASS :INITFORM #(NIL NIL NIL 0)))) 
(DEFCLASS RE2 (E2)
          ((COEF :INITFORM (MAKE-ARRAY 2 :INITIAL-ELEMENT 0))
           (SIZE :ALLOCATION :CLASS :INITFORM 2)
           (BITMAP :ALLOCATION :CLASS :INITFORM #(0 3))
           (LOOKUP :ALLOCATION :CLASS :INITFORM #(0 NIL NIL 1)))) 
(DEFUN E2 (&KEY (C0 0) (C1 0) (C10 0) (C11 0))
  (MAKE-INSTANCE 'E2 :COEF (VECTOR C0 C1 C10 C11))) 
(DEFUN SE2 (&KEY (C0 0)) (MAKE-INSTANCE 'SE2 :COEF (VECTOR C0))) 
(DEFUN VE2 (&KEY (C1 0) (C10 0)) (MAKE-INSTANCE 'VE2 :COEF (VECTOR C1 C10))) 
(DEFUN BVE2 (&KEY (C11 0)) (MAKE-INSTANCE 'BVE2 :COEF (VECTOR C11))) 
(DEFUN RE2 (&KEY (C0 0) (C11 0)) (MAKE-INSTANCE 'RE2 :COEF (VECTOR C0 C11))) 
(DEFMETHOD GREF ((G E2) (BB INTEGER))
           (CASE BB
             (0 (AREF (COEF G) 0))
             (1 (AREF (COEF G) 1))
             (2 (AREF (COEF G) 2))
             (3 (AREF (COEF G) 3)))) 
(DEFMETHOD GREF ((G SE2) (BB INTEGER))
           (CASE BB (0 (AREF (COEF G) 0)) (1 0) (2 0) (3 0))) 
(DEFMETHOD GREF ((G VE2) (BB INTEGER))
           (CASE BB (0 0) (1 (AREF (COEF G) 0)) (2 (AREF (COEF G) 1)) (3 0))) 
(DEFMETHOD GREF ((G BVE2) (BB INTEGER))
           (CASE BB (0 0) (1 0) (2 0) (3 (AREF (COEF G) 0)))) 
(DEFMETHOD GREF ((G RE2) (BB INTEGER))
           (CASE BB (0 (AREF (COEF G) 0)) (1 0) (2 0) (3 (AREF (COEF G) 1)))) 
(DEFMETHOD GSET ((G E2) (BB INTEGER) (VAL NUMBER))
           (CASE BB
             (0 (SETF (AREF (COEF G) 0) VAL))
             (1 (SETF (AREF (COEF G) 1) VAL))
             (2 (SETF (AREF (COEF G) 2) VAL))
             (3 (SETF (AREF (COEF G) 3) VAL))
             (T
              (ERROR
               (FORMAT NIL
                       "Basis bitmap ~b doesn't exist in GA object of type E2."
                       BB))))) 
(DEFMETHOD GSET ((G SE2) (BB INTEGER) (VAL NUMBER))
           (CASE BB
             (0 (SETF (AREF (COEF G) 0) VAL))
             (T
              (ERROR
               (FORMAT NIL
                       "Basis bitmap ~b doesn't exist in GA object of type SE2."
                       BB))))) 
(DEFMETHOD GSET ((G VE2) (BB INTEGER) (VAL NUMBER))
           (CASE BB
             (1 (SETF (AREF (COEF G) 0) VAL))
             (2 (SETF (AREF (COEF G) 1) VAL))
             (T
              (ERROR
               (FORMAT NIL
                       "Basis bitmap ~b doesn't exist in GA object of type VE2."
                       BB))))) 
(DEFMETHOD GSET ((G BVE2) (BB INTEGER) (VAL NUMBER))
           (CASE BB
             (3 (SETF (AREF (COEF G) 0) VAL))
             (T
              (ERROR
               (FORMAT NIL
                       "Basis bitmap ~b doesn't exist in GA object of type BVE2."
                       BB))))) 
(DEFMETHOD GSET ((G RE2) (BB INTEGER) (VAL NUMBER))
           (CASE BB
             (0 (SETF (AREF (COEF G) 0) VAL))
             (3 (SETF (AREF (COEF G) 1) VAL))
             (T
              (ERROR
               (FORMAT NIL
                       "Basis bitmap ~b doesn't exist in GA object of type RE2."
                       BB))))) 