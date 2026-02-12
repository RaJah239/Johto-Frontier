	object_const_def
	const ROUTE12POWERPLANTGATE_ROCKER
	const ROUTE12POWERPLANTGATE_TWIN

Route12PowerPlantGate_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, Route12PowerPlantGateShowSailorCallback

Route12PowerPlantGateShowSailorCallback:
	clearevent EVENT_BATTLE_TOWER_OPEN_CIVILIANS
	endcallback

Route12PowerPlantGateRockerScript:
	jumptextfaceplayer Route12PowerPlantGateRockerText

Route12PowerPlantGateTwinScript:
	jumptextfaceplayer Route12PowerPlantGateTwinText

Route12PowerPlantGateRockerText:
	text "Are you going to"
	line "the BATTLE TOWER?"

	para "This is a secret,"
	line "but if you win a"

	para "whole lot, you can"
	line "win special gifts."
	done

Route12PowerPlantGateTwinText:
	text "The levels of the"
	line "#MON I want to"

	para "use are all"
	line "different."

	para "I have to go train"
	line "them now!"
	done

Route12PowerPlantGate_MapEvents:
	def_warp_events
	warp_event  4,  7, ROUTE_12, 1
	warp_event  5,  7, ROUTE_12, 1
	warp_event  4,  0, POWER_PLANT_OUTSIDE, 2
	warp_event  5,  0, POWER_PLANT_OUTSIDE, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  3, SPRITE_ROCKER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route12PowerPlantGateRockerScript, EVENT_BATTLE_TOWER_OPEN_CIVILIANS
	object_event  7,  5, SPRITE_TWIN, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route12PowerPlantGateTwinScript, -1
