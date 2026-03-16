EcruteakGym_MapEvents:
	def_warp_events
	warp_event  4, 17, ECRUTEAK_CITY, 10
	warp_event  5, 17, ECRUTEAK_CITY, 10
	warp_event  4, 14, ECRUTEAK_GYM, 4
	warp_event  2,  4, ECRUTEAK_GYM, 3
	warp_event  3,  4, ECRUTEAK_GYM, 3
	warp_event  4,  4, ECRUTEAK_GYM, 3
	warp_event  4,  5, ECRUTEAK_GYM, 3
	warp_event  7,  5, ECRUTEAK_GYM, 3
	warp_event  7,  4, ECRUTEAK_GYM, 3
	warp_event  2,  6, ECRUTEAK_GYM, 3
	warp_event  3,  6, ECRUTEAK_GYM, 3
	warp_event  4,  6, ECRUTEAK_GYM, 3
	warp_event  5,  6, ECRUTEAK_GYM, 3
	warp_event  7,  6, ECRUTEAK_GYM, 3
	warp_event  7,  7, ECRUTEAK_GYM, 3
	warp_event  4,  8, ECRUTEAK_GYM, 3
	warp_event  5,  8, ECRUTEAK_GYM, 3
	warp_event  6,  8, ECRUTEAK_GYM, 3
	warp_event  7,  8, ECRUTEAK_GYM, 3
	warp_event  2,  8, ECRUTEAK_GYM, 3
	warp_event  2,  9, ECRUTEAK_GYM, 3
	warp_event  2, 10, ECRUTEAK_GYM, 3
	warp_event  2, 11, ECRUTEAK_GYM, 3
	warp_event  4, 10, ECRUTEAK_GYM, 3
	warp_event  5, 10, ECRUTEAK_GYM, 3
	warp_event  2, 12, ECRUTEAK_GYM, 3
	warp_event  3, 12, ECRUTEAK_GYM, 3
	warp_event  4, 12, ECRUTEAK_GYM, 3
	warp_event  5, 12, ECRUTEAK_GYM, 3
	warp_event  7, 10, ECRUTEAK_GYM, 3
	warp_event  7, 11, ECRUTEAK_GYM, 3
	warp_event  7, 12, ECRUTEAK_GYM, 3
	warp_event  7, 13, ECRUTEAK_GYM, 3

	def_coord_events
	coord_event  4, 13, SCENE_ECRUTEAKGYM_NOOP, TrainerSagePingCheck1
	coord_event  5, 13, SCENE_ECRUTEAKGYM_NOOP, TrainerSagePingCheck2
	coord_event  6,  9, SCENE_ECRUTEAKGYM_NOOP, TrainerMediumGraceCheck
	coord_event  3,  7, SCENE_ECRUTEAKGYM_NOOP, TrainerSageJeffreyCheck
	coord_event  6,  5, SCENE_ECRUTEAKGYM_NOOP, TrainerMediumMarthaCheck

	def_bg_events
	bg_event  3, 15, BGEVENT_READ, EcruteakGymStatue
	bg_event  6, 15, BGEVENT_READ, EcruteakGymStatue

	def_object_events
	object_event  5,  1, SPRITE_MORTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, EcruteakGymMortyScript, -1
	object_event  2,  7, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, TrainerSageJeffrey, -1
	object_event  3, 13, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, TrainerSagePing, -1
	object_event  5,  5, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, TrainerMediumMartha, -1
	object_event  7,  9, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, TrainerMediumGrace, -1
	object_event  7, 15, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EcruteakGymGuideScript, -1
	object_event  4, 16, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakGymCalciumScript, EVENT_ECRUTEAK_GYM_FIVE_CALCIUMS

	object_const_def
	const ECRUTEAKGYM_MORTY
	const ECRUTEAKGYM_SAGE1
	const ECRUTEAKGYM_SAGE2
	const ECRUTEAKGYM_GRANNY1
	const ECRUTEAKGYM_GRANNY2
	const ECRUTEAKGYM_GYM_GUIDE
	const ECRUTEAKGYM_POKE_BALL

