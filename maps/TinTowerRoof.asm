TinTowerRoof_MapEvents:
	def_warp_events
	warp_event  9, 13, TIN_TOWER_9F, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  9,  5, SPRITE_HO_OH, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, TinTowerHoOhScript, EVENT_TIN_TOWER_ROOF_HO_OH

	object_const_def
	const TINTOWERROOF_HO_OH

TinTowerRoof_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, TinTowerRoofHoOhCallback

TinTowerRoofHoOhCallback:
    checktime EVE | NITE
    iftrue .skipWeather
	setval WEATHER_SUN
	writemem wFieldWeather
.skipWeather
	endcallback

; TODOTEXT map callback to prevent roof access unless the player has silver wing
TinTowerHoOhScript:
	isfieldactionssettoquick
	iftrue .skipthis
	reanchormap
	pokepic HO_OH
	cry HO_OH
	waitbutton
	closepokepic
.skipthis
	showthistext
		text "Shaoooh!"
		done
	loadvar VAR_BATTLETYPE, BATTLETYPE_FORCEITEM
	loadwildmon HO_OH, 50
	loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
	startbattle
	disappear TINTOWERROOF_HO_OH
	reloadmapafterbattle
	end
