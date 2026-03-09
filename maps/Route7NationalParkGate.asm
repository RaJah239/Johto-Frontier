Route7NationalParkGate_MapEvents:
	def_warp_events
	warp_event  3,  0, NATIONAL_PARK, 1
	warp_event  4,  0, NATIONAL_PARK, 4
	warp_event  3,  7, ROUTE_7, 3
	warp_event  4,  7, ROUTE_7, 3

	def_coord_events

	def_bg_events
	bg_event  5,  0, BGEVENT_JUMPTEXT, BugCatchingContestExplanationText

	def_object_events
	chanseyheal_event 0,  7
	object_event  2,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route7OfficerScriptContest, EVENT_ROUTE_7_NATIONAL_PARK_GATE_OFFICER_CONTEST_DAY
	object_event  6,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route7NationalParkGateYoungsterText, EVENT_ROUTE_7_NATIONAL_PARK_GATE_YOUNGSTER
	object_event  0,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route7NationalParkGateOfficerScript, EVENT_ROUTE_7_NATIONAL_PARK_GATE_OFFICER_NOT_CONTEST_DAY

	object_const_def
	const ROUTE7NATIONALPARKGATE_CHANSEY
	const ROUTE7NATIONALPARKGATE_OFFICER1
	const ROUTE7NATIONALPARKGATE_YOUNGSTER
	const ROUTE7NATIONALPARKGATE_OFFICER2

Route7NationalParkGate_MapScripts:
	def_scene_scripts
	scene_script Route7NationalParkGateNoop1Scene,             SCENE_ROUTE7NATIONALPARKGATE_NOOP
	scene_script Route7NationalParkGateNoop2Scene,             SCENE_ROUTE7NATIONALPARKGATE_UNUSED
	scene_script Route7NationalParkGateLeaveContestEarlyScene, SCENE_ROUTE7NATIONALPARKGATE_LEAVE_CONTEST_EARLY

	def_callbacks
	callback MAPCALLBACK_NEWMAP, Route7NationalParkGateCheckIfContestRunningCallback
	callback MAPCALLBACK_OBJECTS, Route7NationalParkGateCheckIfContestAvailableCallback

Route7NationalParkGateLeaveContestEarlyScene:
	sdefer Route7NationalParkGateLeavingContestEarlyScript
Route7NationalParkGateNoop1Scene:
Route7NationalParkGateNoop2Scene:
	end

Route7NationalParkGateCheckIfContestRunningCallback:
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue Route7NationalParkBugContestIsRunningScript
	setscene SCENE_ROUTE7NATIONALPARKGATE_NOOP
	endcallback

Route7NationalParkBugContestIsRunningScript:
	setscene SCENE_ROUTE7NATIONALPARKGATE_LEAVE_CONTEST_EARLY
	endcallback

Route7NationalParkGateCheckIfContestAvailableCallback:
	readvar VAR_WEEKDAY
	ifequal TUESDAY, .SetContestOfficer
	ifequal THURSDAY, .SetContestOfficer
	ifequal SATURDAY, .SetContestOfficer
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue Route7NationalParkBugContestIsRunningScript
	disappear ROUTE7NATIONALPARKGATE_OFFICER1
	appear ROUTE7NATIONALPARKGATE_YOUNGSTER
	appear ROUTE7NATIONALPARKGATE_OFFICER2
	endcallback

.SetContestOfficer:
	appear ROUTE7NATIONALPARKGATE_OFFICER1
	disappear ROUTE7NATIONALPARKGATE_YOUNGSTER
	disappear ROUTE7NATIONALPARKGATE_OFFICER2
	endcallback

Route7NationalParkGateLeavingContestEarlyScript:
	applymovement PLAYER, Route7NationalParkGatePlayerApproachOfficer1Movement
	turnobject ROUTE7NATIONALPARKGATE_OFFICER1, RIGHT
	opentext
	readvar VAR_CONTESTMINUTES
	addval 1
	getnum STRING_BUFFER_3
	writetext Route7NationalParkGateOfficer1WantToFinishText
	yesorno
	iffalse .GoBackToContest
	writethistext
		text "OK. Please wait at"
		line "the North Gate for"

		para "the announcement"
		line "of the winners."
		done
	waitclosetext
	jumpstd BugContestResultsWarpScript

