AzaleaGym_MapEvents:
	def_warp_events
	warp_event  4, 15, AZALEA_TOWN, 5
	warp_event  5, 15, AZALEA_TOWN, 5

	def_coord_events
	coord_event  4, 11, SCENE_AZALEAGYM_NOOP, TrainerTwinsAmyandmay1Check
	coord_event  5, 11, SCENE_AZALEAGYM_NOOP, TrainerTwinsAmyandmay2Check
	coord_event  0,  3, SCENE_AZALEAGYM_NOOP, TrainerBugCatcherJoshCheck1
	coord_event  0,  4, SCENE_AZALEAGYM_NOOP, TrainerBugCatcherJoshCheck2
	coord_event  0,  5, SCENE_AZALEAGYM_NOOP, TrainerBugCatcherJoshCheck3
	coord_event  4,  3, SCENE_AZALEAGYM_NOOP, TrainerBugCatcherBennyCheck
	coord_event  8,  9, SCENE_AZALEAGYM_NOOP, TrainerBugCatcherAlCheck1
	coord_event  8, 10, SCENE_AZALEAGYM_NOOP, TrainerBugCatcherAlCheck2
	coord_event  8, 11, SCENE_AZALEAGYM_NOOP, TrainerBugCatcherAlCheck3

	def_bg_events
	bg_event  3, 13, BGEVENT_READ, AzaleaGymStatue
	bg_event  6, 13, BGEVENT_READ, AzaleaGymStatue

	def_object_events
	object_event  5,  7, SPRITE_BUGSY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, AzaleaGymBugsyScript, -1
	object_event  5,  3, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, TrainerBugCatcherBenny, -1
	object_event  8,  8, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, TrainerBugCatcherAl, -1
	object_event  0,  2, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, TrainerBugCatcherJosh, -1
	object_event  4, 10, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, TrainerTwinsAmyandmay1, -1
	object_event  5, 10, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, TrainerTwinsAmyandmay2, -1
	object_event  7, 13, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, AzaleaGymGuideScript, -1
	object_event  4, 14, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaGymNuggetScript, EVENT_AZALEA_GYM_SIX_NUGGETS

	object_const_def
	const AZALEAGYM_BUGSY
	const AZALEAGYM_BUG_CATCHER1
	const AZALEAGYM_BUG_CATCHER2
	const AZALEAGYM_BUG_CATCHER3
	const AZALEAGYM_TWIN1
	const AZALEAGYM_TWIN2
	const AZALEAGYM_GYM_GUIDE
	const AZALEAGYM_POKE_BALL

AzaleaGym_MapScripts:
	def_scene_scripts
	scene_script AzaleaGymNoopScene, SCENE_AZALEAGYM_NOOP

	def_callbacks
	callback MAPCALLBACK_NEWMAP, ResetAzaleaGymTrainersCallback

AzaleaGymNoopScene:
	end

ResetAzaleaGymTrainersCallback:
	checkevent EVENT_PLAYER_IS_THE_POKEMON_LEAGUE_CHAMPION
	iftrue .ResetTrainers
	checkevent EVENT_BEAT_BUGSY
	iffalse .ResetTrainers
	endcallback
.ResetTrainers
	clearevent EVENT_BEAT_TWINS_AMY_AND_MAY
	clearevent EVENT_BEAT_BUG_CATCHER_BENNY
	clearevent EVENT_BEAT_BUG_CATCHER_AL
	clearevent EVENT_BEAT_BUG_CATCHER_JOSH
	endcallback

AzaleaGymBugsyScript:
	faceplayeropentext
	checkevent EVENT_PLAYER_IS_THE_POKEMON_LEAGUE_CHAMPION
	iftrue .BugsyRematch
	checkevent EVENT_BEAT_BUGSY
	iftrue .GymBadgeBattleDone
	writethistext
		text "I'm Bugsy!"
		line "I never lose when"
		cont "it comes to bug"
		cont "#mon."

		para "My research is"
		line "going to make me"
		cont "the authority on"
		cont "bug #mon!"

		para "Let me demonstrate"
		line "what I've learned"
		cont "from my studies."
		done
	waitclosetext
	winlosstext BugsyLossText, 0
	readvar VAR_BADGES
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer BUGSY, BUGSY1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer BUGSY, BUGSY2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer BUGSY, BUGSY3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer BUGSY, BUGSY4
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	playmusic MUSIC_GYM
	setevent EVENT_BEAT_BUGSY
	opentext
	writethistext
		text "<PLAYER> received"
		line "Hivebadge."
		done
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_HIVEBADGE
.GymBadgeBattleDone:
	checkevent EVENT_GOT_AZALEA_GYM_TM
	iftrue .SpeechAfterTM
	writethistext
		text "Here, I also want"
		line "you to have this."
		done
	promptbutton
	verbosegiveitem TM_MUD_SLAP
	iffalse_endtext
	setevent EVENT_GOT_AZALEA_GYM_TM
	jumpthisopenedtext
		text "TODOTEXT"
		line "about this TM."
		done
