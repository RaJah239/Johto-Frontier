	db DARKRAI ; 232

	db  70,  90,  90, 125, 135,  90 ; 600 BST
	evs  1,   2,   2,   3,   3,   2
	;   hp  atk  def  spd  sat  sdf

	db DARK, DARK ; type
	db 3 ; catch rate
	db 240 ; base exp
	db BLACKGLASSES, BLACKGLASSES ; items
	db GENDER_UNKNOWN ; gender ratio
	db 120 ; step cycles to hatch
	INCBIN "gfx/pokemon/darkrai/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm
	; end
