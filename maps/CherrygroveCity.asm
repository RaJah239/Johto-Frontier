CherrygroveCity_MapEvents:
	def_warp_events
	warp_event 29,  3, CHERRYGROVE_POKECENTER_1F, 1
	warp_event 23,  3, CHERRYGROVE_MART, 2
	warp_event 17,  7, CHERRYGROVE_GYM_SPEECH_HOUSE, 1
	warp_event 25,  9, GUIDE_GENTS_HOUSE, 1
	warp_event 31, 11, CHERRYGROVE_EVOLUTION_SPEECH_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 30,  8, BGEVENT_JUMPTEXT, CherrygroveCitySignText
	bg_event 23,  9, BGEVENT_JUMPTEXT, GuideGentsHouseSignText
	bg_event 24,  3, BGEVENT_JUMPSTD, MART_SIGN_SCRIPT
	bg_event 30,  3, BGEVENT_JUMPSTD, POKECENTER_SIGN_SCRIPT

	def_object_events
	object_event 32,  6, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CherrygroveCityGuideGent, EVENT_GUIDE_GENT_IN_HIS_HOUSE
	object_event 27, 12, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CherrygroveTeacherScript, -1
	object_event 23,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CherrygroveYoungsterText, -1
	object_event  7, 12, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, MysticWaterGuy, -1

	object_const_def
	const CHERRYGROVECITY_GRAMPS
	const CHERRYGROVECITY_TEACHER
	const CHERRYGROVECITY_YOUNGSTER
	const CHERRYGROVECITY_FISHER

CherrygroveCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, CherrygroveCityFlypointCallback

CherrygroveCityFlypointCallback:
	setflag ENGINE_FLYPOINT_CHERRYGROVE
	endcallback

CherrygroveCityGuideGent:
	faceplayeropentext
	writetextcheckdialogue GuideGentIntroText, GuideGentIntroTextMin
	yesorno
	iffalse .No
	writethistext
		text "OK, then!"
		line "Follow me!"
		done
	waitclosetext
	playmusic MUSIC_SHOW_ME_AROUND
	follow CHERRYGROVECITY_GRAMPS, PLAYER
	applymovement CHERRYGROVECITY_GRAMPS, GuideGentMovement1
	opentext
	writetextcheckdialogue GuideGentPokecenterText, GuideGentPokecenterTextMin
	waitclosetext
	applymovement CHERRYGROVECITY_GRAMPS, GuideGentMovement2
	turnobject PLAYER, UP
	opentext
	writetextcheckdialogue GuideGentMartText, GuideGentMartTextMin
	waitclosetext
	applymovement CHERRYGROVECITY_GRAMPS, GuideGentMovement3
	turnobject PLAYER, UP
	opentext
	writetextcheckdialogue GuideGentRoute2Text, GuideGentRoute2TextMin
	waitclosetext
	applymovement CHERRYGROVECITY_GRAMPS, GuideGentMovement4
	turnobject PLAYER, LEFT
	opentext
	writetextcheckdialogue GuideGentSeaText, GuideGentSeaTextMin
	waitclosetext
	applymovement CHERRYGROVECITY_GRAMPS, GuideGentMovement5
	turnobject PLAYER, UP
	pause 15
	turnobject CHERRYGROVECITY_GRAMPS, LEFT
	turnobject PLAYER, RIGHT
	opentext
	writetextcheckdialogue GuideGentGiftText, GuideGentGiftTextMin
	promptbutton
	getstring STRING_BUFFER_4, .mapcardname
	scall .JumpstdReceiveItem
	setflag ENGINE_MAP_CARD
	writethistext
		text "<PLAYER>'s #GEAR"
		line "now has a MAP!"
		done
	promptbutton
	writetextcheckdialogue GuideGentPokegearText, GuideGentPokegearTextMin
	waitclosetext
	stopfollow
	special RestartMapMusic
	turnobject PLAYER, UP
	applymovement CHERRYGROVECITY_GRAMPS, GuideGentMovement6
	playsound SFX_ENTER_DOOR
	disappear CHERRYGROVECITY_GRAMPS
	clearevent EVENT_GUIDE_GENT_VISIBLE_IN_CHERRYGROVE
	waitsfx
	end

.JumpstdReceiveItem:
	jumpstd ReceiveItemScript

