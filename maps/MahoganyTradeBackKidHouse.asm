	object_const_def
	const MAHOGANYTRADEBACKKIDHOUSE_TRADEKID

MahoganyTradeBackKidHouse_MapScripts:
	def_scene_scripts

	def_callbacks

TradebackKidScript:
	faceplayer
	opentext
	special TradebackNPC
	waitbutton
	closetext
	turnobject MAHOGANYTRADEBACKKIDHOUSE_TRADEKID, DOWN
	end

MahoganyTradeBackKidHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, MAHOGANY_TOWN, 6
	warp_event  3,  7, MAHOGANY_TOWN, 6

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, TradebackKidScript, -1
