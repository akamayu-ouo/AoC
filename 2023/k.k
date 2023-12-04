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
