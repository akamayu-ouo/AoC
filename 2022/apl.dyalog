#!/sbin/dyalogscript
indir ← './input'

I ← ⌷⍨∘⊂

FL ← { ⊃⎕NGET ⍵ 1 }

∇ in ← CB
	in ← ⎕SH 'xclip -sel clip -o'
∇

Test ← {
	⍺ ← '.in'
	n←⍕⍵
	tab ← '    ' ,⍤1 ⍕
	⎕pp←20
	⎕←'--------- [day',n,']'
	p1 p2 ← ⍎'day',n,' FL indir,''/',n,⍺,''''
	⎕←'+ part 1:'
	⎕←tab p1
	⎕←'+ part 2:'
	⎕←tab p2
}

⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝

day1 ← {
	in ← ⍎¨¨(⊂'')(≢¨⊆⊢) ⍵
	p1 ← ⌈⌿+⌿¨in
	p2 ← (+⌿ ⊢ I 3↑⍒)+⌿¨in
	p1 p2
}

day2 ← {
	⎕io ← 0
	in ← (⊂' ')(∊≠⊆⊢)¨ ⍵
	m  ← ↑(⊂'ABC' 'XYZ')⍳¨¨in
	p1←+⌿(1+1⌷⍉m),(3×3|4+-⍨/m)
	p2←+⌿(3×1⌷⍉m),(1+3|2++⍨/m)
	p1 p2
}

day3 ← {
	⎕io ← 1
	in ← ⍵
	s  ← +⌿(⎕A,⍨⎕C⎕A) ⍳∘∊ ∪⍤∩⌿¨
	p1←s (⊢(↑,⍥⊂↓)⍨2÷⍨≢)¨in
	p2←s in⊂⍨1 0 0⍴⍨≢in
	p1 p2
}

day4 ← {
	(s1 e1 s2 e2)←⊂[1]↑⎕d∘(⍎¨∊⍨⊆⊢)¨⍵
	p1←+⌿((s1≥s2)∧(e1≤e2))∨((s2≥s1)∧(e2≤e1))
	p2←+⌿((e1≥s2)∧(s1≤e2))∨((s2≥e1)∧(e2≤s1))
	p1 p2
}

day5 ← {
	s m ← (×∘≢¨⊆⊢)⍵
	mv ← ⎕D∘(⍎¨∊⍨⊆⊢)¨m
	r ← ' '(⊂¯1↓≠⊢⍤⌿⊢)⍤1⊢(⍸¨' '≠⊢⌿s)⌷⍉↑s
	l ← ⌽mv,⍨⊂r
	_p ← {(n f t)←⍺ ⋄ (f⊃h)↓⍨←≢(t⊃h),⍨←⍺⍺n↑f⊃h←⍵ ⋄ h}
	p1←⊃¨↑ ⌽_p⌿ l
	p2←⊃¨↑ ⊢_p⌿ l
	p1 p2
}

day6 ← {
	⎕io ← 0
	in ← ⊃⍵
	f ← ⊣ + (≢¨∪⌿) ⍳ ⊣
	p1← 4 f in
	p2←14 f in
	p1 p2
}

day7 ← {⍬⍬} ⍝ WIP

day8 ← {
	in ← ⍎¨↑⍵
	_erot_ ← { ⊃⍺⍺⌿ ⍉∘⌽⍤⊢⍀ ⍵⍵¨ ⌽∘⍉⍤⊢⍀ 4⌿⊂⍵ }
	p1←+⌿∊ ∨_erot_{⍵>(⍴⍵)⍴0⍪⌈⍀⍵} 1+in
	p2←⌈⌿∊ ×_erot_(↑⊂{(⍵-⍨≢⍺)@(=∘0), ⍉⍸⍤1⍉ <⍀ ⍵(⌷≤⍤1↓)⍺}¨⍳∘≢) in
	p1 p2
}

day9 ← {
	sim ← {
		≢∪s⊣{
			a ← ⌽⊃(⊢,⍨∘⊂⊣-(×⊢×2∊|)⍤-∘⊃)⌿⌽ (⊂⍺)⊂⍤+@1⊢⍵
			a⊣s,←⊢⌿a
		}⌿⌽⍵,⍨⊂s,⍺⌿s←⊂0 0
	}
	d ← 0 1 0 ¯1 0 I 0 1 + ⊢
	in ← d¨∊(/⍨/) ⍉(⍎¨@2)('URDL'∘⍳¨@1)⍉ ↑' '∘(≠⊆⊢)¨⍵
	p1←1 sim in
	p2←9 sim in
	p1 p2
}

day10 ← {
	v ← 1,(1,'na'⍳⊃¨⍵)⌿(+⍀1,{4=≢⍵:0⋄⍎5↓⍵}¨⍵)
	p1←v(⊢+.×I)40×.5-⍨⍳6
	p2←'.#'I 6 40⍴1≥|(⊢-40|⍳∘≢)v ⊣ ⎕io←0
	p1 p2
}

day11 ← {
	⎕io ← 0
	sr ← {(⊣⌿⍺),⍵,⊢⌿⍺}
	l o d x y ← 1↓↓⍉('+*',⎕D)∘(∊⍨⊆⊢)¨↑(×∘≢¨⊆⊢)⍵
	o ← '×'⍨@('*'∘=)¨(∊'()'sr 3⌽⍤↑'⊢⊢'sr⊢)¨o
	A ← ⍉↑(⊂o),(d x y) ← ∊¨1↓(l d x y) ← ⍎¨¨¨(l d x y)
	_r ← {
		l ← a⊃⊃⌽(a c q) ← ⍵
		0=≢l : (a+1) c q
		(o d x y) ← a⌷⍺
		b ← (x y) I 0≠d|v ← ⍺⍺ ⍎ o,'l'
		q[a] ↓⍨← c[a] +← ≢l
		q[b]  ,← v
		(a+1) c q
	}
	_g_ ← {⍺(⍺⍺_r)⍣⍵⍵⊢0⍨@0⊢⍵}
	_h_← {⊃2×⌿(⊂∘⍒⌷⊢) 1⊃ ⍺ (⍺⍺_g_(≢⍵)⍣⍵⍵) (0 (0⍨¨⍵) ⍵)}
	p1←A    (⌊÷∘3) _h_ 00020 ⊢ l
	p2←A ((×⌿d)∘|) _h_ 10000 ⊢ l
	p1 p2
}

day12 ← {
	pd ← (1+⍴) ↑ ⊢
	st ← 3 1 2 ⍉∘↑ ¯1 1 (⊖¨,⌽¨) ⊂
	fx ← 'a'⍨@(=∘'S') 'z'⍨@(=∘'E')
	_to_ ← {
		f ← (1≥st-⍤1 0⊢) ⎕UCS fx ⍵
		s e ← (⍺⍺ ⍵⍵) ∊⍨¨ ⊂ ⍵
		n ← 0 ⋄ n ⊣ {n+←1 ⋄ ∨/f∧st ⍵}⍣(1∊e∧⊣) s
	}
	p1 ← ('E' _to_ 'S') pd ↑⍵
	p2 ← ('E' _to_ 'Sa') pd ↑⍵
	p1 p2
}

day13 ← { ⍝ TAO works only due to coincidence ?
	fx ← ⍎¨('\['⎕R'(⊂')∘('\]'⎕R',⍬)')∘('(\d+)'⎕R'[\1]')
	dp ← fx '[[2]]' '[[6]]'
	in ← ↑fx¨(×∘≢¨⊆⊢)⍵
	(∊in) ← ⊂∘,¨∊in ⍝ fixed ?
	p1 ← +/⍸</⍋⍤1⊢in
	p2 ← ×⌿2↑⍋⍋dp,,in
	p1 p2
}

day14 ← {
	⎕io ← 0
	d ← (1 0) (1 ¯1) (1 1) (0 0)
	p ← ⊃,⌿(+⍀1∘↑,(+⌿¨∘|⊢⍤⌿×)∘(2-⍨/⊢))¨⌽∘⍎¨¨' ->'∘(~⍤∊⍨⊆⊢)¨⍵
	c ← 0≠ (⍸⍣¯1) I∘⍋⍨ p - ⊂0,m ← ⌊⌿⊢/↑p
	a ← 500-m
	p1 ← +⌿∊c{0::⍵⋄s←(⍺∨⍵){⍵+d[⍺[d+⍵]⍳0]}⍣≡⊂0,a⋄(1@s)⍵}⍣≡0∧c
	k ← (-⌽1↑⍨1+2×⊢)≢c
	c ← 1⍪⍨0⍪⍨(a-≢c)⌽(≢k)↑[1]c
	p2 ← {f⊣{z⊣f+←+⌿z←⍺<⊃∨⌿¯1 0 1⌽¨⊂⍵}⌿↓⍵⊣f←1}⊖k⍪1↓c
	p1 p2
}

day15 ← { ⍝ Part 2 needs ~ 10 sec
	⎕io ← 0
	(Sx Sy Bx By) ← ⊂[0]↑('-',⎕D)∘(⍎¨∊⍨⊆⊢)¨⍵
	zo ← 0 1⍴⍨≢
	d ← +⌿↑|Sx Sy-Bx By
	rg ← ↑(⊂0 1)+Sx(-,+)¨d-Sy|⍤-⊢ ⍝ Ranges that each sensor covers
	vd ← </⊢⍤⌿⊢                   ⍝ Valid ranges
	kl ← (I∘⍋⍨ ⊢,zo) ⍪∘,          ⍝ Part of Klee's algo
	p1 ← {
		a b ← ↓⍉kl vd rg ⍵        ⍝ a: x-coordinates, b: start or end
		se ← (1,2∨/0=+\¯1*b)⌿a    ⍝ Ranges: start1 end1 start2 end2 ...
		ln ← +/-⍨/↑(~∘zo⊂⊢)se     ⍝ # Covered cells
		bc ← +/~2|se⍸∪Bx⌿⍨By=⍵    ⍝ # Covered beacons
		ln-bc
	} 2000000
	1:p1 'Too Slow'
	N ← 4000000 ⊣ dr ← (1 ¯1)(¯1 1)
	p2 ← 0 {
		a b ← ↓⍉kl 0⌈N⌊ vd ⍵  ⍝ a: x-coordinates, b: start or end
		fe ← (0⍳⍨+\¯1*b)⊃a    ⍝ The firs non-covered x-coordinate
		fe≢N:⍺+4000000×fe
		(⍺+1) ∇ ⍵+↑dr[⍺<Sy]
	} rg 0
	p1 p2
}

day16 ← {⍬⍬} ⍝WIP
day16 ← { ⎕io ← 0
	(r f t) ← (∊¨¨@0 1)⊂[0]↑(⎕A,⎕D)∘(↑¨0 1 1 1⊂∊⍨⊆⊢)¨⍵
	v ← (r≡¨⊂'AA')∨0≠f ← ⍎¨ f
}

day17 ← {
	T ← (1 4⍴1) (3 3⍴0 1 0 1 1 1 0 1 0) (3 3⍴0 0 1 0 0 1 1 1 1) (⍪4⍴1) (2 2⍴ 1)  
	M ← 1 9⍴1
	W ← 1⌽9↑1 1
	H ← 1-⍨1⊥∨/
	ad ← {(i v)←⍵ ⋄ (i⊃v) (((≢v)|1+i) v)} 
	D ← 0 (¯1*'<'=⍵)
	S ← 0 T
	t ← 0
    h ← 0
    AA ← {(⍺⍺⍣1e6)⍵}
    BB ← {
		(r S) ∘← ad S
		M ⊢← ⊖ ((≢r)+3+1+H ⍵) ↑⊖⍵
		W ⊢← (⍴M) ⍴ W
		r ← (⊂0 3)+⍸r
		_ ← (M∨W){
			(d D) ∘← ad D
			f ← ⍵
            r ⊢← r+⊂0 d×~1∊⍺[r+⊂0 d]
			⍝R∘←R⌽⍨d×~1∊(M∨W)∧d⌽R
			⍝⎕←⍕d
            r ⊢← r+⊂1 0×~f←1∊M[r+⊂1 0]
			⍝R∘←R⊖⍨¯1×f+←~1∊M∧¯1⊖R
			⍝⎕←' #@'[(M∨W)+2×R]
            ⍝⎕←' #@'[(2@r)⍺]
			⍝_←⎕dl .4
			f
		}⍣⊣  0

        1000<≢M: {
            h ⊢← h + 500
            M ⊢← ¯500 ↓ M
            W ⊢← 500 ↑ W
            (1@r)M
        }⍬
        (1@r)M
    }
    h + H BB AA AA  M
}

day17 ← {⍬⍬} ⍝ WIP

day18 ← {
	_EA ← {⍺(⍺⍺{⍵⍵≤0:⍵⋄⍺(⊣⍺⍺∇∇(⍵⍵-1)⍺⍺⍤⍵⍵)⍵}(⍴⍴⍵))⍵}   ⍝ Every Axis
	_EW ← {⍺(⍺⍺{⍵⍵≤0:⍬⋄⍺(⍺⍺∇∇(⍵⍵-1),⍺⍺⍤⍵⍵¨)⍵}(⍴⍴⍵))⊂⍵} ⍝ Each ⍵ and Axis
	SW ← {⍺⍪⍵⍪⍺} ⍝ Sandwitch
	WP ← SW _EA  ⍝ Wrap {⍺(SW⍤1)⍺(SW⍤2)⍺(SW⍤3)⍵}
	NB ←  ⊖ _EW  ⍝ Neighbors (⊖⍤1¨,⊖⍤2¨,⊖⍤3¨)∘⊂
	SA ← +/∘∊ ⊂ ≠¨ 1 NB ⊢
	bk ← (⍸⍣¯1) ⎕io + (⊢-⌊⌿) I∘⍋⍨ ⍎¨⍵
	p1 ← (SA 0 WP ⊢) bk
	p2 ← (SA ~ (⊣ ∧ ¯1 1 ∨⌿∘↑⍤NB ⊢)⍣≡⍥(1∘WP) 0⍨¨) bk
	p1 p2
}

day19 ← {
	 fmt ← {¯5 5∘↑¨↑¨I∘1 3 2¨@4¨3∘↑¨¨1∘↓¨1 1 1 1 0 1 0∘⊂¨⎕D∘(⍎¨∊⍨⊆⊢)¨⍵}
	 (⍉1⌽⌽⊖A){(t r o)←⍵ ⋄ c ← ⍺[;m←1⍳⍨o∧.≥⍺] ⋄ o +← r-c ⋄ r[m] +← 1 ⋄ (t+1) r o}⍣24⊢ 0 (1 0 0 0 0)(0 0 0 0 0)
}
day24 ← {
	⎕io ← 0
	in ← ↑⍵
	bz ← '<>^v'=¨⊂(1↓⍉∘⊖)⍣4⊢in
	wl ← '#'=in
	ed ← ⊖⌽ st ← ¯1⌽(⍴in)↑1
	BL ← 1 ¯1∘(⊣(⊖¨@2 3)(⌽¨@0 1))
	SM ← {
		(n ex bz)←⍵
		⍺∨.∧⍥,ex: n bz
		bz ← BL bz
		av ← ~wl∨¯1⊖¯1⌽(⍴⍺)↑⊃∨⌿bz
		ex ← av∧⊃∨⌿1 ¯1(⊢,⊖¨,⌽¨)⊂ex
		⍺ ∇ (n+1) ex bz
	}
	(p1 bz) ← ed SM  0 st bz
	(tt bz) ← st SM p1 ed bz
	(p2 bz) ← ed SM tt st bz
	p1 p2
}

day25 ← {
	⎕io ← 0
	SF ← ¯2 + '=-012'∘⍳
	Enc ← (SF⍣¯1) {0(=∘⊃↓⊢)p+(1∘⌽-5∘×)2<p←0,⍵}⍣≡
	Dec ← 5 ⊥ SF
	p1 ← Enc (5∘⊥⍣¯1) +⌿Dec¨⍵
	p1 ⍬
}

Test¨,16

⍝ vim: ft=apl
