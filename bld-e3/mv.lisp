
(IN-PACKAGE :BLD-E3) 
(DEFCLASS E3 (G)
          ((COEF :INITFORM (MAKE-ARRAY 8 :INITIAL-ELEMENT 0))
           (METRIC :ALLOCATION :CLASS :INITFORM NIL)
           (DIMENSION :ALLOCATION :CLASS :INITFORM 3)
           (SIZE :ALLOCATION :CLASS :INITFORM 8)
           (REVTABLE :ALLOCATION :CLASS :INITFORM #(1 1 1 -1 1 -1 -1 -1))
           (BITMAP :ALLOCATION :CLASS :INITFORM #(0 1 2 3 4 5 6 7))
           (SPEC :ALLOCATION :CLASS :READER SPEC :INITFORM
            '((E3 #(0 1 2 3 4 5 6 7)) (SE3 #(0)) (VE3 #(1 2 4)) (BVE3 #(3 5 6))
              (IE3 #(7)) (RE3 #(0 3 5 6)))))) 
(DEFCLASS SE3 (E3)
          ((COEF :INITFORM (MAKE-ARRAY 1 :INITIAL-ELEMENT 0))
           (SIZE :ALLOCATION :CLASS :INITFORM 1)
           (BITMAP :ALLOCATION :CLASS :INITFORM #(0))
           (LOOKUP :ALLOCATION :CLASS :INITFORM
            #(0 NIL NIL NIL NIL NIL NIL NIL)))) 
(DEFCLASS VE3 (E3)
          ((COEF :INITFORM (MAKE-ARRAY 3 :INITIAL-ELEMENT 0))
           (SIZE :ALLOCATION :CLASS :INITFORM 3)
           (BITMAP :ALLOCATION :CLASS :INITFORM #(1 2 4))
           (LOOKUP :ALLOCATION :CLASS :INITFORM #(NIL 0 1 NIL 2 NIL NIL NIL)))) 
(DEFCLASS BVE3 (E3)
          ((COEF :INITFORM (MAKE-ARRAY 3 :INITIAL-ELEMENT 0))
           (SIZE :ALLOCATION :CLASS :INITFORM 3)
           (BITMAP :ALLOCATION :CLASS :INITFORM #(3 5 6))
           (LOOKUP :ALLOCATION :CLASS :INITFORM #(NIL NIL NIL 0 NIL 1 2 NIL)))) 
(DEFCLASS IE3 (E3)
          ((COEF :INITFORM (MAKE-ARRAY 1 :INITIAL-ELEMENT 0))
           (SIZE :ALLOCATION :CLASS :INITFORM 1)
           (BITMAP :ALLOCATION :CLASS :INITFORM #(7))
           (LOOKUP :ALLOCATION :CLASS :INITFORM
            #(NIL NIL NIL NIL NIL NIL NIL 0)))) 
(DEFCLASS RE3 (E3)
          ((COEF :INITFORM (MAKE-ARRAY 4 :INITIAL-ELEMENT 0))
           (SIZE :ALLOCATION :CLASS :INITFORM 4)
           (BITMAP :ALLOCATION :CLASS :INITFORM #(0 3 5 6))
           (LOOKUP :ALLOCATION :CLASS :INITFORM #(0 NIL NIL 1 NIL 2 3 NIL)))) 
(DEFUN E3
       (&KEY (C0 0) (C1 0) (C10 0) (C11 0) (C100 0) (C101 0) (C110 0) (C111 0))
  (MAKE-INSTANCE 'E3 :COEF (VECTOR C0 C1 C10 C11 C100 C101 C110 C111))) 
(DEFUN SE3 (&KEY (C0 0)) (MAKE-INSTANCE 'SE3 :COEF (VECTOR C0))) 
(DEFUN VE3 (&KEY (C1 0) (C10 0) (C100 0))
  (MAKE-INSTANCE 'VE3 :COEF (VECTOR C1 C10 C100))) 
(DEFUN BVE3 (&KEY (C11 0) (C101 0) (C110 0))
  (MAKE-INSTANCE 'BVE3 :COEF (VECTOR C11 C101 C110))) 
(DEFUN IE3 (&KEY (C111 0)) (MAKE-INSTANCE 'IE3 :COEF (VECTOR C111))) 
(DEFUN RE3 (&KEY (C0 0) (C11 0) (C101 0) (C110 0))
  (MAKE-INSTANCE 'RE3 :COEF (VECTOR C0 C11 C101 C110))) 
(DEFMETHOD GREF ((G E3) (BB INTEGER))
           (CASE BB
             (0 (AREF (COEF G) 0))
             (1 (AREF (COEF G) 1))
             (2 (AREF (COEF G) 2))
             (3 (AREF (COEF G) 3))
             (4 (AREF (COEF G) 4))
             (5 (AREF (COEF G) 5))
             (6 (AREF (COEF G) 6))
             (7 (AREF (COEF G) 7)))) 
(DEFMETHOD GREF ((G SE3) (BB INTEGER))
           (CASE BB
             (0 (AREF (COEF G) 0))
             (1 0)
             (2 0)
             (3 0)
             (4 0)
             (5 0)
             (6 0)
             (7 0))) 
(DEFMETHOD GREF ((G VE3) (BB INTEGER))
           (CASE BB
             (0 0)
             (1 (AREF (COEF G) 0))
             (2 (AREF (COEF G) 1))
             (3 0)
             (4 (AREF (COEF G) 2))
             (5 0)
             (6 0)
             (7 0))) 
(DEFMETHOD GREF ((G BVE3) (BB INTEGER))
           (CASE BB
             (0 0)
             (1 0)
             (2 0)
             (3 (AREF (COEF G) 0))
             (4 0)
             (5 (AREF (COEF G) 1))
             (6 (AREF (COEF G) 2))
             (7 0))) 
(DEFMETHOD GREF ((G IE3) (BB INTEGER))
           (CASE BB
             (0 0)
             (1 0)
             (2 0)
             (3 0)
             (4 0)
             (5 0)
             (6 0)
             (7 (AREF (COEF G) 0)))) 
(DEFMETHOD GREF ((G RE3) (BB INTEGER))
           (CASE BB
             (0 (AREF (COEF G) 0))
             (1 0)
             (2 0)
             (3 (AREF (COEF G) 1))
             (4 0)
             (5 (AREF (COEF G) 2))
             (6 (AREF (COEF G) 3))
             (7 0))) 
(DEFMETHOD GSET ((G E3) (BB INTEGER) (VAL NUMBER))
           (CASE BB
             (0 (SETF (AREF (COEF G) 0) VAL))
             (1 (SETF (AREF (COEF G) 1) VAL))
             (2 (SETF (AREF (COEF G) 2) VAL))
             (3 (SETF (AREF (COEF G) 3) VAL))
             (4 (SETF (AREF (COEF G) 4) VAL))
             (5 (SETF (AREF (COEF G) 5) VAL))
             (6 (SETF (AREF (COEF G) 6) VAL))
             (7 (SETF (AREF (COEF G) 7) VAL))
             (T
              (ERROR
               (FORMAT NIL
                       "Basis bitmap ~b doesn't exist in GA object of type E3."
                       BB))))) 
(DEFMETHOD GSET ((G SE3) (BB INTEGER) (VAL NUMBER))
           (CASE BB
             (0 (SETF (AREF (COEF G) 0) VAL))
             (T
              (ERROR
               (FORMAT NIL
                       "Basis bitmap ~b doesn't exist in GA object of type SE3."
                       BB))))) 
(DEFMETHOD GSET ((G VE3) (BB INTEGER) (VAL NUMBER))
           (CASE BB
             (1 (SETF (AREF (COEF G) 0) VAL))
             (2 (SETF (AREF (COEF G) 1) VAL))
             (4 (SETF (AREF (COEF G) 2) VAL))
             (T
              (ERROR
               (FORMAT NIL
                       "Basis bitmap ~b doesn't exist in GA object of type VE3."
                       BB))))) 
(DEFMETHOD GSET ((G BVE3) (BB INTEGER) (VAL NUMBER))
           (CASE BB
             (3 (SETF (AREF (COEF G) 0) VAL))
             (5 (SETF (AREF (COEF G) 1) VAL))
             (6 (SETF (AREF (COEF G) 2) VAL))
             (T
              (ERROR
               (FORMAT NIL
                       "Basis bitmap ~b doesn't exist in GA object of type BVE3."
                       BB))))) 
(DEFMETHOD GSET ((G IE3) (BB INTEGER) (VAL NUMBER))
           (CASE BB
             (7 (SETF (AREF (COEF G) 0) VAL))
             (T
              (ERROR
               (FORMAT NIL
                       "Basis bitmap ~b doesn't exist in GA object of type IE3."
                       BB))))) 
(DEFMETHOD GSET ((G RE3) (BB INTEGER) (VAL NUMBER))
           (CASE BB
             (0 (SETF (AREF (COEF G) 0) VAL))
             (3 (SETF (AREF (COEF G) 1) VAL))
             (5 (SETF (AREF (COEF G) 2) VAL))
             (6 (SETF (AREF (COEF G) 3) VAL))
             (T
              (ERROR
               (FORMAT NIL
                       "Basis bitmap ~b doesn't exist in GA object of type RE3."
                       BB))))) 