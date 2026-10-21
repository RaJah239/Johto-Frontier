	db MANTINE ; 171

	db  85,  70,  65, 130, 100,  50 ; 500 BST
	evs  1,   1,   1,   3,   2,   0
	;   hp  atk  def  spd  sat  sdf

	db WATER, FLYING ; type
	db 45 ; catch rate
	db 190 ; base exp
	db NO_ITEM, SILVER_BERRY ; items
	db GENDER_F50 ; gender ratio
	db 25 ; step cycles to hatch
	INCBIN "gfx/pokemon/mantine/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_WATER_1, EGG_WATER_1 ; egg groups

	; tm/hm learnset
	tmhm
	; end
