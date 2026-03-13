VioletGym_MapEvents:
	def_warp_events
	warp_event  4, 15, VIOLET_CITY, 3
	warp_event  5, 15, VIOLET_CITY, 3

	def_coord_events
	coord_event  4, 10, SCENE_VIOLETGYM_NOOP, TrainerBirdKeeperAbeCheck1
	coord_event  5, 10, SCENE_VIOLETGYM_NOOP, TrainerBirdKeeperAbeCheck2
	coord_event  4, 6, SCENE_VIOLETGYM_NOOP, TrainerBirdKeeperRodCheck

	def_bg_events
	bg_event  3, 13, BGEVENT_READ, VioletGymStatue
	bg_event  6, 13, BGEVENT_READ, VioletGymStatue

	def_object_events
	object_event  5,  1, SPRITE_FALKNER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, VioletGymFalknerScript, -1
	object_event  7,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 2, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, TrainerBirdKeeperRod, -1
	object_event  2, 10, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 2, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, TrainerBirdKeeperAbe, -1
	object_event  7, 13, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, VioletGymGuideScript, -1

	object_const_def
	const VIOLETGYM_FALKNER
	const VIOLETGYM_YOUNGSTER1
	const VIOLETGYM_YOUNGSTER2
	const VIOLETGYM_GYM_GUIDE

VioletGym_MapScripts:
	def_scene_scripts
	scene_script VioletGymNoopScene, SCENE_VIOLETGYM_NOOP

	def_callbacks
    callback MAPCALLBACK_NEWMAP, ResetVioletGymTrainersCallback

VioletGymNoopScene:
	end

ResetVioletGymTrainersCallback:
;	checkevent EVENT_BEAT_FALKNER
;	iffalse .ResetTrainers
;	endcallback
;.ResetTrainers
;	clearevent EVENT_BEAT_BIRD_KEEPER_ROD
;	clearevent EVENT_BEAT_BIRD_KEEPER_ABE
	endcallback

VioletGymFalknerScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_FALKNER
	iftrue .FightDone
	writetext FalknerIntroText
	waitbutton
	closetext
	winlosstext FalknerWinLossText, 0
	loadtrainer FALKNER, FALKNER1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_FALKNER
	opentext
	writetext ReceivedZephyrBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_ZEPHYRBADGE
	readvar VAR_BADGES
.FightDone:
	checkevent EVENT_GOT_TM31_MUD_SLAP
	iftrue .SpeechAfterTM
	setevent EVENT_BEAT_BIRD_KEEPER_ROD
	setevent EVENT_BEAT_BIRD_KEEPER_ABE
	writetext FalknerZephyrBadgeText
	promptbutton
	verbosegiveitem TM_MUD_SLAP
	iffalse .NoRoomForMudSlap
	setevent EVENT_GOT_TM31_MUD_SLAP
	writetext FalknerTMMudSlapText
	waitbutton
	closetext
	end

.SpeechAfterTM:
	writetext FalknerFightDoneText
	waitbutton
.NoRoomForMudSlap:
	closetext
	end

TrainerBirdKeeperAbe:
	jumpthistextfaceplayer
		text "This is pathetic,"
		line "losing to some"
		cont "rookie trainer…"
		done

TrainerBirdKeeperAbeCheck1:
	checkevent EVENT_BEAT_BIRD_KEEPER_ABE
	iftrue .End
	sjump TrainerBirdKeeperAbeStart1
.End
	end

TrainerBirdKeeperAbeCheck2:
	checkevent EVENT_BEAT_BIRD_KEEPER_ABE
	iftrue .End
	sjump TrainerBirdKeeperAbeStart2
.End
	end

TrainerBirdKeeperAbeStart1:
	playmusic MUSIC_YOUNGSTER_ENCOUNTER
	showemote EMOTE_SHOCK, VIOLETGYM_YOUNGSTER2, 30
	applymovement VIOLETGYM_YOUNGSTER2, AbeToPlayerMovement1
	sjump TrainerBirdKeeperAbeBattle

TrainerBirdKeeperAbeStart2:
	playmusic MUSIC_YOUNGSTER_ENCOUNTER
	showemote EMOTE_SHOCK, VIOLETGYM_YOUNGSTER2, 30
	applymovement VIOLETGYM_YOUNGSTER2, AbeToPlayerMovement2
	; fallthrough

TrainerBirdKeeperAbeBattle:
	turnobject PLAYER, LEFT
	showthistext
		text "Let me see if you"
		line "are good enough to"
		cont "face Falkner!"
		done
	winlosstext BirdKeeperAbeBeatenText, 0
	readvar VAR_BADGES
	ifgreater 7, .EightBadges
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge
	loadtrainer BIRD_KEEPER, ABE1
.StartBattle:
	startbattle
	reloadmapafterbattle
	playmusic MUSIC_GYM
	setevent EVENT_BEAT_BIRD_KEEPER_ABE
	end

