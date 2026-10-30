	db URSALUNA_B ; 065

	db 113,  70, 120,  52, 135,  65 ; 555 BST
	evs  2,   1,   3,   0,   3,   1
	;   hp  atk  def  spd  sat  sdf

	db GROUND, NORMAL ; type
	db 20 ; catch rate
	db 240 ; base exp
	db NO_ITEM, GOLD_BERRY ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/ursaluna_b/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
