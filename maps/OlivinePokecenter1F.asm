OlivinePokecenter1F_MapEvents:
	def_warp_events
	warp_event  3,  7, OLIVINE_CITY, 1
	warp_event  4,  7, OLIVINE_CITY, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	heal_event  3,  1, PAL_NPC_BLUE
	chansey_event  4,  1
	object_event  8,  4, SPRITE_FISHING_GURU, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivinePokecenter1FFishingGuruScript, -1
	object_event  2,  3, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivinePokecenter1FFisherText, -1
	object_event  7,  1, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivinePokecenter1FTeacherText, -1

	object_const_def
	const OLIVINEPOKECENTER1F_CHANSEY
	const OLIVINEPOKECENTER1F_NURSE
	const OLIVINEPOKECENTER1F_FISHING_GURU
	const OLIVINEPOKECENTER1F_FISHER
	const OLIVINEPOKECENTER1F_TEACHER

OlivinePokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks

OlivinePokecenter1FFishingGuruScript:
	jumpstd HappinessCheckScript

OlivinePokecenter1FFisherText:
	text "The sailor in the"
	line "Olivine Cafe next"
	cont "door is really"
	cont "generous."

	para "He gave me a"
	line "Donphan Call."

	para "Now I can move"
	line "big boulders."
	done

OlivinePokecenter1FTeacherText:
	text "You look like you"
	line "have a lot of rare"
	cont "#mon."
	done
