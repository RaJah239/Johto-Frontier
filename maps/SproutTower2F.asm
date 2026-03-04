SproutTower2F_MapEvents:
	def_warp_events
	warp_event  6,  4, SPROUT_TOWER_1F, 3
	warp_event  2,  6, SPROUT_TOWER_1F, 4
	warp_event 17,  3, SPROUT_TOWER_1F, 5
	warp_event 10, 14, SPROUT_TOWER_3F, 1

	def_coord_events

	def_bg_events
	bg_event 12, 15, BGEVENT_JUMPTEXT, SproutTowerStatueText

	def_object_events
	object_event 12,  3, SPRITE_SAGE, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 4, TrainerSageNico, -1
	object_event  9, 14, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 5, TrainerSageEdmond, -1
	object_event  3,  1, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SproutTower2FXAccuracy, EVENT_SPROUT_TOWER_2F_X_ACCURACY

	object_const_def
	const SPROUTTOWER2F_SAGE1
	const SPROUTTOWER2F_SAGE2
	const SPROUTTOWER2F_POKE_BALL

SproutTower2F_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerSageNico:
	generictrainer SAGE, NICO, EVENT_BEAT_SAGE_NICO, .SeenText, .BeatenText

.AfterText
	text "The flexible pil-"
	line "lar protects the"
	cont "tower, even from"
	cont "earthquakes."
	done

.SeenText
	text "However hard we"
	line "battle, the tower"
	cont "will stand strong."
	done

.BeatenText
	text "I fought hard but"
	line "I'm too weak."
	done

TrainerSageEdmond:
	generictrainer SAGE, EDMOND, EVENT_BEAT_SAGE_EDMOND, .SeenText, .BeatenText

.AfterText
	text "I tried to copy"
	line "Bellsprout's"
	cont "gentle movements"
	cont "for battle…"

	para "But I didn't train"
	line "well enough."
	done

.SeenText
	text "…Sway like leaves"
	line "in the wind…"
	done

.BeatenText
	text "Oh, I'm weak!"
	done

SproutTower2FXAccuracy:
	itemball X_ACCURACY
