DarkCaveBlackthornEntrance_MapEvents:
	def_warp_events
	warp_event 23,  3, ROUTE_17, 1
	warp_event  3, 25, DARK_CAVE_VIOLET_ENTRANCE, 2

	def_coord_events

	def_bg_events

	def_object_events
	porygonpc_event 22, 21, PAL_NPC_RED
	object_event  7,  3, SPRITE_PHARMACIST, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DarkCaveBlackthornEntrancePharmacistScript, -1
	object_event 21, 24, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, DarkCaveBlackthornEntranceRevive, EVENT_DARK_CAVE_BLACKTHORN_ENTRANCE_REVIVE
	object_event  7, 22, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, DarkCaveBlackthornEntranceTMSnore, EVENT_DARK_CAVE_BLACKTHORN_ENTRANCE_TM_SNORE

	object_const_def
	const DARKCAVEBLACKTHORNENTRANCE_PORYGON_PC
	const DARKCAVEBLACKTHORNENTRANCE_PHARMACIST
	const DARKCAVEBLACKTHORNENTRANCE_POKE_BALL1
	const DARKCAVEBLACKTHORNENTRANCE_POKE_BALL2

DarkCaveBlackthornEntrance_MapScripts:
	def_scene_scripts

	def_callbacks

DarkCaveBlackthornEntrancePharmacistScript:
	faceplayeropentext
	checkevent EVENT_GOT_BLACKGLASSES_IN_DARK_CAVE
	iftrue .GotBlackglasses
	writethistext
		text "Whoa! You startled"
		line "me there!"

		para "I had my Black-"
		line "Glasses on, so I"
		cont "didn't notice you"
		cont "at all."

		para "What am I doing"
		line "here?"

		para "Hey, don't you"
		line "worry about it."

		para "I'll give you a"
		line "pair of Black-"
		cont "Glasses, so forget"
		cont "you saw me, OK?"
		done
	promptbutton
	verbosegiveitem BLACKGLASSES
	iffalse_endtext
	setevent EVENT_GOT_BLACKGLASSES_IN_DARK_CAVE
.GotBlackglasses:
	jumpthisopenedtext
		text "BlackGlasses ups"
		line "the power of dark-"
		cont "type moves."
		done

DarkCaveBlackthornEntranceRevive:
	itemball REVIVE
DarkCaveBlackthornEntranceTMSnore:
	itemball TM_SNORE
