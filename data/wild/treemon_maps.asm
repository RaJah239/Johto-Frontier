MACRO treemon_map
	map_id \1
	db \2 ; treemon set
ENDM

TreeMonMaps::
	treemon_map ROUTE_20,                  TREEMON_SET_KANTO
	treemon_map ROUTE_19,                  TREEMON_SET_KANTO
	treemon_map ROUTE_1,                   TREEMON_SET_ROUTE
	treemon_map ROUTE_2,                   TREEMON_SET_ROUTE
	treemon_map ROUTE_3,                   TREEMON_SET_ROUTE
	treemon_map ROUTE_4,                   TREEMON_SET_KANTO
	treemon_map ROUTE_5,                   TREEMON_SET_TOWN
	treemon_map ROUTE_6,                   TREEMON_SET_ROUTE
	treemon_map ROUTE_7,                   TREEMON_SET_ROUTE
	treemon_map ROUTE_8,                   TREEMON_SET_ROUTE
	treemon_map ROUTE_9,                   TREEMON_SET_ROUTE
	treemon_map ROUTE_10,                  TREEMON_SET_ROUTE
	treemon_map ROUTE_11,                  TREEMON_SET_ROUTE
	treemon_map ROUTE_12,                  TREEMON_SET_CITY
	treemon_map ROUTE_13,                  TREEMON_SET_CITY
	treemon_map ROUTE_14,                  TREEMON_SET_TOWN
	treemon_map ROUTE_15,                  TREEMON_SET_LAKE
	treemon_map ROUTE_16,                  TREEMON_SET_CANYON
	treemon_map ROUTE_17,                  TREEMON_SET_CANYON
	treemon_map ROUTE_18,                  TREEMON_SET_CANYON
	treemon_map NEW_BARK_TOWN,             TREEMON_SET_CITY
	treemon_map CHERRYGROVE_CITY,          TREEMON_SET_CITY
	treemon_map VIOLET_CITY,               TREEMON_SET_CITY
	treemon_map AZALEA_TOWN,               TREEMON_SET_TOWN
	treemon_map CIANWOOD_CITY,             TREEMON_SET_CITY
	treemon_map GOLDENROD_CITY,            TREEMON_SET_CITY
	treemon_map OLIVINE_CITY,              TREEMON_SET_CITY
	treemon_map ECRUTEAK_CITY,             TREEMON_SET_CITY
	treemon_map MAHOGANY_TOWN,             TREEMON_SET_CITY
	treemon_map LAKE_OF_RAGE,              TREEMON_SET_LAKE
	treemon_map BLACKTHORN_CITY,           TREEMON_SET_CITY
	treemon_map SILVER_CAVE_OUTSIDE,       TREEMON_SET_CITY
	treemon_map ILEX_FOREST,               TREEMON_SET_FOREST
	db -1

RockMonMaps::
	treemon_map CIANWOOD_CITY,             TREEMON_SET_ROCK
	treemon_map ROUTE_12,                  TREEMON_SET_ROCK
	treemon_map DARK_CAVE_VIOLET_ENTRANCE, TREEMON_SET_ROCK
	treemon_map SLOWPOKE_WELL_B1F,         TREEMON_SET_ROCK
	db -1
