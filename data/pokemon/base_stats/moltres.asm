	db MOLTRES ; 239

	db  90, 100,  90, 110, 125,  85 ; 600 BST
	evs  2,   2,   2,   2,   3,   1
	;   hp  atk  def  spd  sat  sdf

	db FIRE, FLYING ; type
	db 3 ; catch rate
	db 240 ; base exp
	db CHARCOAL, CHARCOAL ; items
	db GENDER_UNKNOWN ; gender ratio
	db 80 ; step cycles to hatch
	INCBIN "gfx/pokemon/moltres/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm
	; end
