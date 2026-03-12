VictoryRoad_MapEvents:
	def_warp_events
	warp_event  9, 67, VICTORY_ROAD_GATE, 3
	warp_event  1, 49, VICTORY_ROAD, 3
	warp_event  1, 35, VICTORY_ROAD, 2
	warp_event 13, 31, VICTORY_ROAD, 5
	warp_event 13, 17, VICTORY_ROAD, 4
	warp_event 17, 33, VICTORY_ROAD, 7
	warp_event 17, 19, VICTORY_ROAD, 6
	warp_event  0, 11, VICTORY_ROAD, 9
	warp_event  0, 27, VICTORY_ROAD, 8
	warp_event 13,  5, ROUTE_21, 3

	def_coord_events

	def_bg_events
	bg_event  3, 29, BGEVENT_ITEM + MAX_POTION, EVENT_VICTORY_ROAD_HIDDEN_MAX_POTION
	bg_event  3, 65, BGEVENT_ITEM + FULL_HEAL, EVENT_VICTORY_ROAD_HIDDEN_FULL_HEAL

	def_object_events
	chanseyheal_event 16, 12
	object_event  3, 28, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, VictoryRoadTMEarthquake, EVENT_VICTORY_ROAD_TM_EARTHQUAKE
	object_event 12, 48, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, VictoryRoadMaxRevive, EVENT_VICTORY_ROAD_MAX_REVIVE
	object_event 18, 29, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, VictoryRoadFullRestore, EVENT_VICTORY_ROAD_FULL_RESTORE
	object_event 15, 48, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, VictoryRoadFullHeal, EVENT_VICTORY_ROAD_FULL_HEAL
	object_event  7, 38, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, VictoryRoadSacredAsh, EVENT_VICTORY_ROAD_SACRED_ASH
	object_event 13,  6, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, VictoryRoadGSBall, EVENT_CAN_GIVE_GS_BALL_TO_KURT

	object_const_def
	const VICTORYROAD_CHANSEY
	const VICTORYROAD_POKE_BALL1
	const VICTORYROAD_POKE_BALL2
	const VICTORYROAD_POKE_BALL3
	const VICTORYROAD_POKE_BALL4
	const VICTORYROAD_POKE_BALL5
	const VICTORYROAD_GS_BALL

VictoryRoad_MapScripts:
	def_scene_scripts

	def_callbacks

VictoryRoadGSBall:
	disappear VICTORYROAD_GS_BALL
	opentext
	verbosegiveitem GS_BALL
	setmapscene ROUTE_21, SCENE_ROUTE_21_NOOP
	endtext

VictoryRoadTMEarthquake:
	itemball TM_EARTHQUAKE
VictoryRoadMaxRevive:
	itemball MAX_REVIVE
VictoryRoadFullRestore:
	itemball FULL_RESTORE
VictoryRoadFullHeal:
	itemball FULL_HEAL
VictoryRoadSacredAsh:
	itemball SACRED_ASH
