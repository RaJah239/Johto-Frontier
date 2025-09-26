	db GHOLDENGO ; 252

	db  87,  60,  95,  84, 133,  84
	evs  0,   0,   0,   0,   2,   0
	;   hp  atk  def  spd  sat  sdf

	db STEEL, GHOST ; type
	db 45 ; catch rate
	db 220 ; base exp
	db NUGGET, NUGGET ; items
	db GENDER_UNKNOWN ; gender ratio
	db 50 ; step cycles to hatch
	INCBIN "gfx/pokemon/gholdengo/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm
	; end
