
(DEFPACKAGE :BLD-E3.SYSTEM
  (:USE :ASDF :CL)) 
(IN-PACKAGE :BLD-E3.SYSTEM) 
(DEFSYSTEM :BLD-E3 :NAME "BLD-E3" :AUTHOR "Benjamin L. Diedrich" :VERSION
 "0.0.1" :MAINTAINER "Benjamin L. Diedrich" :LICENSE "MIT" :DESCRIPTION
 "Euclidean 2D geometric algebra" :DEPENDS-ON ("bld-ga") :COMPONENTS
 ((:FILE "package") (:FILE "mv" :DEPENDS-ON ("package"))
  (:FILE "ga" :DEPENDS-ON ("mv")))) 