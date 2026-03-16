GoldenrodGym_MapEvents:
	def_warp_events
	warp_event  2, 17, GOLDENROD_CITY, 2
	warp_event  3, 17, GOLDENROD_CITY, 2

	def_coord_events
	coord_event  0,  4, SCENE_GOLDENRODGYM_NOOP, TrainerBeautyVictoriaCheck1
	coord_event  0,  3, SCENE_GOLDENRODGYM_NOOP, TrainerBeautyVictoriaCheck2
	coord_event 19,  7, SCENE_GOLDENRODGYM_NOOP, TrainerBeautySamanthaCheck1
	coord_event 19,  6, SCENE_GOLDENRODGYM_NOOP, TrainerBeautySamanthaCheck2
	coord_event 13, 13, SCENE_GOLDENRODGYM_NOOP, TrainerLassCarrieCheck
	coord_event  8,  5, SCENE_GOLDENRODGYM_NOOP, TrainerLassBridgetCheck

	def_bg_events
	bg_event  1, 15, BGEVENT_READ, GoldenrodGymStatue
	bg_event  4, 15, BGEVENT_READ, GoldenrodGymStatue

	def_object_events
	object_event  8,  3, SPRITE_WHITNEY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodGymWhitneyScript, -1
	object_event  9, 13, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, TrainerLassCarrie, -1
	object_event  7,  5, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, TrainerLassBridget, -1
	object_event  0,  2, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, TrainerBeautyVictoria, -1
	object_event 19,  5, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_AZURE, OBJECTTYPE_SCRIPT, 0, TrainerBeautySamantha, -1
	object_event  5, 15, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodGymGuideScript, -1
	object_event  2, 16, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodGymHPUpScript, EVENT_GOLDENROD_GYM_FIVE_HP_UPS

	object_const_def
	const GOLDENRODGYM_WHITNEY
	const GOLDENRODGYM_LASS1
	const GOLDENRODGYM_LASS2
	const GOLDENRODGYM_BEAUTY1
	const GOLDENRODGYM_BEAUTY2
	const GOLDENRODGYM_GYM_GUIDE
	const GOLDENRODGYM_POKE_BALL

GoldenrodGym_MapScripts:
	def_scene_scripts
	scene_script GoldenrodGymNoop1Scene, SCENE_GOLDENRODGYM_NOOP

	def_callbacks
    callback MAPCALLBACK_NEWMAP, ResetGoldenrodGymTrainersCallback

ResetGoldenrodGymTrainersCallback:
	checkevent EVENT_PLAYER_IS_THE_POKEMON_LEAGUE_CHAMPION
	iftrue .ResetTrainers
	checkevent EVENT_BEAT_WHITNEY
	iffalse .ResetTrainers
	endcallback
.ResetTrainers
	clearevent EVENT_BEAT_BEAUTY_VICTORIA
	clearevent EVENT_BEAT_BEAUTY_SAMANTHA
	clearevent EVENT_BEAT_LASS_CARRIE
	clearevent EVENT_BEAT_LASS_BRIDGET
	endcallback

GoldenrodGymNoop1Scene:
	end

GoldenrodGymWhitneyScript:
	faceplayeropentext
	checkevent EVENT_PLAYER_IS_THE_POKEMON_LEAGUE_CHAMPION
	iftrue .WhitneyRematch
	checkevent EVENT_BEAT_WHITNEY
	iftrue .GymBadgeBattleDone
	writethistext
		text "Hi! I'm Whitney!"
		line "I'm Goldenrod's Gym"
		cont "Leader."

		para "It's been a while"
		line "now but I still"
		cont "think #mon are"
		cont "super-cute!"

		para "I'd say I'm good"
		line "at battling, you've"
		cont "been warned!"
		done
	waitclosetext
	winlosstext WhitneyLossText, 0
	readvar VAR_BADGES
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer WHITNEY, WHITNEY1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer WHITNEY, WHITNEY2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer WHITNEY, WHITNEY3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer WHITNEY, WHITNEY4
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_WHITNEY
	setevent EVENT_BEAT_BEAUTY_VICTORIA
	setevent EVENT_BEAT_BEAUTY_SAMANTHA
	opentext
	writethistext
		text "<PLAYER> received"
		line "Plain Badge."
		done
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_PLAINBADGE
.GymBadgeBattleDone:
	checkevent EVENT_GOT_GOLDENROD_GYM_TM
	iftrue_jumpopenedtext .SpeechAfterTMText
	writethistext
		text "Oh, you can have"
		line "this too!"
		done
	promptbutton
	verbosegiveitem TM_ATTRACT
	iffalse_endtext
	setevent EVENT_GOT_GOLDENROD_GYM_TM
	jumpthisopenedtext
		text "It's Attract!"
		line "It makes full use"
		cont "of a #mon's"
		cont "charm."

		para "Some people consi-"
		line "der it hax. Hehe."
		done

.SpeechAfterTMText
		text "Come for a visit"
		line "again! Bye-bye!"
		done

