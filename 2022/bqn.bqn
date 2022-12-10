#!/sbin/bqn

Day1 ← {
	# Still don't know how to split a list :(
	top3 ← 3↑∨ -⟜» (0⊸=/+`) 0∾˜ (•BQN'0'⊸∾)¨𝕩
	•Show  ⊑top3
	•Show +´top3
}

Day1 •FLines "./input/1.in"

# vim: ft=bqn
