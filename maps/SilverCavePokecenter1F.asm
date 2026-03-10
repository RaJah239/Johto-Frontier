SilverCavePokecenter1F_MapEvents:
	def_warp_events
	warp_event  3,  7, SILVER_CAVE_OUTSIDE, 1
	warp_event  4,  7, SILVER_CAVE_OUTSIDE, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	heal_event  3,  1, PAL_NPC_PINK
	chansey_event  4,  1
	object_event  1,  5, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 2, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SilverCavePokecenter1FGrannyText, -1

	object_const_def
	const SILVERCAVEPOKECENTER1F_NURSE
	const SILVERCAVEPOKECENTER1F_CHANSEY
	const SILVERCAVEPOKECENTER1F_GRANNY

SilverCavePokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks

SilverCavePokecenter1FGrannyText:
	text "Trainers who seek"
	line "power climb Mt."
	cont "Silver despite its"
	cont "many dangers…"

	para "With their trusted"
	line "#mon, they must"
	cont "feel they can go"
	cont "anywhere…"
	done
