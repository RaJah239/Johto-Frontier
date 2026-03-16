CianwoodGym_MapEvents:
	def_warp_events
	warp_event  4, 17, CIANWOOD_CITY, 3
	warp_event  5, 17, CIANWOOD_CITY, 3

	def_coord_events
	coord_event  5,  12, SCENE_CIANWOODGYM_NOOP, TrainerBlackbeltYoshiCheck1
	coord_event  4,  12, SCENE_CIANWOODGYM_NOOP, TrainerBlackbeltYoshiCheck2
	coord_event  5,  9, SCENE_CIANWOODGYM_NOOP, TrainerSailorSteeleCheck1
	coord_event  4,  9, SCENE_CIANWOODGYM_NOOP, TrainerSailorSteeleCheck2
	coord_event  5,  4, SCENE_CIANWOODGYM_NOOP, TrainerBlackbeltLungCheck1
	coord_event  4,  4, SCENE_CIANWOODGYM_NOOP, TrainerBlackbeltLungCheck2

	def_bg_events
	bg_event  3, 15, BGEVENT_READ, CianwoodGymStatue
	bg_event  6, 15, BGEVENT_READ, CianwoodGymStatue

	def_object_events
	strengthboulder_event  5,  1
	object_event  4,  1, SPRITE_CHUCK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, CianwoodGymChuckScript, -1
	object_event  6, 12, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, TrainerBlackbeltYoshi, -1
	object_event  3,  9, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TrainerSailorSteele, -1
	object_event  6,  4, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, TrainerBlackbeltLung, -1
	object_event  7, 15, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CianwoodGymGuideScript, -1
	object_event  4, 16, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodGymProteinScript, EVENT_CIANWOOD_GYM_FIVE_PROTEINS

	object_const_def
	const CIANWOODGYM_BOULDER
	const CIANWOODGYM_CHUCK
	const CIANWOODGYM_BLACK_BELT1
	const CIANWOODGYM_SAILOR
	const CIANWOODGYM_BLACK_BELT2
	const CIANWOODGYM_GYM_GUIDE
	const CIANWOODGYM_POKE_BALL

CianwoodGym_MapScripts:
	def_scene_scripts
	scene_script CianwoodGymNoopScene, SCENE_CIANWOODGYM_NOOP

	def_callbacks
    callback MAPCALLBACK_NEWMAP, ResetCianwoodGymTrainersCallback

CianwoodGymNoopScene:
	end

ResetCianwoodGymTrainersCallback:
	checkevent EVENT_PLAYER_IS_THE_POKEMON_LEAGUE_CHAMPION
	iftrue .ResetTrainers 
	checkevent EVENT_BEAT_CHUCK
	iffalse .ResetTrainers
	endcallback
.ResetTrainers
	clearevent EVENT_BEAT_BLACKBELT_YOSHI
	clearevent EVENT_BEAT_SAILOR_STEELE
	clearevent EVENT_BEAT_BLACKBELT_LUNG
	endcallback

CianwoodGymChuckScript:
	faceplayeropentext
	checkevent EVENT_PLAYER_IS_THE_POKEMON_LEAGUE_CHAMPION
	iftrue .ChuckRematch
	checkevent EVENT_BEAT_CHUCK
	iftrue .GymBadgeBattleDone
	writethistext
		text "Wahahah!"

		para "So you've come"
		line "this far!"

		para "Let me tell you,"
		line "I'm tough!"

		para "My #mon will"
		line "crush stones and"
		cont "shatter bones!"

		para "Watch this!"
		done
	waitclosetext
	turnobject CIANWOODGYM_CHUCK, RIGHT
	showthistext
		text "Chuck: Urggh!"
		line "…"

		para "Oooarrgh!"
		done
	applymovement CIANWOODGYM_BOULDER, CianwoodGymMovement_ChuckChucksBoulder
	playsound SFX_STRENGTH
	earthquake 80
	disappear CIANWOODGYM_BOULDER
	pause 30
	showthistextfaceplayer
		text "There! Scared now,"
		line "are you?"

		para "What?"
		line "It has nothing to"
		cont "do with #mon?"

		para "That's true!"

		para "Come on. We shall"
		line "do battle!"
		done
	winlosstext ChuckLossText, 0
	readvar VAR_BADGES
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer CHUCK, CHUCK1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer CHUCK, CHUCK2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer CHUCK, CHUCK3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer CHUCK, CHUCK4
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	playmusic MUSIC_GYM
	setevent EVENT_BEAT_CHUCK
	opentext
	writethistext
		text "<PLAYER> received"
		line "Storm Badge."
		done
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_STORMBADGE
.GymBadgeBattleDone:
	checkevent EVENT_GOT_CIANWOOD_GYM_TM
	iftrue .SpeechAfterTM
	writethistext
		text "Here, take this"
		line "too!"
		done
	promptbutton
	verbosegiveitem TM_METEOR_MASH
	iffalse_endtext
	setevent EVENT_GOT_CIANWOOD_GYM_TM
	jumpthisopenedtext
		text "That is Meteor"
		line "Mash."

		para "It may raise the"
		line "user's Attack."
		done