.mapcardname
	db "Map Card@"

.No:
	jumpthisopenedtext
	text "Oh… It's something"
	line "I enjoy doing…"

	para "Fine. Come see me"
	line "when you like."
	done

GuideGentMovement1:
	step LEFT
	step LEFT
	step UP
	step LEFT
	turn_head UP
	step_end

GuideGentMovement2:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	turn_head UP
	step_end

GuideGentMovement3:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	turn_head UP
	step_end

GuideGentMovement4:
	step LEFT
	step LEFT
	step LEFT
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	step DOWN
	turn_head LEFT
	step_end

GuideGentMovement5:
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head UP
	step_end

GuideGentMovement6:
	step UP
	step UP
	step_end

GuideGentIntroText:
	text "You're a rookie"
	line "trainer, aren't"
	cont "you? I can tell!"

	para "That's OK! Every-"
	line "one is a rookie"
	cont "at some point!"

	para "If you'd like, I"
	line "can teach you a"
	cont "few things."
	done

GuideGentIntroTextMin:
	text "Give the trainer"
	line "basics tour?"
	done

GuideGentPokecenterText:
	text "This is a #mon"
	line "Center. They heal"
	cont "your #mon in no"
	cont "time at all."

	para "You'll be relying"
	line "on them a lot, so"
	cont "you better learn"
	cont "about them."
	done

GuideGentPokecenterTextMin:
	text "Heal in #mon"
	line "Center."
	done

GuideGentMartText:
	text "This is a #mon"
	line "Mart."

	para "They sell balls"
	line "for catching wild"
	cont "#mon and other"
	cont "useful items."
	done

GuideGentMartTextMin:
	text "Buy items and more"
	line "in Marts."
	done

GuideGentRoute2Text:
	text "Route 2 is out"
	line "this way."

	para "Trainers will be"
	line "battling their"
	cont "prized #mon"
	cont "there."
	done

GuideGentRoute2TextMin:
	text "Exit this way."
	done

GuideGentSeaText:
	text "This is the sea,"
	line "as you can see."

	para "Some #mon are"
	line "found only in"
	cont "water."
	done

GuideGentSeaTextMin:
	text "#mon can be"
	line "found in the sea."
	done

GuideGentGiftText:
	text "Here…"

	para "It's my house!"
	line "Thanks for your"
	cont "company."

	para "Let me give you a"
	line "small gift."
	done

GuideGentGiftTextMin:
	text "A gift!"
	done

GuideGentPokegearText:
	text "#Gear can fit"
	line "a Radio Card too."

	para "I wish you luck on"
	line "your journey!"
	done

GuideGentPokegearTextMin:
	text "#Gear can fit"
	line "a Radio Card too."
	done

CherrygroveTeacherScript:
	checkflag ENGINE_MAP_CARD
	iftrue_jumptextfaceplayer .HaveMapCard
	jumpthistextfaceplayer
	text "Did you talk to"
	line "the old man by the"
	cont "#mon Center?"

	para "He'll put a map of"
	line "Johto on your"
	cont "#Gear."
	done

.HaveMapCard:
	text "When you're with"
	line "#mon, going"
	cont "anywhere is fun."
	done

MysticWaterGuy:
	checkevent EVENT_GOT_MYSTIC_WATER_IN_CHERRYGROVE
	iftrue_jumptextfaceplayer .GotMysticWater
	faceplayeropentext
	writethistext
		text "A #mon I caught"
		line "had an item."

		para "I think it's"
		line "Mystic Water."

		para "I don't need it,"
		line "so do you want it?"
		done
	promptbutton
	verbosegiveitem MYSTIC_WATER
	iffalse_endtext
	setevent EVENT_GOT_MYSTIC_WATER_IN_CHERRYGROVE
	jumpthisopenedtext
.GotMysticWater
		text "Back to fishing"
		line "for me, then."
		done

CherrygroveYoungsterText:
	text "I battled the"
	line "trainers on the"
	cont "road."

	para "My #mon lost."
	line "They're a mess! I"
	cont "must take them to"
	cont "a #mon Center."
	done

CherrygroveCitySignText:
	text "Cherrygrove City"

	para "The City of Cute,"
	line "Fragrant Flowers"
	done

GuideGentsHouseSignText:
	text "Guide Gent's House"
	done
