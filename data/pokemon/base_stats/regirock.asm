	db REGIROCK ; 234

	db 100, 100, 200,  50,  50, 100 ; 600 BST
	evs  2,   2,   3,   0,   0,   2
	;   hp  atk  def  spd  sat  sdf

	db ROCK, ROCK ; type
	db 3 ; catch rate
	db 240 ; base exp
	db HARD_STONE, HARD_STONE ; items
	db GENDER_UNKNOWN ; gender ratio
	db 80 ; step cycles to hatch
	INCBIN "gfx/pokemon/regirock/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm
	; end
