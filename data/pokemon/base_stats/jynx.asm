	db JYNX ; 124

	db  65,  50,  35,  95, 115,  95
	evs  0,   0,   0,   0,   2,   0
	;   hp  atk  def  spd  sat  sdf

	db ICE, PSYCHIC_TYPE ; type
	db 45 ; catch rate
	db 137 ; base exp
	db ICE_BERRY, ICE_BERRY ; items
	db GENDER_F100 ; gender ratio
	db 25 ; step cycles to hatch
	INCBIN "gfx/pokemon/jynx/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_HUMANSHAPE, EGG_HUMANSHAPE ; egg groups

	; tm/hm learnset
	tmhm
	; end
