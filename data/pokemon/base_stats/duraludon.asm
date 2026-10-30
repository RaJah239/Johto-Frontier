	db DURALUDON ; 230

	db  70,  95, 115,  85, 120,  50 ; 535 BST
	evs  1,   2,   2,   1,   3,   0
	;   hp  atk  def  spd  sat  sdf

	db STEEL, DRAGON ; type
	db 3 ; catch rate
	db 220 ; base exp
	db METAL_COAT, DRAGON_SCALE ; items
	db GENDER_UNKNOWN ; gender ratio
	db 30 ; step cycles to hatch
	INCBIN "gfx/pokemon/duraludon/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm
	; end
