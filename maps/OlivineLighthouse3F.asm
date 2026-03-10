OlivineLighthouse3F_MapEvents:
	def_warp_events
	warp_event 13,  3, OLIVINE_LIGHTHOUSE_4F, 1
	warp_event  5,  3, OLIVINE_LIGHTHOUSE_2F, 2
	warp_event  9,  5, OLIVINE_LIGHTHOUSE_4F, 4
	warp_event 16, 11, OLIVINE_LIGHTHOUSE_2F, 5
	warp_event 17, 11, OLIVINE_LIGHTHOUSE_2F, 6
	warp_event 16,  9, OLIVINE_LIGHTHOUSE_4F, 5
	warp_event 17,  9, OLIVINE_LIGHTHOUSE_4F, 6
	warp_event  8,  3, OLIVINE_LIGHTHOUSE_4F, 7
	warp_event  9,  3, OLIVINE_LIGHTHOUSE_4F, 8

	def_coord_events

	def_bg_events

	def_object_events
	chanseyheal_event 13, 13
	object_event  9,  2, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, TrainerSailorTerrell, -1
	object_event 13,  5, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 3, TrainerGentlemanPreston, -1
	object_event  3,  9, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 3, TrainerBirdKeeperTheo, -1
	object_event  8,  2, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, OlivineLighthouse3FEther, EVENT_OLIVINE_LIGHTHOUSE_3F_ETHER

	object_const_def
	const OLIVINELIGHTHOUSE3F_CHANSEY
	const OLIVINELIGHTHOUSE3F_SAILOR
	const OLIVINELIGHTHOUSE3F_GENTLEMAN
	const OLIVINELIGHTHOUSE3F_YOUNGSTER
	const OLIVINELIGHTHOUSE3F_POKE_BALL

OlivineLighthouse3F_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerBirdKeeperTheo:
	generictrainer BIRD_KEEPER, THEO, EVENT_BEAT_BIRD_KEEPER_THEO, .SeenText, .BeatenText

.AfterText
	text "That helped me as"
	line "well."
	done

.SeenText
	text "You're here for"
	line "training too?"

	para "Let's help each-"
	line "other out!"
	done

.BeatenText
	text "Thank you!"
	done

TrainerGentlemanPreston:
	generictrainer GENTLEMAN, PRESTON, EVENT_BEAT_GENTLEMAN_PRESTON, .SeenText, .BeatenText

.AfterText
	text "Jasmine used to"
	line "use rock #mon"
	cont "like Onix."
	done

.SeenText
	text "I travel the world"
	line "to train my #-"
	cont "mon. I wish to"
	cont "battle with you."
	done

.BeatenText
	text "…sigh… I must"
	line "train some more…"
	done

TrainerSailorTerrell:
	generictrainer SAILOR, TERRELL, EVENT_BEAT_SAILOR_TERRELL, .SeenText, .BeatenText

.AfterText
	text "Every time I come"
	line "back to Olivine, I"
	cont "visit the Gym."

	para "The Gym Leader's"
	line "#mon type has"
	cont "changed without me"
	cont "noticing."
	done

.SeenText
	text "Sailors are both"
	line "kind and strong."
	cont "How about you?"
	done

.BeatenText
	text "You are both kind"
	line "and strong…"
	done

OlivineLighthouse3FEther:
	itemball ETHER
