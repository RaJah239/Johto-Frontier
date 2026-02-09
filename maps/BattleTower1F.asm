	object_const_def
	const BATTLETOWER1F_RECEPTIONIST
	const BATTLETOWER1F_YOUNGSTER
	const BATTLETOWER1F_COOLTRAINER_F
	const BATTLETOWER1F_BUG_CATCHER
	const BATTLETOWER1F_GRANNY

BattleTower1F_MapScripts:
	def_scene_scripts
	scene_script BattleTower1FCheckStateScene, SCENE_BATTLETOWER1F_CHECKSTATE
	scene_script BattleTower1FNoopScene,       SCENE_BATTLETOWER1F_NOOP

	def_callbacks

BattleTower1FCheckStateScene:
	setval BATTLETOWERACTION_CHECKSAVEFILEISYOURS
	special BattleTowerAction
	iffalse .SkipEverything
	setval BATTLETOWERACTION_GET_CHALLENGE_STATE ; readmem sBattleTowerChallengeState
	special BattleTowerAction
	ifequal $0, .SkipEverything
	ifequal $2, .LeftWithoutSaving
	ifequal $3, .SkipEverything
	ifequal $4, .SkipEverything
	opentext
	writetext Text_WeveBeenWaitingForYou
	waitbutton
	closetext
	sdefer Script_ResumeBattleTowerChallenge
	end

.LeftWithoutSaving
	sdefer BattleTower_LeftWithoutSaving
	setval BATTLETOWERACTION_CHALLENGECANCELED
	special BattleTowerAction
	setval BATTLETOWERACTION_06
	special BattleTowerAction
.SkipEverything:
	setscene SCENE_BATTLETOWER1F_NOOP
	; fallthrough
BattleTower1FNoopScene:
	end

BattleTower1FReceptionistScript:
	setval BATTLETOWERACTION_GET_CHALLENGE_STATE ; readmem sBattleTowerChallengeState
	special BattleTowerAction
	ifequal $3, Script_BeatenAllTrainers2 ; maps/BattleTowerBattleRoom.asm
	opentext
	writetext Text_BattleTowerWelcomesYou
	promptbutton
	setval BATTLETOWERACTION_CHECK_EXPLANATION_READ ; if new save file: bit 1, [sBattleTowerSaveFileFlags]
	special BattleTowerAction
	ifnotequal $0, Script_Menu_ChallengeExplanationCancel
	sjump Script_BattleTowerIntroductionYesNo

Script_Menu_ChallengeExplanationCancel:
	writetext Text_WantToGoIntoABattleRoom
	checkevent EVENT_BATTLE_TOWER_TYPE_MODES_UNLOCKED
	iffalse .NoSettings
	setval FALSE
	special Menu_ChallengeExplanationCancel
	ifequal 1, Script_ChooseChallenge
	ifequal 2, Script_BattleTowerExplanation
	ifequal 3, Script_BattleTowerSettings
	sjump Script_BattleTowerHopeToServeYouAgain

.NoSettings:
	setval TRUE
	special Menu_ChallengeExplanationCancel
	ifequal 1, Script_ChooseChallenge
	ifequal 2, Script_BattleTowerExplanation
	sjump Script_BattleTowerHopeToServeYouAgain

Script_ChooseChallenge:
	setval BATTLETOWERACTION_RESETDATA ; ResetBattleTowerTrainerSRAM
	special BattleTowerAction
	setscene SCENE_BATTLETOWER1F_CHECKSTATE
	special TryQuickSave
	iffalse Script_Menu_ChallengeExplanationCancel

.ChooseAnOption:
    loadmenu .MirrorMenuHeader
	_2dmenu
	closewindow
	ifequal 1, .normal
	ifequal 2, .mirror
	ifequal 3, .info
	ifequal 4, .cancel
	sjump .ChooseAnOption

.mirror
	setval 1
	writemem wCopyEnemyParty
	; fallthrough

.normal
	setscene SCENE_BATTLETOWER1F_NOOP
	setval BATTLETOWERACTION_SET_EXPLANATION_READ ; set 1, [sBattleTowerSaveFileFlags]
	special BattleTowerAction
	special BattleTowerRoomMenu
	ifequal $a, Script_Menu_ChallengeExplanationCancel
	ifnotequal $0, Script_MobileError
	setval BATTLETOWERACTION_11
	special BattleTowerAction
	writetext Text_RightThisWayToYourBattleRoom
	waitbutton
	closetext
	setval BATTLETOWERACTION_CHOOSEREWARD
	special BattleTowerAction
	sjump Script_WalkToBattleTowerElevator

