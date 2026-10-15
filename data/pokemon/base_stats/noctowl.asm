	db NOCTOWL ; 054

	db 100,  60,  60,  70,  94, 121 ; 505 BST
	evs  2,   1,   1,   1,   2,   3
	;   hp  atk  def  spd  sat  sdf

	db NORMAL, FLYING ; type
	db 90 ; catch rate
	db 210 ; base exp
	db MINT_BERRY, TWISTEDSPOON ; items
	db GENDER_F50 ; gender ratio
	db 15 ; step cycles to hatch
	INCBIN "gfx/pokemon/noctowl/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_FLYING, EGG_FLYING ; egg groups

	; tm/hm learnset
	tmhm
	; end
