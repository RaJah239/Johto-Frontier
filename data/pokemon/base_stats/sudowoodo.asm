	db 0 ; SUDOWOODO 147 (wBaseDexNo: GetBaseData puts the species ID here)

	;   hp  atk  def spd  sat  sdf
	db  85, 115, 100, 75,  60,  65 ; 500 BST
	evs  1,   2,   2,  1,   1,   1

	db ROCK, FIGHTING ; type
	db 45 ; catch rate
	db 200 ; base exp
	db NO_ITEM, FOCUS_SASH ; items
	db GENDER_F50 ; gender ratio
	db 25 ; step cycles to hatch
	INCBIN "gfx/pokemon/sudowoodo/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_MINERAL, EGG_MINERAL ; egg groups

	; tm/hm learnset
	tmhm
	; end
