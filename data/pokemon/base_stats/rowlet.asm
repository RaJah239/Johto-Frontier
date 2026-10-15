	db ROWLET ; 032

	db  68,  55,  55,  42,  50,  50 ; 320 BST
	evs  1,   0,   0,   0,   0,   0
	;   hp  atk  def  spd  sat  sdf

	db GRASS, FLYING ; type
	db 45 ; catch rate
	db 64 ; base exp
	db BERRY, GRN_APRICORN ; items
	db GENDER_F12_5 ; gender ratio
	db 15 ; step cycles to hatch
	INCBIN "gfx/pokemon/rowlet/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_FLYING, EGG_FLYING ; egg groups

	; tm/hm learnset
	tmhm
	; end
