	db HYPNO ; 145

	db  85,  90,  80,  67,  68, 115 ; 505 BST
	evs  1,   2,   1,   1,   1,   2
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC_TYPE, DARK ; type
	db 75 ; catch rate
	db 205 ; base exp
	db MINT_BERRY, BLACKGLASSES ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/hypno/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_HUMANSHAPE, EGG_HUMANSHAPE ; egg groups

	; tm/hm learnset
	tmhm
	; end
