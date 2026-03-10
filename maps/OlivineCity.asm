OlivineCity_MapEvents:
	def_warp_events
	warp_event 13, 21, OLIVINE_POKECENTER_1F, 1
	warp_event 10, 11, OLIVINE_GYM, 1
	warp_event 25, 11, OLIVINE_TIMS_HOUSE, 1
	warp_event 29, 11, OLIVINE_PUNISHMENT_SPEECH_HOUSE, 1
	warp_event 13, 15, OLIVINE_GOOD_ROD_HOUSE, 1
	warp_event  7, 21, OLIVINE_CAFE, 1
	warp_event 19, 17, OLIVINE_MART, 1
	warp_event 29, 27, OLIVINE_LIGHTHOUSE_1F, 1
	warp_event 19, 27, OLIVINE_PORT_PASSAGE, 1
	warp_event 20, 27, OLIVINE_PORT_PASSAGE, 2

	def_coord_events

	def_bg_events
	bg_event 17, 11, BGEVENT_JUMPTEXT, OlivineCitySignText
	bg_event 20, 24, BGEVENT_JUMPTEXT, OlivineCityPortSignText
	bg_event  7, 11, BGEVENT_JUMPTEXT, OlivineGymSignText
	bg_event 30, 28, BGEVENT_JUMPTEXT, OlivineLighthouseSignText
	bg_event  3, 23, BGEVENT_JUMPTEXT, OlivineCityPowerPlantSignText
	bg_event 14, 21, BGEVENT_JUMPSTD, POKECENTER_SIGN_SCRIPT
	bg_event 20, 17, BGEVENT_JUMPSTD, MART_SIGN_SCRIPT

	def_object_events
	object_event 26, 27, SPRITE_SAILOR, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivineCitySailor1Text, -1
	object_event 20, 13, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, OlivineCityStandingYoungsterScript, -1
	object_event 17, 21, SPRITE_SAILOR, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivineCitySailor2Text, -1

	object_const_def
	const OLIVINECITY_SAILOR1
	const OLIVINECITY_STANDING_YOUNGSTER
	const OLIVINECITY_SAILOR2

OlivineCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, OlivineCityFlypointCallback

OlivineCityFlypointCallback:
	setflag ENGINE_FLYPOINT_OLIVINE
	endcallback

OlivineCityStandingYoungsterScript:
	random 2
	ifequal 0, .FiftyFifty
	jumpthistextfaceplayer
		text "That thing you"
		line "have--it's a #-"
		cont "Gear, right? Wow,"
		cont "that's cool."
		done

.FiftyFifty:
	jumpthistextfaceplayer
		text "Wow, you have a"
		line "#dex!"

		para "That is just so"
		line "awesome."
		done

OlivineCitySailor1Text:
	text "Dark roads are"
	line "dangerous at"
	cont "night."

	para "But in the pitch-"
	line "black of night,"
	cont "the sea is even"
	cont "more treacherous!"

	para "Without the beacon"
	line "of the Lighthouse"
	cont "to guide it, no"
	cont "ship can sail."
	done

OlivineCitySailor2Text:
	text "The sea is sweet!"

	para "Sunsets on the sea"
	line "are marvelous!"

	para "Sing with me! "
	line "Yo-ho! Blow the"
	cont "man down!…"
	done

OlivineCitySignText:
	text "Olivine City"

	para "The Port Closest"
	line "to Foreign Lands"
	done

OlivineCityPortSignText:
	text "Olivine Port"
	line "Fast Ship Pier"
	done

OlivineGymSignText:
	text "Olivine City"
	line "#mon Gym"
	cont "Leader: Jasmine"

	para "The Steel-Clad"
	line "Defense Girl"
	done

OlivineLighthouseSignText:
	text "Olivine Lighthouse"
	line "Also known as the"
	cont "Glitter Lighthouse"
	done

OlivineCityPowerPlantSignText:
	text "Power Plant Ahead"
	done