.info
	writetext MirrorBattlesText
	sjump .ChooseAnOption

.cancel
	sjump Script_BattleTowerHopeToServeYouAgain

.MirrorMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 15, 9
	dw .MirrorMenuData
	db 1 ; default option

.MirrorMenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
	dn 4, 1 ; rows, columns
	db 5 ; spacing
	dba .MirrorText
	dbw BANK(@), NULL

.MirrorText:
	db "Normal Battle@"
	db "Mirror Battle@"
	db "Info@"
	db "Cancel@"

MirrorBattlesText:
	text "Normal Battle: use"
	line "your own team."

	para "Mirror Battle: use"
	line "your foe's team in"
	cont "each round against"
	cont "them."
	done

Script_ResumeBattleTowerChallenge:
	closetext
	setval BATTLETOWERACTION_LOADLEVELGROUP ; load choice of level group
	special BattleTowerAction
Script_WalkToBattleTowerElevator:
	musicfadeout MUSIC_NONE, 8
	setmapscene BATTLE_TOWER_BATTLE_ROOM, SCENE_BATTLETOWERBATTLEROOM_ENTER
	setmapscene BATTLE_TOWER_ELEVATOR, SCENE_BATTLETOWERELEVATOR_ENTER
	setmapscene BATTLE_TOWER_HALLWAY, SCENE_BATTLETOWERHALLWAY_ENTER
	follow BATTLETOWER1F_RECEPTIONIST, PLAYER
	applymovement BATTLETOWER1F_RECEPTIONIST, MovementData_BattleTower1FWalkToElevator
	setval BATTLETOWERACTION_0A
	special BattleTowerAction
	warpsound
	disappear BATTLETOWER1F_RECEPTIONIST
	stopfollow
	applymovement PLAYER, MovementData_BattleTowerHallwayPlayerEntersBattleRoom
	warpcheck
	end

CheckCopyEnemyPartyFlag:
    ld a, [wCopyEnemyParty] ; Load the value into register a
    and a                   ; Test if it is 0 or 1
    jr z, .is_zero          ; If 0, jump to the zero handler
    ld a, 1                 ; If not 0, we'll return 1
    jr .done
.is_zero
    xor a                   ; Return 0
.done
    ld [wScriptVar], a      ; Store result in wScriptVar for the script
    ret

Script_GivePlayerPointsThenPrize:
    callasm CheckCopyEnemyPartyFlag
    ifequal 1, .MirrorMode

    ; normal mode branch
    callasm CheckHardModeASM
    iftrue .NormalHardMode
    callasm AwardBattleTowerPoints
    sjump .Finish

.NormalHardMode:
    callasm AwardBattleTowerHardModePoints
    sjump .Finish

.MirrorMode:
    callasm CheckHardModeASM
    iftrue .MirrorHardMode
    callasm AwardBattleTowerMirrorModePoints
    sjump .Finish

.MirrorHardMode:
    callasm AwardBattleTowerMirrorModeHardModePoints

.Finish:
    sjump Script_GivePlayerPrize

AwardBattleTowerMirrorModeHardModePoints:
	CheckEventFlag EVENT_BATTLE_TOWER_INVERSE_MODE
	jr nz, .inverse

	CheckEventFlag EVENT_BATTLE_TOWER_TYPELESS_MODE
	jr nz, .typeless

.normal
	ld hl, wBattleTowerMirrorModeHardModeNormalPoints
	jr .got_ptr

.inverse
	ld hl, wBattleTowerMirrorModeHardModeInversePoints
	jr .got_ptr

.typeless
	ld hl, wBattleTowerMirrorModeHardModeTypelessPoints

.got_ptr
	ld a, [hl]
	cp 100
	ret z ; already max

	add 3
	cp 101
	jr c, .store

	ld a, 100

.store
	ld [hl], a
	ret

