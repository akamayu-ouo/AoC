/split string into three portions
/1) past, 2) now, and 3) future
/starts with past~”” now~(-n)_s future~(-n)#s
/in each iteration, find the first largest number in (2), move the prefix (including the max) from (2) to (1), and transfer the first number in (3) to the end of the remaining suffix of (2)

p:{(1+(*>*x),#*x)_,/x}  /x is (2) and (3)
f:{.,/`c$|/'*'x p\||'(0,x)_|y}

i:0:"in/03.ex"
j:0:"in/03.in"
(+/f[1]'i;+/f[11]'i)
(+/f[1]'j;+/f[11]'j)
