	db DODRIO ; 110

	;   hp  atk  def  spd  sat  sdf
	db  80, 110,  77, 118,  60,  60 ; 505 BST
	evs  1,   2,   1,   2,   1,   1

	db FLYING, FIGHTING ; type
	db 45 ; catch rate
	db 95 ; base exp
	db NO_ITEM, SHARP_BEAK ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/dodrio/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_FLYING, EGG_FLYING ; egg groups

	; tm/hm learnset
	tmhm
	; end
