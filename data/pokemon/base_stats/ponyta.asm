	db PONYTA ; 110

	db  50,  90,  55,  90,  60,  65 ; 410 BST
	evs  0,   2,   0,   2,   1,   0
	;   hp  atk  def  spd  sat  sdf

	db FIRE, FAIRY ; type
	db 190 ; catch rate
	db 100 ; base exp
	db PSNCUREBERRY, RED_APRICORN ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/ponyta/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
