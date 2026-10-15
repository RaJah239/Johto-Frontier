	db EXCADRILL ; 082

	db 110, 135,  60,  88,  50,  65 ; 508 BST
	evs  2,   3,   1,   1,   0,   1
	;   hp  atk  def  spd  sat  sdf

	db GROUND, STEEL ; type
	db 60 ; catch rate
	db 205 ; base exp
	db BLK_APRICORN, SOFT_SAND ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/excadrill/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