.SpeechAfterTM:
	jumpthisopenedtext
		text "Bug #mon are"
		line "deep. There are"
		cont "many mysteries to"
		cont "be explored."

		para "Study your favor-"
		line "ites thoroughly"
		cont "and let's meet up"
		cont "again to share our"
		cont "discoveries."
		done

.BugsyRematch:
	writethistext
		text "Bugsy: Nice to see"
		line "you again <PLAY_G>!"
				
		para "The new Champ huh?"
		line "So you must be do-"
		cont "ing great."

		para "I'm doing great"
		line "too!"

		para "My research has" 
		line "taken me through"
		cont "caves, crawling"
		cont "through bushes,"
		cont "waking late at"
		cont "nights to observe"
		cont "Bug #mon and"
		cont "much more!"
		
		para "Let me show you"
		line "what I've learned?"
		done
	yesorno
	iffalse_endtext
	writethistext
		text "Behold my Bug"
		line "#mon research!"
		done
	waitbutton
	winlosstext BugsyRematchLossText, 0
	loadtrainer BUGSY, BUGSY5 ; super boss team
	startbattle
	reloadmapafterbattle
	appear AZALEAGYM_POKE_BALL
	jumpthistext
		text "Bugsy: Amazing"
		line "<PLAY_G>!"
		
		para "Your journey must"
		line "taken you to a lot"
		cont "more places than"
		cont "my research!"
		done

BugsyLossText:
	text "Whoa, amazing!"
	line "You're an expert"
	cont "on #mon!"

	para "My research isn't"
	line "complete yet."

	para "OK, you win. Take"
	line "this Badge."
	done

BugsyRematchLossText:
	text "Aw, that's the"
	line "end of it…"
	done

TrainerTwinsAmyandmay1:
	jumpthistextfaceplayer
		text "Amy: You're"
		line "really strong!"
		done

TrainerTwinsAmyandmay1Check:
	checkevent EVENT_BEAT_TWINS_AMY_AND_MAY
	iftrue .End
	playmusic MUSIC_LASS_ENCOUNTER
	showemote EMOTE_SHOCK, AZALEAGYM_TWIN1, 30
	showthistext
		text "Amy: Hi! Are you"
		line "challenging the"
		cont "Leader? No way!"
		done
	winlosstext TwinsAmyandmay1BeatenText, 0
	sjump TwinsAmyAndMayBattle

.End
	end

TrainerTwinsAmyandmay2:
	jumpthistextfaceplayer
		text "May: Our bug #-"
		line "mon lost! Oh, what"
		cont "a shame."
		done

TrainerTwinsAmyandmay2Check:
	checkevent EVENT_BEAT_TWINS_AMY_AND_MAY
	iftrue .End
	playmusic MUSIC_LASS_ENCOUNTER
	showemote EMOTE_SHOCK, AZALEAGYM_TWIN2, 30
	showthistext
		text "May: You want to"
		line "see the Leader?"
		cont "We come first!"
		done
	winlosstext TwinsAmyandmay2BeatenText, 0
	sjump TwinsAmyAndMayBattle

.End
	end

TwinsAmyAndMayBattle:
	readvar VAR_BADGES
	ifgreater 7, .EightBadges
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.OneOrZeroBadges:
	loadtrainer TWINS, AMYANDMAY1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer TWINS, AMYANDMAY2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer TWINS, AMYANDMAY3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer TWINS, AMYANDMAY4
	sjump .StartBattle
.EightBadges:
	loadtrainer TWINS, AMYANDMAY5
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	playmusic MUSIC_GYM
	setevent EVENT_BEAT_TWINS_AMY_AND_MAY
	end

TwinsAmyandmay1BeatenText:
	text "Amy & May: Oh,"
	line "double goodness!"
	done

TwinsAmyandmay2BeatenText:
	text "Amy & May: Oh,"
	line "double goodness!"
	done

