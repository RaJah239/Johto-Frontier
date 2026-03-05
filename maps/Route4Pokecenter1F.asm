Route4Pokecenter1F_MapEvents:
	def_warp_events
	warp_event  3,  7, ROUTE_4, 1
	warp_event  4,  7, ROUTE_4, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	heal_event  3,  1, PAL_NPC_AZURE
	chansey_event  4,  1
	object_event  1,  4, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route4Pokecenter1FFishingGuruScript, -1
	object_event  6,  2, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route4Pokecenter1FCooltrainerFText, -1

	object_const_def
	const ROUTE4POKECENTER1F_NURSE
	const ROUTE4POKECENTER1F_CHANSEY
	const ROUTE4POKECENTER1F_FISHING_GURU
	const ROUTE4POKECENTER1F_COOLTRAINER_F


Route4Pokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks

Route4Pokecenter1FFishingGuruScript:
	faceplayeropentext
	checkevent EVENT_GOT_OLD_ROD
	iftrue .GotOldRod
	writethistext
		text "This is a great"
		line "fishing spot."

		para "You saw people"
		line "fishing? How about"
		cont "you?"

		para "Would you like one"
		line "of my Rods?"
		done
	yesorno
	iffalse .Refused
	writethistext
		text "Heh, that's good"
		line "to hear."

		para "Now you're an"
		line "angler too!"
		done
	promptbutton
	verbosegiveitem OLD_ROD
	setevent EVENT_GOT_OLD_ROD
	jumpthisopenedtext
		text "Fishing is great!"

		para "If there's water,"
		line "be it the sea or a"
		cont "stream, try out"
		cont "your Rod."
		done

.Refused:
	jumpthisopenedtext
		text "Oh. That's rather"
		line "disappointing…"
		done

.GotOldRod:
	jumpthisopenedtext
		text "Yo, kid. How are"
		line "they biting?"
		done

Route4Pokecenter1FCooltrainerFText:
	text "What should I make"
	line "my #mon hold?"

	para "Maybe an item that"
	line "increases Attack"
	cont "power…"
	done
