Route8NationalParkGate_MapEvents:
	def_warp_events
	warp_event  0,  4, NATIONAL_PARK, 2
	warp_event  0,  5, NATIONAL_PARK, 3
	warp_event  9,  4, ROUTE_8, 1
	warp_event  9,  5, ROUTE_8, 2

	def_coord_events

	def_bg_events
	bg_event  6,  0, BGEVENT_JUMPTEXT, BugCatchingContestExplanationText

	def_object_events
	object_event  0,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route8OfficerScriptContest, EVENT_ROUTE_8_NATIONAL_PARK_GATE_OFFICER_CONTEST_DAY
	object_event  2,  5, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant1BScript, EVENT_BUG_CATCHING_CONTESTANT_1B
	object_event  4,  5, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant2BScript, EVENT_BUG_CATCHING_CONTESTANT_2B
	object_event  2,  6, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant3BScript, EVENT_BUG_CATCHING_CONTESTANT_3B
	object_event  6,  5, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant4BScript, EVENT_BUG_CATCHING_CONTESTANT_4B
	object_event  2,  7, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant5BScript, EVENT_BUG_CATCHING_CONTESTANT_5B
	object_event  5,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant6BScript, EVENT_BUG_CATCHING_CONTESTANT_6B
	object_event  3,  6, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant7BScript, EVENT_BUG_CATCHING_CONTESTANT_7B
	object_event  4,  7, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant8BScript, EVENT_BUG_CATCHING_CONTESTANT_8B
	object_event  6,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant9BScript, EVENT_BUG_CATCHING_CONTESTANT_9B
	object_event  6,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant10BScript, EVENT_BUG_CATCHING_CONTESTANT_10B
	object_event  3,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route8NationalParkGateOfficerScript, EVENT_ROUTE_8_NATIONAL_PARK_GATE_OFFICER_NOT_CONTEST_DAY

	object_const_def
	const ROUTE8NATIONALPARKGATE_OFFICER1
	const ROUTE8NATIONALPARKGATE_YOUNGSTER1
	const ROUTE8NATIONALPARKGATE_YOUNGSTER2
	const ROUTE8NATIONALPARKGATE_ROCKER
	const ROUTE8NATIONALPARKGATE_POKEFAN_M
	const ROUTE8NATIONALPARKGATE_YOUNGSTER3
	const ROUTE8NATIONALPARKGATE_YOUNGSTER4
	const ROUTE8NATIONALPARKGATE_LASS
	const ROUTE8NATIONALPARKGATE_YOUNGSTER5
	const ROUTE8NATIONALPARKGATE_YOUNGSTER6
	const ROUTE8NATIONALPARKGATE_YOUNGSTER7
	const ROUTE8NATIONALPARKGATE_OFFICER2

Route8NationalParkGate_MapScripts:
	def_scene_scripts
	scene_script Route8NationalParkGateNoop1Scene,             SCENE_ROUTE8NATIONALPARKGATE_NOOP
	scene_script Route8NationalParkGateNoop2Scene,             SCENE_ROUTE8NATIONALPARKGATE_UNUSED
	scene_script Route8NationalParkGateLeaveContestEarlyScene, SCENE_ROUTE8NATIONALPARKGATE_LEAVE_CONTEST_EARLY

	def_callbacks
	callback MAPCALLBACK_NEWMAP, Route8NationalParkGateCheckIfContestRunningCallback
	callback MAPCALLBACK_OBJECTS, Route8NationalParkGateCheckIfContestAvailableCallback

Route8NationalParkGateLeaveContestEarlyScene:
	sdefer Route8NationalParkGateLeavingContestEarlyScript
Route8NationalParkGateNoop1Scene:
Route8NationalParkGateNoop2Scene:
	end

Route8NationalParkGateCheckIfContestRunningCallback:
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue .BugContestIsRunning
	setscene SCENE_ROUTE8NATIONALPARKGATE_NOOP
	endcallback

.BugContestIsRunning:
	setscene SCENE_ROUTE8NATIONALPARKGATE_LEAVE_CONTEST_EARLY
	endcallback

