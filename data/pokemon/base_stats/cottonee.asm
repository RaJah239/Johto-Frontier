	db COTTONEE ; species ID

	db  40,  27,  60,  66,  37,  50 ; 280 BST
	evs  0,   0,   0,   1,   0,   0
	;   hp  atk  def  spd  sat  sdf

	db GRASS, FAIRY ; type
	db 190 ; catch rate
	db 56 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 20 ; step cycles to hatch
	INCBIN "gfx/pokemon/cottonee/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_PLANT, EGG_FAIRY ; egg groups

	; tm/hm learnset
	tmhm
	; end
