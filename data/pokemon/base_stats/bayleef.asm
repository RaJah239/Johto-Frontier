	db BAYLEEF ; 008

	;   hp  atk  def  spd  sat  sdf
	db  75,  75,  80,  50,  50,  80 ; 410 BST
	evs  1,   0,   1,   0,   0,   1

	db GRASS, FAIRY ; type
	db 45 ; catch rate
	db 142 ; base exp
	db BERRY, MIRACLE_SEED ; items
	db GENDER_F12_5 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/bayleef/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_MONSTER, EGG_PLANT ; egg groups

	; tm/hm learnset
	tmhm
	; end