Route8NationalParkGateCheckIfContestAvailableCallback:
	checkevent EVENT_WARPED_FROM_ROUTE_7_NATIONAL_PARK_GATE
	iftrue .Return
	readvar VAR_WEEKDAY
	ifequal TUESDAY, .SetContestOfficer
	ifequal THURSDAY, .SetContestOfficer
	ifequal SATURDAY, .SetContestOfficer
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue .SetContestOfficer
	disappear ROUTE8NATIONALPARKGATE_OFFICER1
	appear ROUTE8NATIONALPARKGATE_OFFICER2
	endcallback

.SetContestOfficer:
	appear ROUTE8NATIONALPARKGATE_OFFICER1
	disappear ROUTE8NATIONALPARKGATE_OFFICER2
.Return:
	endcallback

Route8NationalParkGateLeavingContestEarlyScript:
	turnobject PLAYER, UP
	opentext
	readvar VAR_CONTESTMINUTES
	addval 1
	getnum STRING_BUFFER_3
	writetext Route8NationalParkGateOfficer1WantToFinishText
	yesorno
	iffalse .GoBackToContest
	writethistext
		text "OK. Please wait"
		line "here for the"
		cont "announcement of"
		cont "the winners."
		done
	waitclosetext
	special FadeOutToBlack
	special ReloadSpritesNoPalettes
	scall .CopyContestants
	disappear ROUTE8NATIONALPARKGATE_OFFICER1
	appear ROUTE8NATIONALPARKGATE_OFFICER2
	applymovement PLAYER, Route8NationalParkGatePlayerWaitWithContestantsMovement
	pause 15
	special FadeInFromBlack
	jumpstd BugContestResultsScript

.GoBackToContest:
	writethistext
		text "OK. Please go back"
		line "outside and finish"
		cont "up."
		done
	waitclosetext
	turnobject PLAYER, LEFT
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	warpfacing LEFT, NATIONAL_PARK_BUG_CONTEST, 33, 18
	end

.CopyContestants:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_1A
	iftrue .Not1
	appear ROUTE8NATIONALPARKGATE_YOUNGSTER1
.Not1:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_2A
	iftrue .Not2
	appear ROUTE8NATIONALPARKGATE_YOUNGSTER2
.Not2:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_3A
	iftrue .Not3
	appear ROUTE8NATIONALPARKGATE_ROCKER
.Not3:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_4A
	iftrue .Not4
	appear ROUTE8NATIONALPARKGATE_POKEFAN_M
.Not4:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_5A
	iftrue .Not5
	appear ROUTE8NATIONALPARKGATE_YOUNGSTER3
.Not5:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_6A
	iftrue .Not6
	appear ROUTE8NATIONALPARKGATE_YOUNGSTER4
.Not6:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_7A
	iftrue .Not7
	appear ROUTE8NATIONALPARKGATE_LASS
.Not7:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_8A
	iftrue .Not8
	appear ROUTE8NATIONALPARKGATE_YOUNGSTER5
.Not8:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_9A
	iftrue .Not9
	appear ROUTE8NATIONALPARKGATE_YOUNGSTER6
.Not9:
	checkevent EVENT_BUG_CATCHING_CONTESTANT_10A
	iftrue .Not10
	appear ROUTE8NATIONALPARKGATE_YOUNGSTER7
.Not10:
	special UpdateSprites
	end

Route8NationalParkGateOfficer1WantToFinishText:
	text "You still have @"
	text_ram wStringBuffer3
	text_start
	line "minute(s) left."

	para "Do you want to"
	line "finish now?"
	done

Route8NationalParkGatePlayerWaitWithContestantsMovement:
	big_step DOWN
	big_step RIGHT
	turn_head UP
	step_end

Route8OfficerScriptContest:
	readvar VAR_WEEKDAY
	ifequal SUNDAY, _ContestNotOn
	ifequal MONDAY, _ContestNotOn
	ifequal WEDNESDAY, _ContestNotOn
	ifequal FRIDAY, _ContestNotOn
	faceplayeropentext
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue Route8Officer_ContestHasConcluded
	callstd DayToTextScript
	writetext Route78NationalParkGateOfficer1AskToParticipateText
	yesorno
	iffalse .DecidedNotToJoinContest
	readvar VAR_PARTYCOUNT
	ifgreater 1, .LeaveMonsWithOfficer
	special ContestDropOffMons
	clearevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
