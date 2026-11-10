	db 0 ; WHIRLIPEDE 119 (wBaseDexNo: GetBaseData puts the species ID here)

	db  40,  55,  99,  47,  40,  79 ; 360 BST
	evs  0,   0,   2,   0,   0,   1
	;   hp  atk  def  spd  sat  sdf

	db BUG, POISON ; type
	db 120 ; catch rate
	db 126 ; base exp
	db PSNCUREBERRY, SILVERPOWDER ; items
	db GENDER_F50 ; gender ratio
	db 15 ; step cycles to hatch
	INCBIN "gfx/pokemon/whirlipede/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_BUG, EGG_BUG ; egg groups

	; tm/hm learnset
	tmhm
	; end