EcruteakGym_MapScripts:
	def_scene_scripts
	scene_script EcruteakGymNoopScene, SCENE_ECRUTEAKGYM_NOOP

	def_callbacks

EcruteakGymNoopScene:
	end

EcruteakGymMortyScript:
	faceplayeropentext
	checkevent EVENT_PLAYER_IS_THE_POKEMON_LEAGUE_CHAMPION
	iftrue .MortyRematch
	checkevent EVENT_BEAT_MORTY
	iftrue .GymBadgeBattleDone
	writethistext
		text "Good of you to"
		line "have come."

		para "Here in Ecruteak,"
		line "#mon have been"
		cont "revered."

		para "It's said that a"
		line "rainbow-colored"
		cont "#mon will come"
		cont "down to appear"
		cont "before a truly"
		cont "powerful trainer."

		para "I believed that"
		line "tale, so I have"
		cont "secretly trained"
		cont "here all my life."

		para "As a result, I can"
		line "now see what"
		cont "others cannot."

		para "Just a bit more…"

		para "With a little"
		line "more, I could see"
		cont "a future in which"
		cont "I meet the #mon"
		cont "of rainbow colors."

		para "You're going to"
		line "help me reach that"
		cont "level!"
		done
	waitclosetext
	winlosstext MortyLossText, 0
	readvar VAR_BADGES
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer MORTY, MORTY1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer MORTY, MORTY2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer MORTY, MORTY3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer MORTY, MORTY4
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_MORTY
	setevent EVENT_BEAT_MEDIUM_GRACE
	opentext
	writethistext
		text "<PLAYER> received"
		line "Fog Badge."
		done
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_FOGBADGE
.GymBadgeBattleDone:
	checkevent EVENT_GOT_ECRUTEAK_GYM_TM
	iftrue_jumpopenedtext .SpeechAfterTMText
	writethistext
		text "I want you to have"
		line "this."
		done
	promptbutton
	verbosegiveitem TM_SHADOW_BALL
	iffalse_endtext
	setevent EVENT_GOT_ECRUTEAK_GYM_TM
	jumpthisopenedtext
		text "It's Shadow Ball."
		line "It causes damage"
		cont "and may reduce"
		cont "Spcl.Def."

		para "Use it if it"
		line "appeals to you."
		done

.SpeechAfterTMText
		text "I see…"

		para "Your journey has"
		line "taken you to far-"
		cont "away places."

		para "And you have wit-"
		line "nessed much more"
		cont "than I."

		para "I envy you for"
		line "that…"
		done

.MortyRematch:
	writethistext
	    text "Morty: <PLAYER>, I"
		line "sense your growth."
	    
		para "I aim to match"
		line "Ho-Oh's virtue."
		
		para "And another bout"
		line "between us would"
		cont "beneficial!"
		
		para "Help me push my"
		line "training to the"
		cont "next level!"
		done 
	yesorno
	iffalse_endtext
	writethistext
	    text "Now witness my"
		line "evolution!"
		done
	waitclosetext
	winlosstext MortyRematchLossText, 0
	loadtrainer MORTY, MORTY5 ; super boss team
	startbattle
	reloadmapafterbattle
	clearevent EVENT_BEAT_SAGE_JEFFREY
	clearevent EVENT_BEAT_SAGE_PING
	clearevent EVENT_BEAT_MEDIUM_MARTHA
	clearevent EVENT_BEAT_MEDIUM_GRACE
	appear ECRUTEAKGYM_POKE_BALL
	showthistext
	    text "Morty: Lost again…"
		line "Maybe you've got"
		cont "more than just"
		cont "mere strength."
		done
	playsound SFX_WARP_TO
	special FadeOutPalettes
	waitsfx
	warp ECRUTEAK_GYM, 4, 17
	end

