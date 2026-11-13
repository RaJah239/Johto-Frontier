	db PONYTA ; 110

	db  70,  90,  45,  50,  15,  45 ; 315 BST
	evs  1,   2,   0,   0,   0,   0
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