TrainerBugCatcherBenny:
	faceplayer
	checkevent EVENT_BEAT_BUG_CATCHER_BENNY
	iftrue .AfterBattleText
	playmusic MUSIC_YOUNGSTER_ENCOUNTER
	sjump BennyIntroAndBattle

.AfterBattleText:
	jumpthistext
		text "#mon become"
		line "stronger if they"
		cont "evolve. Really!"
		done

TrainerBugCatcherBennyCheck:
	checkevent EVENT_BEAT_BUG_CATCHER_BENNY
	iftrue .End
	playmusic MUSIC_YOUNGSTER_ENCOUNTER
	showemote EMOTE_SHOCK, AZALEAGYM_BUG_CATCHER1, 30
	turnobject PLAYER, RIGHT
	sjump BennyIntroAndBattle
.End
	end

BennyIntroAndBattle:
	showthistext
		text "Bug #mon evolve"
		line "young. So they get"
		cont "stronger that much"
		cont "faster."
		done
	winlosstext BugCatcherBennyBeatenText, 0
	readvar VAR_BADGES
	ifgreater 7, .EightBadges
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer BUG_CATCHER, BENNY1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer BUG_CATCHER, BENNY2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer BUG_CATCHER, BENNY3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer BUG_CATCHER, BENNY4
	sjump .StartBattle
.EightBadges:
	loadtrainer BUG_CATCHER, BENNY5
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	playmusic MUSIC_GYM
	setevent EVENT_BEAT_BUG_CATCHER_BENNY
	end

BugCatcherBennyBeatenText:
	text "Just evolving"
	line "isn't enough!"
	done

TrainerBugCatcherAl:
	faceplayer
	checkevent EVENT_BEAT_BUG_CATCHER_AL
	iftrue .AfterBattleText
	playmusic MUSIC_YOUNGSTER_ENCOUNTER
	sjump AlIntroAndBattle

.AfterBattleText:
	jumpthistext
		text "They're so cool,"
		line "but most girls"
		cont "don't like bug"
		cont "#mon."

		para "I don't know why…"
		done

TrainerBugCatcherAlCheck1:
	checkevent EVENT_BEAT_BUG_CATCHER_AL
	iftrue .End
	playmusic MUSIC_YOUNGSTER_ENCOUNTER
	showemote EMOTE_SHOCK, AZALEAGYM_BUG_CATCHER2, 30
	turnobject PLAYER, UP
	sjump AlIntroAndBattle
.End
	end

TrainerBugCatcherAlCheck2:
	checkevent EVENT_BEAT_BUG_CATCHER_AL
	iftrue .End
	playmusic MUSIC_YOUNGSTER_ENCOUNTER
	showemote EMOTE_SHOCK, AZALEAGYM_BUG_CATCHER2, 30
	applymovement AZALEAGYM_BUG_CATCHER2, AlToPlayerMovement1
	turnobject PLAYER, UP
	sjump AlIntroAndBattle
.End
	end

AlToPlayerMovement1:
	step DOWN
	step_end

TrainerBugCatcherAlCheck3:
	checkevent EVENT_BEAT_BUG_CATCHER_AL
	iftrue .End
	playmusic MUSIC_YOUNGSTER_ENCOUNTER
	showemote EMOTE_SHOCK, AZALEAGYM_BUG_CATCHER2, 30
	applymovement AZALEAGYM_BUG_CATCHER2, AlToPlayerMovement2
	turnobject PLAYER, UP
	sjump AlIntroAndBattle
.End
	end

AlToPlayerMovement2:
	step DOWN
	step DOWN
	step_end

AlIntroAndBattle:
	showthistext
		text "Bug #mon are"
		line "cool and tough!"
		cont "I'll prove it to"
		cont "you!"
		done
	winlosstext BugCatcherAlBeatenText, 0
	readvar VAR_BADGES
	ifgreater 7, .EightBadges
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer BUG_CATCHER, AL1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer BUG_CATCHER, AL2
	sjump .StartBattle
.FourOrFiveBadges
	loadtrainer BUG_CATCHER, AL3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer BUG_CATCHER, AL4
	sjump .StartBattle
.EightBadges:
	loadtrainer BUG_CATCHER, AL5
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	playmusic MUSIC_GYM
	setevent EVENT_BEAT_BUG_CATCHER_AL
	end

BugCatcherAlBeatenText:
	text "You proved how"
	line "tough you are…"
	done

