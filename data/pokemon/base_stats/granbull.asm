	db GRANBULL ; 143

	db  90, 125,  75,  65,  70,  80 ; 505 BST
	evs  2,   3,   1,   1,   1,   1
	;   hp  atk  def  spd  sat  sdf

	db FAIRY, FIGHTING ; type
	db 75 ; catch rate
	db 205 ; base exp
	db PNK_APRICORN, POLKADOT_BOW ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/granbull/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_FAST ; growth rate
	dn EGG_GROUND, EGG_FAIRY ; egg groups

	; tm/hm learnset
	tmhm
	; end
