	db OCTILLERY ; 169

	;   hp  atk  def  spd  sat  sdf ; 505 BST
	db  80,  80,  80,  70, 115,  80
	evs  1,   1,   1,   1,   2,   1

	db WATER, FIRE ; type
	db 75 ; catch rate
	db 200 ; base exp
	db RED_APRICORN, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/octillery/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_WATER_1, EGG_WATER_2 ; egg groups

	; tm/hm learnset
	tmhm
	; end
