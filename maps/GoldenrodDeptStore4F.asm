GoldenrodDeptStore4F_MapEvents:
	def_warp_events
	warp_event 12,  0, GOLDENROD_DEPT_STORE_5F, 1
	warp_event 15,  0, GOLDENROD_DEPT_STORE_3F, 2
	warp_event  2,  0, GOLDENROD_DEPT_STORE_ELEVATOR, 1

	def_coord_events

	def_bg_events
	bg_event 14,  0, BGEVENT_JUMPTEXT, GoldenrodDeptStore4FDirectoryText
	bg_event  3,  0, BGEVENT_JUMPSTD, ELEVATOR_BUTTON_SCRIPT

	def_object_events
	object_event 13,  5, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore4FClerkScript, -1
	object_event 11,  7, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodDeptStore4FCooltrainerMText, -1
	object_event  7,  2, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodDeptStore4FBugCatcherText, -1
	object_event  5,  1, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore4FGameboyKidScript, -1

	object_const_def
	const GOLDENRODDEPTSTORE4F_CLERK
	const GOLDENRODDEPTSTORE4F_COOLTRAINER_M
	const GOLDENRODDEPTSTORE4F_BUG_CATCHER
	const GOLDENRODDEPTSTORE4F_GAMEBOY_KID

GoldenrodDeptStore4F_MapScripts:
	def_scene_scripts

	def_callbacks

GoldenrodDeptStore4FClerkScript:
	faceplayer
	opentext
	pokemart MARTTYPE_STANDARD, MART_GOLDENROD_4F
	closetext
	end

GoldenrodDeptStore4FGameboyKidScript:
	showthistextfaceplayer
		text "Some #mon"
		line "evolve only by"
		cont "being traded via a"
		cont "Game Link cable."

		para "I hear there's a"
		line "kid in Mahogany"
		cont "Town that can help"
		cont "with those."

		para "Also, your #dex"
	 	line "shows this and a"
	 	cont "lot more!"	
		done
	turnobject GOLDENRODDEPTSTORE4F_GAMEBOY_KID, DOWN
	end

GoldenrodDeptStore4FCooltrainerMText:
	text "Hey. I love strong"
	line "#mon."

	para "I feed them Pro-"
	line "tein to crank up"
	cont "their Attack."
	done

GoldenrodDeptStore4FBugCatcherText:
	text "Iron adds to your"
	line "#mon's Defense."
	done

GoldenrodDeptStore4FDirectoryText:
	text "Let Us Pump Up"
	line "Your #mon!"

	para "4F Medicine Box"
	done