MortyLossText:
	text "I'm not good"
	line "enough yet…"

	para "All right. This"
	line "Badge is yours."
	done

MortyRematchLossText:
    text "How is this"
	line "possible…"
	done

TrainerSageJeffrey:
	jumpthistextfaceplayer
		text "Where did #mon"
		line "come from?"
		done

TrainerSageJeffreyCheck:
	checkevent EVENT_BEAT_SAGE_JEFFREY
	iftrue_end
	special SaveMusic
	playmusic MUSIC_SAGE_ENCOUNTER
	showemote EMOTE_SHOCK, ECRUTEAKGYM_SAGE1, 30
	turnobject PLAYER, LEFT
	showthistext
		text "I spent the spring"
		line "with my #mon."

		para "Then summer, fall"
		line "and winter…"

		para "Then spring came"
		line "again. We have"
		cont "lived together"
		cont "for a long time."
		done
	winlosstext SageJeffreyBeatenText, 0
	readvar VAR_BADGES
	ifgreater 7, .EightBadges
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer SAGE, JEFFREY1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer SAGE, JEFFREY2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer SAGE, JEFFREY3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer SAGE, JEFFREY4
	sjump .StartBattle
.EightBadges:
	loadtrainer SAGE, JEFFREY5
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	special RestoreMusic
	setevent EVENT_BEAT_SAGE_JEFFREY
	end

SageJeffreyBeatenText:
	text "Wins and losses, I"
	line "experienced both."
	done

TrainerSagePing:
	faceplayer
	checkevent EVENT_BEAT_SAGE_PING
	iftrue .AfterBattleText
	special SaveMusic
	playmusic MUSIC_SAGE_ENCOUNTER
	sjump TrainerSagePingBattle

.AfterBattleText:
	jumpthistext
		text "We use the ghost-"
		line "type #mon."

		para "No normal-type"
		line "attack can harm"
		cont "them but the re-"
		cont "verse is also"
		cont "true."
		done

TrainerSagePingCheck1:
	checkevent EVENT_BEAT_SAGE_PING
	iftrue_end
	special SaveMusic
	playmusic MUSIC_SAGE_ENCOUNTER
	showemote EMOTE_SHOCK, ECRUTEAKGYM_SAGE2, 30
	turnobject PLAYER, LEFT
	sjump TrainerSagePingBattle

PingToPlayerMovement1:
	step RIGHT
	step_end

TrainerSagePingCheck2:
	checkevent EVENT_BEAT_SAGE_PING
	iftrue_end
	special SaveMusic
	playmusic MUSIC_SAGE_ENCOUNTER
	showemote EMOTE_SHOCK, ECRUTEAKGYM_SAGE2, 30
	applymovement ECRUTEAKGYM_SAGE2, PingToPlayerMovement1
	turnobject PLAYER, LEFT
	; fallthrough

TrainerSagePingBattle:
	showthistext
		text "Can you inflict"
		line "any damage on our"
		cont "#mon?"
		done
	winlosstext SagePingBeatenText, 0
	readvar VAR_BADGES
	ifgreater 7, .EightBadges
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer SAGE, PING1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer SAGE, PING2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer SAGE, PING3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer SAGE, PING4
	sjump .StartBattle
.EightBadges:
	loadtrainer SAGE, PING5
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	special RestoreMusic
	setevent EVENT_BEAT_SAGE_PING
	end

SagePingBeatenText:
	text "Ah! Well done!"
	done

TrainerMediumMartha:
	jumpthistextfaceplayer
		text "The one who wants"
		line "to win most--will!"
		done

