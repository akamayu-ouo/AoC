#!/sbin/bqn
Day1 ← {
	•Out "--------- [day1]"
	# Still don't know how to split a list :(
	top3 ← 3↑∨ -⟜» (0⊸=/+`) 0∾˜ (•BQN'0'⊸∾)¨𝕩
	•Show  ⊑top3
	•Show +´top3
}

Day2 ← {
	•Out "--------- [day2]"
	in ← (-⟜"AX"0‿2⊸⊏)¨𝕩
	S ← +´·∾1‿0+˝∘+1‿3×⊢
	•Show S (⊢´¨⋈ 3|4--´¨)in
	•Show S (⊢´¨⋈˜3|2++´¨)in
}

Day3 ← {
	•Out "--------- [day3]"
	
	•Show 2‿∘⊸⥊¨ 10↑𝕩
}

Day1 •FLines "./input/1.in"
Day2 •FLines "./input/2.in"
Day3 •FLines "./input/3.in"

# vim: ft=bqn