.TwoOrThreeBadges:
	loadtrainer BIRD_KEEPER, ABE2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer BIRD_KEEPER, ABE3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer BIRD_KEEPER, ABE4
	sjump .StartBattle
.EightBadges:
	loadtrainer BIRD_KEEPER, ABE5
	sjump .StartBattle

AbeToPlayerMovement1:
	step RIGHT
	step_end

AbeToPlayerMovement2:
	step RIGHT
	step RIGHT
	step_end

BirdKeeperAbeBeatenText:
	text "This can't be"
	line "true!"
	done

TrainerBirdKeeperRod:
	jumpthistextfaceplayer
		text "Falkner's skills"
		line "are for real!"

		para "Don't get cocky"
		line "just because you"
		cont "beat me!"
		done

TrainerBirdKeeperRodCheck:
	checkevent EVENT_BEAT_BIRD_KEEPER_ROD
	iftrue .End
	playmusic MUSIC_YOUNGSTER_ENCOUNTER
	showemote EMOTE_SHOCK, VIOLETGYM_YOUNGSTER1, 30
	applymovement VIOLETGYM_YOUNGSTER1, RodToPlayerMovement
	showthistext
		text "The keyword is"
		line "guts!"

		para "Those here are"
		line "training night and"
		cont "day to become bird"
		cont "#mon masters."

		para "Come on!"
		done
	winlosstext BirdKeeperRodBeatenText, 0
	readvar VAR_BADGES
	ifgreater 7, .EightBadges
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge
	loadtrainer BIRD_KEEPER, ROD1
.StartBattle:
	startbattle
	reloadmapafterbattle
	playmusic MUSIC_GYM
	setevent EVENT_BEAT_BIRD_KEEPER_ROD
.End
	end

.TwoOrThreeBadges:
	loadtrainer BIRD_KEEPER, ROD2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer BIRD_KEEPER, ROD3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer BIRD_KEEPER, ROD4
	sjump .StartBattle
.EightBadges:
	loadtrainer BIRD_KEEPER, ROD5
	sjump .StartBattle

RodToPlayerMovement:
	step LEFT
	step LEFT
	step_end

BirdKeeperRodBeatenText:
	text "Gaaah!"
	done

VioletGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_FALKNER
	iftrue .VioletGymGuideWinScript
	writetext VioletGymGuideText
	waitbutton
	closetext
	end

.VioletGymGuideWinScript:
	writetext VioletGymGuideWinText
	waitbutton
	closetext
	end



FalknerIntroText:
	text "I'm FALKNER, the"
	line "VIOLET #MON GYM"
	cont "leader!"

	para "People say you can"
	line "clip flying-type"

	para "#MON's wings"
	line "with a jolt of"
	cont "electricity…"

	para "I won't allow such"
	line "insults to bird"
	cont "#MON!"

	para "I'll show you the"
	line "real power of the"

	para "magnificent bird"
	line "#MON!"
	done

FalknerWinLossText:
	text "…Darn! My dad's"
	line "cherished bird"
	cont "#MON…"

	para "All right."
	line "Take this."

	para "It's the official"
	line "#MON LEAGUE"
	cont "ZEPHYRBADGE."
	done

ReceivedZephyrBadgeText:
	text "<PLAYER> received"
	line "ZEPHYRBADGE."
	done

FalknerZephyrBadgeText:
	text "It enables"
	line "#MON to use"

	para "FLASH, if they"
	line "have it, anytime."

	para "Here--take this"
	line "too."
	done

FalknerTMMudSlapText:
	text "By using a TM, a"
	line "#MON will"

	para "instantly learn a"
	line "new move."

	para "Think before you"
	line "act--a TM can be"
	cont "used only once."

	para "TM31 contains"
	line "MUD-SLAP."

	para "It reduces the"
	line "foe's accuracy"

	para "while it causes"
	line "damage."

	para "In other words, it"
	line "is both defensive"
	cont "and offensive."
	done

FalknerFightDoneText:
	text "There are #MON"
	line "GYMS in cities and"
	cont "towns ahead."

	para "You should test"
	line "your skills at"
	cont "these GYMS."

	para "I'm going to train"
	line "harder to become"

	para "the greatest bird"
	line "master!"
	done

VioletGymGuideText:
	text "Hey! I'm no train-"
	line "er but I can give"
	cont "some advice!"

	para "Believe me!"
	line "If you believe, a"

	para "championship dream"
	line "can come true."

	para "You believe?"
	line "Then listen."

	para "The grass-type is"
	line "weak against the"

	para "flying-type. Keep"
	line "this in mind."
	done

VioletGymGuideWinText:
	text "Nice battle! Keep"
	line "it up, and you'll"

	para "be the CHAMP in no"
	line "time at all!"
	done

VioletGymStatue:
	checkflag ENGINE_ZEPHYRBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, FALKNER, FALKNER1
	jumpstd GymStatue2Script
