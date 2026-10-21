	db TANGROWTH ; 139

	db  100, 100,  88,  50, 110,  87 ; 535 BST
	evs   2,   2,   1,   0,   2,   1
	;    hp  atk  def  spd  sat  sdf

	db GRASS, WATER ; type
	db 30 ; catch rate
	db 210 ; base exp
	db GRN_APRICORN, MIRACLE_SEED ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/tangrowth/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_PLANT, EGG_PLANT ; egg groups

	; tm/hm learnset
	tmhm
	; end
