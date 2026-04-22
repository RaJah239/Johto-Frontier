MapGroupNum_Names::
	table_width 2, MapGroupNum_Names
	dw Olivine_Map_Names
	dw Mahogany_Map_Names
	dw Dungeons_Map_Names
	dw Ecruteak_Map_Names
	dw Blackthorn_Map_Names
	dw Azalea_Map_Names
	dw Lake_of_Rage_Map_Names
	dw Violet_Map_Names
	dw Goldenrod_Map_Names
	dw Fast_Ship_Map_Names
	dw Indigo_Map_Names
	dw Silver_Map_Names
	dw Cable_Club_Map_Names
	dw Cianwood_Map_Names
	dw New_Bark_Map_Names
	dw Cherrygrove_Map_Names
	dw Battle_Plaza_Names
	assert_table_length NUM_MAP_GROUPS

GetMapGroupNum_Name::
	dec d ; map num
	dec e ; map group
	push de
	ld d, 0
	; ld hl, Dungeons_Map_Names
	ld hl, MapGroupNum_Names
	add hl, de
	add hl, de
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a
	ld h, d
	ld l, e
	pop de
	ld e, d
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a
	; return string ptr in de
	ret

Olivine_Map_Names: ; newgroup OLIVINE
	table_width 2, Olivine_Map_Names
	dw Olivine_Map_Name1  ; map_const OLIVINE_POKECENTER_1F
	dw Olivine_Map_Name2  ; map_const OLIVINE_GYM
	dw Olivine_Map_Name3  ; map_const OLIVINE_TIMS_HOUSE
	dw Olivine_Map_Name4  ; map_const OLIVINE_PUNISHMENT_SPEECH_HOUSE
	dw Olivine_Map_Name5  ; map_const OLIVINE_GOOD_ROD_HOUSE
	dw Olivine_Map_Name6  ; map_const OLIVINE_CAFE
	dw Olivine_Map_Name7  ; map_const OLIVINE_MART
	dw Olivine_Map_Name8  ; map_const ROUTE_10_ECRUTEAK_GATE
	dw Olivine_Map_Name9  ; map_const ROUTE_11_BARN
	dw Olivine_Map_Name10 ; map_const ROUTE_11_FARMHOUSE
	dw Olivine_Map_Name11 ; map_const ROUTE_10
	dw Olivine_Map_Name12 ; map_const ROUTE_11
	dw Olivine_Map_Name13 ; map_const OLIVINE_CITY
	assert_table_length NUM_OLIVINE_MAPS

; MAX LENGTH: 17
Olivine_Map_Name1:  db "Olivine <PKMN> Center@"
Olivine_Map_Name2:  db "Olivine Gym@"
Olivine_Map_Name3:  db "Tim's House@"
Olivine_Map_Name4:  db "Olivine House 1@"
Olivine_Map_Name5:  db "Olivine Fisher@"
Olivine_Map_Name6:  db "Olivine Cafe@"
Olivine_Map_Name7:  db "Olivine #mart@"
Olivine_Map_Name8:  db "Route 10 Gate@"
Olivine_Map_Name9:  db "Route 11 Barn@"
Olivine_Map_Name10: db "Route 11 House@"
Olivine_Map_Name11: db "Route 10@"
Olivine_Map_Name12: db "Route 11@"
Olivine_Map_Name13: db "Olivine City@"

Mahogany_Map_Names: ; newgroup MAHOGANY
	table_width 2, Mahogany_Map_Names
	dw Mahogany_Map_Name1 ; map_const MAHOGANY_RED_GYARADOS_SPEECH_HOUSE
	dw Mahogany_Map_Name2 ; map_const MAHOGANY_GYM
	dw Mahogany_Map_Name3 ; map_const MAHOGANY_POKECENTER_1F
	dw Mahogany_Map_Name4 ; map_const ROUTE_14_ECRUTEAK_GATE
	dw Mahogany_Map_Name5 ; map_const ROUTE_14
	dw Mahogany_Map_Name6 ; map_const ROUTE_16
	dw Mahogany_Map_Name7 ; map_const MAHOGANY_TOWN
	dw Mahogany_Map_Name8 ; map_const MAHOGANY_TRADE_BACK_KID_HOUSE
	assert_table_length NUM_MAHOGANY_MAPS

Mahogany_Map_Name1: db "Mahogany House@"
Mahogany_Map_Name2: db "Mahogany Gym@"
Mahogany_Map_Name3: db "Mahogany Center@"
Mahogany_Map_Name4: db "Route 14 Gate@"
Mahogany_Map_Name5: db "Route 14@"
Mahogany_Map_Name6: db "Route 16@"
Mahogany_Map_Name7: db "Mahogany Town@"
Mahogany_Map_Name8: db "Trade Back House@"

