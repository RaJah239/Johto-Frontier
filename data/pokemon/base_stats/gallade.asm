	db GALLADE ; 038

	db  68, 125,  65,  80,  65, 115 ; 518 BST
	evs  1,   3,   1,   1,   1,   2
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC_TYPE, FIGHTING ; type
	db 45 ; catch rate
	db 236 ; base exp
	db NO_ITEM, BLACKBELT_I ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/gallade/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_HUMANSHAPE, EGG_INDETERMINATE ; egg groups

	; tm/hm learnset
	tmhm
	; end
