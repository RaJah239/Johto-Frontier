	db WEEZING ; 149

	db  100,  95, 120,  60,  60,  70 ; 505 BST
	evs   2,   2,   3,   1,   1,   1
	;    hp  atk  def  spd  sat  sdf

	db POISON, FIRE ; type
	db 60 ; catch rate
	db 205 ; base exp
	db RED_APRICORN, CHARCOAL ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/weezing/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_INDETERMINATE, EGG_INDETERMINATE ; egg groups

	; tm/hm learnset
	tmhm
	; end
