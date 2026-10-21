	db CRADILY ; 227

	db  96,  81,  97,  43,  81, 107 ; 505 BST
	evs  2,   1,   2,   0,   1,   2
	;   hp  atk  def  spd  sat  sdf

	db ROCK, GRASS ; type
	db 45 ; catch rate
	db 225 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 30 ; step cycles to hatch
	INCBIN "gfx/pokemon/cradily/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_WATER_3, EGG_WATER_3 ; egg groups

	; tm/hm learnset
	tmhm
	; end
