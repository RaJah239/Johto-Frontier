	db PUPITAR ; 213

	db  70,  84,  70,  51,  65,  70 ; 410 BST
	evs  1,   1,   1,   0,   1,   1
	;   hp  atk  def  spd  sat  sdf

	db ROCK, GROUND ; type
	db 45 ; catch rate
	db 145 ; base exp
	db NO_ITEM, HARD_STONE ; items
	db GENDER_F50 ; gender ratio
	db 40 ; step cycles to hatch
	INCBIN "gfx/pokemon/pupitar/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_MONSTER, EGG_MONSTER ; egg groups

	; tm/hm learnset
	tmhm
	; end