.WhitneyRematch:
	writethistext
		text "Whitney: Hiya"
		line "<PLAYER>!"

		para "Thanks for coming"
		line "to visit me."

		para "My #mon and I"
		line "have been training"
		cont "diligently."

		para "Let's see how they"
		line "do against the"
		cont "champion?"
		done
	yesorno
	iffalse_endtext
	writethistext
		text "Great! We're going"
		line "all out!"
		done
	waitclosetext
	winlosstext WhitneyRematchLossText, 0
	loadtrainer WHITNEY, WHITNEY5 ; super boss team
	startbattle
	reloadmapafterbattle
	clearevent EVENT_BEAT_BEAUTY_VICTORIA
	clearevent EVENT_BEAT_BEAUTY_SAMANTHA
	clearevent EVENT_BEAT_LASS_CARRIE
	clearevent EVENT_BEAT_LASS_BRIDGET
	appear GOLDENRODGYM_POKE_BALL
	showthistext
		text "Whitney: You are"
		line "still very strong."

		para "I've more work to"
		line "do to get to your"
		cont "level."
		
		para "Let's do this again"
		line "sometime."
		done
	playsound SFX_WARP_TO
	special FadeOutPalettes
	waitsfx
	warp GOLDENROD_GYM, 2, 17
	end

WhitneyLossText:
	text "You're even better"
	line "than me!"

	para "You deserve this!"
	done

WhitneyRematchLossText:
	text "We tried our best…"

	para "There's always next"
	line "time."
	done

TrainerLassCarrie:
	jumpthistextfaceplayer
		text "Do my #mon"
		line "think I'm cute?"
		done

TrainerLassCarrieCheck:
	checkevent EVENT_BEAT_LASS_CARRIE
	iftrue_end
	special SaveMusic
	playmusic MUSIC_LASS_ENCOUNTER
	showemote EMOTE_SHOCK, GOLDENRODGYM_LASS1, 30
	applymovement GOLDENRODGYM_LASS1, CarrieToPlayerMovement
	showthistext
		text "Don't let my"
		line "#mon's cute"
		cont "looks fool you."

		para "They can whip you!"
		done
	winlosstext LassCarrieBeatenText, 0
	readvar VAR_BADGES
	ifgreater 7, .EightBadges
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer LASS, CARRIE1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer LASS, CARRIE2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer LASS, CARRIE3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer LASS, CARRIE4
	sjump .StartBattle
.EightBadges:
	loadtrainer LASS, CARRIE5
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	special RestoreMusic
	setevent EVENT_BEAT_LASS_CARRIE
	end

CarrieToPlayerMovement:
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

LassCarrieBeatenText:
	text "Darn… I thought"
	line "you were weak…"
	done

TrainerLassBridget:
	faceplayer
	checkevent EVENT_BEAT_LASS_BRIDGET
	iftrue .AfterBattleText
	special SaveMusic
	playmusic MUSIC_LASS_ENCOUNTER
	sjump TrainerLassBridgetBattle

.AfterBattleText:
	jumpthistext
		text "I'm trying to beat"
		line "Whitney, but…"
		cont "It's depressing."

		para "I'm okay! If I"
		line "lose, I'll just"
		cont "try harder next"
		cont "time!"
		done

TrainerLassBridgetCheck:
	checkevent EVENT_BEAT_LASS_BRIDGET
	iftrue_end
	special SaveMusic
	playmusic MUSIC_LASS_ENCOUNTER
	showemote EMOTE_SHOCK, GOLDENRODGYM_LASS2, 30
	turnobject PLAYER, LEFT
	; fallthrough

TrainerLassBridgetBattle:
	showthistext
		text "I like cute #-"
		line "mon better than"
		cont "strong #mon."

		para "But I have strong"
		line "and cute #mon!"
		done
	winlosstext LassBridgetBeatenText, 0
	readvar VAR_BADGES
	ifgreater 7, .EightBadges
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer LASS, BRIDGET1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer LASS, BRIDGET2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer LASS, BRIDGET3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer LASS, BRIDGET4
	sjump .StartBattle
.EightBadges:
	loadtrainer LASS, BRIDGET5
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	special RestoreMusic
	setevent EVENT_BEAT_LASS_BRIDGET
	end

LassBridgetBeatenText:
	text "Oh, no, no, no!"
	done

TrainerBeautyVictoria:
	faceplayer
	checkevent EVENT_BEAT_BEAUTY_VICTORIA
	iftrue .AfterBattleText
	special SaveMusic
	playmusic MUSIC_BEAUTY_ENCOUNTER
	sjump TrainerBeautyVictoriaBattle

.AfterBattleText:
	jumpthistext
		text "Wow, you must be"
		line "good to beat me!"
		
		para "Keep it up!"
		done

TrainerBeautyVictoriaCheck1:
	checkevent EVENT_BEAT_BEAUTY_VICTORIA
	iftrue_end
	special SaveMusic
	playmusic MUSIC_BEAUTY_ENCOUNTER
	showemote EMOTE_SHOCK, GOLDENRODGYM_BEAUTY1, 30
	applymovement GOLDENRODGYM_BEAUTY1, VictoriaToPlayerMovement1
	turnobject PLAYER, UP
	sjump TrainerBeautyVictoriaBattle