.SpeechAfterTM:
	jumpthisopenedtext
		text "Wahahah! I enjoyed"
		line "battling you!"

		para "But a loss is a"
		line "loss!"

		para "From now on, I'm"
		line "going to train 24"
		cont "hours a day for"
		cont "our eventual re-"
		cont "match!"
		done

.ChuckRematch:
	writethistext
		text "Chuck: There you"
		line "are <PLAYER>!"

		para "Sorry for all the"
		line "yelling."
		
		para "I just finished up"
		line "my training."
		
		para "Up for another"
		line "battle?"
		done
	yesorno
	iffalse_endtext
	writethistext
		text "Taste the outcome"
		line "of my rigorous"
		cont "24-hours a day"
		cont "training!"
		done
	waitbutton
	winlosstext ChuckRematchLossText, 0
	loadtrainer CHUCK, CHUCK5 ; super boss team
	startbattle
	reloadmapafterbattle
	clearevent EVENT_BEAT_BLACKBELT_YOSHI
	clearevent EVENT_BEAT_SAILOR_STEELE
	clearevent EVENT_BEAT_BLACKBELT_LUNG
	appear CIANWOODGYM_POKE_BALL
	showthistext
		text "Chuck: You're some-"
		line "thing special kid!"

		para "No wonder you"
		line "became champion."
		done 
	playsound SFX_WARP_TO
	special FadeOutPalettes
	waitsfx
	warp CIANWOOD_GYM, 4, 17
	end

CianwoodGymMovement_ChuckChucksBoulder:
	set_sliding
	big_step LEFT
	big_step UP
	fast_jump_step RIGHT
	remove_sliding
	step_end

ChuckLossText:
	text "Wha? Huh?"
	line "I lost?"

	para "How about that!"
	
	para "You're worthy of"
	line "Stormbadge!"
	done

ChuckRematchLossText:
	text "We… lost… Back to"
	line "training it is!"
	done 

TrainerBlackbeltYoshi:
	jumpthistextfaceplayer
		text "You seem to have a"
		line "strong bond with"
		cont "your #mon too!"
		done

TrainerBlackbeltYoshiCheck1:
	checkevent EVENT_BEAT_BLACKBELT_YOSHI
	iftrue .End
	sjump TrainerBlackbeltYoshiStart1
.End
	end

TrainerBlackbeltYoshiCheck2:
	checkevent EVENT_BEAT_BLACKBELT_YOSHI
	iftrue .End
	sjump TrainerBlackbeltYoshiStart2
.End
	end

TrainerBlackbeltYoshiStart1:
	playmusic MUSIC_HIKER_ENCOUNTER
	showemote EMOTE_SHOCK, CIANWOODGYM_BLACK_BELT1, 30
	turnobject PLAYER, RIGHT
	sjump TrainerBlackbeltYoshiBattle

TrainerBlackbeltYoshiStart2:
	playmusic MUSIC_HIKER_ENCOUNTER
	showemote EMOTE_SHOCK, CIANWOODGYM_BLACK_BELT1, 30
	applymovement CIANWOODGYM_BLACK_BELT1, BlackBeltToPlayerMovement
	turnobject PLAYER, RIGHT
	; fallthrough

TrainerBlackbeltYoshiBattle:
	showthistext
		text "My #mon and I"
		line "are bound togeth-"
		cont "er by friendship."

		para "Our bond will"
		line "never be broken!"
		done
	winlosstext BlackbeltYoshiBeatenText, 0
	readvar VAR_BADGES
	ifgreater 7, .EightBadges
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer BLACKBELT_T, YOSHI1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer BLACKBELT_T, YOSHI2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer BLACKBELT_T, YOSHI3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer BLACKBELT_T, YOSHI4
	sjump .StartBattle
.EightBadges:
	loadtrainer BLACKBELT_T, YOSHI5
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	playmusic MUSIC_GYM
	setevent EVENT_BEAT_BLACKBELT_YOSHI
	end

BlackbeltYoshiBeatenText:
	text "This isn't real!"
	done

TrainerSailorSteele:
	jumpthistextfaceplayer
		text "TODOTEXT"
		done

TrainerSailorSteeleCheck1:
	checkevent EVENT_BEAT_SAILOR_STEELE
	iftrue .End
	sjump TrainerSailorSteeleStart1
.End
	end

TrainerSailorSteeleCheck2:
	checkevent EVENT_BEAT_SAILOR_STEELE
	iftrue .End
	sjump TrainerSailorSteeleStart2
.End
	end

