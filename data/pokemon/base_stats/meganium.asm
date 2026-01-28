	db MEGANIUM ; 9

	;   hp  atk  def  spd  sat  sdf
	db 100, 100, 100,  73,  62, 100 ; 535 BST
	evs  2,   2,   2,   1,   1,   2

	db GRASS, FAIRY ; type
	db 45 ; catch rate
	db 100 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F12_5 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/meganium/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_MONSTER, EGG_PLANT ; egg groups

	; tm/hm learnset
	tmhm
	; end
