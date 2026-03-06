GoldenrodDeptStore2F_MapEvents:
	def_warp_events
	warp_event 12,  0, GOLDENROD_DEPT_STORE_3F, 1
	warp_event 15,  0, GOLDENROD_DEPT_STORE_1F, 3
	warp_event  2,  0, GOLDENROD_DEPT_STORE_ELEVATOR, 1

	def_coord_events

	def_bg_events
	bg_event 14,  0, BGEVENT_JUMPTEXT, GoldenrodDeptStore2FDirectoryText
	bg_event  3,  0, BGEVENT_JUMPSTD, ELEVATOR_BUTTON_SCRIPT

	def_object_events
	object_event 13,  5, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore2FClerk1Script, -1
	object_event 13,  6, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore2FClerk2Script, -1
	object_event  9,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodDeptStore2FYoungsterText, -1
	object_event  6,  2, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodDeptStore2FCooltrainerFText, -1
	object_event  2,  6, SPRITE_GENTLEMAN, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodDeptStore2FGentlemanText, -1

	object_const_def
	const GOLDENRODDEPTSTORE2F_CLERK1
	const GOLDENRODDEPTSTORE2F_CLERK2
	const GOLDENRODDEPTSTORE2F_YOUNGSTER
	const GOLDENRODDEPTSTORE2F_COOLTRAINER_F
	const GOLDENRODDEPTSTORE2F_GENTLEMAN

GoldenrodDeptStore2F_MapScripts:
	def_scene_scripts

	def_callbacks

GoldenrodDeptStore2FClerk1Script:
	faceplayer
	jumpstd VariableMartScript

GoldenrodDeptStore2FClerk2Script:
	faceplayeropentext
	pokemart MARTTYPE_STANDARD, MART_GOLDENROD_2F_2
	endtext

GoldenrodDeptStore2FYoungsterText:
	text "Your #Gear can"
	line "store many phone"
	cont "numbers!"
	
	para "There's no need to"
	line "delete anyone."
	done

GoldenrodDeptStore2FCooltrainerFText:
	text "I won enough coins"
	line "to finally get a"
	cont "Porygon from the"
	cont "Game Corner."

	para "It's now my best"
	line "partner."
	done

GoldenrodDeptStore2FGentlemanText:
	text "This Dept.Store"
	line "makes me realize"
	cont "that Goldenrod is"
	cont "a big city."

	para "The selection here"
	line "is unmatched any-"
	cont "where else."
	done

GoldenrodDeptStore2FDirectoryText:
	text "Your Travel"
	line "Companion"

	para "2F Trainer's"
	line "   Market"
	done
