	db LUGIA ; 241

	db 106,  90, 130, 110,  90, 154 ; 680 BST
	evs  2,   2,   3,   2,   2,   3
	;   hp  atk  def  spd  sat  sdf

	db WATER, FLYING ; type
	db 3 ; catch rate
	db 255 ; base exp
	db LEFTOVERS, LEFTOVERS ; items
	db GENDER_UNKNOWN ; gender ratio
	db 120 ; step cycles to hatch
	INCBIN "gfx/pokemon/lugia/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm
	; end