.ResumeStartingContest:
	setflag ENGINE_BUG_CONTEST_TIMER
	special PlayMapMusic
	writethistext
		text "Here are the Park"
		line "Balls for the"
		cont "Contest."
		done
	promptbutton
	waitsfx
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
	setflag ENGINE_BUG_CONTEST_TIMER
	special GiveParkBalls
	turnobject PLAYER, LEFT
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	special SelectRandomBugContestContestants
	warpfacing LEFT, NATIONAL_PARK_BUG_CONTEST, 33, 18
	end

.LeaveMonsWithOfficer:
	readvar VAR_PARTYCOUNT
	ifless PARTY_LENGTH, .ContinueLeavingMons
	readvar VAR_BOXSPACE
	ifequal 0, .BoxFull
.ContinueLeavingMons:
	special CheckFirstMonIsEgg
	ifequal TRUE, .FirstMonIsEgg
	writetext Route8NationalParkGateOfficer1AskToUseFirstMonText
	yesorno
	iffalse .RefusedToLeaveMons
	special ContestDropOffMons
	iftrue .FirstMonIsFainted
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
	sjump .ResumeStartingContest

.DecidedNotToJoinContest:
	jumpthisopenedtext
		text "OK. We hope you'll"
		line "take part in the"
		cont "future."
		done

.RefusedToLeaveMons:
	jumpthisopenedtext
		text "Please choose the"
		line "#mon to be used"
		cont "in the Contest,"
		cont "then come see me."
		done

.FirstMonIsFainted:
	jumpthisopenedtext
	text "Uh-oh…"
	line "The first #mon"
	cont "in your party"
	cont "can't battle."

	para "Please switch it"
	line "with the #mon"
	cont "you want to use,"
	cont "then come see me."
	done

.BoxFull:
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

.FirstMonIsEgg:
	jumpthisopenedtext
		text "Uh-oh…"
		line "You have an Egg as"
		cont "the first #mon"
		cont "in your party."

		para "Please switch it"
		line "with the #mon"
		cont "you want to use,"
		cont "then come see me."
		done

Route8NationalParkGateOfficer1AskToUseFirstMonText:
	text "Uh-oh…"

	para "You have more than"
	line "one #MON."

	para "You'll have to use"
	line "@"
	text_ram wStringBuffer3
	text ", the"

	para "first #MON in"
	line "your party."

	para "Is that OK with"
	line "you?"
	done

Route8Officer_ContestHasConcluded:
	checkevent EVENT_CONTEST_OFFICER_HAS_SUN_STONE
	iftrue .Sunstone
	checkevent EVENT_CONTEST_OFFICER_HAS_MOON_STONE
	iftrue .Everstone
	checkevent EVENT_CONTEST_OFFICER_HAS_GOLD_BERRY
	iftrue .GoldBerry
	checkevent EVENT_CONTEST_OFFICER_HAS_BERRY
	iftrue .Berry
	jumpthisopenedtext
		text "Today's Contest is"
		line "over. We hope you"
		cont "will participate"
		cont "in the future."
		done

.Sunstone:
	writetext Route8NationalParkGateOfficer1HeresThePrizeText
	promptbutton
	verbosegiveitem SUN_STONE
	iffalse .BagFull
	clearevent EVENT_CONTEST_OFFICER_HAS_SUN_STONE
	endtext

.Everstone:
	writetext Route8NationalParkGateOfficer1HeresThePrizeText
	promptbutton
	verbosegiveitem MOON_STONE
	iffalse .BagFull
	clearevent EVENT_CONTEST_OFFICER_HAS_MOON_STONE
	endtext

.GoldBerry:
	writetext Route8NationalParkGateOfficer1HeresThePrizeText
	promptbutton
	verbosegiveitem GOLD_BERRY
	iffalse .BagFull
	clearevent EVENT_CONTEST_OFFICER_HAS_GOLD_BERRY
	endtext

.Berry:
	writetext Route8NationalParkGateOfficer1HeresThePrizeText
	promptbutton
	verbosegiveitem BERRY
	iffalse .BagFull
	clearevent EVENT_CONTEST_OFFICER_HAS_BERRY
	endtext

.BagFull:
	jumpthisopenedtext
		text "Uh-oh… Your Bag"
		line "is full."

		para "We'll hold on to"
		line "your prize, but"
		cont "only for today."

		para "Please make room,"
		line "then come see me."
		done

