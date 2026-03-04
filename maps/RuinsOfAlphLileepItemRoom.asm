RuinsOfAlphLileepItemRoom_MapEvents:
	def_warp_events
	warp_event  3,  9, RUINS_OF_ALPH_LILEEP_CHAMBER, 5
	warp_event  4,  9, RUINS_OF_ALPH_LILEEP_CHAMBER, 5
	warp_event  3,  1, RUINS_OF_ALPH_LILEEP_WORD_ROOM, 1
	warp_event  4,  1, RUINS_OF_ALPH_LILEEP_WORD_ROOM, 2

	def_coord_events

	def_bg_events
	bg_event  2,  1, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event  5,  1, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText

	def_object_events
	object_event  2,  6, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RuinsOfAlphLileepItemRoomGripClaw, EVENT_KABUTO_ITEM_ROOM_GRIP_CLAW
	object_event  5,  6, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RuinsOfAlphLileepItemRoomFocusSash, EVENT_KABUTO_ITEM_ROOM_FOCUS_SASH
	object_event  2,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RuinsOfAlphLileepItemRoomHeavyBoots, EVENT_KABUTO_ITEM_ROOM_HEAVY_BOOTS
	object_event  5,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RuinsOfAlphLileepItemRoomZoomLens, EVENT_KABUTO_ITEM_ROOM_ZOOM_LENS

	object_const_def
	const RUINSOFALPHLILEEPITEMROOM_POKE_BALL1
	const RUINSOFALPHLILEEPITEMROOM_POKE_BALL2
	const RUINSOFALPHLILEEPITEMROOM_POKE_BALL3
	const RUINSOFALPHLILEEPITEMROOM_POKE_BALL4

RuinsOfAlphLileepItemRoom_MapScripts:
	def_scene_scripts

	def_callbacks

RuinsOfAlphLileepItemRoomGripClaw:
	itemball GRIP_CLAW
RuinsOfAlphLileepItemRoomFocusSash:
	itemball FOCUS_SASH
RuinsOfAlphLileepItemRoomHeavyBoots:
	itemball HEAVY_BOOTS
RuinsOfAlphLileepItemRoomZoomLens:
	itemball ZOOM_LENS
