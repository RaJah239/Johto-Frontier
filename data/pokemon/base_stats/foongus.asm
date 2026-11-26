	db FOONGUS ; species ID

	db  69,  55,  45,  15,  55,  55 ; 294 BST
	evs  0,   0,   0,   0,   0,   1
	;   hp  atk  def  spd  sat  sdf

	db GRASS, POISON ; type
	db 190 ; catch rate
	db 59 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/foongus/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_PLANT, EGG_INDETERMINATE ; egg groups

	; tm/hm learnset
	tmhm
	; end
