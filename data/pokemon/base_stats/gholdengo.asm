	db GHOLDENGO ; 231

	;   hp  atk  def  spd  sat  sdf
	db  87,  60,  95,  84, 133,  91 ; 550 BST
	evs  1,   1,   2,   1,   3,   2

	db STEEL, GHOST ; type
	db 3 ; catch rate
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
