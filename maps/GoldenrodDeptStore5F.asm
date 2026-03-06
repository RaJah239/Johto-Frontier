GoldenrodDeptStore5F_MapEvents:
	def_warp_events
	warp_event 12,  0, GOLDENROD_DEPT_STORE_4F, 1
	warp_event 15,  0, GOLDENROD_DEPT_STORE_6F, 1
	warp_event  2,  0, GOLDENROD_DEPT_STORE_ELEVATOR, 1

	def_coord_events

	def_bg_events
	bg_event 14,  0, BGEVENT_JUMPTEXT, GoldenrodDeptStore5FDirectoryText
	bg_event  3,  0, BGEVENT_JUMPSTD, ELEVATOR_BUTTON_SCRIPT

	def_object_events
	object_event  8,  5, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore5FPunchTutorScript, -1
	object_event  3,  6, SPRITE_LASS, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodDeptStore5FLassText, -1
	object_event  6,  3, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Mike, -1
	object_event 13,  5, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodDeptStore5FPokefanMText, -1
	object_event  7,  5, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore5FReceptionistScript, EVENT_GOLDENROD_DEPT_STORE_5F_HAPPINESS_EVENT_LADY
	object_event  9,  1, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore5FMysteryGiftCarrieScript, -1

	object_const_def
	const GOLDENRODDEPTSTORE5F_CLERK
	const GOLDENRODDEPTSTORE5F_LASS
	const GOLDENRODDEPTSTORE5F_MIKE
	const GOLDENRODDEPTSTORE5F_POKEFAN_M
	const GOLDENRODDEPTSTORE5F_RECEPTIONIST
	const GOLDENRODDEPTSTORE5F_CARRIE

GoldenrodDeptStore5F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, GoldenrodDeptStore5FCheckIfSundayCallback

GoldenrodDeptStore5FCheckIfSundayCallback:
	readvar VAR_WEEKDAY
	ifequal SUNDAY, .yes
	disappear GOLDENRODDEPTSTORE5F_RECEPTIONIST
	endcallback

.yes
	appear GOLDENRODDEPTSTORE5F_RECEPTIONIST
	endcallback

GoldenrodDeptStore5FPunchTutorScript:
	; TODOTEXT
	; add elemental punches tutor here
	end

GoldenrodDeptStore5FReceptionistScript:
	faceplayeropentext
	readvar VAR_WEEKDAY
	ifnotequal SUNDAY, .EventIsOver
	checkflag ENGINE_GOLDENROD_DEPT_STORE_TM_GIVEAWAY
	iftrue .EventIsOver
	special GetFirstPokemonHappiness
	writethistext
		text "Hello. Oh, your"
		line "#mon…"
		done
	promptbutton
	ifgreater 150 - 1, .VeryHappy
	ifgreater 50 - 1, .SomewhatHappy
.NotVeryHappy:
	checkevent EVENT_TM_FAIRY_FLASH
	iftrue .YouCantGetAnother
	writethistext
		text "It looks evil. How"
		line "about this TM for"
		cont "it?"
		done
	promptbutton
	verbosegiveitem TM_AURA_SPHERE
	iffalse_endtext
	setevent EVENT_TM_FAIRY_FLASH
	setflag ENGINE_GOLDENROD_DEPT_STORE_TM_GIVEAWAY
	endtext

.VeryHappy:
	checkevent EVENT_TM_DARK_PULSE
	iftrue .YouCantGetAnother
	writethistext
		text "It's very attached"
		line "to you."

		para "This move should"
		line "be perfect for a"
		cont "pair like you."
		done
	promptbutton
	verbosegiveitem TM_RETURN
	iffalse_endtext
	setevent EVENT_TM_DARK_PULSE
	setflag ENGINE_GOLDENROD_DEPT_STORE_TM_GIVEAWAY
	endtext

.SomewhatHappy:
	jumpthisopenedtext
		text "It's adorable!"

		para "You should teach"
		line "it good TM moves."
		done

