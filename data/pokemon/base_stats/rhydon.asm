	db RHYDON ; 080

	db  100, 130, 100,  71,  45,  59 ; 505 BST
	evs   2,   3,   2,   1,   0,   0
	;    hp  atk  def  spd  sat  sdf

	db ROCK, DRAGON ; type
	db 60 ; catch rate
	db 220 ; base exp
	db BLK_APRICORN, HARD_STONE ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/rhydon/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_DRAGON, EGG_MONSTER ; egg groups

	; tm/hm learnset
	tmhm
	; end
