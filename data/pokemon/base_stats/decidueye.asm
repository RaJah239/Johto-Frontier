	db DECIDUEYE ; 034

	db   80,  50,  90,  85, 135,  95 ; 535
	evs   1,   0,   2,   1,   3,   2
	;   hp  atk  def  spd  sat  sdf

	db GRASS, GHOST ; type
	db 45 ; catch rate
	db 236 ; base exp
	db MINT_BERRY, SPELL_TAG ; items
	db GENDER_F50 ; gender ratio
	db 15 ; step cycles to hatch
	INCBIN "gfx/pokemon/decidueye/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_FLYING, EGG_FLYING ; egg groups

	; tm/hm learnset
	tmhm
	; end
