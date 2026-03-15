OlivineGym_MapEvents:
	def_warp_events
	warp_event  4, 15, OLIVINE_CITY, 2
	warp_event  5, 15, OLIVINE_CITY, 2

	def_coord_events
	coord_event  4, 10, SCENE_OLIVINEGYM_NOOP, TrainerHikerRustyCheck1
	coord_event  5, 10, SCENE_OLIVINEGYM_NOOP, TrainerHikerRustyCheck2
	coord_event  5,  7, SCENE_OLIVINEGYM_NOOP, TrainerTeacherRavenCheck1
	coord_event  4,  7, SCENE_OLIVINEGYM_NOOP, TrainerTeacherRavenCheck2

	def_bg_events
	bg_event  3, 13, BGEVENT_READ, OlivineGymStatue
	bg_event  6, 13, BGEVENT_READ, OlivineGymStatue

	def_object_events
	object_event  5,  3, SPRITE_JASMINE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, OlivineGymJasmineScript, -1
	object_event  3, 10, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, TrainerHikerRusty, -1
	object_event  6,  7, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, TrainerTeacherRaven, -1
	object_event  7, 13, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, OlivineGymGuideScript, -1
	object_event  4, 14, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineGymIronScript, EVENT_OLIVINE_GYM_FIVE_IRONS

	object_const_def
	const OLIVINEGYM_JASMINE
	const OLIVINEGYM_HIKER
	const OLIVINEGYM_TEACHER
	const OLIVINEGYM_GYM_GUIDE
	const OLIVINEGYM_POKE_BALL

OlivineGym_MapScripts:
	def_scene_scripts
	scene_script OlivineGymNoopScene, SCENE_OLIVINEGYM_NOOP

	def_callbacks
    callback MAPCALLBACK_NEWMAP, ResetOlivineGymTrainersCallback

OlivineGymNoopScene:
	end

ResetOlivineGymTrainersCallback:
	checkevent EVENT_PLAYER_IS_THE_POKEMON_LEAGUE_CHAMPION
	iftrue .ResetTrainers
	checkevent EVENT_BEAT_JASMINE
	iffalse .ResetTrainers
	endcallback
.ResetTrainers
	clearevent EVENT_BEAT_HIKER_RUSTY
	clearevent EVENT_BEAT_TEACHER_RAVEN
	endcallback

OlivineGymJasmineScript:
	faceplayeropentext
	checkevent EVENT_PLAYER_IS_THE_POKEMON_LEAGUE_CHAMPION
	iftrue .JasmineRematch
	checkevent EVENT_BEAT_JASMINE
	iftrue .GymBadgeBattleDone
	writethistext
		text "Please allow me to"
		line "introduce myself."

		para "I am Jasmine, a"
		line "Gym Leader. I use"
		cont "the steel-type."

		para "They're known to"
		line "have many resist-"
		cont "ances and few"
		cont "counters."

		para "…Um… May I begin?"
		done
	waitclosetext
	winlosstext JasmineLossText, 0
	readvar VAR_BADGES
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer JASMINE, JASMINE1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer JASMINE, JASMINE2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer JASMINE, JASMINE3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer JASMINE, JASMINE4
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	playmusic MUSIC_GYM
	setevent EVENT_BEAT_JASMINE
	opentext
	writethistext
		text "<PLAYER> received"
		line "Mineralbadge."
		done
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_MINERALBADGE
.GymBadgeBattleDone:
	checkevent EVENT_GOT_OLIVINE_GYM_TM
	iftrue .SpeechAfterTM
	writethistext
		text "…Um… Please take"
		line "this too…"
		done
	promptbutton
	verbosegiveitem TM_SILVER_WIND
	iffalse_endtext
	setevent EVENT_GOT_OLIVINE_GYM_TM
	jumpthisopenedtext
		text "…You could use"
		line "that TM to teach"
		cont "TODOTEXT."
		done

.SpeechAfterTM:
	jumpthisopenedtext
		text "Um… I don't know"
		line "how to say this,"
		cont "but good luck…"
		done

.JasmineRematch:
	writethistext
		text "Jasmine: Um… hello"
		line "again…"
		
		para "I had more time to"
		line "train…"
		
		para "…Want a rematch?"
		done 
	yesorno
	iffalse_endtext
	writethistext
		text "…Thank you. May"
		line "we get started?"
		done
	waitbutton
	winlosstext JasmineRematchLossText, 0
	loadtrainer JASMINE, JASMINE5 ; super boss team
	startbattle
	reloadmapafterbattle
	clearevent EVENT_BEAT_HIKER_RUSTY
	clearevent EVENT_BEAT_TEACHER_RAVEN
	appear OLIVINEGYM_POKE_BALL
	showthistext
		text "Jasmine: True to"
		line "your reputation…"
		
		para "We'll have to try"
		line "much harder as"
		cont "well…"
		done 
	playsound SFX_WARP_TO
	special FadeOutPalettes
	waitsfx
	warp OLIVINE_GYM, 4, 15
	end

JasmineLossText:
	text "Victory belongs to"
	line "to you…"

	para "In accordance with"
	line "League rules, I"
	cont "confer upon you"
	cont "this Badge…"
	done

JasmineRematchLossText:
    text "Well done…"
	done

TrainerHikerRusty:
	faceplayer
	checkevent EVENT_BEAT_HIKER_RUSTY
	iftrue .AfterBattleText
	playmusic MUSIC_HIKER_ENCOUNTER
	sjump TrainerHikerRustyBattle

