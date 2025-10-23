	db ROTOM ; Species ID

	;   hp  atk  def  spd  sat  sdf
	db  60,  40,  92,  96, 120,  92 ; BST 500
	evs  0,   0,   0,   0,   0,   2

	db ELECTRIC, GHOST ; type
	db 3 ; catch rate
	db 200 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_UNKNOWN ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/rotom/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm
	; end
