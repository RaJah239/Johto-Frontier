GoldenrodMansion2F_MapScripts:
	def_scene_scripts

	def_callbacks

GoldenrodMansion2FComputer:
	jumptext GoldenrodMansion2FComputerText

GoldenrodMansion2FMeetingRoomSign:
	jumptext GoldenrodMansion2FMeetingRoomSignText

GoldenrodMansion2FBookshelf:
	jumpstd DifficultBookshelfScript

GoldenrodMansion2FComputerText:
	text "<PLAYER> turned on"
	line "the PC."

	para "…"

	para "Someone was in the"
	line "middle of compos-"
	cont "ing an e-mail."

	para "…I hope you'll"
	line "come visit KANTO."

	para "I think you'll be"
	line "surprised at how"

	para "much things have"
	line "changed here."

	para "You'll also see"
	line "many #MON that"

	para "aren't native to"
	line "JOHTO."

	para "To the PRODUCER"

	para "…"
	done

GoldenrodMansion2FMeetingRoomSignText:
	text "GAME FREAK"
	line "MEETING ROOM"
	done

GoldenrodMansion2F_MapEvents:
	def_warp_events
	warp_event  0,  0, GOLDENROD_MANSION_1F, 1
	warp_event  1,  0, GOLDENROD_MANSION_3F, 2
	warp_event  6,  0, GOLDENROD_MANSION_3F, 3
	warp_event  7,  0, GOLDENROD_MANSION_1F, 2

	def_coord_events

	def_bg_events
	bg_event  0,  3, BGEVENT_READ, GoldenrodMansion2FComputer
	bg_event  5,  8, BGEVENT_UP, GoldenrodMansion2FMeetingRoomSign
	bg_event  2,  3, BGEVENT_READ, GoldenrodMansion2FBookshelf

	def_object_events
