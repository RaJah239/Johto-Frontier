WhirlIslandLugiaChamber_MapEvents:
	def_warp_events
	warp_event  9, 13, WHIRL_ISLAND_B2F, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  9,  5, SPRITE_LUGIA, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, WhirlIslandLugiaScript, EVENT_WHIRL_ISLAND_LUGIA_CHAMBER_LUGIA

	object_const_def
	const WHIRLISLANDLUGIACHAMBER_LUGIA

WhirlIslandLugiaChamber_MapScripts:
	def_scene_scripts

	def_callbacks

; TODOTEXT map callback to prevent the door from opening unless the player has silver wing
WhirlIslandLugiaScript:
	isfieldactionssettoquick
	iftrue .skipthis
	reanchormap
	pokepic LUGIA
	cry LUGIA
	waitbutton
	closepokepic
.skipthis
	showthistext
		text "Gyaaas!"
		done
	loadvar VAR_BATTLETYPE, BATTLETYPE_FORCEITEM
	loadwildmon LUGIA, 50
	loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
	startbattle
	disappear TINTOWERROOF_HO_OH
	reloadmapafterbattle
	end
