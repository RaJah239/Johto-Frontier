	db TENTACRUEL ; 173

	db  80,  70,  65, 100,  80, 120 ; 515 BST
	evs  1,   1,   1,   2,   1,   3
	;   hp  atk  def  spd  sat  sdf

	db WATER, POISON ; type
	db 60 ; catch rate
	db 205 ; base exp
	db BLU_APRICORN, POISON_BARB ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/tentacruel/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_WATER_3, EGG_WATER_3 ; egg groups

	; tm/hm learnset
	tmhm
	; end
