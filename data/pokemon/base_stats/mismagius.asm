	db MISMAGIUS ; 212

	db  60,  50,  60, 105, 130, 100 ; 505 BST
	evs  1,   0,   1,   2,   3,   2
	;   hp  atk  def  spd  sat  sdf

	db GHOST, FAIRY	; type
	db 45 ; catch rate
	db 220 ; base exp
	db BLK_APRICORN, POLKADOT_BOW ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/mismagius/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_FAST ; growth rate
	dn EGG_INDETERMINATE, EGG_INDETERMINATE  ; egg groups

	; tm/hm learnset
	tmhm
	; end
