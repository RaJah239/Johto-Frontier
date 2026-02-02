	object_const_def
	const GoldenrodMansionRoofHOUSE_PHARMACIST

GoldenrodMansionRoofHouse_MapScripts:
	def_scene_scripts

	def_callbacks

GoldenrodMansionRoofHousePharmacistScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_TM03_CURSE
	iftrue .GotCurse
	writetext GoldenrodMansionRoofHousePharmacistIntroText
	promptbutton
	checktime NITE
	iftrue .Night
	writetext GoldenrodMansionRoofHousePharmacistNotNightText
	waitbutton
	closetext
	end

.Night:
	writetext GoldenrodMansionRoofHousePharmacistStoryText
	promptbutton
	verbosegiveitem TM_CURSE
	iffalse .NoRoom
	setevent EVENT_GOT_TM03_CURSE
.GotCurse:
	writetext GoldenrodMansionRoofHousePharmacistCurseText
	waitbutton
.NoRoom:
	closetext
	end

GoldenrodMansionRoofHousePharmacistIntroText:
	text "Let me recount a"
	line "terrifying tale…"
	done

GoldenrodMansionRoofHousePharmacistNotNightText:
	text "Then again, it's"
	line "not as scary while"

	para "it's still light"
	line "outside."

	para "Come back after"
	line "sunset, OK?"
	done

GoldenrodMansionRoofHousePharmacistStoryText:
	text "Once upon a time,"
	line "there was a little"

	para "boy who was given"
	line "a new BICYCLE…"

	para "He wanted to try"
	line "it right away…"

	para "He was having so"
	line "much fun that he"

	para "didn't notice the"
	line "sun had set…"

	para "While riding home"
	line "in the pitch-black"

	para "night, the bike"
	line "suddenly slowed!"

	para "The pedals became"
	line "heavy!"

	para "When he stopped"
	line "pedaling, the bike"

	para "began slipping"
	line "backwards!"

	para "It was as if the"
	line "bike were cursed"

	para "and trying to drag"
	line "him into oblivion!"

	para "…"

	para "…"

	para "SHRIEEEEK!"

	para "The boy had been"
	line "riding uphill on"
	cont "CYCLING ROAD!"

	para "…"
	line "Ba-dum ba-dum!"

	para "For listening so"
	line "patiently, you may"
	cont "take this--TM03!"
	done

GoldenrodMansionRoofHousePharmacistCurseText:
	text "TM03 is CURSE."

	para "It's a terrifying"
	line "move that slowly"

	para "whittles down the"
	line "victim's HP."
	done

GoldenrodMansionRoofHouse_MapEvents:
	def_warp_events
	warp_event  2,  7, GOLDENROD_MANSION_ROOF, 3
	warp_event  3,  7, GOLDENROD_MANSION_ROOF, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  2, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 2, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodMansionRoofHousePharmacistScript, -1
