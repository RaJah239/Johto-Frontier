	db SUICUNE ; 244

	db 100,  75, 125,  85,  90, 125 ; 600 BST
	evs  2,   1,   3,   1,   2,   3
	;   hp  atk  def  spd  sat  sdf

	db WATER, WATER ; type
	db 3 ; catch rate
	db 240 ; base exp
	db MYSTIC_WATER, MYSTIC_WATER ; items
	db GENDER_UNKNOWN ; gender ratio
	db 80 ; step cycles to hatch
	INCBIN "gfx/pokemon/suicune/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm
	; end
