	object_const_def
	const POWERPLANTOUTSIDE_STANDING_YOUNGSTER
	const POWERPLANTOUTSIDE_BEAUTY
	const POWERPLANTOUTSIDE_SAILOR
	const POWERPLANTOUTSIDE_LASS

PowerPlantOutside_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, PowerPlantOutsideNoopCallback
	callback MAPCALLBACK_OBJECTS, PowerPlantOutsideShowCiviliansCallback
	callback MAPCALLBACK_NEWMAP, .Flypoint

.Flypoint:
	setflag ENGINE_FLYPOINT_POWER_PLANT
	return

PowerPlantOutsideNoopCallback:
	endcallback

PowerPlantOutsideShowCiviliansCallback:
	clearevent EVENT_BATTLE_TOWER_OPEN_CIVILIANS
	endcallback

PowerPlantOutsideYoungsterScript:
	jumptextfaceplayer PowerPlantOutsideYoungsterText

PowerPlantOutsideBeautyScript:
	jumptextfaceplayer PowerPlantOutsideBeautyText

PowerPlantOutsideSailorScript:
	jumptextfaceplayer PowerPlantOutsideSailorText

PowerPlantOutsideSign:
	jumptext PowerPlantOutsideSignText

PowerPlantOutsideYoungsterText:
	text "Wow, the BATTLE"
	line "TOWER is huge!"

	para "There must be many"
	line "kinds of #MON"
	cont "in there!"
	done

PowerPlantOutsideBeautyText:
	text "You can use only"
	line "three #MON."

	para "It's so hard to"
	line "decide which three"

	para "should go into"
	line "battle…"
	done

PowerPlantOutsideSailorText:
	text "Hehehe, I snuck"
	line "out from work."

	para "I can't bail out"
	line "until I've won!"

	para "I have to win it"
	line "all. That I must!"
	done

PowerPlantOutsideSignText:
	text "BATTLE TOWER"

	para "Take the Ultimate"
	line "Trainer Challenge!"
	done

PowerPlantOutside_MapEvents:
	def_warp_events
	warp_event  5,  5, POWER_PLANT, 1
	warp_event  8, 15, ROUTE_12_POWER_PLANT_GATE, 3
	warp_event  9, 15, ROUTE_12_POWER_PLANT_GATE, 4

	def_coord_events

	def_bg_events
	bg_event  6,  6, BGEVENT_READ, PowerPlantOutsideSign

	def_object_events
	object_event  7,  9, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, PowerPlantOutsideYoungsterScript, -1
	object_event 13,  9, SPRITE_BEAUTY, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, PowerPlantOutsideBeautyScript, -1
	object_event 11, 12, SPRITE_SAILOR, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PowerPlantOutsideSailorScript, EVENT_BATTLE_TOWER_OPEN_CIVILIANS
	object_event 12, 18, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
