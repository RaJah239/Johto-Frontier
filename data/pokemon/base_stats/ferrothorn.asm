	db FERROTHORN ; 133

	db  85,  94, 131,  20,  59, 116 ; 505 BST
	evs  1,   2,   3,   0,   0,   2
	;   hp  atk  def  spd  sat  sdf

	db GRASS, STEEL ; type
	db 90 ; catch rate
	db 205 ; base exp
	db YLW_APRICORN, FOCUS_SASH ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/ferrothorn/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_PLANT, EGG_MINERAL ; egg groups

	; tm/hm learnset
	tmhm
	; end
