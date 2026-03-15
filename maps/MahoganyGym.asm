MahoganyGym_MapEvents:
	def_warp_events
	warp_event  4, 17, MAHOGANY_TOWN, 4
	warp_event  5, 17, MAHOGANY_TOWN, 4

	def_coord_events
	coord_event  9, 16, SCENE_MAHOGANY_GYM_NOOP, TrainerSkierRoxanneCheck
	coord_event  3, 13, SCENE_MAHOGANY_GYM_NOOP, TrainerSkierClarissaCheck
	coord_event  5, 10, SCENE_MAHOGANY_GYM_NOOP, TrainerBoarderRonaldCheck
	coord_event  2,  5, SCENE_MAHOGANY_GYM_NOOP, TrainerBoarderDouglasCheck

	def_bg_events
	bg_event  3, 15, BGEVENT_READ, MahoganyGymStatue
	bg_event  6, 15, BGEVENT_READ, MahoganyGymStatue

	def_object_events
	object_event  5,  3, SPRITE_PRYCE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, MahoganyGymPryceScript, -1
	object_event  9, 17, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, TrainerSkierRoxanne, -1
	object_event  5,  9, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, TrainerBoarderRonald, -1
	object_event  2, 13, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, TrainerSkierClarissa, -1
	object_event  2,  4, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, TrainerBoarderDouglas, -1
	object_event  7, 15, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, MahoganyGymGuideScript, -1
	object_event  4, 16, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyGymZincScript, EVENT_MAHOGANY_GYM_FIVE_ZINCS

	object_const_def
	const MAHOGANYGYM_PRYCE
	const MAHOGANYGYM_BEAUTY1
	const MAHOGANYGYM_ROCKER1
	const MAHOGANYGYM_BEAUTY2
	const MAHOGANYGYM_ROCKER2
	const MAHOGANYGYM_GYM_GUIDE
	const MAHOGANYGYM_POKE_BALL

MahoganyGym_MapScripts:
	def_scene_scripts
	scene_script MahoganyGymNoopScene, SCENE_MAHOGANY_GYM_NOOP

	def_callbacks
    callback MAPCALLBACK_NEWMAP, ResetMahoganyGymTrainersCallback

MahoganyGymNoopScene:
	end

ResetMahoganyGymTrainersCallback:
	checkevent EVENT_PLAYER_IS_THE_POKEMON_LEAGUE_CHAMPION
	iftrue .ResetTrainers
	checkevent EVENT_BEAT_PRYCE
	iffalse .ResetTrainers
	endcallback
.ResetTrainers
	clearevent EVENT_BEAT_SKIER_ROXANNE
	clearevent EVENT_BEAT_SKIER_CLARISSA
	clearevent EVENT_BEAT_BOARDER_RONALD
	clearevent EVENT_BEAT_BOARDER_DOUGLAS
	endcallback

MahoganyGymPryceScript:
	faceplayeropentext
	checkevent EVENT_PLAYER_IS_THE_POKEMON_LEAGUE_CHAMPION
	iftrue .PryceRematch
	checkevent EVENT_BEAT_PRYCE
	iftrue .GymBadgeBattleDone
	writethistext
		text "#mon have many"
		line "experiences in"
		cont "their lives, just "
		cont "like we do. "

		para "I, too, have seen"
		line "and suffered much"
		cont "in my life."

		para "Since I am your"
		line "elder, let me show"
		cont "you what I mean."

		para "I have been with"
		line "#mon since"
		cont "before you were"
		cont "born."

		para "I do not lose"
		line "easily."

		para "I, Pryce--the"
		line "winter trainer--"
		cont "shall demonstrate"
		cont "my power!"
		done
	waitclosetext
	winlosstext PryceLossText, 0
	readvar VAR_BADGES
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer PRYCE, PRYCE1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer PRYCE, PRYCE2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer PRYCE, PRYCE3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer PRYCE, PRYCE4
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	playmusic MUSIC_GYM
	setevent EVENT_BEAT_PRYCE
	opentext
	writethistext
		text "<PLAYER> received"
		line "Glacierbadge."
		done
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_GLACIERBADGE
.GymBadgeBattleDone:
	checkevent EVENT_GOT_MAHOGANY_GYM_TM
	iftrue .SpeechAfterTM
	writethistext
		text "This is a gift"
		line "from me!"
		done
	promptbutton
	verbosegiveitem TM_ICY_WIND
	iffalse_endtext
	setevent EVENT_GOT_MAHOGANY_GYM_TM
	jumpthisopenedtext
		text "That TM contains"
		line "Icy Wind."

		para "It inflicts damage"
		line "and lowers speed."

		para "It demonstrates"
		line "the harshness of"
		cont "winter."
		done

