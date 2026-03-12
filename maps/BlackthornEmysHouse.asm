BlackthornEmysHouse_MapEvents:
	def_warp_events
	warp_event  2,  7, BLACKTHORN_CITY, 4
	warp_event  3,  7, BLACKTHORN_CITY, 4

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_JUMPSTD, MAGAZINE_BOOKSHELF_SCRIPT
	bg_event  1,  1, BGEVENT_JUMPSTD, MAGAZINE_BOOKSHELF_SCRIPT

	def_object_events
	object_event  2,  3, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, EmyTradeScript, -1

	object_const_def
	const BLACKTHORNEMYSHOUSE_EMY

BlackthornEmysHouse_MapScripts:
	def_scene_scripts

	def_callbacks

EmyTradeScript:
	faceplayeropentext
	trade NPC_TRADE_EMY
	waitendtext
