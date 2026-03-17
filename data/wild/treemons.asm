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
; TODOTEXT adjust after setting evo attacks
TreeMonSet_City:
TreeMonSet_Canyon:
TreeMonSet_Town:
TreeMonSet_Route:
TreeMonSet_Kanto:
TreeMonSet_Lake:
TreeMonSet_Forest:
; common
	db 5, WURMPLE,    15
	db 4, SILCOON,    15
	db 4, CASCOON,    15
	db 3, BEAUTIFLY,  25
	db 3, DUSTOX,     25
	db 1, HERACROSS,  15
	db 5, HOOTHOOT,   15
	db 2, NOCTOWL,    25
	db 5, PIDGEY,     15
	db 2, PIDGEOTTO,  15
	db 1, PIDGEOT,    15
	db 5, ZUBAT,      15
	db 2, GOLBAT,     15
	db 1, CROBAT,     15
	db 4, TEDDIURSA,  15
	db 2, URSARING,   15
	db 1, URSALUNA,   15
	db 3, GLIGAR,     15
	db 1, GLISCOR,    15
	db 5, SPINARAK,   15
	db 1, ARIADOS,    15
	db 5, JOLTIK,     15
	db 1, GALVANTULA, 15
	db 4, VENIPEDE,   15
	db 2, WHIRLIPEDE, 15
	db 1, SCOLIPEDE,  15
	db 4, SKORUPI,    15
	db 1, DRAPION,    15
	db 4, LARVESTA,   15
	db 1, VOLCARONA,  15
	db 4, MANKEY,     15
	db 1, PRIMEAPE,   15
	db 1, ANNIHILAPE, 15
	db 4, FERROSEED,  15
	db 1, FERROTHORN, 15
	db 4, SCYTHER,    15
	db 1, SCIZOR,     15
	db 1, KLEAVOR,    15
	db -1
; rare - same as above
	db 5, WURMPLE,    15
	db 4, SILCOON,    15
	db 4, CASCOON,    15
	db 3, BEAUTIFLY,  25
	db 3, DUSTOX,     25
	db 1, HERACROSS,  15
	db 5, HOOTHOOT,   15
	db 2, NOCTOWL,    25
	db 5, PIDGEY,     15
	db 2, PIDGEOTTO,  15
	db 1, PIDGEOT,    15
	db 5, ZUBAT,      15
	db 2, GOLBAT,     15
	db 1, CROBAT,     15
	db 4, TEDDIURSA,  15
	db 2, URSARING,   15
	db 1, URSALUNA,   15
	db 3, GLIGAR,     15
	db 1, GLISCOR,    15
	db 5, SPINARAK,   15
	db 1, ARIADOS,    15
	db 5, JOLTIK,     15
	db 1, GALVANTULA, 15
	db 4, VENIPEDE,   15
	db 2, WHIRLIPEDE, 15
	db 1, SCOLIPEDE,  15
	db 4, SKORUPI,    15
	db 1, DRAPION,    15
	db 4, LARVESTA,   15
	db 1, VOLCARONA,  15
	db 4, MANKEY,     15
	db 1, PRIMEAPE,   15
	db 1, ANNIHILAPE, 15
	db 4, FERROSEED,  15
	db 1, FERROTHORN, 15
	db 4, SCYTHER,    15
	db 1, SCIZOR,     15
	db 1, KLEAVOR,    15
	db -1

; Rock smash sets dont have common/rare tables
 ; can have as many entries as you want as long as the % adds up to 100
 ; feel free to add new rock smash sets
TreeMonSet_Rock:
	db 90, HERACROSS,  15
	db 10, SHUCKLE,    15
	db -1
