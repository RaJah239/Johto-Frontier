	db ABSOL ; 230

	db  65, 154,  60, 151,  75,  60 ; 565 BST
	evs  1,   3,   1,   3,   1,   1
	;   hp  atk  def  spd  sat  sdf

	db DARK, FAIRY ; type
	db 3 ; catch rate
	db 220 ; base exp
	db BLACKGLASSES, POLKADOT_BOW ; items
	db GENDER_F50 ; gender ratio
	db 50 ; step cycles to hatch
	INCBIN "gfx/pokemon/absol/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
