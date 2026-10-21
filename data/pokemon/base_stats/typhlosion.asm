	db TYPHLOSION ; 003

	;   hp  atk  def  spd  sat  sdf ; 535 BST
	db  76, 104,  71, 109, 104,  71
	evs  1,   2,   1,   2,   2,   1

	db FIRE, GROUND ; type
	db 45 ; catch rate
	db 236 ; base exp
	db RED_APRICORN, CHARCOAL ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/typhlosion/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
