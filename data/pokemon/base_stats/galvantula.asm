	db GALVANTULA ; 123

	db  80,  77,  64, 118, 102,  64 ; 505 BST
	evs  1,   1,   1,   2,   1,   1
	;   hp  atk  def  spd  sat  sdf

	db BUG, ELECTRIC ; type
	db 75 ; catch rate
	db 205 ; base exp
	db YLW_APRICORN, SILVERPOWDER ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/galvantula/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_FAIRY, EGG_PLANT ; egg groups

	; tm/hm learnset
	tmhm
	; end
