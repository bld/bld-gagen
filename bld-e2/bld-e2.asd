
(DEFPACKAGE :BLD-E2.SYSTEM
  (:USE :ASDF :CL)) 
(IN-PACKAGE :BLD-E2.SYSTEM) 
(DEFSYSTEM :BLD-E2 :NAME "BLD-E2" :AUTHOR "Benjamin L. Diedrich" :VERSION
 "0.0.1" :MAINTAINER "Benjamin L. Diedrich" :LICENSE "MIT" :DESCRIPTION
 "Euclidean 2D geometric algebra" :DEPENDS-ON ("bld-ga") :COMPONENTS
 ((:FILE "package") (:FILE "mv" :DEPENDS-ON ("package"))
  (:FILE "ga" :DEPENDS-ON ("mv")))) 