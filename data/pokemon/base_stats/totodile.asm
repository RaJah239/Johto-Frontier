	db TOTODILE ; 004

	;   hp  atk  def  spd  sat  sdf ; 309 BST
	db  50,  65,  64,  43,  39,  48
	evs  0,   1,   1,   0,   0,   0

	db WATER, DARK ; type
	db 45 ; catch rate
	db 63 ; base exp
	db BERRY, BLU_APRICORN ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/totodile/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_MONSTER, EGG_WATER_1 ; egg groups

	; tm/hm learnset
	tmhm
	; end
