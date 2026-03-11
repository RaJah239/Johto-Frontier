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
	object_event  5,  3, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CianwoodGymGuideScript, -1
	object_event  8,  6, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, CianwoodPokecenter1FSuperNerdText, -1

	object_const_def
	const CIANWOODPOKECENTER1F_NURSE
	const CIANWOODPOKECENTER1F_CHANSEY
	const CIANWOODPOKECENTER1F_LASS
	const CIANWOODPOKECENTER1F_GYM_GUIDE
	const CIANWOODPOKECENTER1F_SUPER_NERD

CianwoodPokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks

CianwoodGymGuideScript:
	checkevent EVENT_BEAT_CHUCK
	iftrue .CianwoodGymGuideWinScript
	jumpthistextfaceplayer
		text "The #mon Gym"
		line "trainers here are"
		cont "macho bullies."

		para "If I stick around,"
		line "they might come"
		cont "after me."

		para "Here's some ad-"
		line "vice: the Gym"
		cont "Leader uses the"
		cont "fighting-type."

		para "So you should"
		line "confound him with"
		cont "Psychic, Flying or"
		cont "Fairy #mon."

		para "Wipe out his #-"
		line "mon before they"
		cont "can use their"
		cont "physical strength."

		para "And those boulders"
		line "in the middle of"
		cont "the Gym?"

		para "If you don't move"
		line "them correctly,"
		cont "you won't reach"
		cont "the Gym Leader."

		para "If you get stuck,"
		line "go outside."
		done

.CianwoodGymGuideWinScript:
	jumpthistextfaceplayer
		text "<PLAYER>! You won!"
		line "I could tell by"
		cont "looking at you!"
		done

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
