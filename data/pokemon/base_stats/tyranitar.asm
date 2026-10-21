	db TYRANITAR ; 214

	db 100, 134, 110,  61,  95, 100 ; 600 BST
	evs  2,   3,   2,   1,   2,   2
	;   hp  atk  def  spd  sat  sdf

	db ROCK, DARK ; type
	db 45 ; catch rate
	db 240 ; base exp
	db NO_ITEM, BLACKGLASSES ; items
	db GENDER_F50 ; gender ratio
	db 40 ; step cycles to hatch
	INCBIN "gfx/pokemon/tyranitar/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_MONSTER, EGG_MONSTER ; egg groups

	; tm/hm learnset
	tmhm
	; end
