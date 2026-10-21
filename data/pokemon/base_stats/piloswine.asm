	db PILOSWINE ; 193

	db 100, 100,  80,  50,  60,  60 ; 450 BST
	evs  2,   2,   1,   0,   1,   1
	;   hp  atk  def  spd  sat  sdf

	db ICE, GROUND ; type
	db 75 ; catch rate
	db 160 ; base exp
	db WHT_APRICORN, NEVERMELTICE ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/piloswine/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
