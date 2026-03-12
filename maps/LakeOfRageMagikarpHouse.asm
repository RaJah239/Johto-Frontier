LakeOfRageMagikarpHouse_MapEvents:
	def_warp_events
	warp_event  2,  7, LAKE_OF_RAGE, 1
	warp_event  3,  7, LAKE_OF_RAGE, 1

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT
	bg_event  1,  1, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT

	def_object_events
	chanseyheal_event  6,  4
	porygonpc_event 7,  5, PAL_NPC_RED
	object_event  2,  4, SPRITE_FISHING_GURU, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MagikarpLengthRaterScript, -1
	object_event  3,  4, SPRITE_POKEDEX, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MagikarpRecordScript, -1

	object_const_def
	const LAKEOFRAGEMAGIKARPHOUSE_CHANSEY
	const LAKEOFRAGEMAGIKARPHOUSE_PORYGON_PC
	const LAKEOFRAGEMAGIKARPHOUSE_FISHING_GURU

LakeOfRageMagikarpHouse_MapScripts:
	def_scene_scripts

	def_callbacks

MagikarpRecordScript:
	opentext
	special MagikarpHouseSign
	endtext

MagikarpLengthRaterScript:
	faceplayeropentext
	checkevent EVENT_LAKE_OF_RAGE_MASTER_BALL_ON_STANDBY
	iftrue .GetReward
	checkevent EVENT_LAKE_OF_RAGE_ASKED_FOR_MAGIKARP
	iftrue .AskedForMagikarp
	writethistext
		text "Lake Of Rage is"
		line "actually a crater"
		cont "made by rampaging"
		cont "Gyarados."

		para "The crater filled"
		line "up with rainwater"
		cont "and the Lake was"
		cont "formed."

		para "That's the story"
		line "passed on from my"
		cont "Grandpa's great-"
		cont "great-grandpa."
		done
	waitbutton
	setevent EVENT_LAKE_OF_RAGE_ASKED_FOR_MAGIKARP
.RemindPlayerToCatchMagikarps:
	jumpthisopenedtext
		text "The Magikarp are"
		line "swarming a lot"
		cont "these days!"

		para "I may yet realize"
		line "my dream of see-"
		cont "ing the world's"
		cont "largest Magikarp."

		para "Do you have a Rod?"
		
		para "Please help me if"
		line "you do."
		done

.AskedForMagikarp:
	setval MAGIKARP
	special FindPartyMonThatSpecies
	iffalse .RemindPlayerToCatchMagikarps
	writethistext
		text "Ah, you have a"
		line "Magikarp! Let's"
		cont "see how big that"
		cont "baby is."
		done
	waitbutton
	special CheckMagikarpLength
	ifequal MAGIKARPLENGTH_NOT_MAGIKARP, .NotMagikarp
	ifequal MAGIKARPLENGTH_REFUSED, .Refused
	ifequal MAGIKARPLENGTH_TOO_SHORT, .TooShort
	; MAGIKARPLENGTH_BEAT_RECORD
	; fallthrough

.GetReward:
	writethistext
		text "Wow! This one is"
		line "outstanding!"

		para "I tip my hat to"
		line "you!"

		para "Take this as a"
		line "memento!"
		done
	promptbutton
	verbosegiveitem MASTER_BALL
	setevent EVENT_LAKE_OF_RAGE_MASTER_BALL_ON_STANDBY
	iffalse_endtext
	clearevent EVENT_LAKE_OF_RAGE_MASTER_BALL_ON_STANDBY
	jumpthisopenedtext
		text "The record is the"
		line "important thing."

		para "Think of that as"
		line "a bonus!"
		done

.TooShort:
	jumpthisopenedtext
		text "Wow! This one is"
		line "outstanding!"

		para "…I wish I could"
		line "say that, but I've"
		cont "seen a bigger one"
		cont "before."
		done

.NotMagikarp:
	jumpthisopenedtext
		text "What? That's not a"
		line "Magikarp!"
		done

.Refused:
	jumpthisopenedtext
		text "Oh… So you didn't"
		line "get one good"
		cont "enough to show me?"
		cont "Maybe next time."
		done
