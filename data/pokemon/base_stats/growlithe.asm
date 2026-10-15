	db GROWLITHE ; 096

	db  55,  70,  45,  60,  70,  50 ; 350 BST
	evs  0,   1,   0,   1,   1,   0
	;   hp  atk  def  spd  sat  sdf

	db FIRE, NORMAL ; type
	db 190 ; catch rate
	db 90 ; base exp
	db BURNT_BERRY, PINK_BOW ; items
	db GENDER_F25 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/growlithe/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
