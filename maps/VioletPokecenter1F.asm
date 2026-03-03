VioletPokecenter1F_MapEvents:
	def_warp_events
	warp_event  3,  7, VIOLET_CITY, 1
	warp_event  4,  7, VIOLET_CITY, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	heal_event  3,  1, PAL_NPC_PURPLE
	object_event  7,  6, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, VioletPokecenter1FGameboyKidText, -1
	object_event  1,  4, SPRITE_GENTLEMAN, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, VioletPokecenter1FGentlemanText, -1
	object_event  8,  1, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, VioletPokecenter1FYoungsterText, -1
	chansey_event  4,  1

	object_const_def
	const VIOLETPOKECENTER1F_NURSE
	const VIOLETPOKECENTER1F_GAMEBOY_KID
	const VIOLETPOKECENTER1F_GENTLEMAN
	const VIOLETPOKECENTER1F_YOUNGSTER
	const VIOLETPOKECENTER1F_CHANSEY

VioletPokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks

VioletPokecenter1FYoungsterText:
	text "A guy named BILL"
	line "made the #mon"
	cont "PC storage system."
	done

VioletPokecenter1FGentlemanText:
	text "TODOTEXT"
	done

VioletPokecenter1FGameboyKidText:
	text "TODOTEXT"
	done
