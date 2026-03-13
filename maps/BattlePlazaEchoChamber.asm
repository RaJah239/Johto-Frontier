	object_const_def
	const BATTLEPLAZAECHOCHAMBER_RECEPTIONIST
	const BATTLEPLAZAECHOCHAMBER_CHRIS
	const BATTLEPLAZAECHOCHAMBER_KRIS

BattlePlazaEchoChamber_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, ChrisAndKrissCallback

ChrisAndKrissCallback:
;.Chris
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .Kris
	appear BATTLEPLAZAECHOCHAMBER_CHRIS
    endcallback

.Kris
	appear BATTLEPLAZAECHOCHAMBER_KRIS
    endcallback

EchoChamberReceptionistScript:
	opentext
	checkevent EVENT_DID_NOT_GET_ECHO_CHAMBER_PRIZE
	iftrue .GivePrize
	writetext EchoChamberIntroText
	yesorno
	iffalse .done
	special TryQuickSave
	writetext BattlePlazasReceptionistGoRightInText
	waitbutton
	closetext

	applymovement BATTLEPLAZAECHOCHAMBER_RECEPTIONIST, BattlePlazasReceptionist_MoveOutTheWay
	applymovement PLAYER, BattlePlazasPlayer_EnterBattleRoom

	winlosstext BattlePlazasPlayerVictoryText, 0

	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .Female

	loadtrainer CAL, CAL1
	startbattle
	ifequal WIN, .win
	sjump .continue_battle

.Female
	loadtrainer CAL_F, CAL_F1
	startbattle
	ifequal WIN, .win
.continue_battle
	dontrestartmapmusic
	reloadmap
	pause 15
	special BattleTowerFade
	warpfacing UP, BATTLE_PLAZA_ECHO_CHAMBER, 3, 11
	turnobject PLAYER, UP
	special LoadPokemonData
	special HealParty
	opentext
	writetext BattlePlazasBattleLoseText
	waitendtext

.done
	closetext
	turnobject PLAYER, DOWN
	end

.win
	dontrestartmapmusic
	reloadmapafterbattle
	pause 15
	special BattleTowerFade
	warpfacing UP, BATTLE_PLAZA_ECHO_CHAMBER, 3, 11
	turnobject PLAYER, UP
	opentext
	writetext BattlePlazasBattleWinText
	promptbutton
	special LoadPokemonData
	special HealParty
.GivePrize:
	writetext BattlePlazasPrizeText
	verbosegiveitem AMULET_COIN
	iffalse EchoChamberPackFull
	clearevent EVENT_DID_NOT_GET_ECHO_CHAMBER_PRIZE
	closetext
	end

.Cancel:
	writetext BattlePlazasPleaseComeAgainText
	waitbutton
	closetext
	turnobject PLAYER, DOWN
	end

EchoChamberPackFull:
	setevent EVENT_DID_NOT_GET_ECHO_CHAMBER_PRIZE
	writetext BattlePlazasFullPackText
	waitendtext

EchoChamberIntroText:
	text "Echo Chamber"
	line "welcomes you!"

	para "Would you like to"
	line "make an attempt?"
	done

EchoChamberInfoSign:
	jumptext EchoChamberInfoSignText

EchoChamberInfoSignText:
	text "You may fight a"
	line "copy of your own"
	cont "team here."

	para "Each victory nets"
	line "an Amulet Coin."
	done

BattlePlazaEchoChamber_MapEvents:
	def_warp_events
	warp_event  4, 13, BATTLE_PLAZA, 13
	warp_event  3, 13, BATTLE_PLAZA, 12

	def_coord_events

	def_bg_events
	bg_event  2, 10, BGEVENT_READ, EchoChamberInfoSign

	def_object_events
	object_event  3, 10, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, EchoChamberReceptionistScript, -1
	object_event  4,  3, SPRITE_CHRIS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_MIRROR_CHRIS
	object_event  4,  3, SPRITE_KRIS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_MIRROR_KRIS
