(asdf:defsystem :bld-gagen
  :name "bld-gagen"
  :author "Benjamin L. Diedrich <ben@solarsails.info>"
  :version "0.0.1"
  :maintainer "Benjamin L. Diedrich <ben@solarsails.info>"
  :license "MIT"
  :description "Write optimized code for specific geometric algebras"
  :depends-on ("bld-utils" "bld-ga" "bld-maxima" "bld-gen" "bld-gensym" "alexandria")
  :components
  ((:file "package")
   (:file "gawrite2" :depends-on ("package"))
   (:file "gagen" :depends-on ("gawrite2" "package"))))