TrainerSailorSteeleStart1:
	playmusic MUSIC_HIKER_ENCOUNTER
	showemote EMOTE_SHOCK, CIANWOODGYM_SAILOR, 30
	applymovement CIANWOODGYM_SAILOR, SteeleToPlayerMovement
	turnobject PLAYER, LEFT
	sjump TrainerSailorSteeleBattle

TrainerSailorSteeleStart2:
	playmusic MUSIC_HIKER_ENCOUNTER
	showemote EMOTE_SHOCK, CIANWOODGYM_SAILOR, 30
	turnobject PLAYER, LEFT
	; fallthrough

TrainerSailorSteeleBattle:
	showthistext
		text "TODOTEXT"
		done
	winlosstext SailorSteeleBeatenText, 0
	readvar VAR_BADGES
	ifgreater 7, .EightBadges
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer SAILOR, STEELE1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer SAILOR, STEELE2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer SAILOR, STEELE3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer SAILOR, STEELE4
	sjump .StartBattle
.EightBadges:
	loadtrainer SAILOR, STEELE5
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	playmusic MUSIC_GYM
	setevent EVENT_BEAT_SAILOR_STEELE
	end

SteeleToPlayerMovement:
	step RIGHT
	step_end

SailorSteeleBeatenText:
	text "TODOTEXT"
	done

TrainerBlackbeltLung:
	jumpthistextfaceplayer
		text "My #mon lost…"
		line "My… my pride is"
		cont "shattered…"
		done

TrainerBlackbeltLungCheck1:
	checkevent EVENT_BEAT_BLACKBELT_LUNG
	iftrue .End
	sjump TrainerBlackbeltLungStart1
.End
	end

TrainerBlackbeltLungCheck2:
	checkevent EVENT_BEAT_BLACKBELT_LUNG
	iftrue .End
	sjump TrainerBlackbeltLungStart2
.End
	end

TrainerBlackbeltLungStart1:
	playmusic MUSIC_HIKER_ENCOUNTER
	showemote EMOTE_SHOCK, CIANWOODGYM_BLACK_BELT2, 30
	turnobject PLAYER, RIGHT
	sjump TrainerBlackbeltLungBattle

TrainerBlackbeltLungStart2:
	playmusic MUSIC_HIKER_ENCOUNTER
	showemote EMOTE_SHOCK, CIANWOODGYM_BLACK_BELT2, 30
	applymovement CIANWOODGYM_BLACK_BELT2, BlackBeltToPlayerMovement
	turnobject PLAYER, RIGHT
	; fallthrough

TrainerBlackbeltLungBattle:
	showthistext
		text "My raging fists"
		line "will shatter your"
		cont "#mon!"
		done
	winlosstext BlackbeltLungBeatenText, 0
	readvar VAR_BADGES
	ifgreater 7, .EightBadges
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer BLACKBELT_T, LUNG1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer BLACKBELT_T, LUNG2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer BLACKBELT_T, LUNG3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer BLACKBELT_T, LUNG4
	sjump .StartBattle
.EightBadges:
	loadtrainer BLACKBELT_T, LUNG5
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	playmusic MUSIC_GYM
	setevent EVENT_BEAT_BLACKBELT_LUNG
	end

BlackBeltToPlayerMovement:
	step LEFT
	step_end

BlackbeltLungBeatenText:
	text "I got shattered!"
	done

CianwoodGymGuideScript:
	checkevent EVENT_PLAYER_IS_THE_POKEMON_LEAGUE_CHAMPION
	iftrue .CianwoodGymGuideChampScript
	checkevent EVENT_BEAT_CHUCK
	iftrue .CianwoodGymGuideWinScript
	jumpthistextfaceplayer
		text "Chuck, the Gym"
		line "Leader uses the"
		cont "fighting-type."

		para "So you should"
		line "confound him with"
		cont "Psychic, Flying or"
		cont "Fairy #mon."

		para "Wipe out his #-"
		line "mon before they"
		cont "can use their"
		cont "physical strength."
		done

.CianwoodGymGuideWinScript:
	jumpthistextfaceplayer
		text "<PLAYER>! You won!"
		line "I could tell by"
		cont "looking at you!"
		done

.CianwoodGymGuideChampScript:
	jumpthistextfaceplayer
		text "There's a lot of"
		line "shouting in here!"

		para "Chuck might defeat"
		line "you with noise!"

		para "Haha. Sorry. I had"
		line "too."
		done

CianwoodGymStatue:
	checkflag ENGINE_STORMBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, CHUCK, CHUCK1
	jumpstd GymStatue2Script

CianwoodGymProteinScript:
	disappear LAST_TALKED
	opentext
	giveitem PROTEIN, 5
	iffalse CianwoodGymPlayersPackIsFull
	jumpthisopenedtext
		text "<PLAYER> got"
		line "5× Proteins!@"
		sound_item
		text_end

CianwoodGymPlayersPackIsFull:
	appear CIANWOODGYM_POKE_BALL
	jumpthisopenedtext
		text "The Item Pocket"
		line "is full…"
		done
