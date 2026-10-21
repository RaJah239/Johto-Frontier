	db REGICE ; 235

	db 100,  50, 100,  50, 100, 200 ; 600 BST
	evs  2,   0,   2,   0,   2,   3
	;   hp  atk  def  spd  sat  sdf

	db ICE, ICE ; type
	db 3 ; catch rate
	db 240 ; base exp
	db NEVERMELTICE, NEVERMELTICE ; items
	db GENDER_UNKNOWN ; gender ratio
	db 80 ; step cycles to hatch
	INCBIN "gfx/pokemon/regice/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm
	; end
