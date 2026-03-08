DEF BLUE_CARD_POINT_CAP EQU 30

RadioTower2F_MapEvents:
	def_warp_events
	warp_event  0,  0, RADIO_TOWER_3F, 1
	warp_event 15,  0, RADIO_TOWER_1F, 3

	def_coord_events

	def_bg_events
	bg_event  3,  0, BGEVENT_JUMPTEXT, RadioTower2FSalesSignText
	bg_event  5,  0, BGEVENT_JUMPTEXT, RadioTower2FOaksPKMNTalkSignText
	bg_event  9,  1, BGEVENT_JUMPSTD, MAGAZINE_BOOKSHELF_SCRIPT
	bg_event 10,  1, BGEVENT_JUMPSTD, MAGAZINE_BOOKSHELF_SCRIPT
	bg_event 11,  1, BGEVENT_JUMPSTD, MAGAZINE_BOOKSHELF_SCRIPT
	bg_event 13,  0, BGEVENT_JUMPTEXT, RadioTower2FPokemonRadioSignText

	def_object_events
	object_event  6,  6, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, RadioTower2FSuperNerdText, -1
	object_event 17,  2, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, RadioTower2FTeacherText, -1
	object_event  1,  1, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, RadioTower2FBlackBelt2Text, -1
	object_event 12,  1, SPRITE_MARILL, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RadioTower2FMarillScript, -1
	object_event 14,  5, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BuenasScript, -1
	object_event 12,  7, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, RadioTowerBuenaPrizeReceptionistScript, -1

	object_const_def
	const RADIOTOWER2F_SUPER_NERD
	const RADIOTOWER2F_TEACHER
	const RADIOTOWER2F_BLACK_BELT
	const RADIOTOWER2F_JIGGLYPUFF
	const RADIOTOWER2F_BUENA
	const RADIOTOWER2F_RECEPTIONIST

RadioTower2F_MapScripts:
	def_scene_scripts

	def_callbacks

RadioTower2FSuperNerdText:
	text "You can listen to"
	line "the radio any-"
	cont "where. Tune in!"
	done

RadioTower2FTeacherText:
	text "Lullabies on the"
	line "radio may make"
	cont "#mon sleep."
	done

RadioTower2FBlackBelt2Text:
	text "Feel free to look"
	line "around anywhere."
	done

BuenasScript:
	faceplayeropentext
	checkevent EVENT_MET_BUENA
	iffalse .Introduction
	
	; always get the option to collect the 30x Sacred Ash
	; if the player has 30 points
	readvar VAR_BLUECARDBALANCE
	ifequal BLUE_CARD_POINT_CAP, .BlueCardCapped1
	
	checkflag ENGINE_BUENAS_PASSWORD_2
	iftrue .PlayedAlready
	readvar VAR_HOUR
	ifless EVE_HOUR, .TooEarly
	checkflag ENGINE_BUENAS_PASSWORD
	iffalse .TuneIn
	readvar VAR_BLUECARDBALANCE
	ifequal BLUE_CARD_POINT_CAP, .BlueCardCapped0
	playmusic MUSIC_BUENAS_PASSWORD
	writethistext
		text "Buena: Hi!"
		line "Did you tune in to"
		cont "my radio show?"

		para "Do you remember"
		line "today's password?"
		done
	special AskRememberPassword
	iffalse .ForgotPassword
	writethistext
		text "Buena: Oh, wow!"
		line "Thank you!"

		para "What was your name"
		line "again?"

		para "…<PLAY_G>, OK!"

		para "Come on, <PLAY_G>."
		line "Join the show."
		done
	waitclosetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	readvar VAR_FACING
	ifnotequal RIGHT, .DontNeedToMove
	applymovement PLAYER, RadioTower2FPlayerWalksToMicrophoneMovement
.DontNeedToMove:
	turnobject PLAYER, RIGHT
	showthistext
		text "Buena: Everyone"
		line "ready?"

		para "I want to hear you"
		line "shout out today's"
		cont "password for"
		cont "<PLAY_G>!"
		done
	turnobject RADIOTOWER2F_BUENA, DOWN
	reanchormap
	special BuenasPassword
	closetext
	iffalse .WrongAnswer
	showthistext
		text "Buena: Yippee!"
		line "That's right!"

		para "You did tune in!"
		line "I'm so happy!"

		para "You earned one"
		line "point! Congrats!"
		done
	readvar VAR_BLUECARDBALANCE
	addval 1
	writevar VAR_BLUECARDBALANCE
	waitsfx
	playsound SFX_TRANSACTION
	setflag ENGINE_BUENAS_PASSWORD_2
	pause 10
	turnobject RADIOTOWER2F_BUENA, RIGHT
	opentext
	writetext RadioTower2FBuenaThanksForComingText
	waitclosetext
	special FadeOutMusic
	pause 10
	special RestartMapMusic
	readvar VAR_BLUECARDBALANCE
	ifequal BLUE_CARD_POINT_CAP, .BlueCardCapped1
	end

.Introduction:
	writethistext
		text "Buena: Hi! I'm"
		line "Buena!"

		para "Do you know about"
		line "a radio program"
		cont "called Password?"

		para "If you can tell me"
		line "the password from"
		cont "the program, you"
		cont "will earn points."

		para "Save up those"
		line "points and trade"
		cont "them to that sweet"
		cont "young lady over"
		cont "there for some"
		cont "choice prizes!"

		para "Here you go!"

		para "It's your very own"
		line "point card!"
		done
	promptbutton
	setevent EVENT_MET_BUENA
	verbosegiveitem BLUE_CARD