TrainerMediumMarthaCheck:
	checkevent EVENT_BEAT_MEDIUM_MARTHA
	iftrue_end
	special SaveMusic
	playmusic MUSIC_SAGE_ENCOUNTER
	showemote EMOTE_SHOCK, ECRUTEAKGYM_GRANNY1, 30
	turnobject PLAYER, LEFT
	showthistext
		text "I shall win!"
		done
	winlosstext MediumMarthaBeatenText, 0
	readvar VAR_BADGES
	ifgreater 7, .EightBadges
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer MEDIUM, MARTHA1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer MEDIUM, MARTHA2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer MEDIUM, MARTHA3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer MEDIUM, MARTHA4
	sjump .StartBattle
.EightBadges:
	loadtrainer MEDIUM, MARTHA5
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	special RestoreMusic
	setevent EVENT_BEAT_MEDIUM_MARTHA
	end

MediumMarthaBeatenText:
	text "I, I, I lost!"
	done

TrainerMediumGrace:
	jumpthistextfaceplayer
		text "Stay the course"
		line "and do not run"
		cont "from adversities!"
		done

TrainerMediumGraceCheck:
	checkevent EVENT_BEAT_MEDIUM_GRACE
	iftrue_end
	special SaveMusic
	playmusic MUSIC_SAGE_ENCOUNTER
	showemote EMOTE_SHOCK, ECRUTEAKGYM_GRANNY2, 30
	turnobject PLAYER, RIGHT
	showthistext
		text "You think I am"
		line "weak, do you?"
		done
	winlosstext MediumGraceBeatenText, 0
	readvar VAR_BADGES
	ifgreater 7, .EightBadges
	ifgreater 5, .SixOrSevenBadges
	ifgreater 3, .FourOrFiveBadges
	ifgreater 1, .TwoOrThreeBadges
.ZeroOrOneBadge:
	loadtrainer MEDIUM, GRACE1
	sjump .StartBattle
.TwoOrThreeBadges:
	loadtrainer MEDIUM, GRACE2
	sjump .StartBattle
.FourOrFiveBadges:
	loadtrainer MEDIUM, GRACE3
	sjump .StartBattle
.SixOrSevenBadges:
	loadtrainer MEDIUM, GRACE4
	sjump .StartBattle
.EightBadges:
	loadtrainer MEDIUM, GRACE5
	; fallthrough

.StartBattle:
	startbattle
	reloadmapafterbattle
	special RestoreMusic
	setevent EVENT_BEAT_MEDIUM_GRACE
	end

MediumGraceBeatenText:
	text "I may not be as"
	line "strong as I once"
	cont "was…"
	done

EcruteakGymGuideScript:
	checkevent EVENT_PLAYER_IS_THE_POKEMON_LEAGUE_CHAMPION
	iftrue_jumptextfaceplayer .EcruteakGymGuideChampText
	checkevent EVENT_BEAT_MORTY
	iftrue_jumptextfaceplayer .EcruteakGymGuideWinText
	jumpthistextfaceplayer
		text "Here is the home"
		line "of the ghost-type"
		cont "#mon."

		para "Dark types shine"
		line "here even though"
		cont "ghosts are also"
		cont "effective against"
		cont "ghosts."

		para "If you keep fall-"
		line "ing, trying walk-"
		cont "ing instead."
		done

.EcruteakGymGuideWinText
		text "Whew, <PLAYER>."
		line "You did great!"

		para "I was cowering in"
		line "the corner out of"
		cont "pure terror!"
		done

.EcruteakGymGuideChampText
		text "Did you come here"
		line "to put fear into"
		cont "ghosts, Champ?"
		done

EcruteakGymStatue:
	checkflag ENGINE_FOGBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, MORTY, MORTY1
	jumpstd GymStatue2Script

EcruteakGymCalciumScript:
	disappear LAST_TALKED
	opentext
	giveitem CALCIUM, 5
	iffalse EcruteakGymPlayersPackIsFull
	jumpthisopenedtext
		text "<PLAYER> got"
		line "5× Calciums!@"
		sound_item
		text_end

EcruteakGymPlayersPackIsFull:
	appear ECRUTEAKGYM_POKE_BALL
	jumpstd ItemPocketIsFullScript
