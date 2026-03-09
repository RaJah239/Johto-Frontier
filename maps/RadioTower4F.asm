RadioTower4F_MapEvents:
	def_warp_events
	warp_event  0,  0, RADIO_TOWER_5F, 1
	warp_event  9,  0, RADIO_TOWER_3F, 2
	warp_event 12,  0, RADIO_TOWER_5F, 2
	warp_event 17,  0, RADIO_TOWER_3F, 3

	def_coord_events

	def_bg_events
	bg_event  7,  0, BGEVENT_JUMPTEXT, RadioTower4FProductionSignText
	bg_event 15,  0, BGEVENT_JUMPTEXT, RadioTower4FStudio2SignText

	def_object_events
	object_event  6,  4, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, RadioTower4FFisherText, -1
	object_event 14,  6, SPRITE_TEACHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, RadioTower4FDJMaryScript, -1
	object_event 12,  7, SPRITE_MEOWTH, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RadioTower4FMeowth, -1

	object_const_def
	const RADIOTOWER4F_FISHER
	const RADIOTOWER4F_TEACHER
	const RADIOTOWER4F_MEOWTH

RadioTower4F_MapScripts:
	def_scene_scripts

	def_callbacks

RadioTower4FDJMaryScript:
	faceplayeropentext
	checkevent EVENT_GOT_PINK_BOW_FROM_MARY
	iftrue .GotPinkBow
	writethistext
		text "Mary: My Meowth's"
		line "Normal type moves"
		cont "are powered up"
		cont "thanks to this!"
		done
	promptbutton
	verbosegiveitem PINK_BOW
	iffalse_endtext
	setevent EVENT_GOT_PINK_BOW_FROM_MARY
	jumpthisopenedtext
		text "Mary: It's just"
		line "right for #mon"
		cont "that know normal-"
		cont "type moves."
		done

.GotPinkBow:
	jumpthisopenedtext
		text "Mary: Please tune"
		line "into me on Prof."
		cont "Oak's #mon Talk"
		cont "show."
		done

RadioTower4FMeowth:
	setval MEOWTH
	special SetMonAsSeen
	isfieldactionssettoquick
	iftrue .skipthis
	reanchormap
	pokepic MEOWTH
	cry MEOWTH
	waitbutton
	closepokepic
.skipthis
	jumpthistext
		text "Meowth: Meow…"
		done

RadioTower4FFisherText:
	text "I listened to the"
	line "radio while I was"
	cont "at the Ruins."

	para "I heard a strange"
	line "broadcast there."
	done

RadioTower4FProductionSignText:
	text "4F Production"
	done

RadioTower4FStudio2SignText:
	text "4F Studio 2"
	done
