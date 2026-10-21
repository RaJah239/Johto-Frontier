	db REGISTEEL ; 236

	db 100,  75, 150,  50,  75, 150
	evs  2,   1,   3,   0,   1,   3
	;   hp  atk  def  spd  sat  sdf

	db STEEL, STEEL ; type
	db 3 ; catch rate
	db 240 ; base exp
	db METAL_COAT, METAL_COAT ; items
	db GENDER_UNKNOWN ; gender ratio
	db 80 ; step cycles to hatch
	INCBIN "gfx/pokemon/registeel/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm
	; end
