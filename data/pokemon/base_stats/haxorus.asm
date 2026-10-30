	db HAXORUS ; 219

	db  76, 147,  90,  97,  60,  70
	evs  1,   3,   2,   2,   1,   1
	;   hp  atk  def  spd  sat  sdf

	db DRAGON, DRAGON ; type
	db 3 ; catch rate
	db 240 ; base exp
	db NO_ITEM, DRAGON_SCALE ; items
	db GENDER_F50 ; gender ratio
	db 40 ; step cycles to hatch
	INCBIN "gfx/pokemon/haxorus/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm
	; end
