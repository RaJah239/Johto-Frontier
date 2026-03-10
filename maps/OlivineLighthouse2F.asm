OlivineLighthouse2F_MapEvents:
	def_warp_events
	warp_event  3, 11, OLIVINE_LIGHTHOUSE_1F, 3
	warp_event  5,  3, OLIVINE_LIGHTHOUSE_3F, 2
	warp_event 16, 13, OLIVINE_LIGHTHOUSE_1F, 4
	warp_event 17, 13, OLIVINE_LIGHTHOUSE_1F, 5
	warp_event 16, 11, OLIVINE_LIGHTHOUSE_3F, 4
	warp_event 17, 11, OLIVINE_LIGHTHOUSE_3F, 5

	def_coord_events

	def_bg_events

	def_object_events
	object_event  9,  3, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 2, TrainerSailorHuey, -1
	object_event 17,  8, SPRITE_GENTLEMAN, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 3, TrainerGentlemanAlfred, -1

	object_const_def
	const OLIVINELIGHTHOUSE2F_SAILOR
	const OLIVINELIGHTHOUSE2F_GENTLEMAN

OlivineLighthouse2F_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerGentlemanAlfred:
	generictrainer GENTLEMAN, ALFRED, EVENT_BEAT_GENTLEMAN_ALFRED,.SeenText, .BeatenText

.AfterText
	text "Up top is a #-"
	line "mon that keeps the"
	cont "Lighthouse lit."
	done

.SeenText
	text "Hm? This is no"
	line "place for playing."
	done

.BeatenText
	text "Ah! I can see that"
	line "you're serious."
	done

TrainerSailorHuey:
	generictrainer SAILOR, HUEY, EVENT_BEAT_SAILOR_HUEY, .SeenText, .BeatenText

.AfterText
	text "What power!"
	line "How would you like"
	cont "to sail the seas"
	cont "with me?"
	done

.SeenText
	text "Men of the sea are"
	line "always spoiling"
	cont "for a good fight!"
	done

.BeatenText
	text "Urf!"
	line "I lose!"
	done
