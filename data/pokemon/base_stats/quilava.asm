	db QUILAVA ; 002

	;   hp  atk  def  spd  sat  sdf ; 405 BST
	db  64,  78,  52,  81,  78,  52
	evs  1,   1,   0,   1,   1,   0

	db FIRE, GROUND ; type
	db 45 ; catch rate
	db 142 ; base exp
	db BERRY, CHARCOAL ; items
	db GENDER_F12_5 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/quilava/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
