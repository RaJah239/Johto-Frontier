	db MAMOSWINE ; 194

	db 110, 130,  80,  75,  60,  80 ; 535 BST
	evs  2,   3,   1,   1,   1,   1
	;   hp  atk  def  spd  sat  sdf

	db ICE, GROUND ; type
	db 50 ; catch rate
	db 239 ; base exp
	db WHT_APRICORN, SOFT_SAND ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/mamoswine/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
