PlayersHouse2F_MapEvents:
	def_warp_events
	warp_event  7,  0, PLAYERS_HOUSE_1F, 3

	def_coord_events

	def_bg_events
	bg_event  2,  1, BGEVENT_UP, PlayersHousePCScript
	bg_event  3,  1, BGEVENT_READ, PlayersHouseRadioScript
	bg_event  5,  1, BGEVENT_JUMPSTD, PICTURE_BOOKSHELF_SCRIPT
	bg_event  6,  0, BGEVENT_IFSET, PlayersHousePosterScript

	def_object_events
	object_event  4,  2, SPRITE_CONSOLE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PlayersHouseGameConsoleScript, EVENT_PLAYERS_HOUSE_2F_CONSOLE
	object_event  4,  4, SPRITE_DOLL_1, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PlayersHouseDoll1Script, EVENT_PLAYERS_HOUSE_2F_DOLL_1
	object_event  5,  4, SPRITE_DOLL_2, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PlayersHouseDoll2Script, EVENT_PLAYERS_HOUSE_2F_DOLL_2
	object_event  0,  1, SPRITE_BIG_DOLL, SPRITEMOVEDATA_BIGDOLL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PlayersHouseBigDollScript, EVENT_PLAYERS_HOUSE_2F_BIG_DOLL
if DEF(_DEBUG)
	object_event  4,  2, SPRITE_SCARLET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, TestTrainerScript, -1
	object_event  3,  5, SPRITE_MONSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RegularMonScript, -1
	object_event  2,  5, SPRITE_MONSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ShinyMonScript, -1
	object_event  7,  5, SPRITE_PAPER, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_TEAL, OBJECTTYPE_SCRIPT, 0, DebugOptions, -1
	object_event  2,  3, SPRITE_MAXIMA, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RandomPartyTrainerScript, -1
endc

	object_const_def
	const PLAYERSHOUSE2F_CONSOLE
	const PLAYERSHOUSE2F_DOLL_1
	const PLAYERSHOUSE2F_DOLL_2
	const PLAYERSHOUSE2F_BIG_DOLL
if DEF(_DEBUG)
	const PLAYERSHOUSE2F_TEST_TRAINER_SCARLET
	const PLAYERSHOUSE2F_TEST_MON_REGULAR
	const PLAYERSHOUSE2F_TEST_MON_SHINY
	const PLAYERSHOUSE2F_DEBUGCOLOURPICKER
	const PLAYERSHOUSE2F_RANDOM_PARTY_TRAINER
endc

PlayersHouse2F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, PlayersHouse2FInitializeRoomCallback
	callback MAPCALLBACK_TILES, PlayersHouse2FSetUpTileDecorationsCallback

PlayersHouseRadioScript:
if DEF(_DEBUG)
	opentext
	; party
	givepoke MAGIKARP, 50
	; 1st mon moves
	loadmem wPartyMon1Moves+0, SEED_BOMB
	loadmem wPartyMon1Moves+1, SPLASH
	loadmem wPartyMon1Moves+2, LOVELY_KISS
	loadmem wPartyMon1Moves+3, FLY
	closetext
	; tms
	giveitem TM_BRICK_BREAK, 50
	giveitem TM_HEADBUTT, 50
	giveitem TM_DIG, 50
	giveitem TM_HIDDEN_POWER, 50
	; hm
	giveitem HM_FLY
	; all fly points
	setflag ENGINE_FLYPOINT_ROUTE_20
	setflag ENGINE_FLYPOINT_INDIGO_PLATEAU
	setflag ENGINE_FLYPOINT_NEW_BARK
	setflag ENGINE_FLYPOINT_CHERRYGROVE
	setflag ENGINE_FLYPOINT_VIOLET
	setflag ENGINE_FLYPOINT_RUINS_OF_ALPH
	setflag ENGINE_FLYPOINT_UNION_CAVE
	setflag ENGINE_FLYPOINT_AZALEA
	setflag ENGINE_FLYPOINT_CIANWOOD
	setflag ENGINE_FLYPOINT_GOLDENROD
	setflag ENGINE_FLYPOINT_NATIONAL_PARK
	setflag ENGINE_FLYPOINT_OLIVINE
	setflag ENGINE_FLYPOINT_POWER_PLANT
	setflag ENGINE_FLYPOINT_ECRUTEAK
	setflag ENGINE_FLYPOINT_MAHOGANY
	setflag ENGINE_FLYPOINT_LAKE_OF_RAGE
	setflag ENGINE_FLYPOINT_BLACKTHORN
	setflag ENGINE_FLYPOINT_SILVER_CAVE
	; full pokegear
	setflag ENGINE_POKEGEAR
	setflag ENGINE_PHONE_CARD
	setflag ENGINE_MAP_CARD
	setflag ENGINE_RADIO_CARD
	setflag ENGINE_START_MENU_WARP
	; pokedex
	setflag ENGINE_POKEDEX
	givemoney YOUR_MONEY, MAX_MONEY
	; key items
	giveitem NOMAD_SIGIL
	giveitem CALM_CHARM
	giveitem MEMBERS_CARD
	giveitem TYPE_CHART
	giveitem BICYCLE
	clearflag ENGINE_BIKE_SHOP_CALL_ENABLED
	setevent EVENT_GOT_BICYCLE
	setmapscene DAY_CARE, SCENE_DAYCARE_NOOP
	giveitem COIN_CASE
	givecoins MAX_COINS
	; all rods
	giveitem OLD_ROD
	giveitem GOOD_ROD
	giveitem SUPER_ROD
	giveitem SHINY_CHARM
	; overworld calls
	giveitem TANGELA_CALL
	giveitem MAREEP_CALL
	giveitem SCYTHER_CALL
	giveitem DONPHAN_CALL
	giveitem LANTURN_CALL
	giveitem KINGDRA_CALL
	giveitem MILOTIC_CALL
	giveitem SQUIRTBOTTLE
	; useful items
	giveitem RARE_CANDY, MAX_ITEM_STACK
	giveitem MAX_REPEL, MAX_ITEM_STACK
	giveitem ESCAPE_ROPE, MAX_ITEM_STACK
	giveitem SACRED_ASH, MAX_ITEM_STACK
	; vitamins
	giveitem HYPER_EV_UP, MAX_ITEM_STACK
