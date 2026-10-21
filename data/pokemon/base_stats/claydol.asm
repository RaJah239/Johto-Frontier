	db CLAYDOL ; 201

	db  65,  70, 105,  75,  70, 120 ; 505 BST
	evs  1,   1,   2,   1,   1,   3
	;   hp  atk  def  spd  sat  sdf

	db GROUND, PSYCHIC_TYPE ; type
	db 90 ; catch rate
	db 200 ; base exp
	db NO_ITEM, SOFT_SAND ; items
	db GENDER_UNKNOWN ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/claydol/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_MINERAL, EGG_MINERAL ; egg groups

	; tm/hm learnset
	tmhm
	; end