Dungeons_Map_Names: ; newgroup DUNGEONS
	table_width 2, Dungeons_Map_Names
	dw Dungeons_Map_Name1  ; map_const SPROUT_TOWER_1F
	dw Dungeons_Map_Name2  ; map_const SPROUT_TOWER_2F
	dw Dungeons_Map_Name3  ; map_const SPROUT_TOWER_3F
	dw Dungeons_Map_Name4  ; map_const TIN_TOWER_1F
	dw Dungeons_Map_Name5  ; map_const TIN_TOWER_2F
	dw Dungeons_Map_Name6  ; map_const TIN_TOWER_3F
	dw Dungeons_Map_Name7  ; map_const TIN_TOWER_4F
	dw Dungeons_Map_Name8  ; map_const TIN_TOWER_5F
	dw Dungeons_Map_Name9  ; map_const TIN_TOWER_6F
	dw Dungeons_Map_Name10 ; map_const TIN_TOWER_7F
	dw Dungeons_Map_Name11 ; map_const TIN_TOWER_8F
	dw Dungeons_Map_Name12 ; map_const TIN_TOWER_9F
	dw Dungeons_Map_Name13 ; map_const BURNED_TOWER_1F
	dw Dungeons_Map_Name14 ; map_const BURNED_TOWER_B1F
	dw Dungeons_Map_Name15 ; map_const NATIONAL_PARK
	dw Dungeons_Map_Name16 ; map_const NATIONAL_PARK_BUG_CONTEST
	dw Dungeons_Map_Name17 ; map_const RADIO_TOWER_1F
	dw Dungeons_Map_Name18 ; map_const RADIO_TOWER_2F
	dw Dungeons_Map_Name19 ; map_const RADIO_TOWER_3F
	dw Dungeons_Map_Name20 ; map_const RADIO_TOWER_4F
	dw Dungeons_Map_Name21 ; map_const RADIO_TOWER_5F
	dw Dungeons_Map_Name22 ; map_const RUINS_OF_ALPH_OUTSIDE
	dw Dungeons_Map_Name23 ; map_const RUINS_OF_ALPH_HO_OH_CHAMBER
	dw Dungeons_Map_Name24 ; map_const RUINS_OF_ALPH_LILEEP_CHAMBER
	dw Dungeons_Map_Name25 ; map_const RUINS_OF_ALPH_OMANYTE_CHAMBER
	dw Dungeons_Map_Name26 ; map_const RUINS_OF_ALPH_AERODACTYL_CHAMBER
	dw Dungeons_Map_Name27 ; map_const RUINS_OF_ALPH_INNER_CHAMBER
	dw Dungeons_Map_Name28 ; map_const RUINS_OF_ALPH_RESEARCH_CENTER
	dw Dungeons_Map_Name29 ; map_const RUINS_OF_ALPH_HO_OH_ITEM_ROOM
	dw Dungeons_Map_Name30 ; map_const RUINS_OF_ALPH_LILEEP_ITEM_ROOM
	dw Dungeons_Map_Name31 ; map_const RUINS_OF_ALPH_OMANYTE_ITEM_ROOM
	dw Dungeons_Map_Name32 ; map_const RUINS_OF_ALPH_AERODACTYL_ITEM_ROOM
	dw Dungeons_Map_Name33 ; map_const RUINS_OF_ALPH_HO_OH_WORD_ROOM
	dw Dungeons_Map_Name34 ; map_const RUINS_OF_ALPH_LILEEP_WORD_ROOM
	dw Dungeons_Map_Name35 ; map_const RUINS_OF_ALPH_OMANYTE_WORD_ROOM
	dw Dungeons_Map_Name36 ; map_const RUINS_OF_ALPH_AERODACTYL_WORD_ROOM
	dw Dungeons_Map_Name37 ; map_const UNION_CAVE_1F
	dw Dungeons_Map_Name38 ; map_const UNION_CAVE_B1F
	dw Dungeons_Map_Name39 ; map_const UNION_CAVE_B2F
	dw Dungeons_Map_Name40 ; map_const SLOWPOKE_WELL_B1F
	dw Dungeons_Map_Name41 ; map_const SLOWPOKE_WELL_B2F
	dw Dungeons_Map_Name42 ; map_const OLIVINE_LIGHTHOUSE_1F
	dw Dungeons_Map_Name43 ; map_const OLIVINE_LIGHTHOUSE_2F
	dw Dungeons_Map_Name44 ; map_const OLIVINE_LIGHTHOUSE_3F
	dw Dungeons_Map_Name45 ; map_const OLIVINE_LIGHTHOUSE_4F
	dw Dungeons_Map_Name46 ; map_const OLIVINE_LIGHTHOUSE_5F
	dw Dungeons_Map_Name47 ; map_const OLIVINE_LIGHTHOUSE_6F
	dw Dungeons_Map_Name48 ; map_const MAHOGANY_MART_1F
	dw Dungeons_Map_Name49 ; map_const TEAM_ROCKET_BASE_B1F
	dw Dungeons_Map_Name50 ; map_const TEAM_ROCKET_BASE_B2F
	dw Dungeons_Map_Name51 ; map_const TEAM_ROCKET_BASE_B3F
	dw Dungeons_Map_Name52 ; map_const ILEX_FOREST
	dw Dungeons_Map_Name53 ; map_const GOLDENROD_UNDERGROUND
	dw Dungeons_Map_Name54 ; map_const GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES
	dw Dungeons_Map_Name55 ; map_const GOLDENROD_DEPT_STORE_B1F
	dw Dungeons_Map_Name56 ; map_const GOLDENROD_UNDERGROUND_WAREHOUSE
	dw Dungeons_Map_Name57 ; map_const MOUNT_MORTAR_1F_OUTSIDE
	dw Dungeons_Map_Name58 ; map_const MOUNT_MORTAR_1F_INSIDE
	dw Dungeons_Map_Name59 ; map_const MOUNT_MORTAR_2F_INSIDE
	dw Dungeons_Map_Name60 ; map_const MOUNT_MORTAR_B1F
	dw Dungeons_Map_Name61 ; map_const ICE_PATH_1F
	dw Dungeons_Map_Name62 ; map_const ICE_PATH_B1F
	dw Dungeons_Map_Name63 ; map_const ICE_PATH_B2F_MAHOGANY_SIDE
	dw Dungeons_Map_Name64 ; map_const ICE_PATH_B2F_BLACKTHORN_SIDE
	dw Dungeons_Map_Name65 ; map_const ICE_PATH_B3F
	dw Dungeons_Map_Name66 ; map_const WHIRL_ISLAND_NW
	dw Dungeons_Map_Name67 ; map_const WHIRL_ISLAND_NE
	dw Dungeons_Map_Name68 ; map_const WHIRL_ISLAND_SW
	dw Dungeons_Map_Name69 ; map_const WHIRL_ISLAND_CAVE
	dw Dungeons_Map_Name70 ; map_const WHIRL_ISLAND_SE
	dw Dungeons_Map_Name71 ; map_const WHIRL_ISLAND_B1F
	dw Dungeons_Map_Name72 ; map_const WHIRL_ISLAND_B2F
	dw Dungeons_Map_Name73 ; map_const WHIRL_ISLAND_LUGIA_CHAMBER
	dw Dungeons_Map_Name74 ; map_const SILVER_CAVE_ROOM_1
	dw Dungeons_Map_Name75 ; map_const SILVER_CAVE_ROOM_2
	dw Dungeons_Map_Name76 ; map_const SILVER_CAVE_ROOM_3
	dw Dungeons_Map_Name77 ; map_const SILVER_CAVE_ITEM_ROOMS
	dw Dungeons_Map_Name78 ; map_const DARK_CAVE_VIOLET_ENTRANCE
	dw Dungeons_Map_Name79 ; map_const DARK_CAVE_BLACKTHORN_ENTRANCE
	dw Dungeons_Map_Name80 ; map_const DRAGONS_DEN_1F
	dw Dungeons_Map_Name81 ; map_const DRAGONS_DEN_B1F
	dw Dungeons_Map_Name82 ; map_const DRAGON_SHRINE
	dw Dungeons_Map_Name83 ; map_const TOHJO_FALLS
	dw Dungeons_Map_Name84 ; map_const VICTORY_ROAD
	assert_table_length NUM_DUNGEONS_MAPS

