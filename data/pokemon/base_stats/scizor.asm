	db SCIZOR ; 135

	db  70, 130, 100,  65,  60,  80 ; 505 BST
	evs  1,   3,   2,   1,   1,   1
	;   hp  atk  def  spd  sat  sdf

	db BUG, STEEL ; type
	db 45 ; catch rate
	db 205 ; base exp
	db NO_ITEM, METAL_COAT ; items
	db GENDER_F50 ; gender ratio
	db 25 ; step cycles to hatch
	INCBIN "gfx/pokemon/scizor/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_BUG, EGG_BUG ; egg groups

	; tm/hm learnset
	tmhm
	; end
