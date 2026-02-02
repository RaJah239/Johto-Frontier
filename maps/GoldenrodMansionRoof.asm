	object_const_def
	const GOLDENRODMANSIONROOF_FISHER

GoldenrodMansionRoof_MapScripts:
	def_scene_scripts

	def_callbacks

GoldenrodMansionRoofFisherScript:
	jumptextfaceplayer GoldenrodMansionRoofFisherText

GoldenrodMansionRoofGraffiti:
	jumptext GoldenrodMansionRoofGraffitiText

GoldenrodMansionRoofFisherText:
	text "High places--I do"
	line "love them so!"

	para "I'd say the only"
	line "thing that loves"

	para "heights as much as"
	line "me is smoke!"
	done

GoldenrodMansionRoofGraffitiText:
	text "There's graffiti"
	line "on the wall…"

	para "<PLAYER> added a"
	line "moustache!"
	done

GoldenrodMansionRoof_MapEvents:
	def_warp_events
	warp_event  1,  1, GOLDENROD_MANSION_3F, 1
	warp_event  6,  1, GOLDENROD_MANSION_3F, 4
	warp_event  2,  5, GOLDENROD_MANSION_ROOF_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event  6,  1, BGEVENT_LEFT, GoldenrodMansionRoofGraffiti

	def_object_events
	object_event  7,  5, SPRITE_FISHER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodMansionRoofFisherScript, -1