Dungeons_Map_Name1:  db "Sprout Tower 1F@"
Dungeons_Map_Name2:  db "Sprout Tower 2F@"
Dungeons_Map_Name3:  db "Sprout Tower 3F@"
Dungeons_Map_Name4:  db "Tin Tower 1F@"
Dungeons_Map_Name5:  db "Tin Tower 2F@"
Dungeons_Map_Name6:  db "Tin Tower 3F@"
Dungeons_Map_Name7:  db "Tin Tower 4F@"
Dungeons_Map_Name8:  db "Tin Tower 5F@"
Dungeons_Map_Name9:  db "Tin Tower 6F@"
Dungeons_Map_Name10: db "Tin Tower 7F@"
Dungeons_Map_Name11: db "Tin Tower 8F@"
Dungeons_Map_Name12: db "Tin Tower 9F@"
Dungeons_Map_Name13: db "Burned Tower 1F@"
Dungeons_Map_Name14: db "Burned Tower B1F@"
Dungeons_Map_Name15: db "National Park@"
Dungeons_Map_Name16: db "Park: Bug Contest@"
Dungeons_Map_Name17: db "Radio Tower 1F@"
Dungeons_Map_Name18: db "Radio Tower 2F@"
Dungeons_Map_Name19: db "Radio Tower 3F@"
Dungeons_Map_Name20: db "Radio Tower 4F@"
Dungeons_Map_Name21: db "Radio Tower 5F@"
Dungeons_Map_Name22: db "Ruins Of Alph@"
Dungeons_Map_Name23: db "Puzzle Chamber@"
Dungeons_Map_Name24: db "Puzzle Chamber@"
Dungeons_Map_Name25: db "Puzzle Chamber@"
Dungeons_Map_Name26: db "Puzzle Chamber@"
Dungeons_Map_Name27: db "Ruins Chamber@"
Dungeons_Map_Name28: db "Ruins Of Alph Lab@"
Dungeons_Map_Name29: db "Ho-Oh Prize Room@"
Dungeons_Map_Name30: db "Lileep Prize Room@"
Dungeons_Map_Name31: db "Omanyte Prize Room@"
Dungeons_Map_Name32: db "Aero. Prize Room@"
Dungeons_Map_Name33: db "Ho-oH Word Room@"
Dungeons_Map_Name34: db "Lileep Word Room@"
Dungeons_Map_Name35: db "Omanyte Word Room@"
Dungeons_Map_Name36: db "Aero. Word Room@"
Dungeons_Map_Name37: db "Union Cave 1F@"
Dungeons_Map_Name38: db "Union Cave B1F@"
Dungeons_Map_Name39: db "Union Cave B2F@"
Dungeons_Map_Name40: db "Slowpoke Well B1@"
Dungeons_Map_Name41: db "Slowpoke Well B2@"
Dungeons_Map_Name42: db "Lighthouse 1F@"
Dungeons_Map_Name43: db "Lighthouse 2F@"
Dungeons_Map_Name44: db "Lighthouse 3F@"
Dungeons_Map_Name45: db "Lighthouse 4F@"
Dungeons_Map_Name46: db "Lighthouse 5F@"
Dungeons_Map_Name47: db "Lighthouse 6F@"
Dungeons_Map_Name48: db "Mahogany #mart@"
Dungeons_Map_Name49: db "Rocket Base B1F@"
Dungeons_Map_Name50: db "Rocket Base B2f@"
Dungeons_Map_Name51: db "Rocket Base B3F@"
Dungeons_Map_Name52: db "Ilex Forest@"
Dungeons_Map_Name53: db "Gold. Underground@"
Dungeons_Map_Name54: db "Gold. Underground@"
Dungeons_Map_Name55: db "Golden. Dept. B1F@"
Dungeons_Map_Name56: db "Golden. Dept. Ware@"
Dungeons_Map_Name57: db "Mt. Mortar Outside@"
Dungeons_Map_Name58: db "Mt. Mortar 1F@"
Dungeons_Map_Name59: db "Mt. Mortar 2F@"
Dungeons_Map_Name60: db "Mt. Mortar B1F@"
Dungeons_Map_Name61: db "Ice Path 1F@"
Dungeons_Map_Name62: db "Ice Path B1F@"
Dungeons_Map_Name63: db "Ice Path B2F West@"
Dungeons_Map_Name64: db "Ice Path B2F East@"
Dungeons_Map_Name65: db "Ice Path B3F@"
Dungeons_Map_Name66: db "Whirl Islands N.W.@"
Dungeons_Map_Name67: db "Whirl Islands N.E.@"
Dungeons_Map_Name68: db "Whirl Islands S.W.@"
Dungeons_Map_Name69: db "Whirl Islands Cave@"
Dungeons_Map_Name70: db "Whirl Islands S.E.@"
Dungeons_Map_Name71: db "Whirl Islands B1F@"
Dungeons_Map_Name72: db "Whirl Islands B2F@"
Dungeons_Map_Name73: db "Whirl Chamber@"
Dungeons_Map_Name74: db "Silver Cave Room 1@"
Dungeons_Map_Name75: db "Silver Cave Room 2@"
Dungeons_Map_Name76: db "Silver Cave Room 3@"
Dungeons_Map_Name77: db "Silver Cave Room 4@"	
Dungeons_Map_Name78: db "Dark Cave, West@"
Dungeons_Map_Name79: db "Dark Cave, East@"
Dungeons_Map_Name80: db "Dragons Den 1F@"
Dungeons_Map_Name81: db "Dragons Den B1@"
Dungeons_Map_Name82: db "Dragon Shrine@"
Dungeons_Map_Name83: db "Tohjo Falls@"
Dungeons_Map_Name84: db "Victory Road@"

