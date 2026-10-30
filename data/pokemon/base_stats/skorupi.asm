	db SKORUPI ; 123

	db  40,  50,  90,  65,  30,  55 ; 330 BST
	evs  0,   0,   2,   1,   0,   0
	;   hp  atk  def  spd  sat  sdf

	db POISON, BUG ; type
	db 120 ; catch rate
	db 65 ; base exp
	db BERRY, MYSTERYBERRY ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/skorupi/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_BUG, EGG_WATER_3 ; egg groups

	; tm/hm learnset
	tmhm
	; end
