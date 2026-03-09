NationalParkBugContest_MapEvents:
	def_warp_events
	warp_event 33, 18, ROUTE_8_NATIONAL_PARK_GATE, 1
	warp_event 33, 19, ROUTE_8_NATIONAL_PARK_GATE, 1
	warp_event 10, 47, ROUTE_7_NATIONAL_PARK_GATE, 1
	warp_event 11, 47, ROUTE_7_NATIONAL_PARK_GATE, 1

	def_coord_events

	def_bg_events
	bg_event 14, 44, BGEVENT_JUMPTEXT, NationalParkRelaxationSquareText
	bg_event 27, 31, BGEVENT_JUMPTEXT, NationalParkBattleNoticeText
	bg_event 12,  4, BGEVENT_JUMPTEXT, NationalParkTrainerTipsText
	bg_event  6, 47, BGEVENT_ITEM + FULL_HEAL, EVENT_NATIONAL_PARK_HIDDEN_FULL_HEAL

	def_object_events
	object_event 19, 29, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, BugCatchingContestant1AText, EVENT_BUG_CATCHING_CONTESTANT_1A
	object_event 28, 22, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, BugCatchingContestant2AText, EVENT_BUG_CATCHING_CONTESTANT_2A
	object_event  9, 18, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, BugCatchingContestant3AText, EVENT_BUG_CATCHING_CONTESTANT_3A
	object_event  7, 13, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, BugCatchingContestant4AText, EVENT_BUG_CATCHING_CONTESTANT_4A
	object_event 23,  9, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, BugCatchingContestant5AText, EVENT_BUG_CATCHING_CONTESTANT_5A
	object_event 27, 13, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 3, 3, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, BugCatchingContestant6AText, EVENT_BUG_CATCHING_CONTESTANT_6A
	object_event  7, 23, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, BugCatchingContestant7AText, EVENT_BUG_CATCHING_CONTESTANT_7A
	object_event 11, 27, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, BugCatchingContestant8AText, EVENT_BUG_CATCHING_CONTESTANT_8A
	object_event 16,  8, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, BugCatchingContestant9AText, EVENT_BUG_CATCHING_CONTESTANT_9A
	object_event 17, 34, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 3, 3, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, BugCatchingContestant10AText, EVENT_BUG_CATCHING_CONTESTANT_10A
	object_event 21, 45, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 1, 1, -1, -1, PAL_NPC_TEAL, OBJECTTYPE_COMMAND, jumptextfaceplayer, BugCatchingContestBlockerText, -1
	object_event 35, 12, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, NationalParkBugContestParlyzHeal, EVENT_NATIONAL_PARK_PARLYZ_HEAL
	object_event  1, 43, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, NationalParkBugContestTMDig, EVENT_NATIONAL_PARK_TM_DIG

	object_const_def
	const NATIONALPARKBUGCONTEST_YOUNGSTER1
	const NATIONALPARKBUGCONTEST_YOUNGSTER2
	const NATIONALPARKBUGCONTEST_ROCKER
	const NATIONALPARKBUGCONTEST_POKEFAN_M
	const NATIONALPARKBUGCONTEST_YOUNGSTER3
	const NATIONALPARKBUGCONTEST_YOUNGSTER4
	const NATIONALPARKBUGCONTEST_LASS
	const NATIONALPARKBUGCONTEST_YOUNGSTER5
	const NATIONALPARKBUGCONTEST_YOUNGSTER6
	const NATIONALPARKBUGCONTEST_YOUNGSTER7
	const NATIONALPARKBUGCONTEST_YOUNGSTER8
	const NATIONALPARKBUGCONTEST_POKE_BALL1
	const NATIONALPARKBUGCONTEST_POKE_BALL2

NationalParkBugContest_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .Weather

.Weather:
    checktime EVE | NITE
    iftrue .skipWeather
	setval WEATHER_SUN
	writemem wFieldWeather
.skipWeather
		endcallback


BugCatchingContestant1AText:
	text "Don: I'm going to"
	line "win! Don't bother"
	cont "me."
	done

BugCatchingContestant2AText:
	text "Al: I'll trying"
	line "paralyzing #mon"
	cont "before attempting"
	cont "to catch them."
	done

BugCatchingContestant3AText:
	text "Nick: I'm raising"
	line "fast #mon for"
	cont "battles."
	done

BugCatchingContestant4AText:
	text "William: I'm not"
	line "concerned about"
	cont "winning."

	para "I'm just looking"
	line "for rare #mon."
	done

BugCatchingContestant5AText:
	text "Benny: Ssh! You'll"
	line "scare off Scyther."

	para "I'll talk to you"
	line "later."
	done

BugCatchingContestant6AText:
	text "Ted: You shouldn't"
	line "weaken bug #mon"
	cont "before trying to"
	cont "capture them…"

	para "If you're trying"
	line "to win."
	done

BugCatchingContestant7AText:
	text "Erin: I love bug"
	line "#mon."

	para "I guess you must"
	line "like them too."
	done

BugCatchingContestant8AText:
	text "Josh: I've been"
	line "collecting bug"
	cont "#mon since I"
	cont "was just a baby."

	para "There's no way I'm"
	line "going to lose!"
	done

BugCatchingContestant9AText:
	text "Samuel: If you've"
	line "got the time to"
	cont "chat, go find some"
	cont "bug #mon."
	done

BugCatchingContestant10AText:
	text "Alan: I've studied"
	line "about bug #mon"
	cont "a lot."

	para "I'm going to win"
	line "for sure."
	done

BugCatchingContestBlockerText:
	text "You can't repel"
	line "#mon during the"
	cont "contest."
	done

NationalParkBugContestParlyzHeal:
	itemball PARLYZ_HEAL
NationalParkBugContestTMDig:
	itemball TM_DIG
