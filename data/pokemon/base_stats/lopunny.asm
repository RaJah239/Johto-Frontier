	db LOPUNNY ; 049

	db  65,  95,  84, 105,  59,  97 ; 505 BST
	evs  1,   2,   1,   2,   0,   2
	;   hp  atk  def  spd  sat  sdf

	db NORMAL, FIGHTING ; type
	db 60 ; catch rate
	db 210 ; base exp
	db PRZCUREBERRY, BLACKBELT_I ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/lopunny/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_HUMANSHAPE ; egg groups

	; tm/hm learnset
	tmhm
	; end