Ecruteak_Map_Names: ; newgroup ECRUTEAK
	table_width 2, Ecruteak_Map_Names
	dw Ecruteak_Map_Name1  ; map_const ECRUTEAK_TIN_TOWER_ENTRANCE
	dw Ecruteak_Map_Name2  ; map_const WISE_TRIOS_ROOM
	dw Ecruteak_Map_Name3  ; map_const ECRUTEAK_POKECENTER_1F
	dw Ecruteak_Map_Name4  ; map_const ECRUTEAK_LUGIA_SPEECH_HOUSE
	dw Ecruteak_Map_Name5  ; map_const DANCE_THEATRE
	dw Ecruteak_Map_Name6  ; map_const ECRUTEAK_MART
	dw Ecruteak_Map_Name7  ; map_const ECRUTEAK_GYM
	dw Ecruteak_Map_Name8  ; map_const ECRUTEAK_ITEMFINDER_HOUSE
	dw Ecruteak_Map_Name9  ; map_const ECRUTEAK_CITY
	dw Ecruteak_Map_Name10 ; map_const ECRUTEAK_BLACKSMITH_HOUSE
	assert_table_length NUM_ECRUTEAK_MAPS

Ecruteak_Map_Name1:  db "Tin Tower Path@"
Ecruteak_Map_Name2:  db "Wise Trio Room@"
Ecruteak_Map_Name3:  db "Ecruteak <PKMN> Center@"
Ecruteak_Map_Name4:  db "Ecruteak House 1@"
Ecruteak_Map_Name5:  db "Dance Theater@"
Ecruteak_Map_Name6:  db "Ecruteak #mart@"
Ecruteak_Map_Name7:  db "Ecruteak Gym@"
Ecruteak_Map_Name8:  db "Itemfinder House@"
Ecruteak_Map_Name9:  db "Ecruteak City@"
Ecruteak_Map_Name10: db "Blacksmith's House@"

Blackthorn_Map_Names: ; newgroup BLACKTHORN
	table_width 2, Blackthorn_Map_Names
	dw Blackthorn_Map_Name1  ; map_const BLACKTHORN_GYM_1F
	dw Blackthorn_Map_Name2  ; map_const BLACKTHORN_GYM_2F
	dw Blackthorn_Map_Name3  ; map_const BLACKTHORN_DRAGON_SPEECH_HOUSE
	dw Blackthorn_Map_Name4  ; map_const BLACKTHORN_EMYS_HOUSE
	dw Blackthorn_Map_Name5  ; map_const BLACKTHORN_MART
	dw Blackthorn_Map_Name6  ; map_const BLACKTHORN_POKECENTER_1F
	dw Blackthorn_Map_Name7  ; map_const MOVE_DELETERS_HOUSE
	dw Blackthorn_Map_Name8  ; map_const ROUTE_17
	dw Blackthorn_Map_Name9  ; map_const ROUTE_18
	dw Blackthorn_Map_Name10 ; map_const BLACKTHORN_CITY
	assert_table_length NUM_BLACKTHORN_MAPS

Blackthorn_Map_Name1:  db "Blackthorn Gym@"
Blackthorn_Map_Name2:  db "Blackthorn Gym B1@"
Blackthorn_Map_Name3:  db "Dragon House@"
Blackthorn_Map_Name4:  db "Emy's House@"
Blackthorn_Map_Name5:  db "Blackthorn <POKE>mart@"
Blackthorn_Map_Name6:  db "Blackthorn Center@"
Blackthorn_Map_Name7:  db "Tutor House@"
Blackthorn_Map_Name8:  db "Route 17@"
Blackthorn_Map_Name9:  db "Route 18@"
Blackthorn_Map_Name10: db "Blackthorn City@"

Azalea_Map_Names: ; newgroup AZALEA
	table_width 2, Azalea_Map_Names
	dw Azalea_Map_Name1 ; map_const AZALEA_POKECENTER_1F
	dw Azalea_Map_Name2 ; map_const CHARCOAL_KILN
	dw Azalea_Map_Name3 ; map_const AZALEA_MART
	dw Azalea_Map_Name4 ; map_const KURTS_HOUSE
	dw Azalea_Map_Name5 ; map_const AZALEA_GYM
	dw Azalea_Map_Name6 ; map_const ROUTE_5
	dw Azalea_Map_Name7 ; map_const AZALEA_TOWN
	assert_table_length NUM_AZALEA_MAPS

