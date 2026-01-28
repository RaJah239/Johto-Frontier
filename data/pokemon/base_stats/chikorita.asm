	db CHIKORITA ; 7

	;   hp  atk  def  spd  sat  sdf
	db  50,  49,  65,  40,  40,  65 ; 309 BST
	evs  0,   0,   1,   0,   0,   1

	db GRASS, FAIRY ; type
	db 45 ; catch rate
	db 57 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F12_5 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/chikorita/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_MONSTER, EGG_PLANT ; egg groups

	; tm/hm learnset
	tmhm
	; end
