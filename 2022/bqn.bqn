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

Day5 ← {
	Dec ← {𝕨|>⌊∘÷`⌾⌽𝕨«˜<𝕩} # From BQN-Dyalog dict..
	stack ← (' '⊸≠<∘/˘⊢) (1+4×↕9) ⊏ (⍉>8↑𝕩)
	moves ← (<0‿1‿1) -˜ (100‿10‿10⊸Dec∘•BQN∊⟜"0987654321"/⊢)¨10↓𝕩
	_step ← {	⟨n,f,t⟩ ← 𝕨 ⋄ n⊸↓⌾(f⊸⊑) (𝔽n↑f⊑𝕩)⊸∾⌾(t⊸⊑) 𝕩 }
	_proc ← {⊑¨ 𝔽_step´⌽(<𝕨)∾𝕩}
	•Show stack ⌽_proc moves
	•Show stack ⊢_proc moves
}

Day12 ← { # Translated from apl solution
	St ← > ⟨«,«˘,»,»˘⟩ {𝕎𝕩}¨ <  # Nudge is awesome !
	_rw_ ← {𝕩+(𝕩=𝕗)×(𝕘-𝕗)}      # Replaced with
	Fx ← ('S'_rw_'a') ('E'_rw_'z')
	_to_ ← {
		s‿e ← (<𝕩) ∊¨ 𝕗‿𝕘
		f ← (1≥St-⎉2⊢) (Fx-@˜) 𝕩
		0 { ∨´⥊e∧𝕩 ? 𝕨 ; (𝕨+1) 𝕊 (∨˝f∧St𝕩) } s
		# Note: The right operand of ⍟ calculates the number
		#       of iterations, while the one in ⍣ determines
		#       the end condition by the results from two
		#       adjacent iterations.
	}
	•Show ( "E" _to_  "S" ) >𝕩
	•Show ( "E" _to_ "Sa" ) >𝕩
}

#Day1 •FLines "./input/1.in"
#Day2 •FLines "./input/2.in"
#Day3 •FLines "./input/3.in"
Day12 •FLines "./input/12.in"

# vim: ft=bqn
