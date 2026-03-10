PowerPlant_MapEvents:
	def_warp_events
	warp_event  2, 17, POWER_PLANT_OUTSIDE, 1
	warp_event  3, 17, POWER_PLANT_OUTSIDE, 1

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT
	bg_event  1,  1, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT

	def_object_events
	object_event 14, 10, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, PowerPlantManagerText, -1
	object_event  4, 14, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, PowerPlantOfficer1Text, -1
	object_event  2,  9, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, PowerPlantGymGuide1Text, -1
	object_event  6, 11, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, PowerPlantBlackBeltText, -1
	object_event  9,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, PowerPlantOfficer2Text, -1
	object_event  7,  2, SPRITE_SAILOR, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, PowerPlantSailorText, -1
	object_event  5,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, PowerPlantScientistText, -1

	object_const_def
	const POWERPLANT_MANAGER
	const POWERPLANT_OFFICER1
	const POWERPLANT_GYM_GUIDE1
	const POWERPLANT_BLACK_BELT
	const POWERPLANT_OFFICER2
	const POWERPLANT_SAILOR
	const POWERPLANT_SCIENTIST

PowerPlant_MapScripts:
	def_scene_scripts

	def_callbacks

PowerPlantManagerText:
	text "Manager: My be-"
	line "loved generator!"

	para "Keep pumping the"
	line "electricity out!"
	done

PowerPlantGymGuide1Text:
	text "The generator is"
	line "making electricity"
	cont "to spare."
	done

PowerPlantBlackBeltText:
	text "The Magnet Train"
	line "requires a lot of"
	cont "power to operate."
	
	para "Huh? Of course I"
	line "have a job!"

	para "I need money to"
	line "train…"
	done

PowerPlantScientistText:
	text "I got my degree"
	line "just to come and"
	cont "work here."

	para "It's quite ful-"
	line "filling."
	done

PowerPlantOfficer1Text:
	text "The Manager sure"
	line "does love his"
	cont "generator…"
	done

PowerPlantSailorText:
	text "They need strong"
	line "people like me to"
	cont "have operations"
	cont "run steadily."
	done

PowerPlantOfficer2Text:
	text "All seems safe and"
	line "peaceful today."

	para "A job well done by"
	line "yours truly!"
	done