;	giveitem HP_UP, MAX_ITEM_STACK
;	giveitem PROTEIN, MAX_ITEM_STACK
;	giveitem IRON, MAX_ITEM_STACK
;	giveitem CALCIUM, MAX_ITEM_STACK
;	giveitem ZINC, MAX_ITEM_STACK
;	giveitem CARBOS, MAX_ITEM_STACK
	; loot
	giveitem CRYSTAL, MAX_ITEM_STACK
	giveitem NUGGET, MAX_ITEM_STACK
;	giveitem SILVER_LEAF, MAX_ITEM_STACK
;	giveitem GOLD_LEAF, MAX_ITEM_STACK
	; fossils
;	giveitem HELIX_FOSSIL
;	giveitem OLD_AMBER
;	giveitem ROOT_FOSSIL
	; all balls
	giveitem MASTER_BALL, MAX_ITEM_STACK
	giveitem SHINY_BALL, MAX_ITEM_STACK
	giveitem POKE_BALL, MAX_ITEM_STACK
	giveitem GREAT_BALL, MAX_ITEM_STACK
	giveitem ULTRA_BALL, MAX_ITEM_STACK
	giveitem HEAVY_BALL, MAX_ITEM_STACK
	giveitem LURE_BALL, MAX_ITEM_STACK
	giveitem FAST_BALL, MAX_ITEM_STACK
	giveitem FRIEND_BALL, MAX_ITEM_STACK
	giveitem MOON_BALL, MAX_ITEM_STACK
	giveitem LOVE_BALL, MAX_ITEM_STACK
	; fruits
	giveitem SILVER_BERRY, MAX_ITEM_STACK
	giveitem GOLD_BERRY, MAX_ITEM_STACK
	; battle items
	giveitem EVERSTONE, MAX_ITEM_STACK
	giveitem TRICK_STICK, MAX_ITEM_STACK
	giveitem GRIP_CLAW, MAX_ITEM_STACK
	giveitem CATCH_CHARM, MAX_ITEM_STACK
	giveitem ASSAULT_VEST, MAX_ITEM_STACK
	giveitem LIFE_ORB, MAX_ITEM_STACK
	giveitem CHOICE_BAND, MAX_ITEM_STACK
	giveitem CHOICE_SPECS, MAX_ITEM_STACK
	giveitem MUSCLE_BAND, MAX_ITEM_STACK
	giveitem WISE_GLASSES, MAX_ITEM_STACK
	giveitem HEAVY_BOOTS, MAX_ITEM_STACK
	giveitem FLAME_ORB, MAX_ITEM_STACK
	giveitem TOXIC_ORB, MAX_ITEM_STACK
	giveitem WIDE_LENS, MAX_ITEM_STACK
	giveitem ZOOM_LENS, MAX_ITEM_STACK
	giveitem BLACK_SLUDGE, MAX_ITEM_STACK
	giveitem HASTE_HERB, MAX_ITEM_STACK
	giveitem X_EVADE, MAX_ITEM_STACK
	giveitem X_ACCURACY, MAX_ITEM_STACK
	giveitem RAIN_SHARD, MAX_ITEM_STACK
	giveitem SUN_SHARD, MAX_ITEM_STACK
	giveitem SAND_SHARD, MAX_ITEM_STACK
	giveitem FROST_SHARD, MAX_ITEM_STACK
	; intro events
	addcellnum PHONE_MOM
	setmapscene PLAYERS_HOUSE_1F, $1
	setmapscene BATTLE_PLAZA, SCENE_BATTLE_PLAZA_NOOP
	setmapscene ROUTE_21, SCENE_ROUTE_21_NOOP
	setmapscene NEW_BARK_TOWN, SCENE_NEWBARKTOWN_NOOP
	setevent EVENT_PLAYERS_HOUSE_MOM_1
	clearevent EVENT_PLAYERS_HOUSE_MOM_2

	; to change DST to test phone numbers
	setevent EVENT_FIRST_TIME_BANKING_WITH_MOM
	setevent EVENT_GOT_A_POKEMON_FROM_ELM
	special HealParty
	warp NONE, 0, 0
	end
