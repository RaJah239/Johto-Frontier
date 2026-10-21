	db BLASTOISE ; 018

	db  84,  83, 100,  78,  85, 105 ; 535 BST
	evs  1,   1,   2,   1,   1,   2
	;   hp  atk  def  spd  sat  sdf

	db WATER, STEEL ; type
	db 45 ; catch rate
	db 239 ; base exp
	db RAIN_SHARD, MYSTIC_WATER ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/blastoise/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_MONSTER, EGG_WATER_1 ; egg groups

	; tm/hm learnset
	tmhm
	; end