Route8NationalParkGateOfficer1HeresThePrizeText:
	text "<PLAYER>?"

	para "Here's the prize"
	line "we were holding"
	cont "for you."
	done

_ContestNotOn:
	jumptextfaceplayer Route8NationalParkGateOfficer1SomeMonOnlySeenInParkText

Route8NationalParkGateOfficer1SomeMonOnlySeenInParkText:
	text "Some #MON can"
	line "only be seen in"
	cont "the PARK."
	done

Route8NationalParkGateOfficerScript:
	faceplayeropentext
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue Route8Officer_ContestHasConcluded
	writetext Route8NationalParkGateOfficer1SomeMonOnlySeenInParkText
	waitendtext

BugCatchingContestant1BScript: ; TODOTEXT ensure these are aligned with trainer names + change these labels and events attached to objects to the right names
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	jumpthistextfaceplayer
		text "Don: Wow, you beat"
		line "me. You're pretty"
		cont "good."
		done

.StillCompeting:
	jumpthistextfaceplayer
		text "Don: Luck plays a"
		line "big part in this."

		para "You never know"
		line "what #mon will"
		cont "appear."
		done

BugCatchingContestant2BScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	jumpthistextfaceplayer
		text "Al: I envy you."
		line "I just couldn't"
		cont "do it this time."
		done

.StillCompeting:
	jumpthistextfaceplayer
		text "Al: Maybe you win"
		line "with big #mon?"
		done

BugCatchingContestant3BScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	jumpthistextfaceplayer
		text "Nick: Well done!"
		line "I'm going to raise"
		cont "my #mon better."
		done

.StillCompeting:
	jumpthistextfaceplayer
		text "Nick: Maybe you"
		line "get a higher score"
		cont "for a #mon of"
		cont "an unusual color."
		done

BugCatchingContestant4BScript:

	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	jumpthistextfaceplayer
		text "William: You're"
		line "the winner? What"
		cont "did you catch?"
		done

.StillCompeting:
	jumpthistextfaceplayer
		text "William: Well, I'm"
		line "satisfied because"
		cont "I caught a #mon"
		cont "that I wanted."
		done

BugCatchingContestant5BScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	jumpthistextfaceplayer
		text "Benny: Congrats!"
		line "You have earned my"
		cont "respect!"
		done

.StillCompeting:
	jumpthistextfaceplayer
		text "Benny: I caught a"
		line "Scyther before,"
		cont "but I didn't win."
		done

BugCatchingContestant6BScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	jumpthistextfaceplayer
		text "Ted: That #-"
		line "mon you caught…"
		cont "it's awesome!"
		done

.StillCompeting:
	jumpthistextfaceplayer
		text "Ted: It's easier"
		line "to win if you get"
		cont "a high-level bug"
		cont "#mon."

		para "But I think they"
		line "also consider some"
		cont "other points."
		done

BugCatchingContestant7BScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	jumpthistextfaceplayer
		text "Erin: You won?"
		line "That's great!"

		para "Do you feel like"
		line "looking for bug"
		cont "#mon with me?"
		done

.StillCompeting:
	jumpthistextfaceplayer
		text "Erin: I really"
		line "love bug #mon!"
		done

BugCatchingContestant8BScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	jumpthistextfaceplayer
		text "Josh: I… I can't"
		line "believe I lost at"
		cont "bug-catching…"
		done

.StillCompeting:
	jumpthistextfaceplayer
		text "Josh: I heard that"
		line "somebody won with"
		cont "a Wurmple!"
		done

BugCatchingContestant9BScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	jumpthistextfaceplayer
		text "Samuel: Next time,"
		line "I'm going to win."
		done

.StillCompeting:
	jumpthistextfaceplayer
		text "Samuel: Darn."
		line "I thought I would"
		cont "score higher…"
		done

BugCatchingContestant10BScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .StillCompeting
	jumpthistextfaceplayer
		text "Alan: Could you"
		line "give me some tips?"

		para "I want to study"
		line "your style."
		done

.StillCompeting:
	jumpthistextfaceplayer
	text "Alan: I study a"
	line "lot, but that's"

	para "not good enough to"
	line "win."
	done
