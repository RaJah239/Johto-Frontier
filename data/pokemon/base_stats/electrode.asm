	db ELECTRODE ; 158

	db  50,  60,  70, 150,  95,  80 ; 505 BST
	evs  1,   0,   1,   3,   2,   1
	;   hp  atk  def  spd  sat  sdf

	db ELECTRIC, GRASS ; type
	db 60 ; catch rate
	db 200 ; base exp
	db RED_APRICORN, NO_ITEM ; items
	db GENDER_UNKNOWN ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/electrode/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_MINERAL, EGG_MINERAL ; egg groups

	; tm/hm learnset
	tmhm
	; end
