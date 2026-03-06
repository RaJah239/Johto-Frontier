CharcoalKiln_MapEvents:
	def_warp_events
	warp_event  2,  7, AZALEA_TOWN, 2
	warp_event  3,  7, AZALEA_TOWN, 2

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_JUMPSTD, MAGAZINE_BOOKSHELF_SCRIPT
	bg_event  1,  1, BGEVENT_JUMPSTD, MAGAZINE_BOOKSHELF_SCRIPT
	bg_event  7,  1, BGEVENT_JUMPSTD, RADIO2SCRIPT

	def_object_events
	object_event  2,  3, SPRITE_BLACK_BELT, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CharcoalKilnBoss, EVENT_CHARCOAL_KILN_BOSS
	object_event  5,  3, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CharcoalKilnApprentice, EVENT_CHARCOAL_KILN_APPRENTICE
	object_event  5,  6, SPRITE_SCYTHER, SPRITEMOVEDATA_POKEMON, 2, 2, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CharcoalKilnScyther, EVENT_CHARCOAL_KILN_SCYTHER

	object_const_def
	const CHARCOALKILN_BLACK_BELT
	const CHARCOALKILN_YOUNGSTER
	const CHARCOALKILN_MOLTRES

CharcoalKiln_MapScripts:
	def_scene_scripts

	def_callbacks

CharcoalKilnBoss:
	faceplayeropentext
	checkevent EVENT_GOT_SCYTHER_CALL
	iftrue .GotScytherCall
	jumpthisopenedtext
		text "My apprentice has"
		line "not returned from"
		cont "the Ilex Forest."

		para "Where in the world"
		line "is that lazy guy?"
		done

.GotScytherCall:
	jumpthisopenedtext
		text "You went to Ilex"
		line "Forest and aided"
		cont "my apprentice?"

		para "You're brave! Come"
		cont "train with us."
		done

CharcoalKilnApprentice:
	faceplayeropentext
	checkevent EVENT_GOT_CHARCOAL_IN_CHARCOAL_KILN
	iftrue .YoureTheCoolest
	writethistext
		text "I'm sorry--I for-"
		line "got to thank you."

		para "This is Charcoal"
		line "that I made."

		para "Fire-type #mon"
		line "would be happy to"
		cont "hold that."
		done
	promptbutton
	verbosegiveitem CHARCOAL
	iffalse_endtext
	setevent EVENT_GOT_CHARCOAL_IN_CHARCOAL_KILN
	endtext

.YoureTheCoolest:
	jumpthisopenedtext
		text "You helped me in"
		line "that bleak forest!"

		para "You're the cool-"
		line "est!"
		done

CharcoalKilnScyther:
	setval SCYTHER
	special SetMonAsSeen
	reanchormap
	pokepic SCYTHER
	cry SCYTHER
	waitbutton
	closepokepic
	jumpthistext
		text "Scyther: Scyth!"
		done
