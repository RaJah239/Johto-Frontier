PlayersHouse1F_MapEvents:
	def_warp_events
	warp_event  6,  7, NEW_BARK_TOWN, 1
	warp_event  7,  7, NEW_BARK_TOWN, 1
	warp_event  9,  0, PLAYERS_HOUSE_2F, 1

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_JUMPTEXT, PlayersHouse1FStoveScript
	bg_event  1,  1, BGEVENT_JUMPTEXT, PlayersHouse1FSinkScript
	bg_event  2,  1, BGEVENT_JUMPTEXT, PlayersHouse1FFridgeScript
	bg_event  4,  1, BGEVENT_JUMPTEXT, PlayersHouse1FTVScript

	def_object_events
	object_event  7,  4, SPRITE_MOM, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_1
	object_event  2,  2, SPRITE_MOM, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, MORN, 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_2
	object_event  7,  4, SPRITE_MOM, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, DAY, 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_2
	object_event  4,  3, SPRITE_MOM, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, EVE, 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_2
	object_event  0,  2, SPRITE_MOM, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, NITE, 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_2

	object_const_def
	const PLAYERSHOUSE1F_MOM1
	const PLAYERSHOUSE1F_MOM2
	const PLAYERSHOUSE1F_MOM3
	const PLAYERSHOUSE1F_MOM4

PlayersHouse1F_MapScripts:
	def_scene_scripts
	scene_script MeetMomFirstTimeNoop1Scene, SCENE_PLAYERSHOUSE1F_MEET_MOM
	scene_script PlayersHouse1FNoop2Scene, SCENE_PLAYERSHOUSE1F_NOOP

	def_callbacks

MeetMomFirstTimeNoop1Scene:
	sdefer MeetMomFirstTimeScript
PlayersHouse1FNoop2Scene:
	end

MeetMomFirstTimeScript: ; intro scene
	applymovement PLAYER, PlayerWalksTowardsMomMovement1
	showemote EMOTE_SHOCK, PLAYERSHOUSE1F_MOM1, 15
	turnobject PLAYERSHOUSE1F_MOM1, RIGHT
	turnobject PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	playmusic MUSIC_MOM
	applymovement PLAYER, PlayerWalksTowardsMomMovement2
	; fallthrough

MeetMomScript:
	opentext
	writetextcheckdialogue ElmsLookingForYouText, ElmsLookingForYouTextMin
	promptbutton
	getstring STRING_BUFFER_4, PokegearName
	scall PlayersHouse1FReceiveItemStd
	setflag ENGINE_POKEGEAR
	setflag ENGINE_PHONE_CARD
	addcellnum PHONE_MOM
	setscene SCENE_PLAYERSHOUSE1F_NOOP
	setevent EVENT_PLAYERS_HOUSE_MOM_1
	clearevent EVENT_PLAYERS_HOUSE_MOM_2
	writetextcheckdialogue MomGivesPokegearText, MomGivesPokegearTextMin
	promptbutton
	special SetDayOfWeek
.SetDayOfWeek:
	writethistext
		text "Is it Daylight"
		line "Saving Time now?"
		done
	yesorno
	iffalse .WrongDay
	special InitialSetDSTFlag
	yesorno
	iffalse .SetDayOfWeek
	sjump .DayOfWeekDone

.WrongDay:
	special InitialClearDSTFlag
	yesorno
	iffalse .SetDayOfWeek
.DayOfWeekDone:
	isdialogueminimal
	iftrue .skipthis
	writethistext
		text "You can change the"
		line "time on your #-"
		cont "Gear but you'll"
		cont "have come home to"
		cont "adjust your clock"
		cont "for Daylight"
		cont "Saving Time."

		para "By the way, do you"
		line "know how to use"
		cont "the Phone?"
		done
	yesorno
	iffalse .ExplainPhone
	writethistext
		text "Great!"
		done
	promptbutton
	sjump .FinishPhone

.ExplainPhone:
	writethistext
		text "I'll read the"
		line "instructions."

		para "Turn the #Gear"
		line "on and select the"
		cont "Phone icon."

		para "Phone numbers are"
		line "stored in memory."

		para "Just choose a name"
		line "you want to call."

		para "Gee, isn't that"
		line "convenient?"
		done
		promptbutton
	; fallthrough

.FinishPhone:
	writethistext
		text "Hurry along now."
		done
	waitbutton
.skipthis
	closetext
	special RestartMapMusic
	turnobject PLAYERSHOUSE1F_MOM1, LEFT
	turnobject PLAYER, DOWN
	end

PokegearName:
	db "#gear@"

PlayersHouse1FReceiveItemStd:
	jumpstd ReceiveItemScript

MomScript:
	playmusic MUSIC_MOM
	faceplayer
	opentext
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .BankOfMom
	writethistext
		text "Prof.Elm is wait-"
		line "ing for you."
		done
	waitclosetext
	special RestartMapMusic
	end

.BankOfMom:
	setevent EVENT_FIRST_TIME_BANKING_WITH_MOM
	setmapscene NEW_BARK_TOWN, SCENE_NEWBARKTOWN_NOOP
	special BankOfMom
	waitclosetext
	special RestartMapMusic
	end

PlayerWalksTowardsMomMovement1:
	step DOWN
	step_end

PlayerWalksTowardsMomMovement2:
	step LEFT
	step DOWN
	step DOWN
	step DOWN
	turn_head LEFT
	step_end

ElmsLookingForYouText:
	text "Oh, <PLAYER>…! Our"
	line "neighbor, Prof."
	cont "Elm, was looking"
	cont "for you."

	para "He, just as you"
	line "and I know that it"
	cont "is your big day."

	para "It's time for you"
	line "to go out in the"
	cont "world like you've"
	cont "always wanted and"
	cont "become a #mon"
	cont "trainer."

	para "Oh! I almost for-"
	line "got!"

	para "Your #mon Gear"
	line "is back from the"
	cont "repair shop."

	para "Here you go!"
	done

ElmsLookingForYouTextMin:
	text "Take along your"
	line "#gear…"
	done

MomGivesPokegearText:
	text "#mon Gear, or"
	line "just #Gear."

	para "It's essential if"
	line "you want to be a"
	cont "good trainer."

	para "Oh, the day of the"
	line "week isn't set."

	para "You mustn't forget"
	line "that!"
	done

MomGivesPokegearTextMin:
	text "Set the day…"
	done

PlayersHouse1FTVScript:
	text "There's a movie on"
	line "TV: Stars dot the"
	cont "sky as two boys"
	cont "ride on a train…"

	para "I'd better get"
	line "rolling too!"
	done

PlayersHouse1FStoveScript:
	text "Mom's specialty!"

	para "Cianwood Coral"
	line "Cake!"
	done

PlayersHouse1FSinkScript:
	text "The sink is spot-"
	line "less. Mom likes it"
	cont "clean."
	done

PlayersHouse1FFridgeScript:
	text "Let's see what's"
	line "in the fridge…"

	para "Fresh Water and"
	line "tasty Lemonade!"
	done
