	db HO_OH ; 245

	;   hp  atk  def  spd  sat  sdf
	db 106, 130,  90,  90, 110, 154 ; 680 BST
	evs  2,   3,   2,   2,   2,   3

	db FIRE, FLYING ; type
	db 3 ; catch rate
	db 255 ; base exp
	db SACRED_ASH, SACRED_ASH ; items
	db GENDER_UNKNOWN ; gender ratio
	db 120 ; step cycles to hatch
	INCBIN "gfx/pokemon/ho_oh/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm
	; end
