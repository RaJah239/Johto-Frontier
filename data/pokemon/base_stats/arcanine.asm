	db ARCANINE ; 097

	db  90, 110,  80,  95, 100,  80 ; 555 BST
	evs  2,   2,   1,   2,   2,   1
	;   hp  atk  def  spd  sat  sdf

	db FIRE, NORMAL ; type
	db 75 ; catch rate
	db 215 ; base exp
	db BURNT_BERRY, CHARCOAL ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/arcanine/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
