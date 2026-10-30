	db DODRIO ; 109

	;   hp  atk  def  spd  sat  sdf
	db  80, 120,  77, 118,  50,  60 ; 505 BST
	evs  1,   3,   1,   2,   0,   1

	db FLYING, FIGHTING ; type
	db 45 ; catch rate
	db 210 ; base exp
	db MINT_BERRY, SHARP_BEAK ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/dodrio/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_FLYING, EGG_FLYING ; egg groups

	; tm/hm learnset
	tmhm
	; end
