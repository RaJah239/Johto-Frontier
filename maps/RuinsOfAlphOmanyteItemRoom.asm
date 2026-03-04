RuinsOfAlphOmanyteItemRoom_MapEvents:
	def_warp_events
	warp_event  3,  9, RUINS_OF_ALPH_OMANYTE_CHAMBER, 5
	warp_event  4,  9, RUINS_OF_ALPH_OMANYTE_CHAMBER, 5
	warp_event  3,  1, RUINS_OF_ALPH_OMANYTE_WORD_ROOM, 1
	warp_event  4,  1, RUINS_OF_ALPH_OMANYTE_WORD_ROOM, 2

	def_coord_events

	def_bg_events
	bg_event  2,  1, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event  5,  1, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText

	def_object_events
	object_event  2,  6, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RuinsOfAlphOmanyteItemRoomLifeOrb, EVENT_OMANYTE_ITEM_ROOM_LIFE_ORB
	object_event  5,  6, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RuinsOfAlphOmanyteItemRoomWeatherRock, EVENT_OMANYTE_ITEM_ROOM_WEATHER_ROCK
	object_event  2,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RuinsOfAlphOmanyteItemRoomBrightPowder, EVENT_OMANYTE_ITEM_ROOM_BRIGHTPOWDER
	object_event  5,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RuinsOfAlphOmanyteItemRoomFocusBand, EVENT_OMANYTE_ITEM_ROOM_FOCUS_BAND

	object_const_def
	const RUINSOFALPHOMANYTEITEMROOM_POKE_BALL1
	const RUINSOFALPHOMANYTEITEMROOM_POKE_BALL2
	const RUINSOFALPHOMANYTEITEMROOM_POKE_BALL3
	const RUINSOFALPHOMANYTEITEMROOM_POKE_BALL4

RuinsOfAlphOmanyteItemRoom_MapScripts:
	def_scene_scripts

	def_callbacks

RuinsOfAlphOmanyteItemRoomLifeOrb:
	itemball LIFE_ORB
RuinsOfAlphOmanyteItemRoomWeatherRock:
	itemball WEATHER_ROCK
RuinsOfAlphOmanyteItemRoomBrightPowder:
	itemball BRIGHTPOWDER
RuinsOfAlphOmanyteItemRoomFocusBand:
	itemball FOCUS_BAND
