EcruteakItemfinderHouse_MapEvents:
	def_warp_events
	warp_event  3,  7, ECRUTEAK_CITY, 11
	warp_event  4,  7, ECRUTEAK_CITY, 11

	def_coord_events

	def_bg_events
	bg_event  2,  1, BGEVENT_JUMPSTD, RADIO2SCRIPT

	def_object_events
	object_event  2,  3, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EcruteakItemfinderGuy, -1
	object_event  3,  3, SPRITE_POKEDEX, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakHistoryBook, -1

	object_const_def
	const ECRUTEAKITEMFINDERHOUSE_COOLTRAINER_M
	const ECRUTEAKITEMFINDERHOUSE_POKEDEX

EcruteakItemfinderHouse_MapScripts:
	def_scene_scripts

	def_callbacks

EcruteakItemfinderGuy:
	faceplayeropentext
	checkevent EVENT_GOT_ITEMFINDER
	iftrue .itemfinder
	writethistext
		text "Ah. You're on an"
		line "adventure with"
		cont "your #mon?"

		para "Well, what's an"
		line "adventure without"
		cont "treasure hunting?"

		para "Am I right, or am"
		line "I right?"
		done
	yesorno
	iffalse .no
	writethistext
		text "Good! You under-"
		line "stand the true"
		cont "spirit of adven-"
		cont "ture."

		para "I like that! Take"
		line "this with you."
		done
	promptbutton
	verbosegiveitem ITEMFINDER
	setevent EVENT_GOT_ITEMFINDER
.itemfinder:
	jumpthisopenedtext
		text "There are many"
		line "items lying about"
		cont "that aren't ob-"
		cont "vious."

		para "Use Itemfinder to"
		line "check if there is"
		cont "an item on the"
		cont "ground near you."

		para "It doesn't show"
		line "the exact spot but"
		cont "beeps faster the"
		cont "nearer you are to"
		cont "the item."

		para "You'll still have"
		line "to search yourself"
		cont "by pressing A."

		para "Oh yeah--I heard"
		line "there are items"
		cont "in Ecruteak's"
		cont "Burned Tower."
		done

.no:
	jumpthisopenedtext
		text "Oh… To each his"
		line "own, I suppose…"
		done

EcruteakHistoryBook:
	opentext
	writethistext
		text "History Of"
		line "Ecruteak"

		para "Want to read it?"
		done
	yesorno
	iffalse_endtext
	writethistext
		text "In Ecruteak, there"
		line "were two towers."

		para "Each tower was the"
		line "roost of powerful"
		cont "flying #mon."

		para "But one of the"
		line "towers burned to"
		cont "the ground."

		para "The two #mon"
		line "haven't been seen"
		cont "since…"

		para "Keep reading?"
		done
	yesorno
	iffalse_endtext
	jumpthisopenedtext
		text "Ecruteak was also"
		line "home to three"
		cont "#mon that raced"
		cont "around the town."

		para "They were said to"
		line "have been born of"
		cont "water, lightning"
		cont "and fire."

		para "But they could not"
		line "contain their"
		cont "excessive power."

		para "So they say the"
		line "three ran like the"
		cont "wind off into the"
		cont "grassland."
		done
