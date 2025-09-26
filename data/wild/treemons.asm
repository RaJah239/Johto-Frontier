TreeMons::
; entries correspond to TREEMON_SET_* constants
	table_width 2, TreeMons
	dw TreeMonSet_City
	dw TreeMonSet_Canyon
	dw TreeMonSet_Town
	dw TreeMonSet_Route
	dw TreeMonSet_Kanto
	dw TreeMonSet_Lake
	dw TreeMonSet_Forest
;	dw TreeMonSet_Rock
	assert_table_length NUM_TREEMON_SETS
;	dw TreeMonSet_City ; unused

RockSmashMons::
 	; broke off from the above table, for nayru's pokedex
 	; delineation was needed because there is no 'rare' table for rocksmash
 	table_width 2, RockSmashMons
 	dw TreeMonSet_Rock
 	assert_table_length NUM_ROCKSMASH_SETS

; Two tables each (common, rare).
; Structure:
;	db  %, species, level

TreeMonSet_City:
TreeMonSet_Canyon:
TreeMonSet_Town:
TreeMonSet_Route:
TreeMonSet_Kanto:
TreeMonSet_Lake:
TreeMonSet_Forest:
; common
	db 50, HOOTHOOT,   10
	db 15, HOOTHOOT,   10
	db 15, HOOTHOOT,   10
	db 10, HOOTHOOT,   10
	db  5, HOOTHOOT,   10
	db  5, HOOTHOOT,   10
	db -1
; rare
	db 50, HOOTHOOT,   10
	db 15, HOOTHOOT,   10
	db 15, HOOTHOOT,   10
	db 10, HOOTHOOT,   10
	db  5, HOOTHOOT,   10
	db  5, HOOTHOOT,   10
	db -1

; Rock smash sets dont have common/rare tables
 ; can have as many entries as you want as long as the % adds up to 100
 ; feel free to add new rock smash sets
TreeMonSet_Rock:
	db 90, HERACROSS,  15
	db 10, SHUCKLE,    15
	db -1
