Route7GoldenrodGate_MapEvents:
	def_warp_events
	warp_event  4,  0, ROUTE_7, 1
	warp_event  5,  0, ROUTE_7, 2
	warp_event  4,  7, GOLDENROD_CITY, 13
	warp_event  5,  7, GOLDENROD_CITY, 13

	def_coord_events

	def_bg_events

	def_object_events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RandyScript, -1
	object_event  6,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route7GoldenrodGatePokefanFText, -1
	object_event  3,  2, SPRITE_FISHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route7GoldenrodGateFisherText, -1

	object_const_def
	const ROUTE7GOLDENRODGATE_RANDY
	const ROUTE7GOLDENRODGATE_POKEFAN_F
	const ROUTE7GOLDENRODGATE_FISHER

Route7GoldenrodGate_MapScripts:
	def_scene_scripts

	def_callbacks

RandyScript:
	faceplayeropentext
	checkevent EVENT_GOT_CRYSTAL_FROM_RANDY
	iftrue .gothpup
	checkevent EVENT_GAVE_KENYA
	iftrue .questcomplete
	checkevent EVENT_GOT_DURACELL
	iftrue .alreadyhavekenya
	writethistext
		text "Excuse me, kid!"
		line "Can you do a guy"
		cont "a favor?"

		para "Can you take this"
		line "#mon with Mail"
		cont "to my friend?"

		para "He's on Route 3."
		done
	yesorno
	iffalse .refused
	writethistext
		text "You will? Perfect!"
		line "Thanks, kid!"

		para "My pal's a chubby"
		line "guy who snoozes"
		cont "all the time."

		para "You'll recognize"
		line "him right away!"
		done
	promptbutton
	waitsfx
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .partyfull
	writethistext
		text "<PLAYER> received a"
		line "#mon with Mail."
		done
	playsound SFX_KEY_ITEM
	waitsfx
	givepoke PIKACHU, 10, NO_ITEM, GiftPikachuName, GiftPikachuOTName
	givepokemail GiftSpearowMail
	setevent EVENT_GOT_DURACELL
.alreadyhavekenya
	jumpthisopenedtext
	text "You can read it,"
	line "but don't lose it!"
	cont "Route 3!"
	done

.partyfull
	jumpthisopenedtext
		text "You can't carry"
		line "another #mon…"
		done

.refused
	jumpthisopenedtext
		text "Oh… Never mind,"
		line "then…"
		done

.questcomplete
	writethistext
		text "Thanks, kid! You"
		line "made the delivery"
		cont "for me!"

		para "Here's something"
		line "for your trouble!"
		done
	promptbutton
	verbosegiveitem CRYSTAL
	iffalse_endtext
	setevent EVENT_GOT_CRYSTAL_FROM_RANDY
.gothpup
	jumpthisopenedtext
		text "My pal was snooz-"
		line "ing, right? Heh,"
		cont "what'd I say?"
		done

GiftSpearowMail:
	db FLOWER_MAIL
	db   "Dark Cave leads"
	next "to another road@"

GiftPikachuName:
	db "Duracell@"

GiftPikachuOTName:
	db "Randy@"

Route7GoldenrodGatePokefanFText:
	text "I like the #mon"
	line "Lullaby they play"
	cont "on the radio."
	done

Route7GoldenrodGateFisherText:
	text "I wonder how many"
	line "kinds of #mon"
	cont "there are in the"
	cont "world."

	para "Three years ago,"
	line "Prof.Oak said that"
	cont "there were 150"
	cont "different kinds."
	done
