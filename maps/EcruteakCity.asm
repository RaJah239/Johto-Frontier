EcruteakCity_MapEvents:
	def_warp_events
	warp_event 23, 27, ECRUTEAK_POKECENTER_1F, 1
	warp_event 35, 26, ROUTE_14_ECRUTEAK_GATE, 1
	warp_event 35, 27, ROUTE_14_ECRUTEAK_GATE, 2
	warp_event 18, 11, ECRUTEAK_TIN_TOWER_ENTRANCE, 1
	warp_event 20,  2, WISE_TRIOS_ROOM, 1
	warp_event 20,  3, WISE_TRIOS_ROOM, 2
	warp_event  5, 21, ECRUTEAK_LUGIA_SPEECH_HOUSE, 1
	warp_event 23, 21, DANCE_THEATER, 1
	warp_event 29, 21, ECRUTEAK_MART, 2
	warp_event  6, 27, ECRUTEAK_GYM, 1
	warp_event 13, 27, ECRUTEAK_ITEMFINDER_HOUSE, 1
	warp_event 37,  7, TIN_TOWER_1F, 1
	warp_event  5,  5, BURNED_TOWER_1F, 1
	warp_event  0, 18, ROUTE_10_ECRUTEAK_GATE, 3
	warp_event  0, 19, ROUTE_10_ECRUTEAK_GATE, 4
	warp_event  5, 17, ECRUTEAK_BLACKSMITH_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 15, 21, BGEVENT_JUMPTEXT, EcruteakCitySignText
	bg_event 38, 10, BGEVENT_JUMPTEXT, TinTowerSignText
	bg_event  8, 28, BGEVENT_JUMPTEXT, EcruteakGymSignText
	bg_event 21, 21, BGEVENT_JUMPTEXT, EcruteakDanceTheaterSignText
	bg_event  2, 10, BGEVENT_JUMPTEXT, BurnedTowerSignText
	bg_event 24, 27, BGEVENT_JUMPSTD, POKECENTER_SIGN_SCRIPT
	bg_event 30, 21, BGEVENT_JUMPSTD, MART_SIGN_SCRIPT
	bg_event 23, 14, BGEVENT_ITEM + HYPER_POTION, EVENT_ECRUTEAK_CITY_HIDDEN_HYPER_POTION

	def_object_events
	object_event 18, 15, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakCityGramps1Text, -1
	object_event 20, 21, SPRITE_GRAMPS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakCityGramps2Text, -1
	object_event 21, 29, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakCityLass1Text, -1
	object_event  3,  9, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakCityLass2Script, -1
	object_event  9, 22, SPRITE_FISHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakCityFisherText, -1
	object_event 10, 14, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakCityYoungsterText, -1
	object_event  3,  7, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakCityGramps3Text, EVENT_ECRUTEAK_CITY_GRAMPS

	object_const_def
	const ECRUTEAKCITY_GRAMPS1
	const ECRUTEAKCITY_GRAMPS2
	const ECRUTEAKCITY_LASS1
	const ECRUTEAKCITY_LASS2
	const ECRUTEAKCITY_FISHER
	const ECRUTEAKCITY_YOUNGSTER
	const ECRUTEAKCITY_GRAMPS3

EcruteakCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, EcruteakCityFlypointCallback

EcruteakCityFlypointCallback:
	setflag ENGINE_FLYPOINT_ECRUTEAK
	endcallback

EcruteakCityLass2Script:
	checkevent EVENT_RELEASED_THE_BEASTS
	iftrue .ReleasedBeasts
	jumpthistextfaceplayer
		text "The tower that"
		line "used to be here…"

		para "My grandma told me"
		line "it used to be much"
		cont "taller."
		done

.ReleasedBeasts:
	jumpthistextfaceplayer
		text "Three big #mon"
		line "ran off in differ-"
		cont "ent directions."
		cont "What were they?"
		done

EcruteakCityGramps1Text:
	text "Ecruteak used to"
	line "have two towers:"
	cont "one each in the"
	cont "east and west."
	done

EcruteakCityGramps2Text:
	text "Ah, child."
	line "Have you learned"
	cont "to dance like the"
	cont "Kimono Girls?"

	para "If you go to their"
	line "Dance Theater, an"
	cont "odd old man will"
	cont "give you something"
	cont "nice, I hear."
	done

EcruteakCityLass1Text:
	text "I'm going to prac-"
	line "tice at the Dance"
	cont "Theater. Care to"
	cont "join me?"
	done

EcruteakCityFisherText:
	text "The #mon at"
	line "Olivine Lighthouse"
	cont "shines brigtly."

	para "Boats can safely"
	line "sail out to sea at"
	cont "night."
	done

EcruteakCityYoungsterText:
	text "I hear #mon are"
	line "rampaging at the"
	cont "Lake Of Rage. I'd"
	cont "like to see that."
	done

EcruteakCityGramps3Text:
	text "In the distant"
	line "past…"

	para "This tower burned"
	line "in a fire. Three"
	cont "nameless #mon"
	cont "perished in it."

	para "A rainbow-colored"
	line "#mon descended"
	cont "from the sky and"
	cont "resurrected them…"

	para "It's a legend that"
	line "has been passed"
	cont "down by Ecruteak"
	cont "Gym Leaders."

	para "Me?"

	para "I was a trainer"
	line "way back when."
	cont "Hohoho!"
	done

EcruteakCitySignText:
	text "Ecruteak City"
	line "A Historical City"

	para "Where the Past"
	line "Meets the Present"
	done

TinTowerSignText:
	text "Tin Tower"

	para "A legendary #-"
	line "mon is said to"
	cont "roost here."
	done

EcruteakGymSignText:
	text "Ecruteak City"
	line "#mon Gym"
	cont "Leader: Morty"

	para "The Mystic Seer of"
	line "the Future"
	done

EcruteakDanceTheaterSignText:
	text "Ecruteak Dance"
	line "Theater"
	done

BurnedTowerSignText:
	text "Burned Tower"

	para "It was destroyed"
	line "by a mysterious"
	cont "fire."

	para "Please stay away,"
	line "as it is unsafe."
	done