Azalea_Map_Name1: db "Azalea <PKMN> Center@"
Azalea_Map_Name2: db "Charcoal Kiln@"
Azalea_Map_Name3: db "Azalea #mart@"
Azalea_Map_Name4: db "Kurt's house@"
Azalea_Map_Name5: db "Azalea Gym@"
Azalea_Map_Name6: db "Route 5@"
Azalea_Map_Name7: db "Azalea Town@"

Lake_of_Rage_Map_Names: ; newgroup LAKE_OF_RAGE
	table_width 2, Lake_of_Rage_Map_Names
	dw Lake_of_Rage_Map_Name1 ; map_const LAKE_OF_RAGE_HIDDEN_POWER_HOUSE
	dw Lake_of_Rage_Map_Name2 ; map_const LAKE_OF_RAGE_MAGIKARP_HOUSE
	dw Lake_of_Rage_Map_Name3 ; map_const ROUTE_15_MAHOGANY_GATE
	dw Lake_of_Rage_Map_Name4 ; map_const ROUTE_15_GATE
	dw Lake_of_Rage_Map_Name5 ; map_const ROUTE_15
	dw Lake_of_Rage_Map_Name6 ; map_const LAKE_OF_RAGE
	assert_table_length NUM_LAKE_OF_RAGE_MAPS

Lake_of_Rage_Map_Name1: db "Hidden Power House@"
Lake_of_Rage_Map_Name2: db "Magikarp House@"
Lake_of_Rage_Map_Name3: db "Route 15, Gate S.@"
Lake_of_Rage_Map_Name4: db "Route 15, Gate N.@"
Lake_of_Rage_Map_Name5: db "Route 15@"
Lake_of_Rage_Map_Name6: db "Lake Of Rage@"

Violet_Map_Names: ; newgroup VIOLET
	table_width 2, Violet_Map_Names
	dw Violet_Map_Name1  ; map_const ROUTE_4
	dw Violet_Map_Name2  ; map_const ROUTE_7
	dw Violet_Map_Name3  ; map_const ROUTE_8
	dw Violet_Map_Name4  ; map_const ROUTE_9
	dw Violet_Map_Name5  ; map_const VIOLET_CITY
	dw Violet_Map_Name6  ; map_const VIOLET_MART
	dw Violet_Map_Name7  ; map_const VIOLET_GYM
	dw Violet_Map_Name8  ; map_const EARLS_POKEMON_ACADEMY
	dw Violet_Map_Name9  ; map_const VIOLET_NICKNAME_SPEECH_HOUSE
	dw Violet_Map_Name10 ; map_const VIOLET_POKECENTER_1F
	dw Violet_Map_Name11 ; map_const VIOLET_KYLES_HOUSE
	dw Violet_Map_Name12 ; map_const ROUTE_4_RUINS_OF_ALPH_GATE
	dw Violet_Map_Name13 ; map_const ROUTE_4_POKECENTER_1F
	dw Violet_Map_Name14 ; map_const ROUTE_7_GOLDENROD_GATE
	dw Violet_Map_Name15 ; map_const ROUTE_7_NATIONAL_PARK_GATE
	dw Violet_Map_Name16 ; map_const ROUTE_8_RUINS_OF_ALPH_GATE
	dw Violet_Map_Name17 ; map_const ROUTE_8_NATIONAL_PARK_GATE
	assert_table_length NUM_VIOLET_MAPS

Violet_Map_Name1:  db "Route 4@"
Violet_Map_Name2:  db "Route 7@"
Violet_Map_Name3:  db "Route 8@"
Violet_Map_Name4:  db "Route 9@"
Violet_Map_Name5:  db "Violet City@"
Violet_Map_Name6:  db "violet #mart@"
Violet_Map_Name7:  db "Violet Gym@"
Violet_Map_Name8:  db "Earl's <PKMN> Academy@"
Violet_Map_Name9:  db "Violet House 1@"
Violet_Map_Name10: db "Violet <PKMN> Center@"
Violet_Map_Name11: db "Kyle's House@"
Violet_Map_Name12: db "Route 4-Ruin Gate@"
Violet_Map_Name13: db "Route 4 Center@"
Violet_Map_Name14: db "Route 7-Gold Gate@"
Violet_Map_Name15: db "Route 7-Park Gate@"
Violet_Map_Name16: db "Route 8-Ruin Gate@"
Violet_Map_Name17: db "Route 8-Park Gate@"