.GoBackToContest:
	writethistext
		text "OK. Please get"
		line "back outside and"
		cont "finish up."
		done
	waitclosetext
	scall Route7NationalParkGate_EnterContest
	playsound SFX_ENTER_DOOR
	special FadeOutPalettes
	waitsfx
	warpfacing UP, NATIONAL_PARK_BUG_CONTEST, 10, 47
	end

Route7NationalParkGatePlayerApproachOfficer1Movement:
	step DOWN
	turn_head LEFT
	step_end

Route7OfficerScriptContest:
	readvar VAR_WEEKDAY
	ifequal SUNDAY, Route7NationalParkGate_NoContestToday
	ifequal MONDAY, Route7NationalParkGate_NoContestToday
	ifequal WEDNESDAY, Route7NationalParkGate_NoContestToday
	ifequal FRIDAY, Route7NationalParkGate_NoContestToday
	faceplayeropentext
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue Route7NationalParkGate_ContestIsOver
	callstd DayToTextScript
	writetext Route7NationalParkGateOfficer1AskToParticipateText
	yesorno
	iffalse Route7NationalParkGate_DeclinedToParticipate
	readvar VAR_PARTYCOUNT
	ifgreater 1, Route7NationalParkGate_LeaveTheRestBehind
	special ContestDropOffMons
	clearevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
Route7NationalParkGate_OkayToProceed:
	setflag ENGINE_BUG_CONTEST_TIMER
	special PlayMapMusic
	writethistext
		text "Here are the Park"
		line "Balls for the"
		cont "Contest."
		done
	promptbutton
	writethistext
		text "<PLAYER> received"
		line "{d:BUG_CONTEST_BALLS} PARK BALLS."
		done
	playsound SFX_ITEM
	waitsfx
	writethistext
		text "The person who"
		line "gets the strong-"
		cont "est bug #mon"
		cont "with the most HP"
		cont "is the winner."

		para "You have {d:BUG_CONTEST_MINUTES}"
		line "minutes."

		para "If you run out of"
		line "Park Balls, you're"
		cont "done."

		para "You can keep the"
		line "last #mon you"
		cont "catch as your own."

		para "Go out and do your"
		line "best!"
		done
	waitclosetext
	special GiveParkBalls
	scall Route7NationalParkGate_EnterContest
	playsound SFX_ENTER_DOOR
	special FadeOutPalettes
	waitsfx
	special SelectRandomBugContestContestants
	warpfacing UP, NATIONAL_PARK_BUG_CONTEST, 10, 47
	end

Route7NationalParkGate_EnterContest:
	readvar VAR_FACING
	ifequal LEFT, Route7NationalParkGate_FacingLeft
	applymovement PLAYER, Route7NationalParkGatePlayerGoAroundOfficerAndEnterParkMovement
	end

Route7NationalParkGatePlayerGoAroundOfficerAndEnterParkMovement:
	step RIGHT
	step UP
	step UP
	step_end

Route7NationalParkGate_FacingLeft:
	applymovement PLAYER, Route7NationalParkGatePlayerEnterParkMovement
	end

Route7NationalParkGatePlayerEnterParkMovement:
	step UP
	step_end

Route7NationalParkGate_LeaveTheRestBehind:
	readvar VAR_PARTYCOUNT
	ifless PARTY_LENGTH, Route7NationalParkGate_LessThanFullParty
	readvar VAR_BOXSPACE
	ifequal 0, Route7NationalParkGate_NoRoomInBox

