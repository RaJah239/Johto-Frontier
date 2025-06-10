	object_const_def
	const INDIGOPLATEAUPOKECENTER1F_NURSE
	const INDIGOPLATEAUPOKECENTER1F_CLERK
	const INDIGOPLATEAUPOKECENTER1F_COOLTRAINER_M
	const INDIGOPLATEAUPOKECENTER1F_RIVAL
	const INDIGOPLATEAUPOKECENTER1F_GRAMPS
	const INDIGOPLATEAUPOKECENTER1F_ABRA
	const INDIGOPLATEAUPOKECENTER1F_VIOLET

IndigoPlateauPokecenter1F_MapScripts:
	def_scene_scripts
	scene_script IndigoPlateauPokecenter1FNoopScene, SCENE_INDIGOPLATEAUPOKECENTER1F_RIVAL_BATTLE

	def_callbacks
	callback MAPCALLBACK_NEWMAP, IndigoPlateauPokecenter1FPrepareElite4Callback

IndigoPlateauPokecenter1FNoopScene:
	end

IndigoPlateauPokecenter1FPrepareElite4Callback:
	setmapscene WILLS_ROOM, SCENE_WILLSROOM_LOCK_DOOR
	setmapscene KOGAS_ROOM, SCENE_KOGASROOM_LOCK_DOOR
	setmapscene BRUNOS_ROOM, SCENE_BRUNOSROOM_LOCK_DOOR
	setmapscene KARENS_ROOM, SCENE_KARENSROOM_LOCK_DOOR
	setmapscene LANCES_ROOM, SCENE_LANCESROOM_LOCK_DOOR
	setmapscene HALL_OF_FAME, SCENE_HALLOFFAME_ENTER
	clearevent EVENT_WILLS_ROOM_ENTRANCE_CLOSED
	clearevent EVENT_WILLS_ROOM_EXIT_OPEN
	clearevent EVENT_KOGAS_ROOM_ENTRANCE_CLOSED
	clearevent EVENT_KOGAS_ROOM_EXIT_OPEN
	clearevent EVENT_BRUNOS_ROOM_ENTRANCE_CLOSED
	clearevent EVENT_BRUNOS_ROOM_EXIT_OPEN
	clearevent EVENT_KARENS_ROOM_ENTRANCE_CLOSED
	clearevent EVENT_KARENS_ROOM_EXIT_OPEN
	clearevent EVENT_LANCES_ROOM_ENTRANCE_CLOSED
	clearevent EVENT_LANCES_ROOM_EXIT_OPEN
	clearevent EVENT_BEAT_ELITE_4_WILL
	clearevent EVENT_BEAT_ELITE_4_KOGA
	clearevent EVENT_BEAT_ELITE_4_BRUNO
	clearevent EVENT_BEAT_ELITE_4_KAREN
	clearevent EVENT_BEAT_CHAMPION_LANCE
	setevent EVENT_LANCES_ROOM_OAK_AND_MARY
	endcallback

PlateauRivalBattle1:
	checkevent EVENT_BEAT_CHAMPION_LANCE
	iffalse PlateauRivalScriptDone
	checkflag ENGINE_INDIGO_PLATEAU_RIVAL_FIGHT
	iftrue PlateauRivalScriptDone
	readvar VAR_WEEKDAY
	ifequal SUNDAY, PlateauRivalScriptDone
	ifequal TUESDAY, PlateauRivalScriptDone
	ifequal THURSDAY, PlateauRivalScriptDone
	ifequal FRIDAY, PlateauRivalScriptDone
	ifequal SATURDAY, PlateauRivalScriptDone
	moveobject INDIGOPLATEAUPOKECENTER1F_RIVAL, 17, 9
	appear INDIGOPLATEAUPOKECENTER1F_RIVAL
	turnobject PLAYER, DOWN
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	pause 15
	applymovement INDIGOPLATEAUPOKECENTER1F_RIVAL, PlateauRivalMovement1
	playmusic MUSIC_RIVAL_ENCOUNTER
	turnobject PLAYER, RIGHT
	sjump PlateauRivalBattleCommon

PlateauRivalBattle2:
	checkevent EVENT_BEAT_CHAMPION_LANCE
	iffalse PlateauRivalScriptDone
	checkflag ENGINE_INDIGO_PLATEAU_RIVAL_FIGHT
	iftrue PlateauRivalScriptDone
	readvar VAR_WEEKDAY
	ifequal SUNDAY, PlateauRivalScriptDone
	ifequal TUESDAY, PlateauRivalScriptDone
	ifequal THURSDAY, PlateauRivalScriptDone
	ifequal FRIDAY, PlateauRivalScriptDone
	ifequal SATURDAY, PlateauRivalScriptDone
	appear INDIGOPLATEAUPOKECENTER1F_RIVAL
	turnobject PLAYER, DOWN
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	pause 15
	applymovement INDIGOPLATEAUPOKECENTER1F_RIVAL, PlateauRivalMovement2
	playmusic MUSIC_RIVAL_ENCOUNTER
	turnobject PLAYER, LEFT
