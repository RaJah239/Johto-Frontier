	db OCTILLERY ; 224

	;   hp  atk  def  spd  sat  sdf
	db  80,  80,  80,  70, 115,  80 ; BST - 505
	evs  1,   1,   1,   1,   2,   1

	db WATER, FIRE ; type
	db 75 ; catch rate
	db 164 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/octillery/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_WATER_1, EGG_WATER_2 ; egg groups

	; tm/hm learnset
	tmhm
	; end
