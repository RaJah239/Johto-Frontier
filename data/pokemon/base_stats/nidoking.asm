	db NIDOKING ; 210

	db  73,  73,  73, 121, 127,  73 ; 540 BST
	evs  1,   1,   1,   3,   3,   1
	;   hp  atk  def  spd  sat  sdf

	db POISON, GROUND ; type
	db 3 ; catch rate
	db 230 ; base exp
	db PNK_APRICORN, POISON_BARB ; items
	db GENDER_F0 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/nidoking/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm
	; end
