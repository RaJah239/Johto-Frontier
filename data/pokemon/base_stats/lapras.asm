	db LAPRAS ; 179

	db 130,  85,  80,  60,  85,  95 ; 535 BST
	evs  3,   1,   1,   1,   1,   2
	;   hp  atk  def  spd  sat  sdf

	db DRAGON, ICE ; type
	db 45 ; catch rate
	db 236 ; base exp
	db ICE_BERRY, DRAGON_FANG ; items
	db GENDER_F50 ; gender ratio
	db 40 ; step cycles to hatch
	INCBIN "gfx/pokemon/lapras/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_MONSTER, EGG_WATER_1 ; egg groups

	; tm/hm learnset
	tmhm
	; end