Goldenrod_Map_Names: ; newgroup GOLDENROD
	table_width 2, Goldenrod_Map_Names
	dw Goldenrod_Map_Name1  ; map_const ROUTE_6
	dw Goldenrod_Map_Name2  ; map_const GOLDENROD_CITY
	dw Goldenrod_Map_Name3  ; map_const GOLDENROD_GYM
	dw Goldenrod_Map_Name4  ; map_const GOLDENROD_BIKE_SHOP
	dw Goldenrod_Map_Name5  ; map_const GOLDENROD_HAPPINESS_RATER
	dw Goldenrod_Map_Name6  ; map_const BILLS_FAMILYS_HOUSE
	dw Goldenrod_Map_Name7  ; map_const GOLDENROD_MAGNET_TRAIN_STATION
	dw Goldenrod_Map_Name8  ; map_const GOLDENROD_FLOWER_SHOP
	dw Goldenrod_Map_Name9  ; map_const GOLDENROD_PP_SPEECH_HOUSE
	dw Goldenrod_Map_Name10 ; map_const GOLDENROD_POKE_BROS_HOUSE
	dw Goldenrod_Map_Name11 ; map_const GOLDENROD_DEPT_STORE_1F
	dw Goldenrod_Map_Name12 ; map_const GOLDENROD_DEPT_STORE_2F
	dw Goldenrod_Map_Name13 ; map_const GOLDENROD_DEPT_STORE_3F
	dw Goldenrod_Map_Name14 ; map_const GOLDENROD_DEPT_STORE_4F
	dw Goldenrod_Map_Name15 ; map_const GOLDENROD_DEPT_STORE_5F
	dw Goldenrod_Map_Name16 ; map_const GOLDENROD_DEPT_STORE_6F
	dw Goldenrod_Map_Name17 ; map_const GOLDENROD_DEPT_STORE_ELEVATOR
	dw Goldenrod_Map_Name18 ; map_const GOLDENROD_DEPT_STORE_ROOF
	dw Goldenrod_Map_Name19 ; map_const GOLDENROD_GAME_CORNER
	dw Goldenrod_Map_Name20 ; map_const GOLDENROD_POKECENTER_1F
	dw Goldenrod_Map_Name21 ; map_const POKECOM_CENTER_ADMIN_OFFICE_MOBILE
	dw Goldenrod_Map_Name22 ; map_const ILEX_FOREST_AZALEA_GATE
	dw Goldenrod_Map_Name23 ; map_const ROUTE_6_ILEX_FOREST_GATE
	dw Goldenrod_Map_Name24 ; map_const DAY_CARE
	dw Goldenrod_Map_Name25 ; map_const HATCH_ROOM
	dw Goldenrod_Map_Name26 ; map_const GOLDENROD_MANSION_1F
	dw Goldenrod_Map_Name27 ; map_const GOLDENROD_MANSION_2F
	dw Goldenrod_Map_Name28 ; map_const GOLDENROD_MANSION_3F
	dw Goldenrod_Map_Name29 ; map_const GOLDENROD_MANSION_ROOF
	dw Goldenrod_Map_Name30 ; map_const GOLDENROD_MANSION_ROOF_HOUSE
	assert_table_length NUM_GOLDENROD_MAPS

Goldenrod_Map_Name1:  db "Route 6@"
Goldenrod_Map_Name2:  db "Goldenrod City@"
Goldenrod_Map_Name3:  db "Goldenrod Gym@"
Goldenrod_Map_Name4:  db "Goldenrod Bikeshop@"
Goldenrod_Map_Name5:  db "Happiness Rater@"
Goldenrod_Map_Name6:  db "Bill's Family Home@"
Goldenrod_Map_Name7:  db "Johto Trainstation@"
Goldenrod_Map_Name8:  db "Golden Flower Shop@"
Goldenrod_Map_Name9:  db "Goldenrod House 1@"
Goldenrod_Map_Name10: db "#-Bros House@"
Goldenrod_Map_Name11: db "Golden. Dept. 1F@"
Goldenrod_Map_Name12: db "Golden. Dept. 2F@"
Goldenrod_Map_Name13: db "Golden. Dept. 3F@"
Goldenrod_Map_Name14: db "Golden. Dept. 4F@"
Goldenrod_Map_Name15: db "Golden. Dept. 5F@"
Goldenrod_Map_Name16: db "Golden. Dept. 6F@"
Goldenrod_Map_Name17: db "Golden. Dept. Lift@"
Goldenrod_Map_Name18: db "Golden. Dept. Roof@"
Goldenrod_Map_Name19: db "Golden. GameCorner@"
Goldenrod_Map_Name20: db "Goldenrod Center@"
Goldenrod_Map_Name21: db "#com Cen Office@"
Goldenrod_Map_Name22: db "Azalea - Ilex gate@"
Goldenrod_Map_Name23: db "Ilex - Rt. 6 Gate@"
Goldenrod_Map_Name24: db "Route 6 Day Care@"
Goldenrod_Map_Name25: db "Hatch Room@"
Goldenrod_Map_Name26: db "Gold. Mansion 1F@"
Goldenrod_Map_Name27: db "Gold. Mansion 2F@"
Goldenrod_Map_Name28: db "Gold. Mansion 3F@"
Goldenrod_Map_Name29: db "Gold. Mansion Roof@"
Goldenrod_Map_Name30: db "Gold. Mansion 4F@"

Fast_Ship_Map_Names: ; newgroup FAST_SHIP
	table_width 2, Fast_Ship_Map_Names
	dw Fast_Ship_Map_Name1 ; map_const OLIVINE_PORT
	dw Fast_Ship_Map_Name2 ; map_const OLIVINE_PORT_PASSAGE
	dw Fast_Ship_Map_Name3 ; map_const MT_MORTAR_SQUARE
	dw Fast_Ship_Map_Name4 ; map_const MT_MORTAR_GIFT_SHOP
	dw Fast_Ship_Map_Name5 ; map_const TIN_TOWER_ROOF
	assert_table_length NUM_FAST_SHIP_MAPS

Fast_Ship_Map_Name1: db "Olivine Marina@"
Fast_Ship_Map_Name2: db "Olivine Passage@"
Fast_Ship_Map_Name3: db "Mt. Mortar Square@"
Fast_Ship_Map_Name4: db "Mt. Mortar Shop@"
Fast_Ship_Map_Name5: db "Tin Tower Roof@"                                             ; 16

Indigo_Map_Names: ; newgroup INDIGO
	table_width 2, Indigo_Map_Names
	dw Indigo_Map_Name1  ; map_const ROUTE_21
	dw Indigo_Map_Name2  ; map_const INDIGO_PLATEAU_POKECENTER_1F
	dw Indigo_Map_Name3  ; map_const WILLS_ROOM
	dw Indigo_Map_Name4  ; map_const KOGAS_ROOM
	dw Indigo_Map_Name5  ; map_const BRUNOS_ROOM
	dw Indigo_Map_Name6  ; map_const KARENS_ROOM
	dw Indigo_Map_Name7  ; map_const LANCES_ROOM
	dw Indigo_Map_Name8  ; map_const HALL_OF_FAME
	dw Indigo_Map_Name9  ; map_const NURSE_JOYS_TRAINING_ACADEMY
	dw Indigo_Map_Name10 ; map_const VICTORY_ROAD_GATE
	assert_table_length NUM_INDIGO_MAPS

