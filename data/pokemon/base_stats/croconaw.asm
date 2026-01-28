	db CROCONAW ; 5

	;   hp  atk  def  spd  sat  sdf
	db  65,  80,  80,  58,  59,  63 ; 405 BST
	evs  1,   1,   1,   0,   0,   1

	db WATER, DARK ; type
	db 45 ; catch rate
	db 75 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F12_5 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/croconaw/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_MONSTER, EGG_WATER_1 ; egg groups

	; tm/hm learnset
	tmhm
	; end
