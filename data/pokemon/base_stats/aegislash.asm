	db AEGISLASH ; 209

	db  60, 150, 60,  20, 150,  60 ; 500 BST
	evs  1,   3,  1,   0,   3,   1
	;   hp  atk  def spd  sat  sdf

	db STEEL, GHOST ; type
	db 3 ; catch rate
	db 230 ; base exp
	db NO_ITEM, SPELL_TAG ; items
	db GENDER_UNKNOWN ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/aegislash/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm
	; end
