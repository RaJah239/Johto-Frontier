	db 0 ; GLALIE 191 (wBaseDexNo: GetBaseData puts the species ID here)

	db  80, 105,  75, 100, 105,  40 ; 505 BST
	evs  1,   2,   1,   2,   2,   2
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
