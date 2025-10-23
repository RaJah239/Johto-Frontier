	db FEEBAS

	db  20, 15,  20,  80,  10,  55
	evs  0,  0,   0,   1,   0,   0
	;   hp  atk  def  spd  sat  sdf

	db WATER, WATER	; type
	db 255 ; catch rate
	db 20 ; base exp
	db NO_ITEM, DRAGON_SCALE ; items
	db GENDER_F50  ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/feebas/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_WATER_1, EGG_DRAGON  ; egg groups

	; tm/hm learnset
	tmhm
	; end
