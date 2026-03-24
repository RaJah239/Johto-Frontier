	db SUDOWOODO ; 185

	;   hp  atk  def  spd  sat  sdf
	db  75, 115,  78, 112,  55,  65 ; 500 BST
	evs  2,   3,   1,   2,   0,   2

	db ROCK, FIGHTING ; type
	db 9 ; catch rate
	db 200 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 25 ; step cycles to hatch
	INCBIN "gfx/pokemon/sudowoodo/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_MINERAL, EGG_MINERAL ; egg groups

	; tm/hm learnset
	tmhm
	; end
