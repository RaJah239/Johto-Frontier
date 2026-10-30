	db STARMIE ; 167

	db  60,  75,  85, 115, 100,  85 ; 520 BST
	evs  1,   1,   1,   2,   2,   1
	;   hp  atk  def  spd  sat  sdf

	db WATER, FAIRY ; type
	db 60 ; catch rate
	db 215 ; base exp
	db STARDUST, STAR_PIECE ; items
	db GENDER_UNKNOWN ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/starmie/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_WATER_3, EGG_WATER_3 ; egg groups

	; tm/hm learnset
	tmhm
	; end
