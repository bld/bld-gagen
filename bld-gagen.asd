(defpackage :bld.gagen.system
  (:use :asdf :cl))
(in-package :bld.gagen.system)
(defsystem :bld-gagen
  :name "bld-gagen"
  :author "Benjamin L. Diedrich <ben@solarsails.info>"
  :version "0.0.1"
  :maintainer "Benjamin L. Diedrich <ben@solarsails.info>"
  :license "MIT"
  :description "Geometric algebra generator"
  :depends-on ("bld-ga")
  :components
  ((:file "package")
   (:file "mvgen" :depends-on ("package"))
   (:file "gagen" :depends-on ("mvgen")))
  :depends-on ("bld-utils" "bld-ga" "bld-maxima"))
