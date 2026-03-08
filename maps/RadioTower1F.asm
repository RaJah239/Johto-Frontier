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

RadioTower1FRaffleManScript: ; TODOTEXT - to adjust item list and cost to play
	opentext
	checkevent EVENT_MET_RAFFLE_MAN
	iftrue .WantToTryTheRaffle
	writethistext
		text "Welcome to Golden-"
		line "rod's Radio Tower"
		cont "Raffle!"
		
		para "For ¥100 per try,"
		line "win a random item!"

		para "What do you say?"
		done
	setevent EVENT_MET_RAFFLE_MAN
.WantToTryTheRaffle:
	special PlaceMoneyTopRight
	writetextcheckdialogue RadioTower1FRaffleManPay, RadioTower1FRaffleManPayMin
.TryAgain:
	yesorno
	iffalse_endtext
	readvar VAR_ITEM_POCKET
	ifequal VAR_ITEM_POCKET, .ItemPocketFull
	readvar VAR_BALL_POCKET
	ifequal VAR_BALL_POCKET, .BallPocketFull
	readvar VAR_BATTLE_POCKET
	ifequal VAR_BATTLE_POCKET, .BattlePocketFull
.AskSave:
	checkmoney YOUR_MONEY, 100
	ifequal HAVE_LESS, .NotEnoughMoney
	writethistext
		text "You need save"
		line "before, okay?"
		done
	yesorno
	iffalse_endtext
	takemoney YOUR_MONEY, 100
	special PlaceMoneyTopRight
	playsound SFX_TRANSACTION
	waitsfx
	special TryQuickSave
	iffalse_endtext
	callstd RaffleManNPCScript
	writethistext
		text "Try again?"
		done
	sjump .TryAgain

.NotEnoughMoney:
	jumpthisopenedtext
		text "Sorry, you don't"
		line "¥100…"
		done

.ItemPocketFull:
	writethistext
		text "Your Item Pocket"
		line "is full!"
		
		para "If an Item is won,"
		line "it'll be lost."
		done
	waitbutton
	sjump .AskContinueAnyway

.BallPocketFull:
	writethistext
		text "Your Ball Pocket"
		line "is full!"
		
		para "If a Ball is won,"
		line "it'll be lost."
		done
	waitbutton
	sjump .AskContinueAnyway

.BattlePocketFull:
	writethistext
		text "Your Battle Pocket"
		line "is full!"
		
		para "If a Battle Item"
		line "is won, it'll be"
		cont "lost."
		done
	waitbutton
.AskContinueAnyway:
	writethistext
		text "Do you want to"
		line "continue anyway?"
		done
	yesorno
	iffalse_endtext
	sjump .AskSave

RadioTower1FRaffleManPay:
		text "Would you like to"
		line "pay ¥100 for a"
		cont "random item?"
		done

RadioTower1FRaffleManPayMin:
		text "Pay ¥100 for a"
		line "random item?"
		done

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

RadioTower1FRaffleSignText: ; TODOTEXT - to adjust cost to play as above
	text "Goldenrod's Raffle!"

	para "For ¥100 per try,"
	line "win a random item!"

	para "Try your luck!"
	done
