	db DONPHAN ; 232

	;   hp  atk  def  spd  sat  sdf
	db 100, 120, 120,  45,  60,  60 ; 505 BST
	evs  2,   3,   3,   0,   1,   1

	db GROUND, FIGHTING ; type
	db 45 ; catch rate
	db 189 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/donphan/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
