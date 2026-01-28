	db FERALIGATR ; 6

	;   hp  atk  def  spd  sat  sdf
	db  85, 110, 100,  78,  79,  83 ; 535 BST
	evs  1,   2,   2,   1,   1,   1

	db WATER, DARK ; type
	db 45 ; catch rate
	db 100 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F12_5 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/feraligatr/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_MONSTER, EGG_WATER_1 ; egg groups

	; tm/hm learnset
	tmhm
	; end
