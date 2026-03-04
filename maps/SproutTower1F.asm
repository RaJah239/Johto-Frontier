SproutTower1F_MapEvents:
	def_warp_events
	warp_event  9, 15, VIOLET_CITY, 7
	warp_event 10, 15, VIOLET_CITY, 7
	warp_event  6,  4, SPROUT_TOWER_2F, 1
	warp_event  2,  6, SPROUT_TOWER_2F, 2
	warp_event 17,  3, SPROUT_TOWER_2F, 3

	def_coord_events

	def_bg_events
	bg_event  7, 15, BGEVENT_JUMPTEXT, SproutTowerStatueText
	bg_event 12, 15, BGEVENT_JUMPTEXT, SproutTowerStatueText

	def_object_events
	object_event  7,  4, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, SproutTower1FSage1Text, -1
	object_event  6,  7, SPRITE_SAGE, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, SproutTower1FSage2Text, -1
	object_event 11, 12, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SproutTower1FGrannyText, -1
	object_event  9,  9, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SproutTower1FTeacherText, -1
	object_event  3,  5, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 4, TrainerSageChow, -1
	object_event 16,  7, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SproutTower1FParlyzHeal, EVENT_SPROUT_TOWER_1F_PARLYZ_HEAL

	object_const_def
	const SPROUTTOWER1F_SAGE1
	const SPROUTTOWER1F_SAGE2
	const SPROUTTOWER1F_GRANNY
	const SPROUTTOWER1F_TEACHER
	const SPROUTTOWER1F_SAGE3
	const SPROUTTOWER1F_POKE_BALL

SproutTower1F_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerSageChow:
	generictrainer SAGE, CHOW, EVENT_BEAT_SAGE_CHOW, .SeenText, .BeatenText

.AfterText
	text "All living beings"
	line "coexist through"
	cont "cooperation."

	para "We must always be"
	line "thankful for this."
	done

.SeenText
	text "We stand guard in"
	line "this tower."

	para "Here, we express"
	line "our gratitude to"
	cont "honor all #mon."
	done

.BeatenText
	text "Th-Thank you!"
	done

SproutTower1FGrannyText:
	text "A Bellsprout over"
	line "100 feet tall…"

	para "People say that it"
	line "became the center"
	cont "pillar here."
	done

SproutTower1FTeacherText:
	text "See the pillar"
	line "shaking?"

	para "People are train-"
	line "ing upstairs."
	done

SproutTower1FSage1Text:
	text "Only if you reach"
	line "the top will you"
	cont "obtain a Call."
	done

SproutTower1FSage2Text:
	text "Sprout Tower was"
	line "built long ago"
	cont "as a place for"
	cont "#mon training."
	done

SproutTowerStatueText:
	text "A #mon statue…"

	para "It looks very"
	line "distinguished."
	done

SproutTower1FParlyzHeal:
	itemball PARLYZ_HEAL
