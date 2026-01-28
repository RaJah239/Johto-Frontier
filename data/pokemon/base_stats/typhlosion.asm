	db TYPHLOSION ; 3

	;   hp  atk  def  spd  sat  sdf
	db  76, 104,  71, 109, 104,  71 ; 535 BST
	evs  1,   2,   1,   2,   2,   1

	db FIRE, GROUND ; type
	db 45 ; catch rate
	db 100 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F12_5 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/typhlosion/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
