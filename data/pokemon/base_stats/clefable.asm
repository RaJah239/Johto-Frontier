	db CLEFABLE ; 181

	db  95,  72,  93,  60,  95,  90 ; 505 BST
	evs  2,   1,   2,   1,   2,   2
	;   hp  atk  def  spd  sat  sdf

	db FAIRY, STEEL ; type
	db 25 ; catch rate
	db 220 ; base exp
	db MYSTERYBERRY, METEOR_MITTS ; items
	db GENDER_F50 ; gender ratio
	db 10 ; step cycles to hatch
	INCBIN "gfx/pokemon/clefable/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_FAST ; growth rate
	dn EGG_FAIRY, EGG_FAIRY ; egg groups

	; tm/hm learnset
	tmhm
	; end
