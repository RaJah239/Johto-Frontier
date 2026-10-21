	db DELIBIRD ; 186

	db  60, 100,  45, 125, 125,  45 ; 500 BST
	evs  1,   2,   0,   3,   3,   0
	;   hp  atk  def  spd  sat  sdf

	db ICE, FAIRY ; type
	db 45 ; catch rate
	db 200 ; base exp
	db NO_ITEM, FOCUS_SASH ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/delibird/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_FAST ; growth rate
	dn EGG_WATER_1, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