.SpeechAfterTM:
	jumpthisopenedtext
		text "When the ice and"
		line "snow melt, spring"
		cont "arrives."

		para "You and your #-"
		line "mon will be to-"
		cont "gether for many"
		cont "years to come."

		para "Cherish your time"
		line "together!"
		done

.PryceRematch:
	writethistext
		text "Pryce: Ah, it's"
		line "good to see you"
		cont "again <PLAYER>."
		
		para "I've heard of your"
		line "victories."
		
		para "I knew you had"
		line "potential, but"
		cont "for someone this"
		cont "young to become"
		cont "champion?"
		
		para "Experience is what"
		line "counts, however!"

		para "As your elder,"
		line "allow me to"
		cont "demonstrate!"
		done
	yesorno
	iffalse_endtext
	writethistext
		text "No words needed."

		para "Let our battle"
		line "speak for us."
		done
	waitbutton
	winlosstext PryceRematchLossText, 0
	loadtrainer PRYCE, PRYCE5 ; super boss team
	startbattle
	reloadmapafterbattle
	clearevent EVENT_BEAT_SKIER_ROXANNE
	clearevent EVENT_BEAT_SKIER_CLARISSA
	clearevent EVENT_BEAT_BOARDER_RONALD
	clearevent EVENT_BEAT_BOARDER_DOUGLAS
	appear MAHOGANYGYM_POKE_BALL
	showthistext
		text "Pryce: Impressive!"
		line "Truly impressive!"

		para "As your elder, I,"
		line "Pryce, ackowledge"
		cont "you <PLAYER>!"
		done
	playsound SFX_WARP_TO
	special FadeOutPalettes
	waitsfx
	warp MAHOGANY_GYM, 4, 17
	end

PryceLossText:
	text "Ah, I am impressed"
	line "by your prowess."

	para "With your strong"
	line "will, I know you"
	cont "will overcome all"
	cont "life's obstacles."

	para "You are worthy of"
	line "this Badge!"
	done

PryceRematchLossText:
    text "I concede defeat."
	done

TrainerSkierRoxanne:
	faceplayer
	checkevent EVENT_BEAT_SKIER_ROXANNE
	iftrue .AfterBattleText
	playmusic MUSIC_BEAUTY_ENCOUNTER
	sjump RoxanneIntroAndBattle

.AfterBattleText:
	jumpthistext
	text "If you don't skate"
	line "with precision,"
	cont "you won't get far"
	cont "in this Gym."
	done

TrainerSkierRoxanneCheck:
	checkevent EVENT_BEAT_SKIER_ROXANNE
	iftrue .End
	playmusic MUSIC_BEAUTY_ENCOUNTER
	showemote EMOTE_SHOCK, MAHOGANYGYM_BEAUTY1, 30
	turnobject PLAYER, DOWN
	sjump RoxanneIntroAndBattle
.End
	end

RoxanneIntroAndBattle:
	showthistext
		text "To get to Pryce,"
		line "our Gym Leader,"
		cont "you need to think"
		cont "before you skate."
		done
	winlosstext SkierRoxanneBeatenText, 0
	readvar VAR_BADGES
	ifgreater 7, .EightBadges
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer SKIER, ROXANNE1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer SKIER, ROXANNE2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer SKIER, ROXANNE3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer SKIER, ROXANNE4
	sjump .StartBattle
.EightBadges:
	loadtrainer SKIER, ROXANNE5
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	playmusic MUSIC_GYM
	setevent EVENT_BEAT_SKIER_ROXANNE
	end

SkierRoxanneBeatenText:
	text "I wouldn't lose to"
	line "you in skiing!"
	done

TrainerSkierClarissa:
	faceplayer
	checkevent EVENT_BEAT_SKIER_CLARISSA
	iftrue .AfterBattleText
	playmusic MUSIC_BEAUTY_ENCOUNTER
	sjump ClarissaIntroAndBattle

.AfterBattleText:
	jumpthistext
		text "I shouldn't have"
		line "been bragging"
		cont "about my skiing…"
		done

TrainerSkierClarissaCheck:
	checkevent EVENT_BEAT_SKIER_CLARISSA
	iftrue .End
	playmusic MUSIC_BEAUTY_ENCOUNTER
	showemote EMOTE_SHOCK, MAHOGANYGYM_BEAUTY2, 30
	sjump ClarissaIntroAndBattle
.End
	end

ClarissaIntroAndBattle:
	showthistext
		text "Check out my"
		line "parallel turn!"
		done
	winlosstext SkierClarissaBeatenText, 0
	readvar VAR_BADGES
	ifgreater 7, .EightBadges
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer SKIER, CLARISSA1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer SKIER, CLARISSA2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer SKIER, CLARISSA3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer SKIER, CLARISSA4
	sjump .StartBattle
