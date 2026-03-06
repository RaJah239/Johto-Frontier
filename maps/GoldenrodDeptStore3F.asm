GoldenrodDeptStore3F_MapEvents:
	def_warp_events
	warp_event 12,  0, GOLDENROD_DEPT_STORE_2F, 1
	warp_event 15,  0, GOLDENROD_DEPT_STORE_4F, 2
	warp_event  2,  0, GOLDENROD_DEPT_STORE_ELEVATOR, 1

	def_coord_events

	def_bg_events
	bg_event 14,  0, BGEVENT_JUMPTEXT, GoldenrodDeptStore3FDirectoryText
	bg_event  3,  0, BGEVENT_JUMPSTD, ELEVATOR_BUTTON_SCRIPT

	def_object_events
	object_event  6,  1, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore3FClerkScript, -1
	object_event 12,  5, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodDeptStore3FSuperNerdText, -1
	object_event  2,  5, SPRITE_ROCKER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodDeptStore3FRockerText, -1

	object_const_def
	const GOLDENRODDEPTSTORE3F_CLERK
	const GOLDENRODDEPTSTORE3F_SUPER_NERD
	const GOLDENRODDEPTSTORE3F_ROCKER

GoldenrodDeptStore3F_MapScripts:
	def_scene_scripts

	def_callbacks

GoldenrodDeptStore3FClerkScript:
	faceplayeropentext
	pokemart MARTTYPE_STANDARD, MART_GOLDENROD_3F
	endtext

GoldenrodDeptStore3FSuperNerdText:
	text "I, I, I'm really"
	line "impatient!"

	para "I always equip"
	line "Haste Herb to my"
	cont "#mon."
	done

GoldenrodDeptStore3FRockerText:
	text "Do you use X Evade"
	line "in battle?"

	para "Some people think"
	line "that's cheap."
	
	para "But… If it works,"
	line "it works."

	para "Am I right?"
	done

GoldenrodDeptStore3FDirectoryText:
	text "For Victory"
	line "Seekers"

	para "3F Battle"
	line "   Collection"
	done