.TuneIn:
	writethistext
		text "Buena: Tune in to"
		line "my Password Show!"
		done
	waitclosetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	end

.ForgotPassword:
	writethistext
		text "Buena: Come back"
		line "after you listen"
		cont "to my show, OK?"

		para "Catch ya later!"
		done
	waitclosetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	special FadeOutMusic
	pause 10
	special RestartMapMusic
	end

.PlayedAlready:
	writethistext
		text "Buena: Sorry…"

		para "You get just one"
		line "chance each day."

		para "Come back tomorrow"
		line "for another try!"
		done
	waitclosetext
	pause 10
	turnobject RADIOTOWER2F_BUENA, RIGHT
	end

.WrongAnswer:
	setflag ENGINE_BUENAS_PASSWORD_2
	showthistext
		text "Buena: Aww…"
		line "That's not it…"

		para "Did you forget the"
		line "password?"
		done
	turnobject RADIOTOWER2F_BUENA, RIGHT
	pause 10
	opentext
	writetext RadioTower2FBuenaThanksForComingText
	waitclosetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	special FadeOutMusic
	pause 20
	special RestartMapMusic
	turnobject RADIOTOWER2F_BUENA, RIGHT
	end

.BlueCardCapped0:
	writethistext
		text "Buena: Your Blue"
		line "Card's full."

		para "Trade it in for a"
		line "fabulous prize!"
		done
	waitclosetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	end

.TooEarly:
	writethistext
		text "Buena: Tune in to"
		line "Password every"
		cont "night from five"
		cont "to midnight!"

		para "Tune in, then drop"
		line "in for a visit!"
		done
	waitclosetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	end

.BlueCardCapped1:
	pause 10
	turnobject RADIOTOWER2F_BUENA, DOWN
	pause 10
	turnobject PLAYER, UP
	pause 10
	showemote EMOTE_SHOCK, RADIOTOWER2F_BUENA, 10
	opentext
	writethistext
		text "Buena: Oh! Your"
		line "Blue Card reached"
		cont "{d:BLUE_CARD_POINT_CAP} points today!"
		cont "That's so wild!"

		para "Hmm… I'll give you"
		line "special prize!"

		para "How about trading"
		line "them all for"
		cont "30× Sacred Ash?"
		done
	yesorno
	iftrue .Give30SacredAsh
	writethistext
		text "Sure, no problem!"
		line "Maybe next time?"
		done
	waitclosetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	end

.Give30SacredAsh:
	giveitem SACRED_ASH, 30
	iffalse Script_YourPackIsStuffedFullTrainer
	readvar VAR_BLUECARDBALANCE
	addval -30
	writetext PlayerGotThirtySacredAsh
	writethistext
		text "A rainbow colored"
		line "#mon sometimes"
		cont "fly over this city"
		cont "and drop these."

		para "I still have a lot"
		line "so you can trade"
		cont "30 points in the"
		cont "future again if"
		cont "you want more."
		
		para "See you around!"
		done
	waitclosetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	end

RadioTower2FPlayerWalksToMicrophoneMovement:
	slow_step DOWN
	slow_step RIGHT
	step_end

RadioTower2FBuenaThanksForComingText:
	text "Buena: Yup! Our"
	line "contestant was"
	cont "<PLAY_G>."
	cont "Thanks for coming!"

	para "I hope all you"
	line "listeners will"
	cont "come too!"
	cont "I'll be waiting!"
	done

Script_YourPackIsStuffedFullTrainer:
	writethistext
		text "Oops, your pocket"
		line "is full."
		done
	waitclosetext
	turnobject RADIOTOWER2F_BUENA, RIGHT
	end

PlayerGotThirtySacredAsh:
	text "<PLAYER> got"
	line "30× Sacred Ash!@"
	sound_item
	text_promptbutton
	text_end

RadioTowerBuenaPrizeReceptionistScript:
	faceplayeropentext
	checkitem BLUE_CARD
	iffalse .NoCard
	writethistext
		text "You can cash in"
		line "your saved points"
		cont "for a lovely prize"
		cont "of your choice!"
		done
	promptbutton
	special BuenaPrize
	endtext

.NoCard:
	jumpthisopenedtext
		text "You can't trade in"
		line "points without"
		cont "your Blue Card."

		para "Talk to Buena to"
		line "be given one."
		done

RadioTower2FMarillScript:
	setval MARILL
	special SetMonAsSeen
	isfieldactionssettoquick
	iftrue .skipthis
	reanchormap
	pokepic MARILL
	cry MARILL
	waitbutton
	closepokepic
.skipthis
	jumpthistext
		text "Marill: Rill rill!"
		done

RadioTower2FSalesSignText:
	text "2F Sales"
	done

RadioTower2FOaksPKMNTalkSignText:
	text "Prof.Oak's #mon"
	line "Talk"

	para "The Hottest Show"
	line "on the Air!"
	done

RadioTower2FPokemonRadioSignText:
	text "Anywhere, Anytime"
	line "#mon Radio"
	done
