	db SOLROCK ; 182

	db  100, 105,  85,  70,  55,  85 ; 500 BST
	evs   2,   2,   1,   1,   0,   1
	;    hp  atk  def  spd  sat  sdf

	db ROCK, FIRE ; type
	db 45 ; catch rate
	db 205 ; base exp
	db STARDUST, SUN_STONE ; items
	db GENDER_UNKNOWN ; gender ratio
	db 25 ; step cycles to hatch
	INCBIN "gfx/pokemon/solrock/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_FAST ; growth rate
	dn EGG_MINERAL, EGG_MINERAL ; egg groups

	; tm/hm learnset
	tmhm
	; end