.EventIsOver:
	jumpthisopenedtext
		text "There are sure to"
		line "be TMs that are"
		cont "just perfect for"
		cont "your #mon."
		done

.YouCantGetAnother:
	jumpthisopenedtext
		text "I'm sorry."

		para "There are two TMs"
		line "that can be gotten"
		cont "here but only once"
		cont "each."
		done

GoldenrodDeptStore5FLassText:
	text "On Sundays, a lady"
	line "comes to check out"
	cont "#mon."

	para "She gives away TMs"
	line "based on how happy"
	cont "or not the first"
	cont "#mon in your"
	cont "party is."
	done

GoldenrodDeptStore5FPokefanMText:
	text "You can rename any"
	line "#mon you want,"
	cont "even those obtain-"
	cont "ed in trades."
	done

GoldenrodDeptStore5FDirectoryText:
	text "Customize Your"
	line "#mon"

	para "5F Tutor Corner"
	done

Mike:
	faceplayeropentext
	trade NPC_TRADE_MIKE
	waitendtext

GoldenrodDeptStore5FMysteryGiftCarrieScript:
	faceplayeropentext
	checkflag ENGINE_DAILY_MYSTERY_GIFT
	iftrue .NoGift
	writethistext
		text "Mystery Gift!"
		line "Mystery Gift!"

		para "Do you want to"
		line "share a Mystery"
		cont "Gift?"
		done
	yesorno
	iffalse .Decline
	readvar VAR_ITEM_POCKET
	
	; compare to DEF MAX_ITEMS
	; compare to DEF MAX_BALLS
	; read if pockets has space for 3 items
	ifgreater 16, .ItemsNearlyFull
	readvar VAR_BALL_POCKET
	ifgreater 8, .BallsNearlyFull

.AskSave
	setflag ENGINE_DAILY_MYSTERY_GIFT
	writethistext
		text "You need to save"
		line "your game before"
		cont "we share, okay?"
		done
	yesorno
	iffalse .Decline
	special TryQuickSave
	iffalse .Decline
	writethistext
		text "Okay! Let's link"
		line "up for a sec!"
		done
	playsound SFX_MOVE_DELETED
	waitsfx
	callstd MysteryGiftCarrieScript
	iffalse .NoRoom
	callstd MysteryGiftCarrieScript
	iffalse .NoRoom
	callstd MysteryGiftCarrieScript
	iffalse .NoRoom
	writethistext
		text "Wow, I got really"
		line "cool items today!"

		para "I hope you got"
		line "something good!"

		para "Let's do this"
		line "again tomorrow!"
		done
	waitclosetext
	turnobject LAST_TALKED, DOWN
	end

.NoRoom
	writethistext
		text "I guess too many"
		line "people shared with"
		cont "you! Hehe!"
		done
	turnobject LAST_TALKED, DOWN
	end

.NoGift
	writethistext
		text "We've already"
		line "shared today."

		para "But I'd be happy"
		line "to share again"
		cont "tomorrow."
		done
	waitclosetext
	turnobject LAST_TALKED, DOWN
	end

.Decline
	clearflag ENGINE_DAILY_MYSTERY_GIFT
	writethistext
		text "Oh…"

		para "Some other time,"
		line "okay?"
	 	done
	waitclosetext
	turnobject LAST_TALKED, DOWN
	end

.ItemsNearlyFull
	writethistext
		text "…You don't have"
		line "much space in your"
		cont "Item Pocket."
		done
	waitbutton
	sjump .AskContinueAnyway

.BallsNearlyFull
	writethistext
		text "…You don't have"
		line "much space in your"
		cont "Ball Pocket."
		done
	waitbutton
.AskContinueAnyway
	writethistext
		text "Do you want to"
		line "use Mystery Gift"
		cont "anyway?"
		done
	yesorno
	iffalse .Decline
	sjump .AskSave
