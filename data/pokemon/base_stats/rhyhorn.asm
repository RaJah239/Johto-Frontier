	db RHYHORN ; 079

	db  80,  85,  95,  25,  30,  30 ; 345 BST
	evs  1,   1,   2,   0,   0,   0
	;   hp  atk  def  spd  sat  sdf

	db ROCK, ROCK ; type
	db 120 ; catch rate
	db 80 ; base exp
	db BITTER_BERRY, BLK_APRICORN ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/rhyhorn/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_MONSTER, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
