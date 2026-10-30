	db URSALUNA ; 064

	db 130, 140, 105,  50,  45,  80 ; 550 BST
	evs  3,   3,   2,   0,   0,   1
	;   hp  atk  def  spd  sat  sdf

	db GROUND, NORMAL ; type
	db 20 ; catch rate
	db 240 ; base exp
	db NO_ITEM, GOLD_BERRY ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/ursaluna/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
