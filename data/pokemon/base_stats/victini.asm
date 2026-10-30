	db VICTINI ; 247

	db 100, 100, 100, 100, 100, 100 ; 600 BST
	evs  2,   2,   2,   2,   2,   2
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC_TYPE, FIRE ; type
	db 3 ; catch rate
	db 240 ; base exp
	db TWISTEDSPOON, CHARCOAL ; items
	db GENDER_UNKNOWN ; gender ratio
	db 120 ; step cycles to hatch
	INCBIN "gfx/pokemon/victini/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm
	; end
