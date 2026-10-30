	db BEAUTIFLY ; 045

	db  75,  75,  60,  85,  95,  60 ; 450 BST
	evs  1,   1,   1,   1,   2,   1
	;   hp  atk  def  spd  sat  sdf

	db BUG, FAIRY ; type
	db 45 ; catch rate
	db 178 ; base exp
	db WHT_APRICORN, POLKADOT_BOW ; items
	db GENDER_F50 ; gender ratio
	db 15 ; step cycles to hatch
	INCBIN "gfx/pokemon/beautifly/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_BUG, EGG_BUG ; egg groups

	; tm/hm learnset
	tmhm
	; end
