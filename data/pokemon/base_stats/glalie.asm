	db GLALIE ; 190

	db  85,  85,  85,  85,  85,  85 ; 510 BST
	evs  2,   2,   2,   2,   2,   2
	;   hp  atk  def  spd  sat  sdf

	db ICE, ICE ; type
	db 75 ; catch rate
	db 200 ; base exp
	db NO_ITEM, NEVERMELTICE ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/glalie/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_FAIRY, EGG_MINERAL ; egg groups

	; tm/hm learnset
	tmhm
	; end
