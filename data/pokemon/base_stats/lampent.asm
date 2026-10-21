	db LAMPENT ; 152

	db  60,  40,  60,  55,  95,  60 ; 370 BST
	evs  1,   0,   1,   0,   2,   1
	;   hp  atk  def  spd  sat  sdf

	db GHOST, FIRE ; type
	db 90 ; catch rate
	db 130 ; base exp
	db WHT_APRICORN, SPELL_TAG ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/lampent/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_INDETERMINATE, EGG_INDETERMINATE ; egg groups

	; tm/hm learnset
	tmhm
	; end
