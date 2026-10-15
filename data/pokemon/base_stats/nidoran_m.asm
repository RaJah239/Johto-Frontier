	db NIDORAN_M ; 072

	db  46,  44,  40,  50,  60,  40 ; 280 BST
	evs  0,   0,   0,   0,   1,   0
	;   hp  atk  def  spd  sat  sdf

	db POISON, POISON ; type
	db 235 ; catch rate
	db 55 ; base exp
	db BERRY, PNK_APRICORN ; items
	db GENDER_F0 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/nidoran_m/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_MONSTER, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