Route7NationalParkGate_LessThanFullParty:
	special CheckFirstMonIsEgg
	ifequal TRUE, Route7NationalParkGate_FirstMonIsEgg
	writetext Route7NationalParkGateOfficer1AskToUseFirstMonText
	yesorno
	iffalse Route7NationalParkGate_DeclinedToLeaveMonsBehind
	special ContestDropOffMons
	iftrue Route7NationalParkGate_FirstMonIsFainted
	setevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
	writethistext
		text "Fine, we'll hold"
		line "your other #mon"
		cont "while you compete."
		done
	promptbutton
	writethistext
		text "<PLAYER>'s #mon"
		line "were left with the"
		cont "Contest Helper."
		done
	playsound SFX_GOT_SAFARI_BALLS
	waitsfx
	promptbutton
	sjump Route7NationalParkGate_OkayToProceed

Route7NationalParkGate_NoRoomInBox:
	jumpthisopenedtext
		text "Uh-oh…"
		line "Both your party"
		cont "and your PC Box"
		cont "are full."

		para "You have no room"
		line "to put the bug"
		cont "#mon you catch."

		para "Please make room"
		line "in your party or"
		cont "your PC Box, then"
		cont "come see me."
		done

Route7NationalParkGate_DeclinedToParticipate:
	jumpthisopenedtext
		text "OK. We hope you'll"
		line "take part in the"
		cont "future."
		done

Route7NationalParkGate_DeclinedToLeaveMonsBehind:
	jumpthisopenedtext
		text "Please choose the"
		line "#mon to be used"
		cont "in the Contest,"
		cont "then come see me."
		done

Route7NationalParkGate_FirstMonIsFainted:
	jumpthisopenedtext
		text "Uh-oh…"

		para "The first #mon"
		line "in your party"
		cont "can't battle."

		para "Please switch it"
		line "with the #mon"
		cont "you want to use,"
		cont "then come see me."
		done

Route7NationalParkGate_FirstMonIsEgg:
	jumpthisopenedtext
		text "Uh-oh…"

		para "You have an Egg as"
		line "the first #mon"
		cont "in your party."

		para "Please switch it"
		line "with the #mon"
		cont "you want to use,"
		cont "then come see me."
		done

Route7NationalParkGate_ContestIsOver:
	jumpthisopenedtext
		text "Today's Contest is"
		line "over. We hope you"
		cont "will participate"
		cont "in the future."
		done

Route7NationalParkGateOfficer1AskToUseFirstMonText:
	text "Uh-oh…"

	para "You have more than"
	line "one #mon."

	para "You'll have to use"
	line "@"
	text_ram wStringBuffer3
	text ", the"
	cont "first #mon in"
	cont "your party."

	para "Is that OK with"
	line "you?"
	done

Route7NationalParkGate_NoContestToday:
	jumptextfaceplayer Route7NationalParkGateOfficer1WeHoldContestsText

Route7NationalParkGateOfficerScript:
	faceplayeropentext
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue Route7NationalParkGate_ContestIsOver
	writetext Route7NationalParkGateOfficer1WeHoldContestsText
	waitendtext

Route7NationalParkGateOfficer1AskToParticipateText:
	text "Today's @"
	text_ram wStringBuffer3
	text "."

	para "That means the"
	line "Bug-Catching Con-"
	cont "test is on today."

	para "The rules are sim-"
	line "ple."

	para "Using one of your"
	line "#mon, catch a"
	cont "bug #mon to be"
	cont "judged."

	para "Would you like to"
	line "give it a try?"
	done

Route7NationalParkGateOfficer1WantToFinishText:
	text "You still have @"
	text_ram wStringBuffer3
	text_start
	line "minute(s) left."

	para "Do you want to"
	line "finish now?"
	done

Route7NationalParkGateOfficer1WeHoldContestsText:
	text "We hold Contests"
	line "regularly in the"
	cont "Park. You should"
	cont "give it a shot."
	done

Route7NationalParkGateYoungsterText:
	text "The Bug-Catching"
	line "contest's details"
	cont "are on the sign."
	done

BugCatchingContestExplanationText:
	text "The Bug-Catching"
	line "Contest is held on"
	cont "Tuesday, Thursday"
	cont "and Saturday."

	para "Prizes are earned"
	line "via placement."

	para "1st: Sun Stone"
	line "2nd: Moon Stone"
	cont "3rd: Gold Berry"
	cont "None: Berry"
	done
