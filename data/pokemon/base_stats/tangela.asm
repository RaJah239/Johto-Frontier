	db TANGELA ; 138

	db  65,  55, 115,  60, 100,  40 ; 435 BST
	evs  1,   0,   2,   1,   2,   0
	;   hp  atk  def  spd  sat  sdf

	db GRASS, WATER ; type
	db 45 ; catch rate
	db 170 ; base exp
	db BLU_APRICORN, GRN_APRICORN ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/tangela/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_PLANT, EGG_PLANT ; egg groups

	; tm/hm learnset
	tmhm
	; end