VictoriaToPlayerMovement1:
	step DOWN
	step_end

TrainerBeautyVictoriaCheck2:
	checkevent EVENT_BEAT_BEAUTY_VICTORIA
	iftrue_end
	special SaveMusic
	playmusic MUSIC_BEAUTY_ENCOUNTER
	showemote EMOTE_SHOCK, GOLDENRODGYM_BEAUTY1, 30
	turnobject PLAYER, UP
	; fallthrough

TrainerBeautyVictoriaBattle:
	showthistext
		text "Oh, you are a cute"
		line "little trainer! "

		para "I like you, but I"
		line "won't hold back!"
		done
	winlosstext BeautyVictoriaBeatenText, 0
	readvar VAR_BADGES
	ifgreater 7, .EightBadges
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer BEAUTY, VICTORIA1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer BEAUTY, VICTORIA2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer BEAUTY, VICTORIA3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer BEAUTY, VICTORIA4
	sjump .StartBattle
.EightBadges:
	loadtrainer BEAUTY, VICTORIA5
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	special RestoreMusic
	setevent EVENT_BEAT_BEAUTY_VICTORIA
	end

BeautyVictoriaBeatenText:
	text "Let's see… Oops,"
	line "it's over?"
	done

TrainerBeautySamantha:
	faceplayer
	checkevent EVENT_BEAT_BEAUTY_SAMANTHA
	iftrue .AfterBattleText
	special SaveMusic
	playmusic MUSIC_BEAUTY_ENCOUNTER
	sjump TrainerBeautySamanthaBattle

.AfterBattleText:
	jumpthistext
		text "I taught #mon"
		line "moves for taking"
		cont "on any type…"
		done

TrainerBeautySamanthaCheck1:
	checkevent EVENT_BEAT_BEAUTY_SAMANTHA
	iftrue_end
	special SaveMusic
	playmusic MUSIC_BEAUTY_ENCOUNTER
	showemote EMOTE_SHOCK, GOLDENRODGYM_BEAUTY2, 30
	applymovement GOLDENRODGYM_BEAUTY2, SamanthaToPlayerMovement1
	turnobject PLAYER, UP
	sjump TrainerBeautySamanthaBattle

SamanthaToPlayerMovement1:
	step DOWN
	step_end

TrainerBeautySamanthaCheck2:
	checkevent EVENT_BEAT_BEAUTY_SAMANTHA
	iftrue_end
	special SaveMusic
	playmusic MUSIC_BEAUTY_ENCOUNTER
	showemote EMOTE_SHOCK, GOLDENRODGYM_BEAUTY2, 30
	turnobject PLAYER, UP
	; fallthrough

TrainerBeautySamanthaBattle:
	showthistext
		text "Give it your best"
		line "shot, or I'll take"
		cont "you down!"
		done
	winlosstext BeautySamanthaBeatenText, 0
	readvar VAR_BADGES
	ifgreater 7, .EightBadges
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer BEAUTY, SAMANTHA1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer BEAUTY, SAMANTHA2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer BEAUTY, SAMANTHA3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer BEAUTY, SAMANTHA4
	sjump .StartBattle
.EightBadges:
	loadtrainer BEAUTY, SAMANTHA5
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	special RestoreMusic
	setevent EVENT_BEAT_BEAUTY_SAMANTHA
	end

BeautySamanthaBeatenText:
	text "No! Oh, my poor"
	line "#mon!"
	done

GoldenrodGymGuideScript:
	checkevent EVENT_PLAYER_IS_THE_POKEMON_LEAGUE_CHAMPION
	iftrue_jumptextfaceplayer .GoldenrodGymGuideChampText
	checkevent EVENT_BEAT_WHITNEY
	iftrue_jumptextfaceplayer .GoldenrodGymGuideWinText
	jumpthistextfaceplayer
		text "Yo! Champ in"
		line "making!"

		para "This Gym uses the"
		line "normal and fairy"
		cont "types."

		para "They cover each-"
		line "other's weaknesses"
		cont "somewhat."

		para "I recommend you"
		line "use fighting and"
		cont "poison-type #-"
		cont "mon with liberal"
		cont "switching."
		done

.GoldenrodGymGuideWinText
		text "You won? Great! I"
		line "was busy admiring"
		cont "the ladies here."
		done

.GoldenrodGymGuideChampText
		text "Yo Champ!"

		para "Here to check out"
		line "the ladies too?"
		done

GoldenrodGymStatue:
	checkflag ENGINE_PLAINBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, WHITNEY, WHITNEY1
	jumpstd GymStatue2Script

GoldenrodGymHPUpScript:
	disappear LAST_TALKED
	opentext
	giveitem HP_UP, 5
	iffalse GoldenrodGymPlayersPackIsFull
	jumpthisopenedtext
		text "<PLAYER> got"
		line "5× HP Ups!@"
		sound_item
		text_end

GoldenrodGymPlayersPackIsFull:
	appear GOLDENRODGYM_POKE_BALL
	jumpstd ItemPocketIsFullScript
