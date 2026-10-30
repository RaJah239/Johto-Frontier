	db ARIADOS ; 117

	;   hp  atk  def  spd  sat  sdf
	db  70, 120,  70, 120,  55,  70 ; 505 BST
	evs  1,   3,   1,   3,   0,   1

	db BUG, DARK ; type
	db 90 ; catch rate
	db 205 ; base exp
	db GRN_APRICORN, SILVERPOWDER ; items
	db GENDER_F50 ; gender ratio
	db 15 ; step cycles to hatch
	INCBIN "gfx/pokemon/ariados/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_FAST ; growth rate
	dn EGG_BUG, EGG_BUG ; egg groups

	; tm/hm learnset
	tmhm
	; end
