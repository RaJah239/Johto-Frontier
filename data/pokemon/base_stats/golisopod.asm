	db GOLISOPOD ; 075

	db  75, 125, 140,  40,  60,  90 ; 530 BST
	evs  2,   3,   3,   0,   1,   2
	;   hp  atk  def  spd  sat  sdf

	db BUG, WATER ; type
	db 45 ; catch rate
	db 215 ; base exp
	db MYSTERYBERRY, QUICK_CLAW ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/golisopod/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_BUG, EGG_WATER_3 ; egg groups

	; tm/hm learnset
	tmhm
	; end
