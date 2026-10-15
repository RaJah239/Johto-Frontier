	db GYARADOS ; 086

	db  95, 125,  79,  81,  60, 100 ; 540 BST
	evs  2,   3,   1,   1,   1,   2
	;   hp  atk  def  spd  sat  sdf

	db WATER, FLYING ; type
	db 45 ; catch rate
	db 220 ; base exp
	db BLU_APRICORN, MUSCLE_BAND ; items
	db GENDER_F50 ; gender ratio
	db 5 ; step cycles to hatch
	INCBIN "gfx/pokemon/gyarados/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_WATER_2, EGG_DRAGON ; egg groups

	; tm/hm learnset
	tmhm
	; end
