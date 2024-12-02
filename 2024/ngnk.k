#!/usr/bin/env k
lines:{0:"in/",x,".in"}

d01a:{ +/{(x|y)-x&y}.{x[<x]}'+.'x } /lines "01"
d01b:{ +/{x*0^(#'=y)[x]}.+.'x } /lines "01"

c:{+/x(~#^)/:\:i,-i:,1+!3}@(1_-':)'
d02a:+/c@
d02b:+/{|/c@x@i^/:-1,i:!#x}'
