	db HARIYAMA ; 107

	db 150, 125,  70,  50,  40,  70 ; 505 BST
	evs  3,   3,   1,   0,   0,   1
	;   hp  atk  def  spd  sat  sdf

	db FIGHTING, FIGHTING ; type
	db 60 ; catch rate
	db 215 ; base exp
	db YLW_APRICORN, BLACKBELT_I ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/hariyama/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_HUMANSHAPE, EGG_HUMANSHAPE ; egg groups

	; tm/hm learnset
	tmhm
	; end
