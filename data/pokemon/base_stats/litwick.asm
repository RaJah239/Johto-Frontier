	db LITWICK ; 151

	db  50,  30,  55,  20,  65,  55 ; 275 BST
	evs  0,   0,   0,   0,   1,   0
	;   hp  atk  def  spd  sat  sdf

	db GHOST, FIRE ; type
	db 190 ; catch rate
	db 55 ; base exp
	db BURNT_BERRY, WHT_APRICORN ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/litwick/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_INDETERMINATE, EGG_INDETERMINATE ; egg groups

	; tm/hm learnset
	tmhm
	; end
