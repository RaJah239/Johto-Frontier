	db ARTICUNO ; 238

	db  90,  85, 100, 105,  95, 125 ; 600 BST
	evs  2,   1,   2,   2,   2,   3
	;   hp  atk  def  spd  sat  sdf

	db ICE, FLYING ; type
	db 3 ; catch rate
	db 240 ; base exp
	db NEVERMELTICE, NEVERMELTICE ; items
	db GENDER_UNKNOWN ; gender ratio
	db 80 ; step cycles to hatch
	INCBIN "gfx/pokemon/articuno/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm
	; end
