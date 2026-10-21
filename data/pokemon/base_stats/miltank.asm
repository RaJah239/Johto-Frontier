	db MILTANK ; 154

	db  95,  90, 105, 100,  40,  70 ; 500 BST
	evs  2,   2,   2,   2,   0,   1
	;   hp  atk  def  spd  sat  sdf

	db NORMAL, FAIRY ; type
	db 45 ; catch rate
	db 200 ; base exp
	db MOOMOO_MILK, MOOMOO_MILK ; items
	db GENDER_F100 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/miltank/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm
	; end