.AfterBattleText:
	jumpthistext
		text "Jasmine is quite"
		line "the trainer."

		para "I swapped to steel"
		line "#mon becaue of"
		cont "her."
		done

TrainerHikerRustyCheck1:
	checkevent EVENT_BEAT_HIKER_RUSTY
	iftrue .End
	sjump TrainerHikerRustyStart1
.End
	end

TrainerHikerRustyCheck2:
	checkevent EVENT_BEAT_HIKER_RUSTY
	iftrue .End
	sjump TrainerHikerRustyStart2
.End
	end

TrainerHikerRustyStart1:
	playmusic MUSIC_HIKER_ENCOUNTER
	showemote EMOTE_SHOCK, OLIVINEGYM_HIKER, 30
	turnobject PLAYER, LEFT
	sjump TrainerHikerRustyBattle

TrainerHikerRustyStart2:
	playmusic MUSIC_HIKER_ENCOUNTER
	showemote EMOTE_SHOCK, OLIVINEGYM_HIKER, 30
	applymovement OLIVINEGYM_HIKER, RustyToPlayerMovement
	turnobject PLAYER, LEFT
	; fallthrough

TrainerHikerRustyBattle:
	showthistext
		text "Hey! You're not"
		line "not getting to see"
		cont "Jasmine unless you"
		cont "get past me!"
		done
	winlosstext HikerRustyBeatenText, 0
	readvar VAR_BADGES
	ifgreater 7, .EightBadges
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer HIKER, RUSTY1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer HIKER, RUSTY2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer HIKER, RUSTY3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer HIKER, RUSTY4
	sjump .StartBattle
.EightBadges:
	loadtrainer HIKER, RUSTY5
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	playmusic MUSIC_GYM
	setevent EVENT_BEAT_HIKER_RUSTY
	end

RustyToPlayerMovement:
	step RIGHT
	step_end

HikerRustyBeatenText:
	text "Oh no! You got"
	line "past me!"
	done

TrainerTeacherRaven:
	faceplayer
	checkevent EVENT_BEAT_TEACHER_RAVEN
	iftrue .AfterBattleText
	playmusic MUSIC_BEAUTY_ENCOUNTER
	sjump TrainerTeacherRavenBattle

.AfterBattleText:
	jumpthistext
		text "I never leave home"
		line "without a Steel"
		cont "#mon."
		done

TrainerTeacherRavenCheck1:
	checkevent EVENT_BEAT_TEACHER_RAVEN
	iftrue .End
	sjump TrainerTeacherRavenStart1
.End
	end

TrainerTeacherRavenCheck2:
	checkevent EVENT_BEAT_TEACHER_RAVEN
	iftrue .End
	sjump TrainerTeacherRavenStart2
.End
	end

TrainerTeacherRavenStart1:
	playmusic MUSIC_BEAUTY_ENCOUNTER
	showemote EMOTE_SHOCK, OLIVINEGYM_TEACHER, 30
	turnobject PLAYER, RIGHT
	sjump TrainerTeacherRavenBattle

TrainerTeacherRavenStart2:
	playmusic MUSIC_BEAUTY_ENCOUNTER
	showemote EMOTE_SHOCK, OLIVINEGYM_TEACHER, 30
	applymovement OLIVINEGYM_TEACHER, RavenToPlayerMovement
	turnobject PLAYER, RIGHT
	; fallthrough

TrainerTeacherRavenBattle:
	showthistext
		text "Let me teach you"
		line "about the steel"
		cont "typing!"
		done
	winlosstext TeacherRavenBeatenText, 0
	readvar VAR_BADGES
	ifgreater 7, .EightBadges
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer TEACHER, RAVEN1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer TEACHER, RAVEN2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer TEACHER, RAVEN3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer TEACHER, RAVEN4
	sjump .StartBattle
.EightBadges:
	loadtrainer TEACHER, RAVEN5
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	playmusic MUSIC_GYM
	setevent EVENT_BEAT_TEACHER_RAVEN
	end

RavenToPlayerMovement:
	step LEFT
	step_end

TeacherRavenBeatenText:
	text "I was taught in-"
	line "stead!"
	done

OlivineGymGuideScript:
	checkevent EVENT_PLAYER_IS_THE_POKEMON_LEAGUE_CHAMPION
	iftrue .OlivineGymGuideChampScript
	checkevent EVENT_BEAT_JASMINE
	iftrue .OlivineGymGuideWinScript
	jumpthistextfaceplayer
		text "Jasmine uses the"
		line "steel-type."

		para "They're quite re-"
		line "sistant."
			
		para "Fire, fighting and"
		line "ground types work"
		cont "well agaisnt them."
		done

.OlivineGymGuideWinScript:
	jumpthistextfaceplayer
		text "That was awesome."

		para "You carved through"
		line "their defenses."
		done

.OlivineGymGuideChampScript:
	jumpthistextfaceplayer
		text "Hey Champ!"

		para "Are you going to"
		line "grace Jasmine with"
		cont "your presence?"
		done

OlivineGymStatue:
	checkflag ENGINE_MINERALBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, JASMINE, JASMINE1
	jumpstd GymStatue2Script

OlivineGymIronScript:
	disappear LAST_TALKED
	opentext
	giveitem IRON, 5
	iffalse OlivineGymPlayersPackIsFull
	jumpthisopenedtext
		text "<PLAYER> got"
		line "5× Irons!@"
		sound_item
		text_end

OlivineGymPlayersPackIsFull:
	appear OLIVINEGYM_POKE_BALL
	jumpthisopenedtext
		text "The Item Pocket"
		line "is full…"
		done
