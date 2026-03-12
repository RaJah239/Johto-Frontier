IcePathB3F_MapEvents:
	def_warp_events
	warp_event  3,  5, ICE_PATH_B2F_MAHOGANY_SIDE, 2
	warp_event 15,  5, ICE_PATH_B2F_BLACKTHORN_SIDE, 2

	def_coord_events

	def_bg_events

	def_object_events
	rocksmash_event  6,  6
	chanseyheal_event  4,  3
	porygonpc_event  3,  3, PAL_NPC_RED
	object_event  5,  7, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, IcePathB3FNevermeltice, EVENT_ICE_PATH_B3F_NEVERMELTICE

	object_const_def
	const ICEPATHB3F_ROCK
	const ICEPATHB3F_CHANSEY
	const ICEPATHB3F_PORYGON_PC
	const ICEPATHB3F_POKE_BALL

IcePathB3F_MapScripts:
	def_scene_scripts

	def_callbacks

IcePathB3FNevermeltice:
	itemball NEVERMELTICE
