MACRO spawn
; map, x, y
	map_id \1
	db \2, \3
ENDM

SpawnPoints:
; entries correspond to SPAWN_* constants
	table_width 4, SpawnPoints

if DEF(_DEBUG)
	spawn PLAYERS_HOUSE_2F,            3,  2
else
	spawn PLAYERS_HOUSE_2F,            3,  3
endc
	spawn PLAYERS_HOUSE_2F,            3,  3
	spawn NEW_BARK_TOWN,              13,  6
	spawn CHERRYGROVE_CITY,           29,  4
	spawn VIOLET_CITY,                31, 26
	spawn RUINS_OF_ALPH_OUTSIDE,      17, 12
	spawn ROUTE_4,                    11, 74
	spawn AZALEA_TOWN,                15, 10
	spawn CIANWOOD_CITY,              23, 44
	spawn GOLDENROD_CITY,             15, 28
	spawn NATIONAL_PARK,              14, 43
	spawn OLIVINE_CITY,               13, 22
	spawn POWER_PLANT_OUTSIDE,         5,  6
	spawn ECRUTEAK_CITY,              23, 28
	spawn MAHOGANY_TOWN,              15, 14
	spawn LAKE_OF_RAGE,               21, 29
	spawn BLACKTHORN_CITY,            21, 30
	spawn ROUTE_20,                   15, 58
	spawn ROUTE_23,                    9,  6
	spawn SILVER_CAVE_OUTSIDE,        25, 20
	spawn N_A,                        -1, -1

	assert_table_length NUM_SPAWNS + 1
