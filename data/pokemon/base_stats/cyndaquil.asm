	db CYNDAQUIL ; 001

	;   hp  atk  def  spd  sat  sdf ; 309 BST
	db  44,  58,  44,  61,  58,  44
	evs  0,   0,   0,   1,   0,   0

	db FIRE, GROUND ; type
	db 45 ; catch rate
	db 62 ; base exp
	db BERRY, RED_APRICORN ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/cyndaquil/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
