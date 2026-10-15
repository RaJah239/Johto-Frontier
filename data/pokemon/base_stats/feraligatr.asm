	db FERALIGATR ; 006

	;   hp  atk  def  spd  sat  sdf ; 535 BST
	db  85, 125, 107,  78,  69,  71
	evs  1,   3,   2,   1,   1,   1

	db WATER, DARK ; type
	db 45 ; catch rate
	db 239 ; base exp
	db BLU_APRICORN, MYSTIC_WATER ; items
	db GENDER_F12_5 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/feraligatr/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_MONSTER, EGG_WATER_1 ; egg groups

	; tm/hm learnset
	tmhm
	; end
