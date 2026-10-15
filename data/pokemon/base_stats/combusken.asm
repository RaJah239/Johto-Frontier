	db COMBUSKEN ; 028

	db  60,  85,  60,  55,  85,  60 ; 405 BST
	evs  1,   1,   1,   0,   1,   1
	;   hp  atk  def  spd  sat  sdf

	db FIRE, FIGHTING ; type
	db 45 ; catch rate
	db 142 ; base exp
	db RED_APRICORN, BLACKBELT_I ; items
	db GENDER_F12_5 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/combusken/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm 
	; end
