	object_const_def
	const BATTLEPLAZAECHOCHAMBER_RECEPTIONIST
	const BATTLEPLAZAECHOCHAMBER_ENEMY

BattlePlazaEchoChamber_MapScripts:
	def_scene_scripts

	def_callbacks

EchoChamberReceptionistScript:
	opentext
	checkevent EVENT_DID_NOT_GET_ECHO_CHAMBER_PRIZE
	iftrue .GivePrize
	writetext EchoChamberIntroText
	yesorno
	iffalse .done
	special TryQuickSave
	writetext BattleLobbyReceptionistGoRightInText
	waitbutton
	closetext

	applymovement BATTLEPLAZAECHOCHAMBER_RECEPTIONIST, BattleLobbyReceptionist_MoveOutTheWay
	applymovement PLAYER, BattleLobbyPlayer_EnterBattleRoom
	winlosstext BattleLobbyPlayerVictoryText, 0

	loadtrainer CAL, CAL1
	startbattle
	ifequal WIN, .win
	dontrestartmapmusic
	reloadmap
	pause 15
	special BattleTowerFade
	warpfacing UP, BATTLE_PLAZA_ECHO_CHAMBER, 3, 11
	turnobject PLAYER, UP
	special LoadPokemonData
	special HealParty
	opentext
	writetextend BattleLobbyBattleLoseText

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
	writetext BattleLobbyBattleWinText
	promptbutton
	special LoadPokemonData
	special HealParty
.GivePrize:
	writetext BattleLobbyPrizeText
	verbosegiveitem AMULET_COIN
	iffalse EchoChamberPackFull
	clearevent EVENT_DID_NOT_GET_ECHO_CHAMBER_PRIZE
	closetext
	end

.Cancel:
	writetext BattleLobbyPleaseComeAgainText
	waitbutton
	closetext
	turnobject PLAYER, DOWN
	end

EchoChamberPackFull:
	setevent EVENT_DID_NOT_GET_ECHO_CHAMBER_PRIZE
	writetextend BattleLobbyFullPackText

EchoChamberIntroText:
	text "Echo Chamber"
	line "welcomes you!"

	para "Would you like to"
	line "battle a copy of"
	cont "your own team?"
	done

BattlePlazaEchoChamber_MapEvents:
	def_warp_events
	warp_event  4, 13, BATTLE_PLAZA, 13
	warp_event  3, 13, BATTLE_PLAZA, 12

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3, 10, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, EchoChamberReceptionistScript, -1
	object_event  4,  3, SPRITE_UNKNOWN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
