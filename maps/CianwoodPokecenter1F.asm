CianwoodPokecenter1F_MapEvents:
	def_warp_events
	warp_event  3,  7, CIANWOOD_CITY, 1
	warp_event  4,  7, CIANWOOD_CITY, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	heal_event  3,  1, PAL_NPC_PURPLE
	chansey_event  4,  1
	object_event  1,  5, SPRITE_LASS, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CianwoodPokecenter1FLassText, -1
	object_event  8,  6, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, CianwoodPokecenter1FSuperNerdText, -1

	object_const_def
	const CIANWOODPOKECENTER1F_NURSE
	const CIANWOODPOKECENTER1F_CHANSEY
	const CIANWOODPOKECENTER1F_LASS
	const CIANWOODPOKECENTER1F_SUPER_NERD

CianwoodPokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks

CianwoodPokecenter1FLassText:
	text "Did you meet the"
	line "#maniac?"

	para "He's always brag-"
	line "ging about his"
	cont "rare #mon."
	done

CianwoodPokecenter1FSuperNerdText:
	text "I love showing off"
	line "the #mon that"
	cont "I've raised."
	cont "Don't you?"

	para "I'm going to get"
	line "into a bunch of"
	cont "battles, and show"
	cont "off my #mon!"
	done
