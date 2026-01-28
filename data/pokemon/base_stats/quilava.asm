	db QUILAVA ; 2

	;   hp  atk  def  spd  sat  sdf
	db  64,  78,  52,  81,  78,  52 ; 405 BST
	evs  1,   1,   0,   1,   1,   0

	db FIRE, GROUND ; type
	db 45 ; catch rate
	db 75 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F12_5 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/quilava/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
