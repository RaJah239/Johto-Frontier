	db ELEKID ; 158

	db  45,  63,  37,  95,  65,  55 ; 360 BST
	evs  0,   1,   0,   2,   1,   0
	;   hp  atk  def  spd  sat  sdf

	db ELECTRIC, FIGHTING ; type
	db 45 ; catch rate
	db 90 ; base exp
	db NO_ITEM, MAGNET ; items
	db GENDER_F50 ; gender ratio
	db 25 ; step cycles to hatch
	INCBIN "gfx/pokemon/elekid/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm
	; end
