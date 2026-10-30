	db KOFFING ; 148

	db  40,  65,  95,  35,  60,  45 ; 340 BST
	evs  0,   1,   2,   0,   1,   0
	;   hp  atk  def  spd  sat  sdf

	db POISON, FIRE ; type
	db 190 ; catch rate
	db 90 ; base exp
	db PSNCUREBERRY, POISON_BARB ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/koffing/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_INDETERMINATE, EGG_INDETERMINATE ; egg groups

	; tm/hm learnset
	tmhm
	; end