AwardBattleTowerHardModePoints:
	CheckEventFlag EVENT_BATTLE_TOWER_INVERSE_MODE
	jr nz, .inverse

	CheckEventFlag EVENT_BATTLE_TOWER_TYPELESS_MODE
	jr nz, .typeless

.normal
	ld hl, wBattleTowerHardModeNormalPoints
	jr .got_ptr

.inverse
	ld hl, wBattleTowerHardModeInversePoints
	jr .got_ptr

.typeless
	ld hl, wBattleTowerHardModeTypelessPoints

.got_ptr
	ld a, [hl]
	cp 100
	ret z ; already max

	add 3
	cp 101
	jr c, .store

	ld a, 100

.store
	ld [hl], a
	ret

AwardBattleTowerMirrorModePoints:
	; choose WRAM pointer based on mode
	CheckEventFlag EVENT_BATTLE_TOWER_INVERSE_MODE
	jr nz, .inverse

	CheckEventFlag EVENT_BATTLE_TOWER_TYPELESS_MODE
	jr nz, .typeless

.normal
	ld hl, wBattleTowerMirrorModeNormalPoints
	jr .got_ptr

.inverse
	ld hl, wBattleTowerMirrorModeInversePoints
	jr .got_ptr

.typeless
	ld hl, wBattleTowerMirrorModeTypelessPoints

.got_ptr
	ld a, [hl]
	cp 100
	ret z ; already max

	add 3
	cp 101
	jr c, .store

	ld a, 100

.store
	ld [hl], a
	ret

AwardBattleTowerPoints:
	; choose WRAM pointer based on mode
	CheckEventFlag EVENT_BATTLE_TOWER_INVERSE_MODE
	jr nz, .inverse

	CheckEventFlag EVENT_BATTLE_TOWER_TYPELESS_MODE
	jr nz, .typeless

.normal
	ld hl, wBattleTowerNormalPoints
	jr .got_ptr

.inverse
	ld hl, wBattleTowerInversePoints
	jr .got_ptr

.typeless
	ld hl, wBattleTowerTypelessPoints

.got_ptr
	ld a, [hl]
	cp 100
	ret z ; already max

	add 3
	cp 101
	jr c, .store

	ld a, 100

.store
	ld [hl], a
	ret

Script_GivePlayerPrize:
	; give back player their party
	setval 0
	writemem wCopyEnemyParty

	special TryQuickSave
	setval BATTLETOWERACTION_1C
	special BattleTowerAction
	setval BATTLETOWERACTION_GIVEREWARD
	special BattleTowerAction
	giveitem CRYSTAL, 3
	iffalse Script_YourPackIsStuffedFull
	writetext Text_PlayerGotThree
	setval BATTLETOWERACTION_1D
	special BattleTowerAction
	closetext
	end

Script_YourPackIsStuffedFull:
	writetext Text_YourPackIsStuffedFull
	waitbutton
	closetext
	end

Script_BattleTowerIntroductionYesNo:
	writetext Text_WouldYouLikeToHearAboutTheBattleTower
	yesorno
	iffalse Script_BattleTowerSkipExplanation
Script_BattleTowerExplanation:
	writetext Text_BattleTowerIntroduction_2
Script_BattleTowerSkipExplanation:
	setval BATTLETOWERACTION_SET_EXPLANATION_READ
	special BattleTowerAction
	sjump Script_Menu_ChallengeExplanationCancel

Script_BattleTowerHopeToServeYouAgain:
    setval 0
    writemem wCopyEnemyParty
	writetext Text_WeHopeToServeYouAgain
	waitbutton
	closetext
	end

Script_BattleTowerSettings:
	writetext Text_BattleTower_AskTypesMode
	special Menu_BattleTowerSettings
	ifequal 1, .SetNormalMode
	ifequal 2, .SetInverseMode
	ifequal 3, .SetTypelessMode
	sjump Script_BattleTowerHopeToServeYouAgain

.SetNormalMode:
	clearevent EVENT_BATTLE_TOWER_INVERSE_MODE
 	clearevent EVENT_BATTLE_TOWER_TYPELESS_MODE
 	writetext Text_BattleTower_SetToNormalMode
	promptbutton
	sjump Script_Menu_ChallengeExplanationCancel

