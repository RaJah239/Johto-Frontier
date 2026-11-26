	db DRAGAPULT ; fa

	db  88, 120,  75, 142, 100,  75
	evs 0,   0,   0,   3,   0,   0
	;   hp  atk  def  spd  sat  sdf

	db DRAGON, GHOST ; type
	db 45 ; catch rate
	db 255 ; base exp (canonical 300 capped to engine byte)
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 40 ; step cycles to hatch
	INCBIN "gfx/pokemon/dragapult/front.dimensions"
	db GROWTH_SLOW ; growth rate
	dn EGG_DRAGON, EGG_INDETERMINATE ; egg groups

	; tm/hm learnset
	tmhm
	; end
