	db ALTARIA ; 090

	db  75,  75,  90,  80,  80, 105 ; 505 BST
	evs  1,   1,   2,   1,   1,   2
	;   hp  atk  def  spd  sat  sdf

	db DRAGON, FAIRY ; type
	db 45 ; catch rate
	db 215 ; base exp
	db BLU_APRICORN, POLKADOT_BOW ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/altaria/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_FLYING, EGG_DRAGON ; egg groups

	; tm/hm learnset
	tmhm
	; end
