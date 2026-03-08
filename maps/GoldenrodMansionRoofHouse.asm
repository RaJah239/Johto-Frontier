GoldenrodMansionRoofHouse_MapEvents:
	def_warp_events
	warp_event  2,  7, GOLDENROD_MANSION_ROOF, 3
	warp_event  3,  7, GOLDENROD_MANSION_ROOF, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  2, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 2, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodMansionRoofHousePharmacistScript, -1

	object_const_def
	const GoldenrodMansionRoofHOUSE_PHARMACIST

GoldenrodMansionRoofHouse_MapScripts:
	def_scene_scripts

	def_callbacks

GoldenrodMansionRoofHousePharmacistScript:
	faceplayeropentext
	checkevent EVENT_GOT_TM_CURSE
	iftrue .GotCurse
	writethistext
		text "Let me recount a"
		line "terrifying tale…"
		done
	promptbutton
	checktime NITE
	iftrue .Night
	jumpthisopenedtext
		text "Then again, it's"
		line "not as scary while"
		cont "it's still light"
		cont "outside."

		para "Come back after"
		line "sunset, OK?"
		done

.Night:
	writethistext
		text "Once upon a time,"
		line "there was a little"
		cont "boy who was on his"
		cont "first adventure…"

		para "He wanted to ex-"
		line "plore all he"
		cont "could…"

		para "He was having so"
		line "much fun that he"
		cont "didn't notice the"
		cont "sun had set…"

		para "He entered some"
		line "new and unknown"
		cont "place…"

		para "Ghosts from the"
		line "left and right be-"
		cont "gan appearing and"
		cont "chasing him!"

		para "He ran and ran un-"
		line "til he ran into a"
		cont "man clad in black!"

		para "…"

		para "…"

		para "SHRIEEEEK!"

		para "It was just a Sage"
		line "and he was in the"
		cont "Sprout Tower of"
		cont "Violet City."

		para "Ba-dum ba-dum!"

		para "For listening so"
		line "patiently, you may"
		cont "take this TM!"
		done
	promptbutton
	verbosegiveitem TM_CURSE
	iffalse_endtext
	setevent EVENT_GOT_TM_CURSE
.GotCurse:
	jumpthisopenedtext
		text "It's Curse." ; TODOTEXT change this if need be eventually

		para "It's a terrifying"
		line "move that slowly"
		cont "whittles down the"
		cont "victim's HP if a"
		cont "Ghost #mon uses"
		cont "it."

		para "Any other type"
		line "gets their speed"
		cont "reduced in trade"
		cont "for buffed Attack"
		cont "and Defense stats."
		done
