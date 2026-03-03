VioletNicknameSpeechHouse_MapEvents:
	def_warp_events
	warp_event  3,  7, VIOLET_CITY, 5
	warp_event  4,  7, VIOLET_CITY, 5

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, VioletNicknameSpeechHouseTeacherText, -1
	object_event  6,  4, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, VioletNicknameSpeechHouseLassText, -1
	object_event  5,  2, SPRITE_PIDGEY, SPRITEMOVEDATA_POKEMON, 1, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, VioletNicknameSpeechHouseBirdScript, -1

	object_const_def
	const VIOLETNICKNAMESPEECHHOUSE_TEACHER
	const VIOLETNICKNAMESPEECHHOUSE_LASS
	const VIOLETNICKNAMESPEECHHOUSE_PIDGEY

VioletNicknameSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks

VioletNicknameSpeechHouseBirdScript:
	setval PIDGEY
	special SetMonAsSeen
	reanchormap
	pokepic PIDGEY
	cry PIDGEY
	waitbutton
	closepokepic
	jumpthistext
		text "Strawberry: Pijji!"
		done

VioletNicknameSpeechHouseLassText:
	text "I call my Pidgey"
	line "Strawberry!"
	done

VioletNicknameSpeechHouseTeacherText:
	text "She uses the names"
	line "of her favorite"
	cont "things to eat."

	para "For the nicknames"
	line "she gives to her"
	cont "#mon, I mean."
	done