PlateauRivalBattleCommon:
	opentext
	writetext PlateauRivalText1
	waitbutton
	closetext
	setevent EVENT_INDIGO_PLATEAU_POKECENTER_RIVAL
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .Totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .Chikorita
	; Cyndaquil
	winlosstext PlateauRivalWinText, PlateauRivalLoseText
	setlasttalked INDIGOPLATEAUPOKECENTER1F_RIVAL
	loadtrainer RIVAL2, RIVAL2_2_TOTODILE
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump PlateauRivalPostBattle

.Totodile:
	winlosstext PlateauRivalWinText, PlateauRivalLoseText
	setlasttalked INDIGOPLATEAUPOKECENTER1F_RIVAL
	loadtrainer RIVAL2, RIVAL2_2_CHIKORITA
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump PlateauRivalPostBattle

.Chikorita:
	winlosstext PlateauRivalWinText, PlateauRivalLoseText
	setlasttalked INDIGOPLATEAUPOKECENTER1F_RIVAL
	loadtrainer RIVAL2, RIVAL2_2_CYNDAQUIL
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump PlateauRivalPostBattle

PlateauRivalPostBattle:
	playmusic MUSIC_RIVAL_AFTER
	opentext
	writetext PlateauRivalText2
	waitbutton
	closetext
	turnobject PLAYER, DOWN
	applymovement INDIGOPLATEAUPOKECENTER1F_RIVAL, PlateauRivalLeavesMovement
	disappear INDIGOPLATEAUPOKECENTER1F_RIVAL
	setscene SCENE_INDIGOPLATEAUPOKECENTER1F_RIVAL_BATTLE
	playmapmusic
	setflag ENGINE_INDIGO_PLATEAU_RIVAL_FIGHT
PlateauRivalScriptDone:
	end

IndigoPlateauPokecenter1FNurseScript:
	jumpstd PokecenterNurseScript

IndigoPlateauPokecenter1FClerkScript:
	opentext
	pokemart MARTTYPE_STANDARD, MART_INDIGO_PLATEAU
	closetext
	end

IndigoPlateauPokecenter1FCooltrainerMScript:
	jumptextfaceplayer IndigoPlateauPokecenter1FCooltrainerMText

TeleportGuyScript:
	faceplayer
	opentext
	writetext TeleportGuyText1
	yesorno
	iffalse .No
	writetext TeleportGuyYesText
	waitbutton
	closetext
	playsound SFX_WARP_TO
	special FadeOutPalettes
	waitsfx
	warp NEW_BARK_TOWN, 13, 6
	end

.No:
	writetext TeleportGuyNoText
	waitbutton
	closetext
	end

NatuScript:
	opentext
	writetext NatuText
	cry NATU
	waitbutton
	closetext
	end

PlateauRivalMovement1:
	step UP
	step UP
	step UP
	step UP
	step UP
	turn_head LEFT
	step_end

PlateauRivalMovement2:
	step UP
	step UP
	step UP
	step UP
	step UP
	turn_head RIGHT
	step_end

PlateauRivalLeavesMovement:
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end

VioletScript:
	faceplayer
	opentext
	checkevent EVENT_MET_VIOLET
	iftrue .LetsTrade
	writetext VioletIntroText
	setevent EVENT_MET_VIOLET
	waitbutton
.LetsTrade
	writetext UpForATradeText
	special DisplayCoinCaseBalance
	yesorno
	iffalse .Refused
	loadmenu .MoveMenuHeader
	verticalmenu
	closewindow
	ifequal 1, .SacredAsh
	ifequal 2, .EonMail
	ifequal 3, .Nuggets
	writetext NotTradingText
	waitbutton
	closetext
	end

.SacredAsh:
	checkcoins 9999
	ifequal HAVE_LESS, .CoinCaseNotAtMax
	giveitem SACRED_ASH, 5
	iffalse .NoRoom
	writetext PlayerGotFiveSacredAshText
	sjump .WrappingUpThisCoinTrade

.EonMail:
	checkcoins 9999
	ifequal HAVE_LESS, .CoinCaseNotAtMax
	giveitem EON_MAIL
	iffalse .NoRoom
	writetext PlayerGotEonMailText
	sjump .WrappingUpThisCoinTrade

.Nuggets:
	checkcoins 9999
	ifequal HAVE_LESS, .CoinCaseNotAtMax
	giveitem NUGGET, 99
	iffalse .NoRoom
	writetext PlayerGotNinetyNineNuggetsText
.WrappingUpThisCoinTrade:
	ifequal TRUE, .ConcludeTransaction
	waitbutton
	closetext
	end

.NoRoom:
	writetext VioletNoRoomText
	waitbutton
	closetext
	end

