	db JIRACHI ; 248

	db  100, 100, 100, 100, 100, 100 ; 600 BST
	evs   2,   2,   2,   2,   2,   2
	;    hp  atk  def  spd  sat  sdf

	db STEEL, PSYCHIC_TYPE ; type
	db 45 ; catch rate
	db 240 ; base exp
	db METAL_COAT, METAL_COAT ; items
	db GENDER_UNKNOWN ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/jirachi/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm
	; end

