	db RAPIDASH ; 111

	db  105, 140,  55,  95,  30,  55 ; 485 BST
	evs   2,   3,   0,   2,   0,   0
	;    hp  atk  def  spd  sat  sdf

	db FIRE, FAIRY ; type
	db 60 ; catch rate
	db 210 ; base exp
	db RED_APRICORN, POLKADOT_BOW ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/rapidash/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
