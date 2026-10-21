	db TOGETIC ; 011

	db  55,  40,  85,  40,  80, 105 ; 405 BST
	evs  0,   0,   1,   0,   1,   2
	;   hp  atk  def  spd  sat  sdf

	db FAIRY, FLYING ; type
	db 75 ; catch rate
	db 142 ; base exp
	db WHT_APRICORN, MIRACLEBERRY ; items
	db GENDER_F50 ; gender ratio
	db 10 ; step cycles to hatch
	INCBIN "gfx/pokemon/togetic/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_FAST ; growth rate
	dn EGG_FLYING, EGG_FAIRY ; egg groups

	; tm/hm learnset
	tmhm
	; end