Indigo_Map_Name1:  db "Route 21@"
Indigo_Map_Name2:  db "Indigo Plateau@"
Indigo_Map_Name3:  db "E4 Will's Room@"
Indigo_Map_Name4:  db "E4 Koga's Room@"
Indigo_Map_Name5:  db "E4 Bruno's Room@"
Indigo_Map_Name6:  db "E4 Karen's Room@"
Indigo_Map_Name7:  db "Champion's Room@"
Indigo_Map_Name8:  db "@" ; no text as player can never see this in standard play
Indigo_Map_Name9:  db "Joy's Academy@"
Indigo_Map_Name10: db "Victory Road Gate@"

Silver_Map_Names: ; newgroup SILVER
	table_width 2, Silver_Map_Names
	dw Silver_Map_Name1 ; map_const SILVER_CAVE_OUTSIDE
	dw Silver_Map_Name2 ; map_const SILVER_CAVE_POKECENTER_1F
	dw Silver_Map_Name3 ; map_const ROUTE_11_SILVER_CAVE_GATE
	assert_table_length NUM_SILVER_MAPS

Silver_Map_Name1: db "Mt. Silver@"
Silver_Map_Name2: db "Silver Cave Center@"
Silver_Map_Name3: db "Route 11 Gate@"

; ============
; === Note ===
; ============
; to remove this entire map group
; refer to commit "e79d224e800c18e6f7854cd54ff5f9beb2b103b0" or
; "Refactor: Organised Battle Plaza as a separated Map Group, can add Outdoor Sprites now"
Cable_Club_Map_Names: ; newgroup CABLE_CLUB
	table_width 2, Cable_Club_Map_Names
	dw Cable_Club_Map_Name1 ; map_const POKECENTER_2F
	dw Cable_Club_Map_Name2 ; map_const TRADE_CENTER
	dw Cable_Club_Map_Name3 ; map_const COLOSSEUM
	dw Cable_Club_Map_Name4 ; map_const MOBILE_TRADE_ROOM
	dw Cable_Club_Map_Name5 ; map_const MOBILE_BATTLE_ROOM
	assert_table_length NUM_CABLE_CLUB_MAPS

Cable_Club_Map_Name1: db "@"
Cable_Club_Map_Name2: db "@"
Cable_Club_Map_Name3: db "@"
Cable_Club_Map_Name4: db "@"
Cable_Club_Map_Name5: db "@"

Cianwood_Map_Names: ; newgroup CIANWOOD
	table_width 2, Cianwood_Map_Names
	dw Cianwood_Map_Name1  ; map_const ROUTE_12
	dw Cianwood_Map_Name2  ; map_const ROUTE_13
	dw Cianwood_Map_Name3  ; map_const CIANWOOD_CITY
	dw Cianwood_Map_Name4  ; map_const MANIAS_HOUSE
	dw Cianwood_Map_Name5  ; map_const CIANWOOD_GYM
	dw Cianwood_Map_Name6  ; map_const CIANWOOD_POKECENTER_1F
	dw Cianwood_Map_Name7  ; map_const CIANWOOD_PHARMACY
	dw Cianwood_Map_Name8  ; map_const CIANWOOD_PHOTO_STUDIO
	dw Cianwood_Map_Name9  ; map_const CIANWOOD_LUGIA_SPEECH_HOUSE
	dw Cianwood_Map_Name10 ; map_const POKE_SEERS_HOUSE
	dw Cianwood_Map_Name11 ; map_const ROUTE_12_POWER_PLANT_GATE
	dw Cianwood_Map_Name12 ; map_const POWER_PLANT_OUTSIDE
	dw Cianwood_Map_Name13 ; map_const CIANWOOD_PORT
	dw Cianwood_Map_Name14 ; map_const CIANWOOD_PORT_PASSAGE
	dw Cianwood_Map_Name15 ; map_const POWER_PLANT
	assert_table_length NUM_CIANWOOD_MAPS

Cianwood_Map_Name1:  db "Route 12@"
Cianwood_Map_Name2:  db "Route 13@"
Cianwood_Map_Name3:  db "Cianwood City@"
Cianwood_Map_Name4:  db "Mania's House@"
Cianwood_Map_Name5:  db "Cianwood Gym@"
Cianwood_Map_Name6:  db "Cianwood Center@"
Cianwood_Map_Name7:  db "Cianwood Pharmacy@"
Cianwood_Map_Name8:  db "Cianwood Studio@"
Cianwood_Map_Name9:  db "Cianwood House@"
Cianwood_Map_Name10: db "#seer House@"
Cianwood_Map_Name11: db "Route 12 Gate@"
Cianwood_Map_Name12: db "Power Plant@"
Cianwood_Map_Name13: db "Cianwood Marina@"
Cianwood_Map_Name14: db "Cianwood Passage@"
Cianwood_Map_Name15: db "Power Plant@"

