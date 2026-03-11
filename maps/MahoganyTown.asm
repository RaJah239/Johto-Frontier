MahoganyTown_MapEvents:
	def_warp_events
	warp_event 15, 13, MAHOGANY_POKECENTER_1F, 1
	warp_event 11,  7, MAHOGANY_MART_1F, 1
	warp_event 17,  7, MAHOGANY_RED_GYARADOS_SPEECH_HOUSE, 1
	warp_event  6, 13, MAHOGANY_GYM, 1
	warp_event  9,  1, ROUTE_15_MAHOGANY_GATE, 3
	warp_event  3,  5, MAHOGANY_TRADE_BACK_KID_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event  3,  9, BGEVENT_JUMPTEXT, MahoganyTownSignText
	bg_event  9,  7, BGEVENT_JUMPTEXT, MahoganyTownRagecandybarSignText
	bg_event  3, 13, BGEVENT_JUMPTEXT, MahoganyGymSignText
	bg_event 16, 13, BGEVENT_JUMPSTD, POKECENTER_SIGN_SCRIPT
	bg_event  1,  5, BGEVENT_JUMPTEXT, MahoganyTradeBackKidSignText

	def_object_events
	object_event  6,  9, SPRITE_GRAMPS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, MahoganyTownGrampsText, -1
	object_event 12,  8, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, MahoganyTownLassText, -1

	object_const_def
	const MAHOGANYTOWN_GRAMPS
	const MAHOGANYTOWN_LASS

MahoganyTown_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, MahoganyTownFlypointCallback

MahoganyTownFlypointCallback:
	setflag ENGINE_FLYPOINT_MAHOGANY
	endcallback

MahoganyTownGrampsText:
	text "Are you off to see"
	line "the Gyarados ram-"
	cont "page at the Lake?"
	done

MahoganyTownLassText:
	text "Visit Grandma's"
	line "shop. She sells"

	para "stuff that nobody"
	line "else has."
	done

MahoganyTownSignText:
	text "Mahogany Town"

	para "Welcome to the"
	line "Home of the Ninja"
	done

MahoganyTownRagecandybarSignText:
	text "While visiting"
	line "Mahogany Town, try"
	cont "a Ragecandybar!"
	done

MahoganyGymSignText:
	text "Mahogany Town"
	line "#mon Gym"
	cont "Leader: Pryce"

	para "The Teacher of"
	line "Winter's Harshness"
	done

MahoganyTradeBackKidSignText:
	text "Tradeback Kid's"
	line "House"
	done
