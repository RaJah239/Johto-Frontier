	db DUSKNOIR ; e2

	db  45, 100, 135,  45,  65, 135
	evs  0,   0,   1,   0,   0,   2
	;   hp  atk  def  spd  sat  sdf

	db GHOST, GHOST ; type
	db 45 ; catch rate
	db 210 ; base exp
	db SPELL_TAG, SPELL_TAG ; items
	db GENDER_F50 ; gender ratio
	db 22 ; step cycles to hatch
	INCBIN "gfx/pokemon/dusknoir/front.dimensions"
	db GROWTH_FAST ; growth rate
	dn EGG_INDETERMINATE, EGG_INDETERMINATE ; egg groups

	; tm/hm learnset
	tmhm
	; end
