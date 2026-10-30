	db GARCHOMP ; 105

	db 108, 130,  95, 102,  80,  85 ; 600 BST
	evs  2,   3,   2,   2,   1,   1
	;   hp  atk  def  spd  sat  sdf

	db DRAGON, GROUND ; type
	db 45 ; catch rate
	db 240 ; base exp
	db RED_APRICORN, LIFE_ORB ; items
	db GENDER_F50 ; gender ratio
	db 40 ; step cycles to hatch
	INCBIN "gfx/pokemon/garchomp/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_WATER_1, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
