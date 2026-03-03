CherrygrovePokecenter1F_MapEvents:
	def_warp_events
	warp_event  3,  7, CHERRYGROVE_CITY, 1
	warp_event  4,  7, CHERRYGROVE_CITY, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	heal_event  3,  1, PAL_NPC_PINK
	chansey_event  4,  1
	object_event  2,  3, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CherrygrovePokecenter1FFisherText, -1
	object_event  8,  6, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CherrygrovePokecenter1FGentlemanText, -1
	object_event  1,  6, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CherrygrovePokecenter1FTeacherText, -1

	object_const_def
	const CHERRYGROVEPOKECENTER1F_NURSE
	const CHERRYGROVEPOKECENTER1F_CHANSEY
	const CHERRYGROVEPOKECENTER1F_FISHER
	const CHERRYGROVEPOKECENTER1F_GENTLEMAN
	const CHERRYGROVEPOKECENTER1F_TEACHER

CherrygrovePokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks

CherrygrovePokecenter1FFisherText:
	text "It's great. I can"
	line "store any number"
	cont "of #mon, and"
	cont "it's all free."
	done

CherrygrovePokecenter1FGentlemanText:
	text "That PC is free"
	line "for any trainer"
	cont "to use."
	done

CherrygrovePokecenter1FTeacherText:
	text "The Communication"
	line "Center upstairs,"
	cont "was just built."

	para "I traded #mon"
	line "there already!"
	done
