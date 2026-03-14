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
	object_event  4, 14, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletGymRareCandyScript, EVENT_VIOLET_GYM_THREE_RARE_CANDIES

	object_const_def
	const VIOLETGYM_FALKNER
	const VIOLETGYM_YOUNGSTER1
	const VIOLETGYM_YOUNGSTER2
	const VIOLETGYM_GYM_GUIDE
	const VIOLETGYM_POKE_BALL

VioletGym_MapScripts:
	def_scene_scripts
	scene_script VioletGymNoopScene, SCENE_VIOLETGYM_NOOP

	def_callbacks
    callback MAPCALLBACK_NEWMAP, ResetVioletGymTrainersCallback

VioletGymNoopScene:
	end

ResetVioletGymTrainersCallback:
	checkevent EVENT_PLAYER_IS_THE_POKEMON_LEAGUE_CHAMPION
	iftrue .ResetTrainers
	checkevent EVENT_BEAT_FALKNER
	iffalse .ResetTrainers
	endcallback
.ResetTrainers
	clearevent EVENT_BEAT_BIRD_KEEPER_ROD
	clearevent EVENT_BEAT_BIRD_KEEPER_ABE
	endcallback

VioletGymFalknerScript:
	faceplayeropentext
	checkevent EVENT_PLAYER_IS_THE_POKEMON_LEAGUE_CHAMPION
	iftrue .FalknerRematch
	checkevent EVENT_BEAT_FALKNER
	iftrue .GymBadgeBattleDone
	writethistext
		text "I'm Falkner, the"
		line "Violet #mon Gym"
		cont "leader!"

		para "I am the Bird"
		line "#mon user."

		para "Allow me to show"
		line "their majesty!"
		done
	waitclosetext
	winlosstext FalknerLossText, 0
	readvar VAR_BADGES
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer FALKNER, FALKNER1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer FALKNER, FALKNER2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer FALKNER, FALKNER3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer FALKNER, FALKNER4
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	playmusic MUSIC_GYM
	setevent EVENT_BEAT_FALKNER
	opentext
	writethistext
		text "<PLAYER> received"
		line "Zephyrbadge."
		done
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_ZEPHYRBADGE
.GymBadgeBattleDone:
	checkevent EVENT_GOT_VIOLET_GYM_TM
	iftrue .SpeechAfterTM
	writethistext
		text "Take this TM too!"
		done
	promptbutton
	verbosegiveitem TM_MUD_SLAP
	iffalse_endtext
	setevent EVENT_GOT_VIOLET_GYM_TM
	jumpthisopenedtext
		text "Technical Machine"
		line "or TM for short."

		para "By using a TM, a"
		line "#mon will"
		cont "instantly learn a"
		cont "new move."

		para "Think before you"
		line "act--a TM can be"
		cont "used only once."

		para "There's a place"
		line "where all TMs can"
		cont "be re-obtained as"
		cont "many times as one"
		cont "likes."
		done

.SpeechAfterTM:
	jumpthisopenedtext
		text "I'm going to train"
		line "harder to become"
		cont "the greatest bird"
		cont "master!"

		para "Let's battle again"
		line "when we both reach"
		cont "new heights."
		done

.FalknerRematch:
	writethistext
		text "Falkner: Congrats"
		line "on becoming champ-"
		cont "ion, <PLAYER>!"

		para "But you're not the"
		line "only one who's been"
		cont "flying high."
		
		para "I've worked hard"
		line "since our last" 
		cont "battle."
		
		para "Now my #mon are"
		line "in top shape."
		
		para "Up for a rematch?"
		done
	yesorno
	iffalse_endtext
	writethistext
		text "I'll show you the"
		line "real power of the"
		cont "magnificent bird"
		cont "#mon!"
		done
	waitbutton
	winlosstext FalknerRematchLossText, 0
	loadtrainer FALKNER, FALKNER5 ; super boss team
	startbattle
	reloadmapafterbattle
	appear VIOLETGYM_POKE_BALL
	jumpthistext
		text "Falkner: What an"
		line "intense battle!"
		
		para "We've fought hard,"
		line "but you've proven"
		cont "once again, that"
		cont "you're as tough as"
		cont "ever!"
		done 

FalknerLossText:
	text "No! My beloved"
	line "bird #mon!"

	para "All right."
	line "Take this."

	para "It's the official"
	line "#mon League"
	cont "Zephyrbadge."
	done

FalknerRematchLossText:
	text "I understand…"
	line "I'll bow out…"
	done

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
.ZeroOrOneBadge:
	loadtrainer BIRD_KEEPER, ABE1
	sjump .StartBattle
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
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	playmusic MUSIC_GYM
	setevent EVENT_BEAT_BIRD_KEEPER_ABE
	end

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
.ZeroOrOneBadge:
	loadtrainer BIRD_KEEPER, ROD1
	sjump .StartBattle
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
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	playmusic MUSIC_GYM
	setevent EVENT_BEAT_BIRD_KEEPER_ROD
.End
	end

RodToPlayerMovement:
	step LEFT
	step LEFT
	step_end

BirdKeeperRodBeatenText:
	text "Gaaah!"
	done

VioletGymGuideScript:
	checkevent EVENT_PLAYER_IS_THE_POKEMON_LEAGUE_CHAMPION
	iftrue .VioletGymGuideChampScript
	checkevent EVENT_BEAT_FALKNER
	iftrue .VioletGymGuideWinScript
	jumpthistextfaceplayer
		text "Hey! I'm no train-"
		line "er but I can give"
		cont "some advice!"

		para "Believe me!"
		line "If you believe, a"
		cont "championship dream"
		cont "can come true."

		para "You believe?"
		line "Then listen."

		para "The grass-type is"
		line "weak against the"
		cont "flying-type. Keep"
		cont "this in mind."
		done

.VioletGymGuideWinScript:
	jumpthistextfaceplayer
		text "Nice battle! Keep"
		line "it up, and you'll"
		cont "be the Champ in no"
		cont "time at all!"
		done

.VioletGymGuideChampScript:
	jumpthistextfaceplayer
		text "Champion <PLAYER>!"

		para "Good to see you"
		line "again."

		para "Here to brush up"
		line "on your skills?"

		para "Of course, you do"
		line "not need my advice"
		cont "anymore. Hehe."
		done

VioletGymStatue:
	checkflag ENGINE_ZEPHYRBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, FALKNER, FALKNER1
	jumpstd GymStatue2Script

VioletGymRareCandyScript:
	disappear LAST_TALKED
	opentext
	giveitem RARE_CANDY, 3
	iffalse VioletGymPlayersPackIsFull
	jumpthisopenedtext
		text "<PLAYER> got"
		line "3× Rare Candies!@"
		sound_item
		text_end

VioletGymPlayersPackIsFull:
	appear VIOLETGYM_POKE_BALL
	jumpthisopenedtext
		text "The Item Pocket"
		line "is full…"
		done