.EightBadges:
	loadtrainer SKIER, CLARISSA5
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	playmusic MUSIC_GYM
	setevent EVENT_BEAT_SKIER_CLARISSA
	end

SkierClarissaBeatenText:
	text "No! You made me"
	line "wipe out!"
	done

TrainerBoarderRonald:
	faceplayer
	checkevent EVENT_BEAT_BOARDER_RONALD
	iftrue .AfterBattleText
	playmusic MUSIC_HIKER_ENCOUNTER
	sjump RonaldIntroAndBattle

.AfterBattleText:
	jumpthistext
		text "Frostbites are can"
		line "make the migthiest"
		cont "special attackers"
		cont "look weak."
		done

TrainerBoarderRonaldCheck:
	checkevent EVENT_BEAT_BOARDER_RONALD
	iftrue .End
	playmusic MUSIC_HIKER_ENCOUNTER
	showemote EMOTE_SHOCK, MAHOGANYGYM_ROCKER1, 30
	sjump RonaldIntroAndBattle
.End
	end

RonaldIntroAndBattle:
	showthistext
		text "I'll frostbite"
		line "your #mon, so"
		cont "they can't do a"
		cont "thing!"
		done
	winlosstext BoarderRonaldBeatenText, 0
	readvar VAR_BADGES
	ifgreater 7, .EightBadges
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer BOARDER, RONALD1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer BOARDER, RONALD2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer BOARDER, RONALD3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer BOARDER, RONALD4
	sjump .StartBattle
.EightBadges:
	loadtrainer BOARDER, RONALD5
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	playmusic MUSIC_GYM
	setevent EVENT_BEAT_BOARDER_RONALD
	end

BoarderRonaldBeatenText:
	text "Darn. I couldn't"
	line "do a thing."
	done

TrainerBoarderDouglas:
	jumpthistext
		text "The secret behind"
		line "Pryce's power…"

		para "He meditates under"
		line "a waterfall daily"
		cont "to strengthen his"
		cont "mind and body."
		done

TrainerBoarderDouglasCheck:
	checkevent EVENT_BEAT_BOARDER_DOUGLAS
	iftrue .End
	playmusic MUSIC_HIKER_ENCOUNTER
	showemote EMOTE_SHOCK, MAHOGANYGYM_ROCKER2, 30
	showthistext
		text "I know Pryce's"
		line "secret."
		done
	winlosstext BoarderDouglasBeatenText, 0
	readvar VAR_BADGES
	ifgreater 7, .EightBadges
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer BOARDER, DOUGLAS1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer BOARDER, DOUGLAS2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer BOARDER, DOUGLAS3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer BOARDER, DOUGLAS4
	sjump .StartBattle
.EightBadges:
	loadtrainer BOARDER, DOUGLAS5
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	playmusic MUSIC_GYM
	setevent EVENT_BEAT_BOARDER_DOUGLAS
.End
	end

BoarderDouglasBeatenText:
	text "OK. I'll tell you"
	line "Pryce's secret."
	done

MahoganyGymGuideScript:
	checkevent EVENT_PLAYER_IS_THE_POKEMON_LEAGUE_CHAMPION
	iftrue .MahoganyGymGuideChampScript
	checkevent EVENT_BEAT_PRYCE
	iftrue .MahoganyGymGuideWinScript
	jumpthistextfaceplayer
		text "Pryce is a veteran"
		line "who has trained"
		cont "#mon for some"
		cont "50 years."

		para "He's said to be"
		line "good at frostbit-"
		cont "ing opponents with"
		cont "ice-type moves."

		para "That means you"
		line "should melt him"
		cont "with your burning"
		cont "ambition!"

		para "Rock, fighting and"
		line "and steel types"
		cont "also work well."
		done

.MahoganyGymGuideWinScript:
	jumpthistextfaceplayer
		text "Pryce is some-"
		line "thing, but you're"
		cont "something else!"

		para "That was a hot"
		line "battle that"
		cont "bridged the gen-"
		cont "eration gap!"
		done

.MahoganyGymGuideChampScript:
	jumpthistextfaceplayer
		text "Pryce'll be pleased"
		line "to see your rapid"
		cont "growth."
		done

MahoganyGymStatue:
	checkflag ENGINE_GLACIERBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, PRYCE, PRYCE1
	jumpstd GymStatue2Script

MahoganyGymZincScript:
	disappear LAST_TALKED
	opentext
	giveitem ZINC, 5
	iffalse MahoganyGymPlayersPackIsFull
	jumpthisopenedtext
		text "<PLAYER> got"
		line "5× Zincs!@"
		sound_item
		text_end

MahoganyGymPlayersPackIsFull:
	appear OLIVINEGYM_POKE_BALL
	jumpthisopenedtext
		text "The Item Pocket"
		line "is full…"
		done
