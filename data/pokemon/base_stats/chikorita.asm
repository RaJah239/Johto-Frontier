	db CHIKORITA ; 007

	;   hp  atk  def  spd  sat  sdf ; 314 BST
	db  55,  49,  65,  40,  40,  65
	evs  0,   0,   1,   0,   0,   1

	db GRASS, FAIRY ; type
	db 45 ; catch rate
	db 64 ; base exp
	db BERRY, GRN_APRICORN ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/chikorita/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_MONSTER, EGG_PLANT ; egg groups

	; tm/hm learnset
	tmhm
	; end