.ConcludeTransaction:
	writetext ValueOurTradeText
	waitbutton
	takecoins 9999
	waitsfx
	playsound SFX_TRANSACTION
	special DisplayCoinCaseBalance
	writetext ThanksFortheTradeText
	waitbutton
	closetext
	end 

.Refused:
	writetext ComOnByAnyTimeText
	waitbutton
	closetext
	end

.CoinCaseNotAtMax:
	writetext YouNeedToFillItUpText
	waitbutton
	closetext
	end

.MoveMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 2, 15, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 4 ; items
	db "SACRED ASH x5@"
	db "EON MAIL   x1@"
	db "NUGGET    x99@"
	db "CANCEL@"

VioletIntroText:
	text "Hello. I'm VIOLET."
	line "I enjoy collecting"
	cont "coins."

	para "A COIN COLLECTOR"
	line "of sorts."

	para "And you are?"

	para "…"

	para "<PLAY_G>? Nice to"
	line "meet you!"

	para "To make it here…"
	line "You must be quite"
	cont "the trainer!"

	para "I think we may be"
	line "able to help each-"
	cont "other out."

	para "For 9,999 coins or"
	line "a full COIN CASE,"

	para "I'll trade you"
	line "something special."

	para "How about it?"
	done

UpForATradeText:
	text "VIOLET: Up for a"
	line "trade <PLAY_G>?"

	para "9,999 coins for"
	line "something special?"
	done

VioletNoRoomText:
	text "Make space to con-"
	line "clude our trade…"
	done

ComOnByAnyTimeText:
	text "Come trade with me"
	line "anytime."
	done

YouNeedToFillItUpText:
	text "Hm… You're short on"
	line "coins…"
	done

NotTradingText:
	text "Not in a trading"
	line "mood?"
	done

ValueOurTradeText:
	text "I hope you value"
	line "our trade!"
	done

PlayerGotFiveSacredAshText:
	text "<PLAYER> got"
	line "5 SACRED ASH!@"
	sound_item
	text_promptbutton
	text_end

PlayerGotEonMailText:
	text "<PLAYER> got"
	line "EON MAIL!@"
	sound_item
	text_promptbutton
	text_end

PlayerGotNinetyNineNuggetsText:
	text "<PLAYER> got"
	line "99 NUGGET!@"
	sound_item
	text_promptbutton
	text_end

ThanksFortheTradeText:
	text "Let's trade again"
	line "sometime!"
	done

IndigoPlateauPokecenter1FCooltrainerMText:
	text "At the #MON"
	line "LEAGUE, you'll get"

	para "tested by the"
	line "ELITE FOUR."

	para "You have to beat"
	line "them all. If you"

	para "lose, you have to"
	line "start all over!"
	done

PlateauRivalText1:
	text "Hold it."

	para "You're going to"
	line "take the #MON"

	para "LEAGUE challenge"
	line "now?"

	para "That's not going"
	line "to happen."

	para "My super-well-"
	line "trained #MON"

	para "are going to pound"
	line "you."

	para "<PLAYER>!"
	line "I challenge you!"
	done

PlateauRivalWinText:
	text "…"

	para "OK--I lost…"
	done

PlateauRivalText2:
	text "…Darn… I still"
	line "can't win…"

	para "I… I have to think"
	line "more about my"
	cont "#MON…"

	para "Humph! Try not to"
	line "lose!"
	done

PlateauRivalLoseText:
	text "…"

	para "Whew…"
	line "With my partners,"

	para "I'm going to be"
	line "the CHAMPION!"
	done

TeleportGuyText1:
	text "Want my NATU to"
	line "TELEPORT you home?"
	done

TeleportGuyYesText:
	text "OK! Picture your"
	line "house mentally…"
	done

TeleportGuyNoText:
	text "OK, all the best!"
	done

NatuText:
	text "NATU: Tweet…"
	done

IndigoPlateauPokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5, 13, ROUTE_23, 1
	warp_event  6, 13, ROUTE_23, 2
	warp_event  0, 13, POKECENTER_2F, 1
	warp_event 14,  3, WILLS_ROOM, 1

	def_coord_events
	coord_event 16,  4, SCENE_INDIGOPLATEAUPOKECENTER1F_RIVAL_BATTLE, PlateauRivalBattle1
	coord_event 17,  4, SCENE_INDIGOPLATEAUPOKECENTER1F_RIVAL_BATTLE, PlateauRivalBattle2

	def_bg_events

	def_object_events
	object_event  3,  7, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, IndigoPlateauPokecenter1FNurseScript, -1
	object_event 11,  7, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, IndigoPlateauPokecenter1FClerkScript, -1
	object_event 11, 11, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, IndigoPlateauPokecenter1FCooltrainerMScript, -1
	object_event 16,  9, SPRITE_RIVAL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_INDIGO_PLATEAU_POKECENTER_RIVAL
	object_event  1,  9, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, TeleportGuyScript, -1
	object_event  0,  9, SPRITE_NATU, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, NatuScript, -1
	object_event  5, 10, SPRITE_POKEFAN_F, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, VioletScript, -1
