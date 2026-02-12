MACRO map_attributes
;\1: map name
;\2: map id
;\3: border block
;\4: connections: combo of NORTH, SOUTH, WEST, and/or EAST, or 0 for none
	DEF CURRENT_MAP_WIDTH = \2_WIDTH
	DEF CURRENT_MAP_HEIGHT = \2_HEIGHT
\1_MapAttributes::
	db \3
	db CURRENT_MAP_HEIGHT, CURRENT_MAP_WIDTH
	db BANK(\1_Blocks)
	dw \1_Blocks
	db BANK(\1_MapScripts) ; aka BANK(\1_MapEvents)
	dw \1_MapScripts
	dw \1_MapEvents
	db \4
ENDM

; Connections go in order: north, south, west, east
MACRO connection
;\1: direction
;\2: map name
;\3: map id
;\4: offset of the target map relative to the current map
;    (x offset for east/west, y offset for north/south)

	; LEGACY: Support for old connection macro
	if _NARG == 6
		connection \1, \2, \3, (\4) - (\5)
	else

		; Calculate tile offsets for source (current) and target maps
		DEF _src = 0
		DEF _tgt = (\4) + MAP_CONNECTION_PADDING_WIDTH
		if _tgt < 0
			DEF _src = -_tgt
			DEF _tgt = 0
		endc

		if !STRCMP("\1", "north")
			DEF _blk = \3_WIDTH * (\3_HEIGHT - MAP_CONNECTION_PADDING_WIDTH) + _src
			DEF _map = _tgt
			DEF _win = (\3_WIDTH + MAP_CONNECTION_PADDING_WIDTH * 2) * \3_HEIGHT + 1
			DEF _y = \3_HEIGHT * 2 - 1
			DEF _x = (\4) * -2
			DEF _len = CURRENT_MAP_WIDTH + MAP_CONNECTION_PADDING_WIDTH - (\4)
			if _len > \3_WIDTH
				DEF _len = \3_WIDTH
			endc

		elif !STRCMP("\1", "south")
			DEF _blk = _src
			DEF _map = (CURRENT_MAP_WIDTH + MAP_CONNECTION_PADDING_WIDTH * 2) * (CURRENT_MAP_HEIGHT + MAP_CONNECTION_PADDING_WIDTH) + _tgt
			DEF _win = \3_WIDTH + MAP_CONNECTION_PADDING_WIDTH * 2 + 1
			DEF _y = 0
			DEF _x = (\4) * -2
			DEF _len = CURRENT_MAP_WIDTH + MAP_CONNECTION_PADDING_WIDTH - (\4)
			if _len > \3_WIDTH
				DEF _len = \3_WIDTH
			endc

		elif !STRCMP("\1", "west")
			DEF _blk = (\3_WIDTH * _src) + \3_WIDTH - MAP_CONNECTION_PADDING_WIDTH
			DEF _map = (CURRENT_MAP_WIDTH + MAP_CONNECTION_PADDING_WIDTH * 2) * _tgt
			DEF _win = (\3_WIDTH + MAP_CONNECTION_PADDING_WIDTH * 2) * 2 - MAP_CONNECTION_PADDING_WIDTH * 2
			DEF _y = (\4) * -2
			DEF _x = \3_WIDTH * 2 - 1
			DEF _len = CURRENT_MAP_HEIGHT + MAP_CONNECTION_PADDING_WIDTH - (\4)
			if _len > \3_HEIGHT
				DEF _len = \3_HEIGHT
			endc

		elif !STRCMP("\1", "east")
			DEF _blk = (\3_WIDTH * _src)
			DEF _map = (CURRENT_MAP_WIDTH + MAP_CONNECTION_PADDING_WIDTH * 2) * _tgt + CURRENT_MAP_WIDTH + MAP_CONNECTION_PADDING_WIDTH
			DEF _win = \3_WIDTH + MAP_CONNECTION_PADDING_WIDTH * 2 + 1
			DEF _y = (\4) * -2
			DEF _x = 0
			DEF _len = CURRENT_MAP_HEIGHT + MAP_CONNECTION_PADDING_WIDTH - (\4)
			if _len > \3_HEIGHT
				DEF _len = \3_HEIGHT
			endc

		else
			fail "Invalid direction for 'connection'."
		endc

	map_id \3
	dw \2_Blocks + _blk
	dw wOverworldMapBlocks + _map
	db _len - _src
	db \3_WIDTH
	db _y, _x
	dw wOverworldMapBlocks + _win

	endc
