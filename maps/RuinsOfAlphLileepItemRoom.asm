	object_const_def
	const RUINSOFALPHLILEEPITEMROOM_POKE_BALL1
	const RUINSOFALPHLILEEPITEMROOM_POKE_BALL2
	const RUINSOFALPHLILEEPITEMROOM_POKE_BALL3
	const RUINSOFALPHLILEEPITEMROOM_POKE_BALL4

RuinsOfAlphLileepItemRoom_MapScripts:
	def_scene_scripts

	def_callbacks

RuinsOfAlphLileepItemRoomBerry:
	itemball BERRY

RuinsOfAlphLileepItemRoomPsncureberry:
	itemball PSNCUREBERRY

RuinsOfAlphLileepItemRoomHealPowder:
	itemball HEAL_POWDER

RuinsOfAlphLileepItemRoomEnergypowder:
	itemball ENERGYPOWDER

RuinsOfAlphLileepItemRoomAncientReplica:
	jumptext RuinsOfAlphLileepItemRoomAncientReplicaText

RuinsOfAlphLileepItemRoomAncientReplicaText:
	text "It's a replica of"
	line "an ancient #-"
	cont "MON."
	done

RuinsOfAlphLileepItemRoom_MapEvents:
	def_warp_events
	warp_event  3,  9, RUINS_OF_ALPH_LILEEP_CHAMBER, 5
	warp_event  4,  9, RUINS_OF_ALPH_LILEEP_CHAMBER, 5
	warp_event  3,  1, RUINS_OF_ALPH_LILEEP_WORD_ROOM, 1
	warp_event  4,  1, RUINS_OF_ALPH_LILEEP_WORD_ROOM, 2

	def_coord_events

	def_bg_events
	bg_event  2,  1, BGEVENT_READ, RuinsOfAlphLileepItemRoomAncientReplica
	bg_event  5,  1, BGEVENT_READ, RuinsOfAlphLileepItemRoomAncientReplica

	def_object_events
	object_event  2,  6, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RuinsOfAlphLileepItemRoomBerry, EVENT_PICKED_UP_BERRY_FROM_KABUTO_ITEM_ROOM
	object_event  5,  6, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RuinsOfAlphLileepItemRoomPsncureberry, EVENT_PICKED_UP_PSNCUREBERRY_FROM_KABUTO_ITEM_ROOM
	object_event  2,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RuinsOfAlphLileepItemRoomHealPowder, EVENT_PICKED_UP_HEAL_POWDER_FROM_KABUTO_ITEM_ROOM
	object_event  5,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RuinsOfAlphLileepItemRoomEnergypowder, EVENT_PICKED_UP_ENERGYPOWDER_FROM_KABUTO_ITEM_ROOM
