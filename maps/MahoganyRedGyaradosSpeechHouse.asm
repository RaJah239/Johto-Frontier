MahoganyRedGyaradosSpeechHouse_MapEvents:
	def_warp_events
	warp_event  2,  7, MAHOGANY_TOWN, 3
	warp_event  3,  7, MAHOGANY_TOWN, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, MahoganyRedGyaradosSpeechHouseBlackBeltText, -1
	object_event  6,  5, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, MahoganyRedGyaradosSpeechHouseTeacherText, -1

	object_const_def
	const MAHOGANYREDGYARADOSSPEECHHOUSE_BLACK_BELT
	const MAHOGANYREDGYARADOSSPEECHHOUSE_TEACHER

MahoganyRedGyaradosSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks

MahoganyRedGyaradosSpeechHouseBlackBeltText:
	text "TODOTEXT"
	done

MahoganyRedGyaradosSpeechHouseTeacherText:
	text "My favorite radio"
	line "program? I'd say"
	cont "#mon Music."
	done
