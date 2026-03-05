SlowpokeWellB1F_MapEvents:
	def_warp_events
	warp_event 17, 15, AZALEA_TOWN, 6
	warp_event  7, 11, SLOWPOKE_WELL_B2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	strengthboulder_event 3, 2
	object_event 15,  7, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, TrainerGruntM29, -1
	object_event  5,  2, SPRITE_PROTON, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, TrainerGruntM1, -1
	object_event  5,  6, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, TrainerGruntM2, -1
	object_event 10,  4, SPRITE_ROCKET_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 4, TrainerGruntF1, -1
	object_event 10,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SlowpokeWellB1FSuperPotion, EVENT_SLOWPOKE_WELL_B1F_SUPER_POTION

	object_const_def
	const SLOWPOKEWELLB1F_BOULDER
	const SLOWPOKEWELLB1F_ROCKET1
	const SLOWPOKEWELLB1F_ROCKET2
	const SLOWPOKEWELLB1F_ROCKET3
	const SLOWPOKEWELLB1F_ROCKET_GIRL
	const SLOWPOKEWELLB1F_POKE_BALL

SlowpokeWellB1F_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerGruntM29:
	generictrainer GRUNTM, GRUNTM_29, EVENT_BEAT_, .SeenText, .BeatenText

.AfterText
	text "TODOTEXT"
	done

.SeenText
	text "TODOTEXT"
	done

.BeatenText
	text "TODOTEXT"
	done

TrainerGruntM1:
	generictrainer PROTON, PROTON1, EVENT_BEAT_, .SeenText, .BeatenText

.AfterText
	text "TODOTEXT"
	done

.SeenText
	text "TODOTEXT"
	done

.BeatenText
	text "TODOTEXT"
	done

TrainerGruntM2:
	generictrainer GRUNTM, GRUNTM_2, EVENT_BEAT_, .SeenText, .BeatenText

.AfterText
	text "TODOTEXT"
	done

.SeenText
	text "TODOTEXT"
	done

.BeatenText
	text "TODOTEXT"
	done

TrainerGruntF1:
	generictrainer GRUNTF, GRUNTF_1, EVENT_BEAT_, .SeenText, .BeatenText

.AfterText
	text "TODOTEXT"
	done

.SeenText
	text "TODOTEXT"
	done

.BeatenText
	text "TODOTEXT"
	done

SlowpokeWellB1FSuperPotion:
	itemball SUPER_POTION
