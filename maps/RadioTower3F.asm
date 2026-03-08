RadioTower3F_MapEvents:
	def_warp_events
	warp_event  0,  0, RADIO_TOWER_2F, 1
	warp_event  7,  0, RADIO_TOWER_4F, 2
	warp_event 17,  0, RADIO_TOWER_4F, 4

	def_coord_events

	def_bg_events
	bg_event  3,  0, BGEVENT_JUMPTEXT, RadioTower3FPersonnelSignText
	bg_event  9,  0, BGEVENT_JUMPTEXT, RadioTower3FPokemonMusicSignText

	def_object_events
	object_event 11,  4, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINRANDOM_SLOW, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, RadioTower3FCooltrainerFScript, -1
	object_event  6,  7, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, RadioTower3FSuperNerdText, -1
	object_event  3,  4, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, RadioTower3FGymGuideText, -1

	object_const_def
	const RADIOTOWER3F_COOLTRAINER_F
	const RADIOTOWER3F_SUPER_NERD
	const RADIOTOWER3F_GYM_GUIDE

RadioTower3F_MapScripts:
	def_scene_scripts

	def_callbacks

RadioTower3FCooltrainerFScript:
	faceplayeropentext ; TODOTEXT when TMs are redone
	checkevent EVENT_GOT_SUNNY_DAY_FROM_RADIO_TOWER
	iftrue .GotSunnyDay
	writethistext
		text "I found this some"
		line "time ago."

		para "I'm too busy to"
		line "battle so please"
		cont "accept it."
		done
	promptbutton
	verbosegiveitem TM_SUNNY_DAY
	iffalse_endtext
	setevent EVENT_GOT_SUNNY_DAY_FROM_RADIO_TOWER
	jumpthisopenedtext
		text "It's Sunny Day."
		line "It powers up fire-"
		cont "type moves for a"
		cont "while."
		done

.GotSunnyDay:
	jumpthisopenedtext
		text "Back to making"
		line "awesome content"
		cont "for our audience."
		done

RadioTower3FSuperNerdText:
	text "We have recordings"
	line "of the cries of"
	cont "all #mon that"
	cont "have been found."

	para "We must have about"
	line "200 kinds."
	done

RadioTower3FGymGuideText:
	text "We run 24 hours a"
	line "day to broadcast"
	cont "entertaining pro-"
	cont "grams."

	para "I'll do my best to"
	line "run around the"
	cont "clock too!"
	done

RadioTower3FPersonnelSignText:
	text "3F Personnel"
	done

RadioTower3FPokemonMusicSignText:
	text "#mon Music with"
	line "Host DJ Ben"
	done
