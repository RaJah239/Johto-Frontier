	db KROOKODILE ; ef

	db  95, 117,  80,  92,  65,  70
	evs 0,   3,   0,   0,   0,   0
	;   hp  atk  def  spd  sat  sdf

	db GROUND, DARK ; type
	db 45 ; catch rate
	db 255 ; base exp (engine maximum)
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/krookodile/front.dimensions"
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