.SetInverseMode:
	clearevent EVENT_BATTLE_TOWER_TYPELESS_MODE
 	setevent EVENT_BATTLE_TOWER_INVERSE_MODE
 	writetext Text_BattleTower_SetToInverseMode
	promptbutton
	sjump Script_Menu_ChallengeExplanationCancel

.SetTypelessMode:
	clearevent EVENT_BATTLE_TOWER_INVERSE_MODE
 	setevent EVENT_BATTLE_TOWER_TYPELESS_MODE
 	writetext Text_BattleTower_SetToTypelessMode
	promptbutton
	sjump Script_Menu_ChallengeExplanationCancel

Script_MobileError:
	special BattleTowerMobileError
	closetext
	end

BattleTower_LeftWithoutSaving:
	opentext
	writetext Text_BattleTower_LeftWithoutSaving
	waitbutton
	sjump Script_BattleTowerHopeToServeYouAgain

BattleTower1FYoungsterScript:
	faceplayer
	opentext
	writetext Text_BattleTowerYoungster
	waitbutton
	closetext
	turnobject BATTLETOWER1F_YOUNGSTER, RIGHT
	end

BattleTower1FCooltrainerFScript:
	jumptextfaceplayer Text_BattleTowerCooltrainerF

BattleTower1FBugCatcherScript:
	jumptextfaceplayer Text_BattleTowerBugCatcher

BattleTower1FGrannyScript:
	jumptextfaceplayer Text_BattleTowerGranny

MovementData_BattleTower1FWalkToElevator:
	step UP
	step UP
	step UP
	step UP
	step UP
MovementData_BattleTowerHallwayPlayerEntersBattleRoom:
	step UP
	step_end

MovementData_BattleTowerElevatorExitElevator:
	step DOWN
	step_end

MovementData_BattleTowerHallwayWalkTo1020Room:
	step RIGHT
	step RIGHT
MovementData_BattleTowerHallwayWalkTo3040Room:
	step RIGHT
	step RIGHT
	step UP
	step RIGHT
	turn_head LEFT
	step_end

MovementData_BattleTowerHallwayWalkTo90100Room:
	step LEFT
	step LEFT
MovementData_BattleTowerHallwayWalkTo7080Room:
	step LEFT
	step LEFT
MovementData_BattleTowerHallwayWalkTo5060Room:
	step LEFT
	step LEFT
	step UP
	step LEFT
	turn_head RIGHT
	step_end

MovementData_BattleTowerBattleRoomPlayerWalksIn:
	step UP
	step UP
	step UP
	step UP
	turn_head RIGHT
	step_end

MovementData_BattleTowerBattleRoomOpponentWalksIn:
	slow_step DOWN
	slow_step DOWN
	slow_step DOWN
	turn_head LEFT
	step_end

MovementData_BattleTowerBattleRoomOpponentWalksOut:
	turn_head UP
	slow_step UP
	slow_step UP
	slow_step UP
	step_end

MovementData_BattleTowerBattleRoomReceptionistWalksToPlayer:
	slow_step RIGHT
	slow_step RIGHT
	slow_step UP
	slow_step UP
	step_end

MovementData_BattleTowerBattleRoomReceptionistWalksAway:
	slow_step DOWN
	slow_step DOWN
	slow_step LEFT
	slow_step LEFT
	turn_head RIGHT
	step_end

MovementData_BattleTowerBattleRoomPlayerTurnsToFaceReceptionist:
	turn_head DOWN
	step_end

MovementData_BattleTowerBattleRoomPlayerTurnsToFaceNextOpponent:
	turn_head RIGHT
	step_end

Text_BattleTowerWelcomesYou:
	text "Battle Tower"
	line "welcomes you!"
	done

Text_WantToGoIntoABattleRoom:
	text "Want to go into a"
	line "Battle Room?"
	done

Text_RightThisWayToYourBattleRoom:
	text "Right this way to"
	line "your Battle Room."
	done

Text_BattleTowerIntroduction_2:
	text "Battle Tower is a"
	line "facility made for"
	cont "#mon battles."

	para "Countless #mon"
	line "trainers gather"

	para "from all over to"
	line "hold battles in"

	para "specially designed"
	line "Battle Rooms."

	para "There are many"
	line "Battle Rooms in"
	cont "the Battle Tower."

	para "Each room holds"
	line "three trainers."

	para "Beat them all, and"
	line "win 3× Crystals."

	para "To interrupt a"
	line "session, you must"

	para "Save. If not, you"
	line "won't be able to"

	para "resume your"
	line "challenge."

	para ""
	done

