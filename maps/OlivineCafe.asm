OlivineCafe_MapEvents:
	def_warp_events
	warp_event  2,  7, OLIVINE_CITY, 6
	warp_event  3,  7, OLIVINE_CITY, 6

	def_coord_events

	def_bg_events
	bg_event  7,  7,  BGEVENT_READ, OlivineCafeTrashCan

	def_object_events
	object_event  4,  3, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineCafeStrengthSailorScript, -1
	object_event  7,  3, SPRITE_FISHING_GURU, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivineCafeFishingGuruText, -1
	object_event  6,  6, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivineCafeSailorText, -1


	object_const_def
	const OLIVINECAFE_SAILOR1
	const OLIVINECAFE_FISHING_GURU
	const OLIVINECAFE_SAILOR2

OlivineCafe_MapScripts:
	def_scene_scripts

	def_callbacks

OlivineCafeStrengthSailorScript:
	faceplayeropentext
	checkevent EVENT_GOT_DONPHAN_CALL
	iftrue .GotStrength
	writethistext
		text "Hah! Your #mon"
		line "sure look like"
		cont "lightweights!"

		para "They don't have"
		line "the power to move"
		cont "boulders aside."

		para "Here, use this!"
		done
	promptbutton
	verbosegiveitem DONPHAN_CALL
	setevent EVENT_GOT_DONPHAN_CALL
.GotStrength:
	jumpthisopenedtext
		text "On the sea, the"
		line "only thing you can"
		cont "count on is your"
		cont "own good self!"

		para "I'm so proud of my"
		line "buff bod!"
		done

OlivineCafeFishingGuruText:
	text "Olivine Cafe's"
	line "menu is chock full"
	cont "of hearty fare for"
	cont "beefy Sailors!"
	done

OlivineCafeSailorText:
	text "Whenever I roll"
	line "into this town, I"
	cont "always visit the"
	cont "Olivine Cafe."

	para "Everything on the"
	line "menu makes me feel"
	cont "stronger. I can't"
	cont "stop eating!"
	done

OlivineCafeTrashCan:
	checkevent EVENT_OLIVINE_CAFE_HIDDEN_LEFTOVERS
	iftrue .TrashEmpty
	opentext
	verbosegiveitem LEFTOVERS
	iffalse_endtext
	setevent EVENT_OLIVINE_CAFE_HIDDEN_LEFTOVERS
	endtext

.TrashEmpty
	jumpstd TrashCanScript
