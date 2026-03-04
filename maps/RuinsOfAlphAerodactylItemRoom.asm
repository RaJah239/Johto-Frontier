RuinsOfAlphAerodactylItemRoom_MapEvents:
	def_warp_events
	warp_event  3,  9, RUINS_OF_ALPH_AERODACTYL_CHAMBER, 5
	warp_event  4,  9, RUINS_OF_ALPH_AERODACTYL_CHAMBER, 5
	warp_event  3,  1, RUINS_OF_ALPH_AERODACTYL_WORD_ROOM, 1
	warp_event  4,  1, RUINS_OF_ALPH_AERODACTYL_WORD_ROOM, 2

	def_coord_events

	def_bg_events
	bg_event  2,  1, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event  5,  1, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText

	def_object_events
	object_event  2,  6, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RuinsOfAlphAerodactylItemRoomFlameOrb, EVENT_AERODACTYL_ITEM_ROOM_FLAME_ORB
	object_event  5,  6, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RuinsOfAlphAerodactylItemRoomMoonStone, EVENT_AERODACTYL_ITEM_ROOM_MOON_STONE
	object_event  2,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RuinsOfAlphAerodactylItemRoomMeteorMitts, EVENT_AERODACTYL_ITEM_ROOM_METEOR_MITTS
	object_event  5,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RuinsOfAlphAerodactylItemRoomSunStone, EVENT_AERODACTYL_ITEM_ROOM_SUNSTONE

	object_const_def
	const RUINSOFALPHAERODACTYLITEMROOM_POKE_BALL1
	const RUINSOFALPHAERODACTYLITEMROOM_POKE_BALL2
	const RUINSOFALPHAERODACTYLITEMROOM_POKE_BALL3
	const RUINSOFALPHAERODACTYLITEMROOM_POKE_BALL4

RuinsOfAlphAerodactylItemRoom_MapScripts:
	def_scene_scripts

	def_callbacks

RuinsOfAlphAerodactylItemRoomFlameOrb:
	itemball FLAME_ORB
RuinsOfAlphAerodactylItemRoomMoonStone:
	itemball MOON_STONE
RuinsOfAlphAerodactylItemRoomMeteorMitts:
	itemball METEOR_MITTS
RuinsOfAlphAerodactylItemRoomSunStone:
	itemball SUN_STONE