ENDM


	map_attributes NewBarkTown, NEW_BARK_TOWN, $05, WEST | EAST
	connection west, Route1, ROUTE_1, 0
	connection east, Route27, ROUTE_27, 0

	map_attributes CherrygroveCity, CHERRYGROVE_CITY, $35, NORTH | EAST
	connection north, Route2, ROUTE_2, 5
	connection east, Route1, ROUTE_1, 0

	map_attributes VioletCity, VIOLET_CITY, $05, SOUTH | WEST | EAST
	connection south, Route4, ROUTE_4, 0
	connection west, Route8, ROUTE_8, 0
	connection east, Route3, ROUTE_3, 9

	map_attributes AzaleaTown, AZALEA_TOWN, $05, WEST | EAST
	connection west, Route6, ROUTE_6, -18
	connection east, Route5, ROUTE_5, 0

	map_attributes CianwoodCity, CIANWOOD_CITY, $35, EAST
	connection east, Route13, ROUTE_13, 0

	map_attributes GoldenrodCity, GOLDENROD_CITY, $35, NORTH | SOUTH
	connection north, Route7, ROUTE_7, 5
	connection south, Route6, ROUTE_6, 5

	map_attributes OlivineCity, OLIVINE_CITY, $35, NORTH | WEST
	connection north, Route11, ROUTE_11, 5
	connection west, Route12, ROUTE_12, 9

	map_attributes EcruteakCity, ECRUTEAK_CITY, $05, SOUTH | WEST | EAST
	connection south, Route9, ROUTE_9, 5
	connection west, Route10, ROUTE_10, 5
	connection east, Route14, ROUTE_14, 9

	map_attributes MahoganyTown, MAHOGANY_TOWN, $71, NORTH | WEST | EAST
	connection north, Route15, ROUTE_15, 0
	connection west, Route14, ROUTE_14, 0
	connection east, Route16, ROUTE_16, 0

	map_attributes LakeOfRage, LAKE_OF_RAGE, $05, SOUTH
	connection south, Route15, ROUTE_15, 5

	map_attributes BlackthornCity, BLACKTHORN_CITY, $71, SOUTH | WEST
	connection south, Route17, ROUTE_17, 0
	connection west, Route16, ROUTE_16, 9

	map_attributes Route26, ROUTE_26, $05, WEST
	connection west, Route27, ROUTE_27, 45

	map_attributes Route27, ROUTE_27, $35, WEST | EAST
	connection west, NewBarkTown, NEW_BARK_TOWN, 0
	connection east, Route26, ROUTE_26, -45

	map_attributes Route1, ROUTE_1, $05, NORTH | WEST | EAST
	connection north, Route46, ROUTE_46, 10
	connection west, CherrygroveCity, CHERRYGROVE_CITY, 0
	connection east, NewBarkTown, NEW_BARK_TOWN, 0

	map_attributes Route2, ROUTE_2, $05, NORTH | SOUTH
	connection north, Route3, ROUTE_3, -10
	connection south, CherrygroveCity, CHERRYGROVE_CITY, -5

	map_attributes Route3, ROUTE_3, $05, SOUTH | WEST
	connection south, Route2, ROUTE_2, 10
	connection west, VioletCity, VIOLET_CITY, -9

	map_attributes Route4, ROUTE_4, $05, NORTH | SOUTH
	connection north, VioletCity, VIOLET_CITY, 0
	connection south, Route5, ROUTE_5, 0

	map_attributes Route5, ROUTE_5, $05, NORTH | WEST
	connection north, Route4, ROUTE_4, 0
	connection west, AzaleaTown, AZALEA_TOWN, 0

	map_attributes Route6, ROUTE_6, $05, NORTH | EAST
	connection north, GoldenrodCity, GOLDENROD_CITY, -5
	connection east, AzaleaTown, AZALEA_TOWN, 18

	map_attributes Route7, ROUTE_7, $05, NORTH | SOUTH
	connection north, Route8, ROUTE_8, 0
	connection south, GoldenrodCity, GOLDENROD_CITY, -5

	map_attributes Route8, ROUTE_8, $05, NORTH | SOUTH | EAST
	connection north, Route9, ROUTE_9, 10
	connection south, Route7, ROUTE_7, 0
	connection east, VioletCity, VIOLET_CITY, 0

	map_attributes Route9, ROUTE_9, $05, NORTH | SOUTH
	connection north, EcruteakCity, ECRUTEAK_CITY, -5
	connection south, Route8, ROUTE_8, -10

	map_attributes Route10, ROUTE_10, $05, WEST | EAST
	connection west, Route11, ROUTE_11, -7
	connection east, EcruteakCity, ECRUTEAK_CITY, -5

	map_attributes Route11, ROUTE_11, $05, SOUTH | EAST
	connection south, OlivineCity, OLIVINE_CITY, -5
	connection east, Route10, ROUTE_10, 7

	map_attributes Route12, ROUTE_12, $35, SOUTH | EAST
	connection south, Route13, ROUTE_13, -15
	connection east, OlivineCity, OLIVINE_CITY, -9

	map_attributes Route13, ROUTE_13, $35, NORTH | WEST
	connection north, Route12, ROUTE_12, 15
	connection west, CianwoodCity, CIANWOOD_CITY, 0

	map_attributes Route14, ROUTE_14, $05, WEST | EAST
	connection west, EcruteakCity, ECRUTEAK_CITY, -9
	connection east, MahoganyTown, MAHOGANY_TOWN, 0

	map_attributes Route15, ROUTE_15, $05, NORTH | SOUTH
	connection north, LakeOfRage, LAKE_OF_RAGE, -5
	connection south, MahoganyTown, MAHOGANY_TOWN, 0

	map_attributes Route16, ROUTE_16, $71, WEST | EAST
	connection west, MahoganyTown, MAHOGANY_TOWN, 0
	connection east, BlackthornCity, BLACKTHORN_CITY, -9

	map_attributes Route17, ROUTE_17, $71, NORTH | WEST
	connection north, BlackthornCity, BLACKTHORN_CITY, 0
	connection west, Route46, ROUTE_46, 36

	map_attributes Route46, ROUTE_46, $05, SOUTH | EAST
	connection south, Route1, ROUTE_1, -10
	connection east, Route17, ROUTE_17, -36


	map_attributes Route23, ROUTE_23, $0f, 0
	map_attributes SproutTower1F, SPROUT_TOWER_1F, $00, 0
	map_attributes SproutTower2F, SPROUT_TOWER_2F, $00, 0
	map_attributes SproutTower3F, SPROUT_TOWER_3F, $00, 0
	map_attributes TinTower1F, TIN_TOWER_1F, $00, 0
	map_attributes TinTower2F, TIN_TOWER_2F, $00, 0
	map_attributes TinTower3F, TIN_TOWER_3F, $00, 0
	map_attributes TinTower4F, TIN_TOWER_4F, $00, 0
	map_attributes TinTower5F, TIN_TOWER_5F, $00, 0
	map_attributes TinTower6F, TIN_TOWER_6F, $00, 0
	map_attributes TinTower7F, TIN_TOWER_7F, $00, 0
	map_attributes TinTower8F, TIN_TOWER_8F, $00, 0
	map_attributes TinTower9F, TIN_TOWER_9F, $00, 0
	map_attributes BurnedTower1F, BURNED_TOWER_1F, $00, 0
	map_attributes BurnedTowerB1F, BURNED_TOWER_B1F, $09, 0
	map_attributes NationalPark, NATIONAL_PARK, $00, 0
	map_attributes NationalParkBugContest, NATIONAL_PARK_BUG_CONTEST, $00, 0
	map_attributes RadioTower1F, RADIO_TOWER_1F, $00, 0
	map_attributes RadioTower2F, RADIO_TOWER_2F, $00, 0
	map_attributes RadioTower3F, RADIO_TOWER_3F, $00, 0
	map_attributes RadioTower4F, RADIO_TOWER_4F, $00, 0
	map_attributes RadioTower5F, RADIO_TOWER_5F, $00, 0
	map_attributes RuinsOfAlphOutside, RUINS_OF_ALPH_OUTSIDE, $05, 0
	map_attributes RuinsOfAlphHoOhChamber, RUINS_OF_ALPH_HO_OH_CHAMBER, $00, 0
	map_attributes RuinsOfAlphKabutoChamber, RUINS_OF_ALPH_KABUTO_CHAMBER, $00, 0
	map_attributes RuinsOfAlphOmanyteChamber, RUINS_OF_ALPH_OMANYTE_CHAMBER, $00, 0
	map_attributes RuinsOfAlphAerodactylChamber, RUINS_OF_ALPH_AERODACTYL_CHAMBER, $00, 0
	map_attributes RuinsOfAlphInnerChamber, RUINS_OF_ALPH_INNER_CHAMBER, $00, 0
	map_attributes RuinsOfAlphResearchCenter, RUINS_OF_ALPH_RESEARCH_CENTER, $00, 0
	map_attributes RuinsOfAlphHoOhItemRoom, RUINS_OF_ALPH_HO_OH_ITEM_ROOM, $00, 0
	map_attributes RuinsOfAlphKabutoItemRoom, RUINS_OF_ALPH_KABUTO_ITEM_ROOM, $00, 0
	map_attributes RuinsOfAlphOmanyteItemRoom, RUINS_OF_ALPH_OMANYTE_ITEM_ROOM, $00, 0
	map_attributes RuinsOfAlphAerodactylItemRoom, RUINS_OF_ALPH_AERODACTYL_ITEM_ROOM, $00, 0
	map_attributes RuinsOfAlphHoOhWordRoom, RUINS_OF_ALPH_HO_OH_WORD_ROOM, $00, 0
	map_attributes RuinsOfAlphKabutoWordRoom, RUINS_OF_ALPH_KABUTO_WORD_ROOM, $00, 0
	map_attributes RuinsOfAlphOmanyteWordRoom, RUINS_OF_ALPH_OMANYTE_WORD_ROOM, $00, 0
	map_attributes RuinsOfAlphAerodactylWordRoom, RUINS_OF_ALPH_AERODACTYL_WORD_ROOM, $00, 0
	map_attributes UnionCave1F, UNION_CAVE_1F, $09, 0
	map_attributes UnionCaveB1F, UNION_CAVE_B1F, $09, 0
	map_attributes UnionCaveB2F, UNION_CAVE_B2F, $09, 0
	map_attributes SlowpokeWellB1F, SLOWPOKE_WELL_B1F, $09, 0
	map_attributes SlowpokeWellB2F, SLOWPOKE_WELL_B2F, $09, 0
	map_attributes OlivineLighthouse1F, OLIVINE_LIGHTHOUSE_1F, $00, 0
	map_attributes OlivineLighthouse2F, OLIVINE_LIGHTHOUSE_2F, $00, 0
	map_attributes OlivineLighthouse3F, OLIVINE_LIGHTHOUSE_3F, $00, 0
	map_attributes OlivineLighthouse4F, OLIVINE_LIGHTHOUSE_4F, $00, 0
	map_attributes OlivineLighthouse5F, OLIVINE_LIGHTHOUSE_5F, $00, 0
	map_attributes OlivineLighthouse6F, OLIVINE_LIGHTHOUSE_6F, $00, 0
	map_attributes MahoganyMart1F, MAHOGANY_MART_1F, $00, 0
	map_attributes TeamRocketBaseB1F, TEAM_ROCKET_BASE_B1F, $00, 0
	map_attributes TeamRocketBaseB2F, TEAM_ROCKET_BASE_B2F, $00, 0
	map_attributes TeamRocketBaseB3F, TEAM_ROCKET_BASE_B3F, $00, 0
	map_attributes IlexForest, ILEX_FOREST, $05, 0
	map_attributes GoldenrodUnderground, GOLDENROD_UNDERGROUND, $00, 0
	map_attributes GoldenrodUndergroundSwitchRoomEntrances, GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES, $00, 0
	map_attributes GoldenrodDeptStoreB1F, GOLDENROD_DEPT_STORE_B1F, $00, 0
	map_attributes GoldenrodUndergroundWarehouse, GOLDENROD_UNDERGROUND_WAREHOUSE, $00, 0
	map_attributes MountMortar1FOutside, MOUNT_MORTAR_1F_OUTSIDE, $09, 0
	map_attributes MountMortar1FInside, MOUNT_MORTAR_1F_INSIDE, $09, 0
	map_attributes MountMortar2FInside, MOUNT_MORTAR_2F_INSIDE, $09, 0
	map_attributes MountMortarB1F, MOUNT_MORTAR_B1F, $09, 0
	map_attributes IcePath1F, ICE_PATH_1F, $09, 0
	map_attributes IcePathB1F, ICE_PATH_B1F, $19, 0
	map_attributes IcePathB2FMahoganySide, ICE_PATH_B2F_MAHOGANY_SIDE, $19, 0
	map_attributes IcePathB2FBlackthornSide, ICE_PATH_B2F_BLACKTHORN_SIDE, $19, 0
	map_attributes IcePathB3F, ICE_PATH_B3F, $19, 0
	map_attributes WhirlIslandNW, WHIRL_ISLAND_NW, $09, 0
	map_attributes WhirlIslandNE, WHIRL_ISLAND_NE, $09, 0
	map_attributes WhirlIslandSW, WHIRL_ISLAND_SW, $09, 0
	map_attributes WhirlIslandCave, WHIRL_ISLAND_CAVE, $09, 0
	map_attributes WhirlIslandSE, WHIRL_ISLAND_SE, $0f, 0
	map_attributes WhirlIslandB1F, WHIRL_ISLAND_B1F, $09, 0
	map_attributes WhirlIslandB2F, WHIRL_ISLAND_B2F, $2e, 0
	map_attributes WhirlIslandLugiaChamber, WHIRL_ISLAND_LUGIA_CHAMBER, $0f, 0
	map_attributes SilverCaveRoom1, SILVER_CAVE_ROOM_1, $09, 0
	map_attributes SilverCaveRoom2, SILVER_CAVE_ROOM_2, $09, 0
	map_attributes SilverCaveRoom3, SILVER_CAVE_ROOM_3, $09, 0
	map_attributes SilverCaveItemRooms, SILVER_CAVE_ITEM_ROOMS, $09, 0
	map_attributes DarkCaveVioletEntrance, DARK_CAVE_VIOLET_ENTRANCE, $09, 0
	map_attributes DarkCaveBlackthornEntrance, DARK_CAVE_BLACKTHORN_ENTRANCE, $09, 0
	map_attributes DragonsDen1F, DRAGONS_DEN_1F, $09, 0
	map_attributes DragonsDenB1F, DRAGONS_DEN_B1F, $71, 0
	map_attributes DragonShrine, DRAGON_SHRINE, $00, 0
	map_attributes TohjoFalls, TOHJO_FALLS, $09, 0
	map_attributes OlivinePokecenter1F, OLIVINE_POKECENTER_1F, $00, 0
	map_attributes OlivineGym, OLIVINE_GYM, $00, 0
	map_attributes OlivineTimsHouse, OLIVINE_TIMS_HOUSE, $00, 0
	map_attributes OlivinePunishmentSpeechHouse, OLIVINE_PUNISHMENT_SPEECH_HOUSE, $00, 0
	map_attributes OlivineGoodRodHouse, OLIVINE_GOOD_ROD_HOUSE, $00, 0
	map_attributes OlivineCafe, OLIVINE_CAFE, $00, 0
	map_attributes OlivineMart, OLIVINE_MART, $00, 0
	map_attributes Route10EcruteakGate, ROUTE_10_ECRUTEAK_GATE, $00, 0
	map_attributes Route11Barn, ROUTE_11_BARN, $00, 0
	map_attributes Route11Farmhouse, ROUTE_11_FARMHOUSE, $00, 0
	map_attributes MahoganyRedGyaradosSpeechHouse, MAHOGANY_RED_GYARADOS_SPEECH_HOUSE, $00, 0
	map_attributes MahoganyTradeBackKidHouse, MAHOGANY_TRADE_BACK_KID_HOUSE, $00, 0
	map_attributes MahoganyGym, MAHOGANY_GYM, $00, 0
	map_attributes MahoganyPokecenter1F, MAHOGANY_POKECENTER_1F, $00, 0
	map_attributes Route14EcruteakGate, ROUTE_14_ECRUTEAK_GATE, $00, 0
	map_attributes VictoryRoad, VICTORY_ROAD, $1d, 0
	map_attributes EcruteakTinTowerEntrance, ECRUTEAK_TIN_TOWER_ENTRANCE, $00, 0
	map_attributes WiseTriosRoom, WISE_TRIOS_ROOM, $00, 0
	map_attributes EcruteakPokecenter1F, ECRUTEAK_POKECENTER_1F, $00, 0
	map_attributes EcruteakLugiaSpeechHouse, ECRUTEAK_LUGIA_SPEECH_HOUSE, $00, 0
	map_attributes DanceTheater, DANCE_THEATER, $00, 0
	map_attributes EcruteakMart, ECRUTEAK_MART, $00, 0
	map_attributes EcruteakGym, ECRUTEAK_GYM, $00, 0
	map_attributes EcruteakItemfinderHouse, ECRUTEAK_ITEMFINDER_HOUSE, $00, 0
	map_attributes BlackthornGym1F, BLACKTHORN_GYM_1F, $00, 0
	map_attributes BlackthornGym2F, BLACKTHORN_GYM_2F, $00, 0
	map_attributes BlackthornDragonSpeechHouse, BLACKTHORN_DRAGON_SPEECH_HOUSE, $00, 0
	map_attributes BlackthornEmysHouse, BLACKTHORN_EMYS_HOUSE, $00, 0
	map_attributes BlackthornMart, BLACKTHORN_MART, $00, 0
	map_attributes BlackthornPokecenter1F, BLACKTHORN_POKECENTER_1F, $00, 0
	map_attributes MoveDeletersHouse, MOVE_DELETERS_HOUSE, $00, 0
	map_attributes AzaleaPokecenter1F, AZALEA_POKECENTER_1F, $00, 0
	map_attributes CharcoalKiln, CHARCOAL_KILN, $00, 0
	map_attributes AzaleaMart, AZALEA_MART, $00, 0
	map_attributes KurtsHouse, KURTS_HOUSE, $00, 0
	map_attributes AzaleaGym, AZALEA_GYM, $00, 0
	map_attributes LakeOfRageHiddenPowerHouse, LAKE_OF_RAGE_HIDDEN_POWER_HOUSE, $00, 0
	map_attributes LakeOfRageMagikarpHouse, LAKE_OF_RAGE_MAGIKARP_HOUSE, $00, 0
	map_attributes Route15MahoganyGate, ROUTE_15_MAHOGANY_GATE, $00, 0
	map_attributes Route15Gate, ROUTE_15_GATE, $00, 0
	map_attributes VioletMart, VIOLET_MART, $00, 0
	map_attributes VioletGym, VIOLET_GYM, $00, 0
	map_attributes EarlsPokemonAcademy, EARLS_POKEMON_ACADEMY, $00, 0
	map_attributes VioletNicknameSpeechHouse, VIOLET_NICKNAME_SPEECH_HOUSE, $00, 0
	map_attributes VioletPokecenter1F, VIOLET_POKECENTER_1F, $00, 0
	map_attributes VioletKylesHouse, VIOLET_KYLES_HOUSE, $00, 0
	map_attributes Route4RuinsOfAlphGate, ROUTE_4_RUINS_OF_ALPH_GATE, $00, 0
	map_attributes Route4Pokecenter1F, ROUTE_4_POKECENTER_1F, $00, 0
	map_attributes Route7GoldenrodGate, ROUTE_7_GOLDENROD_GATE, $00, 0
	map_attributes Route7NationalParkGate, ROUTE_7_NATIONAL_PARK_GATE, $00, 0
	map_attributes Route8RuinsOfAlphGate, ROUTE_8_RUINS_OF_ALPH_GATE, $00, 0
	map_attributes Route8NationalParkGate, ROUTE_8_NATIONAL_PARK_GATE, $00, 0
	map_attributes GoldenrodGym, GOLDENROD_GYM, $00, 0
	map_attributes GoldenrodBikeShop, GOLDENROD_BIKE_SHOP, $00, 0
	map_attributes GoldenrodHappinessRater, GOLDENROD_HAPPINESS_RATER, $00, 0
	map_attributes BillsFamilysHouse, BILLS_FAMILYS_HOUSE, $00, 0
	map_attributes GoldenrodMagnetTrainStation, GOLDENROD_MAGNET_TRAIN_STATION, $00, 0
	map_attributes GoldenrodFlowerShop, GOLDENROD_FLOWER_SHOP, $00, 0
	map_attributes GoldenrodPPSpeechHouse, GOLDENROD_PP_SPEECH_HOUSE, $00, 0
	map_attributes GoldenrodNameRater, GOLDENROD_NAME_RATER, $00, 0
	map_attributes GoldenrodDeptStore1F, GOLDENROD_DEPT_STORE_1F, $00, 0
	map_attributes GoldenrodDeptStore2F, GOLDENROD_DEPT_STORE_2F, $00, 0
	map_attributes GoldenrodDeptStore3F, GOLDENROD_DEPT_STORE_3F, $00, 0
	map_attributes GoldenrodDeptStore4F, GOLDENROD_DEPT_STORE_4F, $00, 0
	map_attributes GoldenrodDeptStore5F, GOLDENROD_DEPT_STORE_5F, $00, 0
	map_attributes GoldenrodDeptStore6F, GOLDENROD_DEPT_STORE_6F, $00, 0
	map_attributes GoldenrodDeptStoreElevator, GOLDENROD_DEPT_STORE_ELEVATOR, $00, 0
	map_attributes GoldenrodDeptStoreRoof, GOLDENROD_DEPT_STORE_ROOF, $24, 0
	map_attributes GoldenrodGameCorner, GOLDENROD_GAME_CORNER, $00, 0
	map_attributes GoldenrodPokecenter1F, GOLDENROD_POKECENTER_1F, $00, 0
	map_attributes PokecomCenterAdminOfficeMobile, POKECOM_CENTER_ADMIN_OFFICE_MOBILE, $00, 0
	map_attributes IlexForestAzaleaGate, ILEX_FOREST_AZALEA_GATE, $00, 0
	map_attributes Route6IlexForestGate, ROUTE_6_ILEX_FOREST_GATE, $00, 0
	map_attributes DayCare, DAY_CARE, $00, 0
	map_attributes HatchRoom, HATCH_ROOM, $00, 0
	map_attributes OaksLab, OAKS_LAB, $00, 0
	map_attributes OlivinePort, OLIVINE_PORT, $0a, 0
	map_attributes OlivinePortPassage, OLIVINE_PORT_PASSAGE, $00, 0
	map_attributes MountMortarSquare, MT_MORTAR_SQUARE, $2d, 0
	map_attributes MountMortarGiftShop, MT_MORTAR_GIFT_SHOP, $00, 0
	map_attributes TinTowerRoof, TIN_TOWER_ROOF, $00, 0
	map_attributes IndigoPlateauPokecenter1F, INDIGO_PLATEAU_POKECENTER_1F, $00, 0
	map_attributes WillsRoom, WILLS_ROOM, $00, 0
	map_attributes KogasRoom, KOGAS_ROOM, $00, 0
	map_attributes BrunosRoom, BRUNOS_ROOM, $00, 0
	map_attributes KarensRoom, KARENS_ROOM, $00, 0
	map_attributes LancesRoom, LANCES_ROOM, $00, 0
	map_attributes HallOfFame, HALL_OF_FAME, $00, 0
	map_attributes SilverCavePokecenter1F, SILVER_CAVE_POKECENTER_1F, $00, 0
	map_attributes Route11_SilverCaveGate, ROUTE_11_SILVER_CAVE_GATE, $00, 0
	map_attributes Pokecenter2F, POKECENTER_2F, $00, 0
	map_attributes TradeCenter, TRADE_CENTER, $00, 0
	map_attributes Colosseum, COLOSSEUM, $00, 0
	map_attributes TimeCapsule, TIME_CAPSULE, $00, 0
	map_attributes MobileTradeRoom, MOBILE_TRADE_ROOM, $00, 0
	map_attributes MobileBattleRoom, MOBILE_BATTLE_ROOM, $00, 0
	map_attributes GoldenrodMansion1F, GOLDENROD_MANSION_1F, $00, 0
	map_attributes GoldenrodMansion2F, GOLDENROD_MANSION_2F, $00, 0
	map_attributes GoldenrodMansion3F, GOLDENROD_MANSION_3F, $00, 0
	map_attributes GoldenrodMansionRoof, GOLDENROD_MANSION_ROOF, $01, 0
	map_attributes GoldenrodMansionRoofHouse, GOLDENROD_MANSION_ROOF_HOUSE, $00, 0
	map_attributes ManiasHouse, MANIAS_HOUSE, $00, 0
	map_attributes CianwoodGym, CIANWOOD_GYM, $00, 0
	map_attributes CianwoodPokecenter1F, CIANWOOD_POKECENTER_1F, $00, 0
	map_attributes CianwoodPharmacy, CIANWOOD_PHARMACY, $00, 0
	map_attributes CianwoodPhotoStudio, CIANWOOD_PHOTO_STUDIO, $00, 0
	map_attributes CianwoodLugiaSpeechHouse, CIANWOOD_LUGIA_SPEECH_HOUSE, $00, 0
	map_attributes PokeSeersHouse, POKE_SEERS_HOUSE, $00, 0
	map_attributes BattleTower1F, BATTLE_TOWER_1F, $00, 0
	map_attributes BattlePlazaMart, BATTLE_PLAZA_MART, $00, 0
	map_attributes BattleTowerBattleRoom, BATTLE_TOWER_BATTLE_ROOM, $00, 0
	map_attributes BattleTowerElevator, BATTLE_TOWER_ELEVATOR, $00, 0
	map_attributes BattleTowerHallway, BATTLE_TOWER_HALLWAY, $00, 0
	map_attributes Route12PowerPlantGate, ROUTE_12_POWER_PLANT_GATE, $00, 0
	map_attributes PowerPlantOutside, POWER_PLANT_OUTSIDE, $05, 0
	map_attributes VictoryRoadGate, VICTORY_ROAD_GATE, $00, 0
	map_attributes ElmsLab, ELMS_LAB, $00, 0
	map_attributes PlayersHouse1F, PLAYERS_HOUSE_1F, $00, 0
	map_attributes PlayersHouse2F, PLAYERS_HOUSE_2F, $00, 0
	map_attributes PlayersNeighborsHouse, PLAYERS_NEIGHBORS_HOUSE, $00, 0
	map_attributes ElmsHouse, ELMS_HOUSE, $00, 0
	map_attributes Route26HealHouse, ROUTE_26_HEAL_HOUSE, $00, 0
	map_attributes DayOfWeekSiblingsHouse, DAY_OF_WEEK_SIBLINGS_HOUSE, $00, 0
	map_attributes Route27SandstormHouse, ROUTE_27_SANDSTORM_HOUSE, $00, 0
	map_attributes Route29Route46Gate, ROUTE_29_ROUTE_46_GATE, $00, 0
	map_attributes CherrygroveMart, CHERRYGROVE_MART, $00, 0
	map_attributes CherrygrovePokecenter1F, CHERRYGROVE_POKECENTER_1F, $00, 0
	map_attributes CherrygroveGymSpeechHouse, CHERRYGROVE_GYM_SPEECH_HOUSE, $00, 0
	map_attributes GuideGentsHouse, GUIDE_GENTS_HOUSE, $00, 0
	map_attributes CherrygroveEvolutionSpeechHouse, CHERRYGROVE_EVOLUTION_SPEECH_HOUSE, $00, 0
	map_attributes Route2BerryHouse, ROUTE_2_BERRY_HOUSE, $00, 0
	map_attributes MrPokemonsHouse, MR_POKEMONS_HOUSE, $00, 0
	map_attributes Route3VioletGate, ROUTE_3_VIOLET_GATE, $00, 0
	map_attributes SilverCaveOutside, SILVER_CAVE_OUTSIDE, $00, 0
	map_attributes CianwoodPort, CIANWOOD_PORT, $0a, 0
	map_attributes CianwoodPortPassage, CIANWOOD_PORT_PASSAGE, $00, 0
	map_attributes BattlePlazaMagnetTrainStation, BATTLE_PLAZA_MAGNET_TRAIN_STATION, $00, 0
	map_attributes NurseJoyTrainingAcademy, NURSE_JOYS_TRAINING_ACADEMY, $00, 0
	map_attributes EcruteakBlacksmithHouse, ECRUTEAK_BLACKSMITH_HOUSE, $00, 0
	map_attributes BattlePlaza, BATTLE_PLAZA, $05, 0
	map_attributes PowerPlant, POWER_PLANT, $00, 0
	map_attributes BattlePlazaRaJaHouse, BATTLE_PLAZA_RAJA_HOUSE, $00, 0
	map_attributes BattlePlazaBattleLobby, BATTLE_PLAZA_BATTLE_LOBBY, $00, 0
	map_attributes BattlePlazaDraftArena, BATTLE_PLAZA_DRAFT_ARENA, $00, 0
	map_attributes BattlePlazaEchoChamber, BATTLE_PLAZA_ECHO_CHAMBER, $00, 0
