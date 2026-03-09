BillsFamilysHouse_MapEvents:
	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 5
	warp_event  3,  7, GOLDENROD_CITY, 5

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_JUMPSTD, MAGAZINE_BOOKSHELF_SCRIPT
	bg_event  1,  1, BGEVENT_JUMPSTD, PICTURE_BOOKSHELF_SCRIPT
	bg_event  7,  1, BGEVENT_JUMPSTD, RADIO2SCRIPT

	def_object_events
	object_event  2,  3, SPRITE_BILL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BillScript, -1
	object_event  5,  3, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, BillsMomText_AfterEcruteak, -1
	object_event  5,  4, SPRITE_TWIN, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, BillsSisterStorageSystemText, -1

	object_const_def
	const BILLSFAMILYSHOUSE_BILL
	const BILLSFAMILYSHOUSE_POKEFAN_F
	const BILLSFAMILYSHOUSE_TWIN

BillsFamilysHouse_MapScripts:
	def_scene_scripts

	def_callbacks

BillScript:
	faceplayeropentext
	checkevent EVENT_GOT_EEVEE
	iftrue .GotEevee
	writethistext
		text "Hi. I'm Bill."
		line "<PLAYER> is it?"

		para "A trainer right?"

		para "Right… Since you're"
		line "a trainer, can you"
		cont "do me a favor and"
		cont "take this Eevee."

		para "It tagged along"
		line "with me when I was"
		cont "coming home today."

		para "Someone has to"
		line "take care of it"
		cont "but I don't like"
		cont "being outside."

		para "Can I count on you"
		line "to play with it,"
		cont "<PLAYER>?"
		done	
	yesorno
	iffalse .Refused
	writethistext
		text "Bill: I knew you'd"
		line "come through!"

		para "Way to go! You're"
		line "the real deal!"

		para "OK, I'm counting"
		line "on you."

		para "Take good care of"
		line "it!"
		done
	promptbutton
	waitsfx
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .NoRoom
	writethistext
		text "<PLAYER> received"
		line "Eevee!"
		done
	playsound SFX_CAUGHT_MON
	waitsfx
	givepoke EEVEE, 5
	setevent EVENT_GOT_EEVEE
	jumpthisopenedtext
		text "Bill: Prof.Elm"
		line "claims Eevee may"
		cont "evolve in new and"
		cont "unknown ways."
		done

.NoRoom:
	jumpthisopenedtext
		text "Whoa, wait. You"
		line "can't carry any"
		cont "more #mon."
		done

.Refused:
	jumpthisopenedtext
		text "Oh… Now what to"
		line "do?"
		done

.GotEevee:
	jumpthisopenedtext
		text "Bill: My pop, he"
		line "won't work. All he"
		cont "does is goof off"
		cont "all day long."

		para "He's getting to be"
		line "a real headache…"
		done

BillsMomText_AfterEcruteak:
	text "My husband was"
	line "once known as a"
	cont "#maniac."

	para "Bill must have"
	line "taken after his"
	cont "father."

	para "These days though…"
	
	para "All he seems to"
	line "ever do, is waste"
	cont "time in the Game"
	cont "Corner."
	done

BillsSisterStorageSystemText:
	text "My big brother,"
	line "Bill, made the PC"
	cont "#mon storage"
	cont "system."

	para "He made it open"
	line "source and a very"
	cont "a skilled coder by"
	cont "the online name,"
	cont "FIQ overhauled it."
	done