else
	checkevent EVENT_LISTENED_TO_INITIAL_RADIO
	iftrue .NormalRadio
	playmusic MUSIC_POKEMON_TALK
	opentext
	writethistext
		text "Prof.Oak's #mon"
		line "Talk! Please tune"
		cont "in next time!"
		done
	pause 30
	writethistext
		text "#mon Channel!"
		done
	pause 30
	writethistext
		text "This is DJ Mary,"
		line "your co-host!"
		done
	pause 30
	musicfadeout MUSIC_NEW_BARK_TOWN, 16
	writethistext
		text "#mon!"
		line "#mon Channel…"
		done
	pause 30
	setevent EVENT_LISTENED_TO_INITIAL_RADIO
	endtext

.NormalRadio:
	jumpstd Radio1Script
endc

PlayersHouse2FInitializeRoomCallback:
	special ToggleDecorationsVisibility
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8
	endcallback

PlayersHouse2FSetUpTileDecorationsCallback:
	special ToggleMaptileDecorations
	endcallback

PlayersHouseDoll1Script::
	describedecoration DECODESC_LEFT_DOLL

PlayersHouseDoll2Script:
	describedecoration DECODESC_RIGHT_DOLL

PlayersHouseBigDollScript:
	describedecoration DECODESC_BIG_DOLL

PlayersHouseGameConsoleScript:
	describedecoration DECODESC_CONSOLE

PlayersHousePosterScript:
	conditional_event EVENT_PLAYERS_ROOM_POSTER, .Script

.Script:
	describedecoration DECODESC_POSTER

PlayersHousePCScript:
	opentext
	special PlayersHousePC
	iftrue .Warp
	endtext
.Warp:
	warp NONE, 0, 0
	end

if DEF(_DEBUG)
DebugOptions:
	opentext
	writethistext
		text "Welcome to the"
		line "Debug Options."
		done
	loadmenu .MoveMenuHeader
	verticalmenu
	closewindow
	ifequal 1, .AllBadges
	ifequal 2, .FillPokedex
	ifequal 3, .DebugColourPicker
	ifequal 4, .Unused
	sjump .finish

.AllBadges
	writethistext
		text "All badges"
		line "acquired!"
		done
	waitbutton
	playsound SFX_1ST_PLACE
	waitsfx
	; all badges
	setflag ENGINE_ZEPHYRBADGE
	setflag ENGINE_HIVEBADGE
	setflag ENGINE_PLAINBADGE
	setflag ENGINE_FOGBADGE
	setflag ENGINE_STORMBADGE
	setflag ENGINE_MINERALBADGE
	setflag ENGINE_GLACIERBADGE
	setflag ENGINE_RISINGBADGE
	sjump .finish

.FillPokedex
	special FillPokedex
	writethistext
		text "#dex Completed!"
		line "#mon Master!"
		done
	waitbutton
	playsound SFX_1ST_PLACE
	waitsfx
	sjump .finish

.Unused
	sjump .finish

.DebugColourPicker
	special DebugColourPicker
.finish
	endtext

.MoveMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 19, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 5 ; items
	db "All Badges@"
	db "#dex Completed@"
	db "Debug Color@"
	db "Unused@"
	db "Cancel@"

RandomPartyTrainerScript:
	faceplayer
	special BackupPartyHeldItems
	special HealParty
	winlosstext TestText, 0
	loadtrainer MAXIMA, MAXIMA1
	startbattle
	reloadmap
	special RestorePartyHeldItems
	special HealParty
	end

TestTrainerScript:
	faceplayer
	special BackupPartyHeldItems
	special HealParty
	winlosstext TestText, 0
	loadtrainer SCARLET, SCARLET1
	startbattle
	reloadmap
	special RestorePartyHeldItems
	special HealParty
	end

TestText:
	text "<……>"
	line "<……>"
	done

RegularMonScript:
	faceplayer
	special HealParty
	loadwildmon MAGIKARP, 10
	startbattle
	reloadmap
	special HealParty
	end

ShinyMonScript:
	faceplayer
	special HealParty
	loadwildmon MAGIKARP, 10
	loadvar VAR_BATTLETYPE, BATTLETYPE_FORCESHINY
	startbattle
	reloadmap
	special HealParty
	end
endc
