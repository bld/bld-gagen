(defpackage :bld-gagen
  (:use :cl :bld-ga :bld-utils :bld-symbolic)
  (:import-from :alexandria make-keyword)
  (:shadowing-import-from :bld-gen
                          + - * / expt
                          sin cos tan
                          atan asin acos
                          sinh cosh tanh
                          asinh acosh atanh
                          log exp sqrt abs
                          min max signum)
  (:export :defchildfun
	   :defchildfuns
	   :defchild
	   :defchildren
	   :defgref
	   :defgrefs
	   :defgset
	   :defgsets
	   :defgamethod
	   :defgamethods
	   :defgamethodsall))
