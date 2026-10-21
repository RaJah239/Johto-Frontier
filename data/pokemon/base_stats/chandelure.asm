	db CHANDELURE ; 153

	db  60,  55,  90,  80, 145,  90 ; 520 BST
	evs  1,   0,   2,   1,   3,   2
	;   hp  atk  def  spd  sat  sdf

	db GHOST, FIRE ; type
	db 45 ; catch rate
	db 234 ; base exp
	db WHT_APRICORN, CHARCOAL ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/chandelure/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_INDETERMINATE, EGG_INDETERMINATE ; egg groups

	; tm/hm learnset
	tmhm
	; end
