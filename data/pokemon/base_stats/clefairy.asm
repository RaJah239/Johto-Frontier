	db CLEFAIRY ; 180

	db  70,  45,  48,  35,  62,  65 ; 325 BST
	evs  1,   0,   0,   0,   1,   1
	;   hp  atk  def  spd  sat  sdf

	db FAIRY, STEEL ; type
	db 150 ; catch rate
	db 110 ; base exp
	db MYSTERYBERRY, MOON_STONE ; items
	db GENDER_F50 ; gender ratio
	db 10 ; step cycles to hatch
	INCBIN "gfx/pokemon/clefairy/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_FAST ; growth rate
	dn EGG_FAIRY, EGG_FAIRY ; egg groups

	; tm/hm learnset
	tmhm
	; end
