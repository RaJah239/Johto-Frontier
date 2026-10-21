	db BRONZONG ; 205

	db  67,  94, 116,  33,  79, 116 ; 505 BST
	evs  1,   2,   2,   0,   1,   2
	;   hp  atk  def  spd  sat  sdf

	db STEEL, PSYCHIC_TYPE ; type
	db 90 ; catch rate
	db 205 ; base exp
	db BLU_APRICORN, METAL_COAT ; items
	db GENDER_UNKNOWN ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/bronzong/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_MINERAL, EGG_MINERAL ; egg groups

	; tm/hm learnset
	tmhm
	; end
