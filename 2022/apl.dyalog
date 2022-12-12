#!/sbin/dyalogscript
indir ← './input'

I ← ⌷⍨∘⊂

FL ← { ⊃⎕NGET ⍵ 1 }

∇ in ← CB
	in ← ⎕SH 'xclip -sel clip -o'
∇

Test ← {
	n←⍕⍵
	tab ← '    ' ,⍤1 ⍕
	⎕pp←12
	⎕←'--------- [day',n,']'
	p1 p2 ← ⍎'day',n,' FL indir,''/',n,'.in'''
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
	st ← ((⊂2×⍳4)⌷,)¨{⊂⍵}⌺3 3
	fx ← 'a'⍨@(=∘'S') 'z'⍨@(=∘'E')
	_to_ ← {
		f ← ∊(1≥st-⊢) ⎕UCS fx ⍵
		⍝f ← (1≥st-⊢) ⎕UCS fx ⍵
		s e ← (⍺⍺ ⍵⍵) ∊⍨¨ ⊂⍵ 
		n ← 0 ⋄ n ⊣ {n+←1 ⋄ ∨/(4,⍨⍴⍵)⍴f∧∊st ⍵}⍣(1∊e∧⊣) s
		⍝           {n+←1 ⋄ 1∊¨f∧st ⍵}⍣(1∊e∧⊣) s ⍝ simplier but slower
	}
	p1 ← ('E' _to_ 'S') ↑⍵
	p2 ← ('E' _to_ 'Sa') ↑⍵
	p1 p2
}

Test¨,12

⍝ vim: ft=apl
