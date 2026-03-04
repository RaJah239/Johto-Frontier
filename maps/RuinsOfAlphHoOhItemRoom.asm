RuinsOfAlphHoOhItemRoom_MapEvents:
	def_warp_events
	warp_event  3,  9, RUINS_OF_ALPH_HO_OH_CHAMBER, 5
	warp_event  4,  9, RUINS_OF_ALPH_HO_OH_CHAMBER, 5
	warp_event  3,  1, RUINS_OF_ALPH_HO_OH_WORD_ROOM, 1
	warp_event  4,  1, RUINS_OF_ALPH_HO_OH_WORD_ROOM, 2

	def_coord_events

	def_bg_events
	bg_event  2,  1, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event  5,  1, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText

	def_object_events
	object_event  2,  6, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RuinsOfAlphHoOhItemRoomSacredAsh, EVENT_HO_OH_ITEM_ROOM_SACRED_ASH
	object_event  5,  6, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RuinsOfAlphHoOhItemRoomChoiceBand, EVENT_HO_OH_ITEM_ROOM_CHOICE_BAND
	object_event  2,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RuinsOfAlphHoOhItemRoomChoiceSpecs, EVENT_HO_OH_ITEM_ROOM_CHOICE_SPECS
	object_event  5,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RuinsOfAlphHoOhItemRoomCharcoal, EVENT_HO_OH_ITEM_ROOM_MUSCLE_BAND

	object_const_def
	const RUINSOFALPHHOOHITEMROOM_POKE_BALL1
	const RUINSOFALPHHOOHITEMROOM_POKE_BALL2
	const RUINSOFALPHHOOHITEMROOM_POKE_BALL3
	const RUINSOFALPHHOOHITEMROOM_POKE_BALL4

RuinsOfAlphHoOhItemRoom_MapScripts:
	def_scene_scripts

	def_callbacks

RuinsOfAlphHoOhItemRoomSacredAsh:
	itemball SACRED_ASH
RuinsOfAlphHoOhItemRoomChoiceBand:
	itemball CHOICE_BAND
RuinsOfAlphHoOhItemRoomChoiceSpecs:
	itemball CHOICE_SPECS
RuinsOfAlphHoOhItemRoomCharcoal:
	itemball MUSCLE_BAND