TrainerBugCatcherJosh:
	faceplayer
	checkevent EVENT_BEAT_BUG_CATCHER_JOSH
	iftrue .AfterBattleText
	playmusic MUSIC_YOUNGSTER_ENCOUNTER
	sjump JoshIntroAndBattle

.AfterBattleText:
	jumpthistext
		text "I guess I should"
		line "teach them better"
		cont "moves…"
		done

TrainerBugCatcherJoshCheck1:
	checkevent EVENT_BEAT_BUG_CATCHER_JOSH
	iftrue .End
	playmusic MUSIC_YOUNGSTER_ENCOUNTER
	showemote EMOTE_SHOCK, AZALEAGYM_BUG_CATCHER3, 30
	turnobject PLAYER, UP
	sjump JoshIntroAndBattle
.End
	end

TrainerBugCatcherJoshCheck2:
	checkevent EVENT_BEAT_BUG_CATCHER_JOSH
	iftrue .End
	playmusic MUSIC_YOUNGSTER_ENCOUNTER
	showemote EMOTE_SHOCK, AZALEAGYM_BUG_CATCHER3, 30
	applymovement AZALEAGYM_BUG_CATCHER3, JoshToPlayerMovement1
	turnobject PLAYER, UP
	sjump JoshIntroAndBattle
.End
	end

JoshToPlayerMovement1:
	step DOWN
	step_end

TrainerBugCatcherJoshCheck3:
	checkevent EVENT_BEAT_BUG_CATCHER_JOSH
	iftrue .End
	playmusic MUSIC_YOUNGSTER_ENCOUNTER
	showemote EMOTE_SHOCK, AZALEAGYM_BUG_CATCHER3, 30
	applymovement AZALEAGYM_BUG_CATCHER3, JoshToPlayerMovement2
	turnobject PLAYER, UP
	sjump JoshIntroAndBattle
.End
	end

JoshToPlayerMovement2:
	step DOWN
	step DOWN
	step_end

JoshIntroAndBattle:
	showthistext
		text "My grown-up #-"
		line "-mon are tough!"
		done
	winlosstext BugCatcherJoshBeatenText, 0
	readvar VAR_BADGES
	ifgreater 7, .EightBadges
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer BUG_CATCHER, JOSH1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer BUG_CATCHER, JOSH2
	sjump .StartBattle
.FourOrFiveBadges
	loadtrainer BUG_CATCHER, JOSH3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer BUG_CATCHER, JOSH4
	sjump .StartBattle
.EightBadges:
	loadtrainer BUG_CATCHER, JOSH5
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	playmusic MUSIC_GYM
	setevent EVENT_BEAT_BUG_CATCHER_JOSH
	end

BugCatcherJoshBeatenText:
	text "Urrgggh!"
	done

AzaleaGymStatue:
	checkflag ENGINE_HIVEBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, BUGSY, BUGSY1
	jumpstd GymStatue2Script

AzaleaGymGuideScript:
	checkevent EVENT_PLAYER_IS_THE_POKEMON_LEAGUE_CHAMPION
	iftrue .AzaleaGymGuideChampScript
	checkevent EVENT_BEAT_BUGSY
	iftrue .AzaleaGymGuideWinScript
	jumpthistextfaceplayer
		text "Yo, challenger!"

		para "Bugsy's young, but"
		line "his knowledge of"
		cont "bug #mon is for"
		cont "real."

		para "Let's see… Bug"
		line "#mon don't like"
		cont "fire and rocks."

		para "Flying-type moves"
		line "are super-effec-"
		cont "tive too."

		para "Of course, he'll"
		line "try to cover their"
		cont "weaknesses too."
		done

.AzaleaGymGuideWinScript:
	jumpthistextfaceplayer
		text "Well done! That"
		line "was a great clash"
		cont "of talented young"
		cont "trainers."
		done

.AzaleaGymGuideChampScript:
	jumpthistextfaceplayer
		text "Hey Champ!"

		para "Back to squash"
		line "some bugs are you?"
		done

AzaleaGymNuggetScript:
	disappear LAST_TALKED
	opentext
	giveitem NUGGET, 6
	iffalse AzaleaGymPlayersPackIsFull
	jumpthisopenedtext
		text "<PLAYER> got"
		line "6× Nuggets!@"
		sound_item
		text_end

AzaleaGymPlayersPackIsFull:
	appear AZALEAGYM_POKE_BALL
	jumpthisopenedtext
		text "The Item Pocket"
		line "is full…"
		done
