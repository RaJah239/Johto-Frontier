	db TROPIUS ; 128

	db  99,  68,  93,  51,  92,  97 ; 500 BST
	evs  2,   1,   2,   0,   2,   2
	;   hp  atk  def  spd  sat  sdf

	db GRASS, FLYING ; type
	db 75 ; catch rate
	db 200 ; base exp
	db NO_ITEM, MIRACLE_SEED ; items
	db GENDER_F50 ; gender ratio
	db 25 ; step cycles to hatch
	INCBIN "gfx/pokemon/tropius/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_MONSTER, EGG_PLANT ; egg groups

	; tm/hm learnset
	tmhm
	; end
