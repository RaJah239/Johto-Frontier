	db AGGRON ; 208

	db  70, 110, 150,  50,  60,  60 ; 500 BST
	evs  1,   2,   3,   0,   1,   1
	;   hp  atk  def  spd  sat  sdf

	db STEEL, ROCK ; type
	db 3 ; catch rate
	db 200 ; base exp
	db HARD_STONE, METAL_COAT ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/aggron/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm
	; end
