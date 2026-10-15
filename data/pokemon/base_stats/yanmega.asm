	db YANMEGA ; 045

	db  86,  76,  86, 105, 126,  56 ; 535 BST
	evs  1,   1,   1,   2,   3,   0
	;   hp  atk  def  spd  sat  sdf

	db BUG, DRAGON ; type
	db 30 ; catch rate
	db 220 ; base exp
	db MINT_BERRY, DRAGON_FANG ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/yanmega/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_BUG, EGG_BUG ; egg groups

	; tm/hm learnset
	tmhm
	; end
