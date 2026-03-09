EcruteakPokecenter1F_MapEvents:
	def_warp_events
	warp_event  3,  7, ECRUTEAK_CITY, 1
	warp_event  4,  7, ECRUTEAK_CITY, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	heal_event  3,  1, PAL_NPC_BROWN
	chansey_event  4,  1
	object_event  7,  6, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakPokecenter1FPokefanMText, -1
	object_event  1,  4, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakPokecenter1FCooltrainerFText, -1
	object_event  7,  1, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakPokecenter1FGymGuideText, -1

	object_const_def
	const ECRUTEAKPOKECENTER1F_NURSE
	const ECRUTEAKPOKECENTER1F_CHANSEY
	const ECRUTEAKPOKECENTER1F_POKEFAN_M
	const ECRUTEAKPOKECENTER1F_COOLTRAINER_F
	const ECRUTEAKPOKECENTER1F_GYM_GUIDE

EcruteakPokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks

EcruteakPokecenter1FPokefanMText:
	text "The way the Kimono"
	line "Girls dance is"
	cont "marvelous. Just"
	cont "like the way they"
	cont "use their #mon."
	done

EcruteakPokecenter1FCooltrainerFText:
	text "Morty, the Gym"
	line "Leader, is soooo"
	cont "cool."

	para "His #mon are"
	line "really tough too."
	done

EcruteakPokecenter1FGymGuideText:
	text "Lake Of Rage…"

	para "The appearance of"
	line "a Gyarados swarm…"

	para "It must be a sight"
	line "to behold!"
	done
