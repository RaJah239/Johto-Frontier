	db UNOWN ; 246

	db  72,  72,  72,  72,  72,  72 ; 432 BST
	evs  1,   1,   1,   1,   1,   1
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC_TYPE, PSYCHIC_TYPE ; type
	db 225 ; catch rate
	db 120 ; base exp
	db NO_ITEM, MIRACLEBERRY ; items
	db GENDER_UNKNOWN ; gender ratio
	db 40 ; step cycles to hatch
	INCBIN "gfx/pokemon/unown_a/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm
	; end
