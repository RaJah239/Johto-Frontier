RadioTower5F_MapEvents:
	def_warp_events
	warp_event  0,  0, RADIO_TOWER_4F, 1
	warp_event 12,  0, RADIO_TOWER_4F, 3

	def_coord_events

	def_bg_events
	bg_event  3,  0, BGEVENT_JUMPTEXT, RadioTower5FDirectorsOfficeSignText
	bg_event 11,  0, BGEVENT_JUMPTEXT, RadioTower5FStudio1SignText
	bg_event 15,  0, BGEVENT_JUMPTEXT, RadioTower5FStudio1SignText
	bg_event 16,  1, BGEVENT_JUMPSTD, MAGAZINE_BOOKSHELF_SCRIPT
	bg_event 17,  1, BGEVENT_JUMPSTD, MAGAZINE_BOOKSHELF_SCRIPT

	def_object_events
	object_event  3,  6, SPRITE_GENTLEMAN, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1,PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, RadioTower5FDirectorText, -1
	object_event 13,  5, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, RadioTower5FBenText, -1
	object_event  8,  5, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, RadioTower5FUltraBall, EVENT_RADIO_TOWER_5F_ULTRA_BALL

	object_const_def
	const RADIOTOWER5F_DIRECTOR
	const RADIOTOWER5F_ROCKER
	const RADIOTOWER5F_POKE_BALL

RadioTower5F_MapScripts:
	def_scene_scripts

	def_callbacks

RadioTower5FDirectorText:
	text "Director: Hello!"

	para "You know, I love"
	line "#mon."

	para "I built this Radio"
	line "Tower so I could"
	cont "express my love"
	cont "of #mon."

	para "It would be nice"
	line "if people enjoyed"
	cont "our programs."
	done

RadioTower5FBenText:
	text "Ben: Do you listen"
	line "to our music?"
	done

RadioTower5FDirectorsOfficeSignText:
	text "5F Director's"
	line "   Office"
	done

RadioTower5FStudio1SignText:
	text "5F Studio 1"
	done

RadioTower5FUltraBall:
	itemball ULTRA_BALL
