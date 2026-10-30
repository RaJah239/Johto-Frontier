	db ONIX ; 082

	;   hp  atk  def  spd  sat  sdf ; BST 500
	db  70,  80, 130,  90,  30, 100
	evs  1,   1,   3,   2,   0,   2

	db ROCK, GROUND ; type
	db 45 ; catch rate
	db 150 ; base exp
	db NO_ITEM, METAL_COAT ; items
	db GENDER_F50 ; gender ratio
	db 25 ; step cycles to hatch
	INCBIN "gfx/pokemon/onix/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_MINERAL, EGG_MINERAL ; egg groups

	; tm/hm learnset
	tmhm
	; end
