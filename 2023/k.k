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
G:2(||':)/                      /
W:~^D?                          / [W]alls (non digits)
E:{{(y&x')/y&x'x@z}[G; W x; y]} / [E]xpand to mark the part numbers
S:." "/"\0"\`c$',/0,'           / [A]dd up the part numbers
F:{(2=#'x)*/'x}                 / [F]ilter out bad gears
d03a:{+/S[x*E[x;^(D,".")?x]]}
d03b:{+/F@S'x*/:E[x]'{.[x;y;:;1]}[x*0]'+&"*"=x}
d03b:{+/F@,/(3':x){S'x*'/:E[x]'{.[x;1,y;:;1]}[0*x]'y}'(1_-1_&'"*"=x)}
/           +-+--+|            +----------+-+       | +-----+------+
/             |   +----------------+------|---------+       |
/       No gear on fst and lst row | Mark the gear     Find "gears" for each row
/                         Process each strip
//a2:+1+&2=3+/':{(x=5)+x>0}3(2/)':'W / find cells that have 2 adjacent numbers
