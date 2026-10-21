	db ABOMASNOW ; 199

	db  101,  92,  75,  60,  92,  85 ; 505 BST
	evs   2,   2,   1,   1,   2,   1
	;    hp  atk  def  spd  sat  sdf

	db GRASS, ICE ; type
	db 60 ; catch rate
	db 223 ; base exp
	db WHT_APRICORN, MIRACLE_SEED ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/abomasnow/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_MONSTER, EGG_PLANT ; egg groups

	; tm/hm learnset
	tmhm
	; end
