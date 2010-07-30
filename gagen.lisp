(in-package :bld-gagen)

(defmacro defchild (child parent dim bitmap)
  (write-child child parent dim bitmap))

(defmacro defchildren (parent dim spec)
  `(progn ,@(write-children parent dim (symbol-value spec))))

(defmacro defchildfun (class bitmap)
  (write-gfun class bitmap))

(defmacro defchildfuns (spec)
  `(progn ,@(write-child-gfuns (symbol-value spec))))

(defmacro defgref (child psize bitmap)
  (write-gref child psize bitmap))

(defmacro defgrefs (dim spec)
  `(progn ,@(write-grefs dim (symbol-value spec))))

(defmacro defgset (child dim bitmap)
  (write-gset child dim bitmap))

(defmacro defgsets (dim spec)
  `(progn ,@(write-gsets dim (symbol-value spec))))

(defmacro defgamethod (parent fun spec &rest classes)
  (apply #'write-gamethod parent fun (symbol-value spec) classes))

(defmacro defgamethods (parent fun spec classes1 &optional classes2 classes3)
  `(progn ,@(write-gamethods parent fun (symbol-value spec) classes1 classes2 classes3)))

(defmacro defgamethodsall (parent spec &key vector spinor)
  `(progn ,@(write-gamethodsall parent (symbol-value spec) :vector vector :spinor spinor)))

