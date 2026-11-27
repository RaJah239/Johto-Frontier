	db BAXCALIBUR ; fb

	db 115, 145,  92,  87,  75,  86
	evs 0,   3,   0,   0,   0,   0
	;   hp  atk  def  spd  sat  sdf

	db DRAGON, ICE ; type
	db 10 ; catch rate
	db 255 ; base exp (canonical 300 capped to engine byte)
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 40 ; step cycles to hatch
	INCBIN "gfx/pokemon/baxcalibur/front.dimensions"
	db GROWTH_SLOW ; growth rate
	dn EGG_DRAGON, EGG_DRAGON ; egg groups

	; tm/hm learnset
	tmhm
	; end
