	db NIDOKING ; 034

	db  81,  92,  77,  85,  85,  75
	evs  0,   3,   0,   0,   0,   0
	;   hp  atk  def  spd  sat  sdf

	db POISON, GROUND ; type
	db 45 ; catch rate
	db 195 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F0 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/nidoking/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_MONSTER, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
