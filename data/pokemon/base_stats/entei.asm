	db ENTEI ; 243

	db 125, 125,  85, 100,  90,  75 ; 600 BST
	evs  3,   3,   1,   2,   2,   1
	;   hp  atk  def  spd  sat  sdf

	db FIRE, FIRE ; type
	db 3 ; catch rate
	db 240 ; base exp
	db CHARCOAL, CHARCOAL ; items
	db GENDER_UNKNOWN ; gender ratio
	db 80 ; step cycles to hatch
	INCBIN "gfx/pokemon/entei/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm
	; end