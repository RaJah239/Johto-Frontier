	db IRON_MOTH ; 127

	db  85,  60,  65, 100, 135, 105 ; 550 BST
	evs  1,   1,   1,   2,   3,   2
	;   hp  atk  def  spd  sat  sdf

	db FIRE, POISON ; type
	db 3 ; catch rate
	db 255 ; base exp
	db PSNCUREBERRY, CHARCOAL ; items
	db GENDER_F50 ; gender ratio
	db 40 ; step cycles to hatch
	INCBIN "gfx/pokemon/iron_moth/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm
	; end
