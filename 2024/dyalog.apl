#!/usr/bin/env dyalogscript
raw ← { ⊃ ⎕nget ('in/',⍵,'.in') 0 }
lines ← { ⊃ ⎕nget ('in/',⍵,'.in') 1 }

d01a ← { +⍥|.-⌿{⍵[⍋⍵]}¨↓⍉↑⍎¨⍵ } ⍝ lines '01'
d01b ← { {+⌿⍺+.×⍺∘.=⍵}⌿↓⍉↑⍎¨⍵ } ⍝ lines '01'
