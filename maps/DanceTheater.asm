DanceTheater_MapEvents:
	def_warp_events
	warp_event  5, 13, ECRUTEAK_CITY, 8
	warp_event  6, 13, ECRUTEAK_CITY, 8

	def_coord_events

	def_bg_events
	bg_event  5,  6, BGEVENT_UP, DanceTheaterFancyPanel
	bg_event  6,  6, BGEVENT_UP, DanceTheaterFancyPanel

	def_object_events
	object_event  0,  2, SPRITE_KIMONO_GIRL, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 0, TrainerKimonoGirlNaoko, -1
	object_event  2,  1, SPRITE_KIMONO_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 0, TrainerKimonoGirlSayo, -1
	object_event  6,  2, SPRITE_KIMONO_GIRL, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 0, TrainerKimonoGirlZuki, -1
	object_event  9,  1, SPRITE_KIMONO_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 0, TrainerKimonoGirlKuni, -1
	object_event 11,  2, SPRITE_KIMONO_GIRL, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 0, TrainerKimonoGirlMiki, -1
	object_event  7, 10, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DanceTheaterSurfGuy, -1
	object_event 10, 10, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, DanceTheaterCooltrainerMText, -1
	object_event  3,  6, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, DanceTheaterGrannyText, -1
	object_event 10,  6, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, DanceTheaterTutorSurfScript, -1
	object_event  6,  8, SPRITE_RHYDON, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_GRAY, OBJECTTYPE_SCRIPT, 0, DanceTheaterRhydonScript, -1

	object_const_def
	const DANCETHEATER_KIMONO_GIRL1
	const DANCETHEATER_KIMONO_GIRL2
	const DANCETHEATER_KIMONO_GIRL3
	const DANCETHEATER_KIMONO_GIRL4
	const DANCETHEATER_KIMONO_GIRL5
	const DANCETHEATER_GENTLEMAN
	const DANCETHEATER_COOLTRAINER_M
	const DANCETHEATER_GRANNY
	const DANCETHEATER_SURF_TUTOR
	const DANCETHEATER_RHYDON

DanceTheater_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerKimonoGirlNaoko:
	generictrainer KIMONO_GIRL, NAOKO, EVENT_BEAT_KIMONO_GIRL_NAOKO, .SeenText, .BeatenText

.AfterText
	text "I enjoyed that"
	line "bout. I would like"
	cont "to see you again."
	done

.SeenText
	text "You have lovely"
	line "#mon. May I see"
	cont "them in battle?"
	done

.BeatenText
	text "Oh, you are very"
	line "strong."
	done

TrainerKimonoGirlSayo:
	generictrainer KIMONO_GIRL, SAYO, EVENT_BEAT_KIMONO_GIRL_SAYO, .SeenText, .BeatenText

.fterText
	text "Rhythm is impor-"
	line "tant for both"
	cont "dancing and #-"
	cont "mon."
	done

.SeenText
	text "I always dance"
	line "with my #mon."

	para "Of course, I also"
	line "train them."
	done

.BeatenText
	text "Oh, so close!"
	line "I almost had you."
	done

TrainerKimonoGirlZuki:
	generictrainer KIMONO_GIRL, ZUKI, EVENT_BEAT_KIMONO_GIRL_ZUKI, .SeenText, .BeatenText

.AfterText
	text "I put a different"
	line "flower in my bar-"
	cont "rette every month."
	done

.SeenText
	text "Isn't my barrette"
	line "pretty?"

	para "Oh. A #mon"
	line "battle?"
	done

.BeatenText
	text "I don't have any"
	line "#mon left…"
	done

TrainerKimonoGirlKuni:
	generictrainer KIMONO_GIRL, KUNI, EVENT_BEAT_KIMONO_GIRL_KUNI, .SeenText, .BeatenText

.AfterText
	text "I trained a lot,"
	line "so I thought I was"
	cont "a capable trainer."

	para "I guess I'm not."
	done

.SeenText
	text "Oh, you're a cute"
	line "trainer. Would you"
	cont "like to battle?"
	done

.BeatenText
	text "You're stronger"
	line "than you look."
	done

TrainerKimonoGirlMiki:
	generictrainer KIMONO_GIRL, MIKI, EVENT_BEAT_KIMONO_GIRL_MIKI, .SeenText, .BeatenText

.AfterText
	text "I can keep dancing"
	line "because there are"
	cont "people who enjoy"
	cont "what I do."

	para "My #mon keep my"
	line "spirits up too."
	done

