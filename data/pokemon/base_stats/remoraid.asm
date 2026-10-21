	db REMORAID ; 167

	db  35,  65,  35,  65,  65,  35 ; 300 BST
	evs  0,   1,   0,   1,   1,   0
	;   hp  atk  def  spd  sat  sdf

	db WATER, WATER ; type
	db 190 ; catch rate
	db 75 ; base exp
	db WHT_APRICORN, BLU_APRICORN ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/remoraid/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_WATER_1, EGG_WATER_2 ; egg groups

	; tm/hm learnset
	tmhm
	; end
