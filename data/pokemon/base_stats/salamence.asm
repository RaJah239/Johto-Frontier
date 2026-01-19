	db SALAMENCE ; Species ID

	;   hp  atk  def  spd  sat  sdf
	db  100, 120,  80, 100, 120,  80 ; BST 600
	evs   2,   3,   1,   2,   3,   1

	db DRAGON, FLYING ; type
	db 45 ; catch rate
	db 235 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 40 ; step cycles to hatch
	INCBIN "gfx/pokemon/salamence/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_DRAGON, EGG_DRAGON ; egg groups

	; tm/hm learnset
	tmhm
	; end
