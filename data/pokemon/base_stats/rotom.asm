	db ROTOM ; 229

	;   hp  atk  def  spd  sat  sdf
	db  60,  65, 107,  91, 110, 107 ; 540 BST
	evs  1,   1,   2,   2,   2,   2

	db ELECTRIC, GHOST ; type
	db 3 ; catch rate
	db 240 ; base exp
	db MAGNET, SPELL_TAG ; items
	db GENDER_UNKNOWN ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/rotom/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm
	; end
