;; Use BLD-GAGEN to WRITE lisp code that can be standalone compiled without Maxima or all the dependencies

(in-package :bld-gagen)

#|
(defun write-parent (parent dim &key metric spec)
    (let* ((size (expt 2 dim))
	   (bitmap (make-array size :initial-contents (loop for b below size collect b))))
      `(defclass ,parent (g)
|#

(defun write-children (parent dim &key spec)
  (loop for line in (cdr (macroexpand-1 `(defchildren ,parent ,dim :spec ,spec)))
     collect (macroexpand-1 line)))

(defun write-grefs (dim spec)
  (loop for line in (cdr (macroexpand-1 `(defgrefs ,dim ,spec)))
     collect (macroexpand-1 line)))

(defun write-gsets (dim spec)
  (loop for line in (cdr (macroexpand-1 `(defgsets ,dim ,spec)))
     collect (macroexpand-1 line)))

(defun write-ga (parent dim &key spec)
  (append (write-children parent dim :spec spec)
	  (write-grefs dim spec)
	  (write-gsets dim spec)))

(defun write-gamethod (parent fun &rest classes)
  (macroexpand-1 `(defgamethod ,parent ,fun ,@classes)))

(defun write-gamethods1 (parent fun classes)
  (loop for class in classes
     collect (write-gamethod parent fun class)))

(defun write-gamethods2 (parent fun classes1 classes2)
  (loop for class1 in classes1
     append (loop for class2 in classes2
	       collect (write-gamethod parent fun class1 class2))))

(defun write-gamethods3 (parent fun classes1 classes2 classes3)
  (loop for class1 in classes1
     append (loop for class2 in classes2
	       append (loop for class3 in classes3
			 collect (write-gamethod parent fun class1 class2 class3)))))

(defun write-gamethods (parent method &rest classlists)
  (apply (build-symbol write-gamethods (:< (length classlists))) parent method classlists))

(defun write-gamethodsall (parent &key vector spinor spec)
  (let ((versors (find-versors parent)))
    (loop initially (maxima-start)
       for methdef in *gamethods-table*
       for method = (first methdef)
       for classlists = (subst '(float) 'float ; replacing keywords with appropriate definitions
			    (subst (mapcar #'first spec) 'all
				   (subst-unless-nil ; only substitute spinors & vectors if provided
				    (list spinor) 'spinor
				    (subst-unless-nil
				     (list vector) 'vector
				     (subst versors 'versor
					    (rest methdef))))))
       append (apply #'write-gamethods parent method classlists)
       finally (maxima-shutdown))))

(defun write-ga-file (filespec parent dim &key spec vector spinor)
  (with-open-file (stream filespec :direction :output)
    (dolist (line (write-ga parent dim :spec spec))
      (print line stream))
    (dolist (line (write-gamethodsall parent :vector vector :spinor spinor))
      (print line stream))))