New_Bark_Map_Names: ; newgroup NEW_BARK
	table_width 2, New_Bark_Map_Names
	dw New_Bark_Map_Name1  ; map_const ROUTE_20
	dw New_Bark_Map_Name2  ; map_const ROUTE_19
	dw New_Bark_Map_Name3  ; map_const ROUTE_1
	dw New_Bark_Map_Name4  ; map_const NEW_BARK_TOWN
	dw New_Bark_Map_Name5  ; map_const ELMS_LAB
	dw New_Bark_Map_Name6  ; map_const PLAYERS_HOUSE_1F
	dw New_Bark_Map_Name7  ; map_const PLAYERS_HOUSE_2F
	dw New_Bark_Map_Name8  ; map_const PLAYERS_NEIGHBORS_HOUSE
	dw New_Bark_Map_Name9  ; map_const ELMS_HOUSE
	dw New_Bark_Map_Name10 ; map_const ROUTE_20_HEAL_HOUSE
	dw New_Bark_Map_Name11 ; map_const DAY_OF_WEEK_SIBLINGS_HOUSE
	dw New_Bark_Map_Name12 ; map_const ROUTE_19_SANDSTORM_HOUSE
	dw New_Bark_Map_Name13 ; map_const ROUTE_1_ROUTE_18_GATE
	assert_table_length NUM_NEW_BARK_MAPS

New_Bark_Map_Name1:  db "Route 20@"
New_Bark_Map_Name2:  db "Route 19@"
New_Bark_Map_Name3:  db "Route 1@"
New_Bark_Map_Name4:  db "New Bark Town@"
New_Bark_Map_Name5:  db "Elm's Lab@"
New_Bark_Map_Name6:  db "player's House 1F@"
New_Bark_Map_Name7:  db "Player's House 2F@"
New_Bark_Map_Name8:  db "Neighbor's House@"
New_Bark_Map_Name9:  db "Elm's House@"
New_Bark_Map_Name10: db "Route 20 House@"
New_Bark_Map_Name11: db "Day Siblings House@"
New_Bark_Map_Name12: db "Route 19 House@"
New_Bark_Map_Name13: db "Route 1 Gate@"

Cherrygrove_Map_Names: ; newgroup CHERRYGROVE
	table_width 2, Cherrygrove_Map_Names
	dw Cherrygrove_Map_Name1  ; map_const ROUTE_2
	dw Cherrygrove_Map_Name2  ; map_const ROUTE_3
	dw Cherrygrove_Map_Name3  ; map_const CHERRYGROVE_CITY
	dw Cherrygrove_Map_Name4  ; map_const CHERRYGROVE_MART
	dw Cherrygrove_Map_Name5  ; map_const CHERRYGROVE_POKECENTER_1F
	dw Cherrygrove_Map_Name6  ; map_const CHERRYGROVE_GYM_SPEECH_HOUSE
	dw Cherrygrove_Map_Name7  ; map_const GUIDE_GENTS_HOUSE
	dw Cherrygrove_Map_Name8  ; map_const CHERRYGROVE_EVOLUTION_SPEECH_HOUSE
	dw Cherrygrove_Map_Name9  ; map_const ROUTE_2_BERRY_HOUSE
	dw Cherrygrove_Map_Name10 ; map_const MR_POKEMONS_HOUSE
	dw Cherrygrove_Map_Name11 ; map_const ROUTE_3_VIOLET_GATE
	assert_table_length NUM_CHERRYGROVE_MAPS

Cherrygrove_Map_Name1:  db "Route 2@"
Cherrygrove_Map_Name2:  db "Route 3@"
Cherrygrove_Map_Name3:  db "Cherrygrove City@"
Cherrygrove_Map_Name4:  db "Cherrygrove Mart@"
Cherrygrove_Map_Name5:  db "Cherrygrove Center@"
Cherrygrove_Map_Name6:  db "Cherrygrove House1@"
Cherrygrove_Map_Name7:  db "Guide Gent's House@"
Cherrygrove_Map_Name8:  db "Cherrygrove House2@"
Cherrygrove_Map_Name9:  db "Route 2 House@"
Cherrygrove_Map_Name10: db "Mr. #mon House@"
Cherrygrove_Map_Name11: db "Route 3 Gate@"

Battle_Plaza_Names: ; newgroup BATTLE_PLAZA
	table_width 2, Battle_Plaza_Names
	dw Battle_Plaza_Name1  ; map_const BATTLE_PLAZA
	dw Battle_Plaza_Name2  ; map_const BATTLE_PLAZA_MAGNET_TRAIN_STATION
	dw Battle_Plaza_Name3  ; map_const OAKS_LAB
	dw Battle_Plaza_Name4  ; map_const BATTLE_TOWER_1F
	dw Battle_Plaza_Name5  ; map_const BATTLE_PLAZA_MART
	dw Battle_Plaza_Name6  ; map_const BATTLE_TOWER_ELEVATOR
	dw Battle_Plaza_Name7  ; map_const BATTLE_TOWER_HALLWAY
	dw Battle_Plaza_Name8  ; map_const BATTLE_TOWER_BATTLE_ROOM
	dw Battle_Plaza_Name9  ; map_const BATTLE_PLAZA_RAJA_HOUSE
	dw Battle_Plaza_Name10 ; map_const BATTLE_PLAZA_BATTLE_LOBBY
	dw Battle_Plaza_Name11 ; map_const BATTLE_PLAZA_DRAFT_ARENA
	dw Battle_Plaza_Name12 ; map_const BATTLE_PLAZA_ECHO_CHAMBER
	assert_table_length NUM_BATTLE_PLAZA_MAPS

Battle_Plaza_Name1:  db "Battle Plaza@"
Battle_Plaza_Name2:  db "Plaza Station@"
Battle_Plaza_Name3:  db "Oak's Lab@"
Battle_Plaza_Name4:  db "Battle Tower 1F@"
Battle_Plaza_Name5:  db "Battle Plaza Mart@"
Battle_Plaza_Name6:  db "@" ; no text as player can never see this in standard play
Battle_Plaza_Name7:  db "@" ; no text as player can never see this in standard play
Battle_Plaza_Name8:  db "@" ; no text as player can never see this in standard play
Battle_Plaza_Name9:  db "RaJa239's House@"
Battle_Plaza_Name10: db "Battle Lobby@"
Battle_Plaza_Name11: db "Draft Arena@"
Battle_Plaza_Name12: db "Echo Chamber@"
