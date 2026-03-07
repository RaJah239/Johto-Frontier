GoldenrodMansion2F_MapEvents:
	def_warp_events
	warp_event  0,  0, GOLDENROD_MANSION_1F, 1
	warp_event  1,  0, GOLDENROD_MANSION_3F, 2
	warp_event  6,  0, GOLDENROD_MANSION_3F, 3
	warp_event  7,  0, GOLDENROD_MANSION_1F, 2

	def_coord_events

	def_bg_events
	bg_event  0,  3, BGEVENT_JUMPTEXT, GoldenrodMansion2FComputerText
	bg_event  5,  8, BGEVENT_UP, GoldenrodMansion2FMeetingRoomSign
	bg_event  2,  3, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT

	def_object_events

GoldenrodMansion2F_MapScripts:
	def_scene_scripts

	def_callbacks

GoldenrodMansion2FComputerText:
	text "<PLAYER> turned on"
	line "the PC."

	para "…"

	para "Better not touch"
	line "someone else's PC."

	para "…"
	done

GoldenrodMansion2FMeetingRoomSign:
	jumpthistext
		text "Game Freak"
		line "Meeting Room"
		done
