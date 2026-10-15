	db DONPHAN ; 062

	db  90, 120, 100,  45,  50, 100 ; 505 BST
	evs  2,   3,   2,   0,   0,   2
	;   hp  atk  def  spd  sat  sdf

	db GROUND, FIGHTING ; type
	db 60 ; catch rate
	db 215 ; base exp
	db BLK_APRICORN, BLACKBELT_I ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/donphan/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
