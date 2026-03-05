SlowpokeWellB1F_MapEvents:
	def_warp_events
	warp_event 17, 15, AZALEA_TOWN, 6
	warp_event  7, 11, SLOWPOKE_WELL_B2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	strengthboulder_event 3, 2
	object_event 15, 14, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 1, TrainerSchoolboyLiam, -1
	object_event  5,  6, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_GENERICTRAINER, 1, TrainerGentlemanCharles, -1
	object_event 11,  2, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 2, TrainerBugCatcherEmmanuel, -1
	object_event  6,  2, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, TrainerCooltrainerMKyle, -1
	object_event 10,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SlowpokeWellB1FSuperPotion, EVENT_SLOWPOKE_WELL_B1F_SUPER_POTION

	object_const_def
	const SLOWPOKEWELLB1F_BOULDER
	const SLOWPOKEWELLB1F_YOUNGSTER
	const SLOWPOKEWELLB1F_GENTLEMAN
	const SLOWPOKEWELLB1F_BUGCATCHER
	const SLOWPOKEWELLB1F_COOLTRAINERM
	const SLOWPOKEWELLB1F_POKE_BALL

SlowpokeWellB1F_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerSchoolboyLiam:
	generictrainer SCHOOLBOY, LIAM, EVENT_BEAT_SCHOOLBOY_LIAM, .SeenText, .BeatenText

.AfterText
	text "TODOTEXT"
	done

.SeenText
	text "TODOTEXT"
	done

.BeatenText
	text "TODOTEXT"
	done

TrainerCooltrainerMKyle:
	generictrainer COOLTRAINERM, KYLE, EVENT_BEAT_COOLTRAINERM_KYLE, .SeenText, .BeatenText

.AfterText
	text "TODOTEXT"
	done

.SeenText
	text "TODOTEXT"
	done

.BeatenText
	text "TODOTEXT"
	done

TrainerGentlemanCharles:
	generictrainer GENTLEMAN, CHARLES, EVENT_BEAT_GENTLEMAN_CHARLES, .SeenText, .BeatenText

.AfterText
	text "TODOTEXT"
	done

.SeenText
	text "TODOTEXT"
	done

.BeatenText
	text "TODOTEXT"
	done

TrainerBugCatcherEmmanuel:
	generictrainer BUG_CATCHER, EMMANUEL, EVENT_BEAT_BUG_CATCHER_EMMANUEL, .SeenText, .BeatenText

.AfterText
	text "TODOTEXT"
	done

.SeenText
	text "I'll even go down"
	line "a well to find Bug"
	cont "#mon!"
	done

.BeatenText
	text "TODOTEXT"
	done

SlowpokeWellB1FSuperPotion:
	itemball SUPER_POTION
