Route11_SilverCaveGate_MapEvents:
	def_warp_events
	warp_event  4,  7, ROUTE_11, 4
	warp_event  5,  7, ROUTE_11, 4
	warp_event  4,  0, SILVER_CAVE_OUTSIDE, 3
	warp_event  5,  0, SILVER_CAVE_OUTSIDE, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route11MtSilverGateOfficerText, -1

	object_const_def
	const ROUTE11MTSILVERGATE_OFFICER

Route11_SilverCaveGate_MapScripts:
	def_scene_scripts

	def_callbacks

Route11MtSilverGateOfficerText:
	text "This way leads to"
	line "Mt.Silver."

	para "You'll see scary-"
	line "strong #mon out"
	cont "there."
		
	para "I will not stop"
	line "you."

	para "Be careful out"
	line "there!" 
	done	
