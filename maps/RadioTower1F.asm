RadioTower1F_MapEvents:
	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 12
	warp_event  3,  7, GOLDENROD_CITY, 12
	warp_event 15,  0, RADIO_TOWER_2F, 2

	def_coord_events

	def_bg_events
	bg_event  3,  0, BGEVENT_JUMPTEXT, RadioTower1FDirectoryText
	bg_event 13,  0, BGEVENT_JUMPTEXT, RadioTower1FRaffleSignText

	def_object_events
	object_event  5,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, RadioTower1FReceptionistWelcomeText, -1
	object_event 16,  4, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, RadioTower1FLassText, -1
	object_event 15,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, RadioTower1FYoungsterText, -1
	object_event  8,  6, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RadioTower1FRaffleManScript, -1
	object_event 12,  6, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, RadioTower1FRadioCardWomanScript, -1
	object_event  2,  2, SPRITE_FISHER, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_PINK, OBJECTTYPE_COMMAND, jumptextfaceplayer, RadioTowerFisherText, -1

	object_const_def
	const RADIOTOWER1F_RECEPTIONIST
	const RADIOTOWER1F_LASS
	const RADIOTOWER1F_YOUNGSTER
	const RADIOTOWER1F_RAFFLEMAN
	const RADIOTOWER1F_CARD_WOMAN
	const RADIOTOWER1F_FISHER

RadioTower1F_MapScripts:
	def_scene_scripts

	def_callbacks

RadioTower1FRaffleManScript:
	; use special TryQuickSave to take money first
	; use speical displymoney too to see lost money
	end

RadioTower1FRadioCardWomanScript:
	faceplayeropentext
	checkflag ENGINE_RADIO_CARD
	iftrue .GotCard
	writethistext
		text "We have a special"
		line "quiz campaign on"
		cont "right now."

		para "Answer five ques-"
		line "tions correctly to"
		cont "win a Radio Card."

		para "Slide it into your"
		line "#Gear to play"
		cont "the radio anytime,"
		cont "anywhere."

		para "Would you like to"
		line "take the quiz?"
		done
	yesorno
	iffalse .NoQuiz
	writethistext
		text "Question 1:"

		para "Is there a #mon"
		line "that appears only"
		cont "in the morning?"
		done
	yesorno
	iffalse .WrongAnswer
	playsound SFX_ELEVATOR_END
	waitsfx
	writethistext
		text "Correct!"
		line "Question 2:"

		para "Is this statement"
		line "correct?"

		para "You can't buy a"
		line "Berry at a Mart."
		done
	yesorno
	iffalse .WrongAnswer
	playsound SFX_ELEVATOR_END
	waitsfx
	writethistext
		text "Bull's-eye!"
		line "Question 3:"

		para "Does TM01 contain"
		line "the move Trick?"
		done
	yesorno
	iftrue .WrongAnswer
	playsound SFX_ELEVATOR_END
	waitsfx
	writethistext
		text "So far so good!"
		line "Question 4:"

		para "Is Falkner the"
		line "Violet Gym Leader"
		cont "who uses flying"
		cont "type #mon?"
		done
	yesorno
	iffalse .WrongAnswer
	playsound SFX_ELEVATOR_END
	waitsfx
	writethistext
		text "Wow! Right again!"
		line "Here's the final"
		cont "question:"

		para "Do Goldenrod Game"
		line "Corner's slots"
		cont "have Charmander"
		cont "on their reels?"
		done
	yesorno
	iftrue .WrongAnswer
	playsound SFX_ELEVATOR_END
	waitsfx
	writethistext
		text "Bingo! You got it!"
		line "Congratulations!"

		para "Here's your prize,"
		line "a Radio Card!"
		done
	promptbutton
	getstring STRING_BUFFER_4, .RadioCardText
	callstd ReceiveItemScript
	writethistext
		text "<PLAYER>'s #Gear"
		line "can now double as"
		cont "a radio!"
		done
	promptbutton
	setflag ENGINE_RADIO_CARD
.GotCard:
	jumpthisopenedtext
		text "Please tune in to"
		line "our radio shows."
		done

.RadioCardText:
	db "Radio Card@"

.WrongAnswer:
	playsound SFX_WRONG
	jumpthisopenedtext
		text "Oh, dear."
		line "Sorry, but you"

		para "got it wrong."
		line "Please try again!"
		done

.NoQuiz:
	jumpthisopenedtext
		text "Oh. I see. Please"
		line "see me if you"
		cont "change your mind."
		done

RadioTower1FLassText:
	text "Ben is a fabulous"
	line "DJ."

	para "His sweet voice"
	line "makes me melt!"
	done

RadioTower1FYoungsterText:
	text "I love Mary, from"
	line "#mon Talk."
	done

RadioTowerFisherText:
	text "I've lost so much"
	line "money at the"
	cont "raffle…"

	para "It's so addictive"
	line "that is should've"
	cont "had a warning!"
	done

RadioTower1FReceptionistWelcomeText:
	text "Welcome!"
	done

RadioTower1FDirectoryText:
	text "1F Reception"
	line "2F Sales"

	para "3F Personnel"
	line "4F Production"

	para "5F Director's"
	line "   Office"
	done

RadioTower1FRaffleSignText:
	text "Goldenrod's Raffle!"

	para "For ¥500 per try,"
	line "get the chance to"
	cont "win a random item"
	cont "or bust!"

	para "Try your luck!"
	done
