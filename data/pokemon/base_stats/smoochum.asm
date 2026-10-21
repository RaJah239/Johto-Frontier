	db SMOOCHUM ; 187

	db  45,  30,  15,  65,  85,  65 ; 305 BST
	evs  0,   0,   0,   1,   1,   1
	;   hp  atk  def  spd  sat  sdf

	db ICE, PSYCHIC_TYPE ; type
	db 45 ; catch rate
	db 60 ; base exp
	db ICE_BERRY, NEVERMELTICE ; items
	db GENDER_F100 ; gender ratio
	db 25 ; step cycles to hatch
	INCBIN "gfx/pokemon/smoochum/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm
	; end