Text_ThanksForVisiting:
	text "Thanks for"
	line "visiting!"
	done

Text_CongratulationsYouveBeatenAllTheTrainers:
	text "Congratulations!"

	para "You've beaten all"
	line "the trainers!"

	para "For that, you get"
	line "this great prize!"

	para ""
	done

Text_PlayerGotThree:
	text "<PLAYER> got"
	line "3× Crystals!@"
	sound_item
	text_promptbutton
	text_end

Text_YourPackIsStuffedFull:
	text "Oops, your Items"
	line "pocket is full."

	para "Please make room"
	line "and come back."
	done

Text_WeHopeToServeYouAgain:
	text "We hope to serve"
	line "you again."
	done

Text_PleaseStepThisWay:
	text "Please step this"
	line "way."
	done

Text_WouldYouLikeToHearAboutTheBattleTower:
	text "Would you like to"
	line "hear about the"
	cont "Battle Tower?"
	done

Text_BattleTower_AskTypesMode:
	text "Challenge which"
	line "kind of battles?"
	done

Text_BattleTower_SetToNormalMode:
	text "Type matchups set"
	line "to normal mode."
	done

Text_BattleTower_SetToInverseMode:
	text "Type matchups set"
	line "to inverse mode."
	done

Text_BattleTower_SetToTypelessMode:
	text "Type matchups set"
	line "to neutral mode."
	done

Text_BattleTower_LeftWithoutSaving:
	text "Excuse me!"
	
	para "You didn't Save"
	line "before exiting"
	cont "the Battle Room."

	para "I'm awfully sorry,"
	line "but your challenge"
	cont "will be declared"
	cont "invalid."
	
	para "I hope you didn't"
	line "reset to stave off"
	cont "a loss…"
	done

Text_YourMonWillBeHealedToFullHealth:
	text "Your #mon will"
	line "be healed."
	done

Text_NextUpOpponentNo:
	text "Next up, opponent"
	line "no.@"
	text_ram wStringBuffer3
	text ". Ready?"
	done

Text_SaveAndEndTheSession:
	text "Save and end the"
	line "session?"
	done

Text_SaveBeforeReentry:
	text "Your record will"
	line "be Saved before"
	cont "you go back into"
	cont "the previous Room."
	done

Text_CancelYourBattleRoomChallenge:
	text "Cancel your Battle"
	line "Room challenge?"
	done

Text_WeveBeenWaitingForYou:
	text "We've been waiting"
	line "for you. This way"
	cont "to a Battle Room,"
	cont "please."
	done

Text_BattleTowerYoungster:
	text "Destroyed by the"
	line "first opponent in"
	cont "no time at all…"
	
	para "I'm no good…"
	done

Text_BattleTowerCooltrainerF:
	text "There are lots of"
	line "Battle Rooms, but"
	cont "I'm going to win"
	cont "them all!"
	done

Text_BattleTowerGranny:
	text "Making your"
	line "#mon hold items"
	cont "is the key to"
	cont "winning battles."
	done

Text_BattleTowerBugCatcher:
	text "I'm trying to see"
	line "how far I can go"
	cont "using just bug"
	cont "#mon."

	para "Don't let there be"
	line "any fire #mon…"
	done

BattleTower1FStreakSign:
	end

BattleTower1F_MapEvents:
	def_warp_events
	warp_event  7,  9, BATTLE_PLAZA, 2
	warp_event  8,  9, BATTLE_PLAZA, 3
	warp_event  7,  0, BATTLE_TOWER_ELEVATOR, 1

	def_coord_events

	def_bg_events
	bg_event  6,  6, BGEVENT_READ, BattleTower1FStreakSign

	def_object_events
	object_event  7,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BattleTower1FReceptionistScript, -1
	object_event 14,  9, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, BattleTower1FYoungsterScript, -1
	object_event  4,  9, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BattleTower1FCooltrainerFScript, -1
	object_event  1,  3, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BattleTower1FBugCatcherScript, -1
	object_event 14,  3, SPRITE_GRANNY, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BattleTower1FGrannyScript, -1
