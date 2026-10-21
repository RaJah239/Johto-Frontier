	db SHELGON ; 216

	db  65,  95, 100,  50,  60,  50 ; 420 BST
	evs  1,   2,   2,   0,   1,   0
	;   hp  atk  def  spd  sat  sdf

	db DRAGON, DRAGON ; type
	db 45 ; catch rate
	db 150 ; base exp
	db NO_ITEM, DRAGON_FANG ; items
	db GENDER_F50 ; gender ratio
	db 40 ; step cycles to hatch
	INCBIN "gfx/pokemon/shelgon/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_DRAGON, EGG_DRAGON ; egg groups

	; tm/hm learnset
	tmhm
	; end