.SeenText
	text "Do you like my"
	line "dancing? I'm good"
	cont "at #mon too."
	done

.BeatenText
	text "Ooh, you're good"
	line "at #mon too."
	done

DanceTheaterSurfGuy:
	faceplayeropentext
	writethistext
		text "Not only are the"
		line "Kimono Girls great"
		cont "dancers, they're"
		cont "also skilled at"
		cont "#mon."

		para "I always challenge"
		line "them, but I've"
		cont "never even left a"
		cont "scratch…"
		done
	promptbutton
	checkevent EVENT_GOT_LANTURN_CALL
	iftrue .SurfGuyAlreadyGaveSurf
	checkevent EVENT_BEAT_KIMONO_GIRL_NAOKO
	iffalse .KimonoGirlsUndefeated
	checkevent EVENT_BEAT_KIMONO_GIRL_SAYO
	iffalse .KimonoGirlsUndefeated
	checkevent EVENT_BEAT_KIMONO_GIRL_ZUKI
	iffalse .KimonoGirlsUndefeated
	checkevent EVENT_BEAT_KIMONO_GIRL_KUNI
	iffalse .KimonoGirlsUndefeated
	checkevent EVENT_BEAT_KIMONO_GIRL_MIKI
	iffalse .KimonoGirlsUndefeated
.GetSurf:
	writethistext
		text "The way you bat-"
		line "tled, it was like"
		cont "watching a dance."

		para "It was a rare"
		line "treat to see!"

		para "I want you to have"
		line "this. Don't worry"
		cont "--take it!"
		done
	promptbutton
	verbosegiveitem LANTURN_CALL
	setevent EVENT_GOT_LANTURN_CALL
	jumpthisopenedtext
		text "It's Lanturn Call!"

		para "It'll let you"
		line "traverse any body"
		cont "of water."
		done

.KimonoGirlsUndefeated:
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .PlayerIsFemale
	jumpthisopenedtext
		text "Lad! If you can"
		line "defeat all the"
		cont "Kimono Girls, I'll"
		cont "give you a gift."
		done

.PlayerIsFemale:
	jumpthisopenedtext
		text "Lassie, if you can"
		line "defeat all the"
		cont "Kimono Girls, I'll"
		cont "give you a gift."
		done

.SurfGuyAlreadyGaveSurf:
	jumpthisopenedtext
		text "I wish my #mon"
		line "were as elegant as"
		cont "the Kimono Girls…"
		done

DanceTheaterCooltrainerMText:
	text "That man's always"
	line "with his Rhydon."

	para "Says he wants a"
	line "#mon that can"
	cont "Surf and dance."

	para "Is he trying to"
	line "make a synchro-"
	cont "nized swimming"
	cont "#mon?"
	done

DanceTheaterGrannyText:
	text "The Kimono Girls"
	line "are so beautiful…"

	para "But they have to"
	line "go through rigor-"
	cont "ous training."

	para "And they have to"
	line "learn to follow"
	cont "customs before ap-"
	cont "pearing in public."

	para "But if you love"
	line "something, any-"
	cont "thing is possible."
	done

; TODOTEXT when I know what I want for here
DanceTheaterTutorSurfScript:
	faceplayer
	opentext
	writetext DanceTheaterTutorSurfText
	yesorno
	iffalse .TutorRefused
	setval SURF
	writetext DanceTheaterTutorSurfClear
	special MoveTutor
	ifequal FALSE, .TeachMove
.TutorRefused:
	writetext DanceTheaterTutorSurfRefused
	waitbutton
	closetext
	end

.TeachMove:
	writetext DanceTheaterTutorSurfTaught
	waitbutton
	closetext
	end

DanceTheaterTutorSurfText:
	text "Hello there!"
	line "Teach SURF?"
	done

DanceTheaterTutorSurfRefused:
	text "OK then."
	done

DanceTheaterTutorSurfClear:
	text_start
	done

DanceTheaterTutorSurfTaught:
	text "Ride the waves!"
	done

DanceTheaterFancyPanel:
	jumpthistext
		text "It's a fancy panel"
		line "that's decorated"
		cont "with flowers."
		done

DanceTheaterRhydonScript:
	setval RHYDON
	special SetMonAsSeen
	isfieldactionssettoquick
	iftrue .skipthis
	reanchormap
	pokepic RHYDON
	cry RHYDON
	waitbutton
	closepokepic
.skipthis
	jumpthistext
		text "Rhydon: Gugooh!"
		done
