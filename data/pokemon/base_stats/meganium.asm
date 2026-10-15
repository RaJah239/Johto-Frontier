	db MEGANIUM ; 009

	;   hp  atk  def  spd  sat  sdf ; 535 BST
	db 120, 100, 100,  63,  52, 100
	evs  2,   2,   2,   1,   1,   2

	db GRASS, FAIRY ; type
	db 45 ; catch rate
	db 236 ; base exp
	db GRN_APRICORN, MIRACLE_SEED ; items
	db GENDER_F12_5 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/meganium/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_MONSTER, EGG_PLANT ; egg groups

	; tm/hm learnset
	tmhm
	; end
