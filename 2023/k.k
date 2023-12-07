D:"0123456789",("zero";"one";"two";"three";"four";"five";"six";"seven";"eight";"nine")
G:+/(10!*<{#*x\y}\:)/:
F:{10/G[x;y],G[|'x;|'y]}
d01a:F[10#D;]
d01b:F[D;]

//d01a:{10/G/'(::;|:')@/:\:(10#D;x)}
//d01b:{10/G/'(::;|:')@/:\:(D;x)}

F:{{|/'(.'x)@(=*'y)@"rgb"}.+0N 2#2_" "\x^",;:"}
d02a:+/1+&~|/'(12+!3)</:F'
d02b:+/*/'F'


D:"0123456789"                  / [D]igits
E:2(||':)/                      / [E]xpand to adjacent (up and down) cells
W:~^D?                          / [W]alls (non digits)
F:{{(y&x')/y&x'x@z}[E; W x; y]} / [F]lood to mark the part numbers
S:." "/"\0"\`c$',/0,'           / [S]eparate numbers
G:{(2=#'x)*/'x}                 / [G]ood gears only
d03a:{+/S[x*F[x;^(D,".")?x]]}
d03b:{+/G@S'x*/:F[x]'{.[x;y;:;1]}[x*0]'+&"*"=x}
d03b:{+/G@,/(3':x){S'x*'/:F[x]'{.[x;1,y;:;1]}[0*x]'y}'(1_-1_&'"*"=x)}
/           +-+--+|            +----------+-+       | +-----+------+
/             |   +----------------+------|---------+       |
/       No gear on fst and lst row | Mark the gear     Find "gears" for each row
/                         Process each strip
//a2:+1+&2=3+/':{(x=5)+x>0}3(2/)':'W / find cells that have 2 adjacent numbers
F:!:+/~:^:.:*:|:":"\"?"/"|"\
d04a:+/2/'~F'
M:{1+(!#x)+'F'x}
d04b:{+/#'{,/x@y}[M x]\!#x}


S:.:*:|:":"\*:                            / [S]eeds
P:.''2_'1_{x@.=+\""~/:x}                  / [P]arse
G:,/''+'{x@<x}'({(y,y+z;(x-y),0)}.)''     / [G]rouping
O:{x@<x}0N 2#                             / [O]rdered
sub:{((x,y)@<x,y)@&|':2=+\(,/2 1*1-2*2!!'(#x),#y)@<x,y} / subtraction between two sets of non-overlapped intervals
d05a:&/{(S@x){x+0^(*|y)@(*y)'x}/G@P@x}
d05b:&/{(,/+\'O@S@x){,/(=/')_O@g,f+{2}#0^(*|y)@*'0N 2#(*y)'f:sub[x;g:sub[x;*y]]}/ G@P@x}
/                      +-+--+     ^                        ^       ^
/                        |        |                        |   g is x without *y
/                        |    apply shift     f is intersection of x and *y
/                        |
/                   Remove empty
/ BUG in `sub`: sub[2 4 3 7 4 6;!0]  --> 2 3 4 4 6 7

C:{(~~r)+r:-+/_1+(-+;-).\:(x;%(x*x)-4*y)%2}  / [C]ount
P:(.*|":"\)'^\:                              / [P]arse
d06a:*/C/P[;""]@
d06b:*/C/P[;" "]@

F:{+/&0,.'b@<(({(5-+/x),x}1_{x@>x}@.#'y_=)'a),'(y,"23456789TJQKA")?*(a;b):+" "\'x}
d07a:F[;""]
d07b:F[;"J"]
