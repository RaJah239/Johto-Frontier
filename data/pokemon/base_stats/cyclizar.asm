	db CYCLIZAR ; ee

	db  70,  95,  65, 121,  85,  65
	evs 0,   0,   0,   2,   0,   0
	;   hp  atk  def  spd  sat  sdf

	db DRAGON, NORMAL ; type
	db 190 ; catch rate
	db 175 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 30 ; step cycles to hatch
	INCBIN "gfx/pokemon/cyclizar/front.dimensions"
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
