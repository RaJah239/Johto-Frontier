	db TANGROWTH ; Species ID

	db  100, 100, 125,  50, 110,  50
	evs   0,   0,   2,   0,   0,   0
	;    hp  atk  def  spd  sat  sdf

	db GRASS, WATER ; type
	db 30 ; catch rate
	db 200 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/tangrowth/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_PLANT, EGG_PLANT ; egg groups

	; tm/hm learnset
	tmhm
	; end
