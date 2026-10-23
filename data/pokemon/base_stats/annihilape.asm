	db ANNIHILAPE ; 131

	db  85,  80, 60,  95,  115,  70 ; 505 BST
	evs  2,   1,   1,   2,   2,   1
	;   hp  atk  def  spd  sat  sdf

	db FIGHTING, GHOST ; type
	db 75 ; catch rate
	db 210 ; base exp
	db BLK_APRICORN, BLACKBELT_I ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/annihilape/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
