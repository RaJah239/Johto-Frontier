AzaleaPokecenter1F_MapEvents:
	def_warp_events
	warp_event  3,  7, AZALEA_TOWN, 1
	warp_event  4,  7, AZALEA_TOWN, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	heal_event  3,  1, PAL_NPC_GREEN
	chansey_event  4,  1
	object_event  9,  6, SPRITE_GENTLEMAN, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, AzaleaPokecenter1FGentlemanText, -1
	object_event  6,  1, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, AzaleaPokecenter1FFishingGuruText, -1
	object_event  1,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WANDER, 1, 2, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, AzaleaPokecenter1FPokefanFText, -1

	object_const_def
	const AZALEAPOKECENTER1F_NURSE
	const AZALEAPOKECENTER1F_CHANSEY
	const AZALEAPOKECENTER1F_GENTLEMAN
	const AZALEAPOKECENTER1F_FISHING_GURU
	const AZALEAPOKECENTER1F_POKEFAN_F


AzaleaPokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks

AzaleaPokecenter1FGentlemanText:
	text "Do your #mon"
	line "know field moves?"

	para "Most can be used"
	line "even if your #-"
	cont "mon has fainted."
	done

AzaleaPokecenter1FFishingGuruText:
	text "Bill's PC can"
	line "store up to 20"
	cont "#mon per Box."
	done

AzaleaPokecenter1FPokefanFText:
	text "Do you know about"
	line "Apricorns?"

	para "Crack one open,"
	line "hollow it out and"
	cont "fit it with a"
	cont "special device."

	para "Then you can catch"
	line "#mon with it."

	para "Before # Balls"
	line "were invented,"
	cont "everyone used"
	cont "Apricorns."
	done
