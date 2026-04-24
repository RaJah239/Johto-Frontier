	db MEW ; 151

	db 100, 100, 100, 100, 100, 100
	evs  3,   0,   0,   0,   0,   0
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC_TYPE, PSYCHIC_TYPE ; type
	db 45 ; catch rate
	db 64 ; base exp
	db MIRACLEBERRY, MIRACLEBERRY ; items
	db GENDER_UNKNOWN ; gender ratio
	db 120 ; step cycles to hatch
	INCBIN "gfx/pokemon/mew/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/tutor learnset
	tmhm HEADBUTT, \
		 FLAMETHROWER, \
		 THUNDERBOLT, \
		 ICE_BEAM, \
		 EXPLOSION, \ 
		 OUTRAGE, \
		 ROCK_SLIDE, \
		 SKY_ATTACK, \
		 SURF
	; end
