	db CORSOLA ; 164

	db  65,  95, 115,  45,  65, 115 ; 500 BST
	evs  1,   2,   2,   0,   1,   2
	;   hp  atk  def  spd  sat  sdf

	db ROCK, FAIRY ; type
	db 60 ; catch rate
	db 200 ; base exp
	db PSNCUREBERRY, HARD_STONE ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/corsola/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_FAST ; growth rate
	dn EGG_WATER_1, EGG_WATER_3 ; egg groups

	; tm/hm learnset
	tmhm
	; end
