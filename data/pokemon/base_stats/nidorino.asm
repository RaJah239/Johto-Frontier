	db NIDORINO ; 073

	db  61,  55,  57,  65,  72,  55 ; 365 BST
	evs  1,   0,   0,   1,   1,   0
	;   hp  atk  def  spd  sat  sdf

	db POISON, POISON ; type
	db 120 ; catch rate
	db 120 ; base exp
	db NO_ITEM, PNK_APRICORN ; items
	db GENDER_F0 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/nidorino/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_MONSTER, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
