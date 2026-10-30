	db SUNFLORA ; 051

	db  95,  95,  85,  30, 125,  75 ; 505 BST
	evs  1,   1,   0,   0,   3,   2
	;   hp  atk  def  spd  sat  sdf

	db GRASS, FIRE ; type
	db 120 ; catch rate
	db 200 ; base exp
	db GRN_APRICORN, SUN_STONE ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/sunflora/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_PLANT, EGG_PLANT ; egg groups

	; tm/hm learnset
	tmhm
	; end
