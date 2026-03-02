CherrygroveGymSpeechHouse_MapEvents:
	def_warp_events
	warp_event  2,  7, CHERRYGROVE_CITY, 3
	warp_event  3,  7, CHERRYGROVE_CITY, 3

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_JUMPSTD, MAGAZINE_BOOKSHELF_SCRIPT
	bg_event  1,  1, BGEVENT_JUMPSTD, MAGAZINE_BOOKSHELF_SCRIPT

	def_object_events
	object_event  2,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CherrygroveGymSpeechHousePokefanMScript, -1
	object_event  5,  5, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CherrygroveGymSpeechHouseBugCatcherText, -1

	object_const_def
	const CHERRYGROVEGYMSPEECHHOUSE_POKEFAN_M
	const CHERRYGROVEGYMSPEECHHOUSE_BUG_CATCHER

CherrygroveGymSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks

CherrygroveGymSpeechHousePokefanMScript:
	faceplayeropentext
	checkevent EVENT_CHERRYGROVE_SACRED_ASH
	iftrue_jumpopenedtext .JourneyAndGrowth
	readvar VAR_BADGES
	ifgreater NUM_JOHTO_BADGES - 1, .AllEightBadges
	jumpthisopenedtext 
		text "You're trying to"
		line "see how good you"
		cont "are as a #mon"
		cont "trainer?"

		para "If you gather all"
		line "8 Gym badges, I'll"
		cont "give you something"
		cont "for your trouble."
		done

.AllEightBadges:
	writethistext
		text "Congratulations on"
		line "collecting all Gym"
		cont "badges."

		para "Have this!"
		done
	promptbutton
	verbosegiveitem SACRED_ASH
	iffalse_endtext
	setevent EVENT_CHERRYGROVE_SACRED_ASH
	jumpthisopenedtext
		text "That'll surely be"
		line "useful to you!"
		done

.JourneyAndGrowth:
	text "Journey and growth"
	line "go hand in hand."
	done

CherrygroveGymSpeechHouseBugCatcherText:
	text "Gym Leaders are"
	line "cool!"

	para "I want to be one"
	line "when I grow up."
	done
