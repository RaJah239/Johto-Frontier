	db DODUO ; 109

	;   hp  atk  def  spd  sat  sdf
	db  45,  75,  40,  85,  35,  35 ; 315 BST
	evs  0,   1,   0,   1,   0,   0

	db FLYING, FIGHTING ; type
	db 190 ; catch rate
	db 60 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/doduo/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_FLYING, EGG_FLYING ; egg groups

	; tm/hm learnset
	tmhm
	; end
