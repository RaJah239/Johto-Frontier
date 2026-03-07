DEF GOLDENRODGAMECORNER_TM_COINS       EQU 9000
DEF GOLDENRODGAMECORNER_SMEARGLE_COINS EQU 7777
DEF GOLDENRODGAMECORNER_AXEW_COINS     EQU 8888
DEF GOLDENRODGAMECORNER_PORYGON_COINS  EQU 9999

EXPORT GOLDENRODGAMECORNER_SMEARGLE_COINS
EXPORT GOLDENRODGAMECORNER_AXEW_COINS
EXPORT GOLDENRODGAMECORNER_PORYGON_COINS

GoldenrodGameCorner_MapEvents:
	def_warp_events
	warp_event  2, 13, GOLDENROD_CITY, 11
	warp_event  3, 13, GOLDENROD_CITY, 11

	def_coord_events

	def_bg_events
	bg_event  1, 10, BGEVENT_READ, GoldenrodGameCornerMemoryGameScript
	bg_event  1, 11, BGEVENT_READ, GoldenrodGameCornerMemoryGameScript
	bg_event  1,  6, BGEVENT_READ, GoldenrodGameCornerMemoryGameScript
	bg_event  1,  7, BGEVENT_READ, GoldenrodGameCornerMemoryGameScript
	bg_event  1,  8, BGEVENT_READ, GoldenrodGameCornerMemoryGameScript
	bg_event  1,  9, BGEVENT_READ, GoldenrodGameCornerMemoryGameScript
	bg_event  6,  6, BGEVENT_READ, GoldenrodGameCornerLuckySlotsMachineScript
	bg_event  6,  7, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  6,  8, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  6,  9, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  6, 10, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  6, 11, BGEVENT_RIGHT, GoldenrodGameCornerLuckySlotsMachineScript
	bg_event  7,  6, BGEVENT_READ, GoldenrodGameCornerLuckySlotsMachineScript
	bg_event  7,  7, BGEVENT_READ, GoldenrodGameCornerLuckySlotsMachineScript
	bg_event  7,  8, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  7,  9, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  7, 10, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  7, 11, BGEVENT_LEFT, GoldenrodGameCornerLuckySlotsMachineScript
	bg_event 12,  6, BGEVENT_READ, GoldenrodGameCornerVoltorbFlipMachineScript
	bg_event 12,  7, BGEVENT_READ, GoldenrodGameCornerVoltorbFlipMachineScript
	bg_event 12,  8, BGEVENT_READ, GoldenrodGameCornerVoltorbFlipMachineScript
	bg_event 12,  9, BGEVENT_READ, GoldenrodGameCornerVoltorbFlipMachineScript
	bg_event 12, 10, BGEVENT_READ, GoldenrodGameCornerVoltorbFlipMachineScript
	bg_event 12, 11, BGEVENT_RIGHT, GoldenrodGameCornerVoltorbFlipMachineScript
	bg_event 13,  6, BGEVENT_READ, GoldenrodGameCornerVoltorbFlipMachineScript
	bg_event 13,  7, BGEVENT_READ, GoldenrodGameCornerVoltorbFlipMachineScript
	bg_event 13,  8, BGEVENT_READ, GoldenrodGameCornerVoltorbFlipMachineScript
	bg_event 13,  9, BGEVENT_READ, GoldenrodGameCornerVoltorbFlipMachineScript
	bg_event 13, 10, BGEVENT_READ, GoldenrodGameCornerVoltorbFlipMachineScript
	bg_event 13, 11, BGEVENT_LEFT, GoldenrodGameCornerVoltorbFlipMachineScript
	bg_event 18,  6, BGEVENT_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 18,  7, BGEVENT_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 18,  8, BGEVENT_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 18,  9, BGEVENT_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 18, 10, BGEVENT_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 18, 11, BGEVENT_RIGHT, GoldenrodGameCornerCardFlipMachineScript
	bg_event 12,  1, BGEVENT_LEFT, GoldenrodGameCornerLeftTheirDrinkScript

	def_object_events
	object_event  3,  2, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerCoinVendorScript, -1
	object_event 16,  2, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerTMVendorScript, -1
	object_event 18,  2, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerPrizeMonVendorScript, -1
	object_event  8,  7, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, DAY, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerPharmacistScript, -1
	object_event  8,  7, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, NITE, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerPharmacistScript, -1
	object_event 11, 10, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerPokefanM1Script, -1
	object_event 14,  8, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerCooltrainerMScript, -1
	object_event 17,  6, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerPokefanFScript, -1
	object_event 10,  3, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WANDER, 2, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodGameCornerCooltrainerFText, -1
	object_event  5, 10, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerGentlemanScript, -1
	object_event  9, 12, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodGameCornerPokefanM2Text, -1
	object_event 17, 10, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerPokeFanMScript, -1

	object_const_def
	const GOLDENRODGAMECORNER_CLERK
	const GOLDENRODGAMECORNER_RECEPTIONIST1
	const GOLDENRODGAMECORNER_RECEPTIONIST2
	const GOLDENRODGAMECORNER_PHARMACIST1
	const GOLDENRODGAMECORNER_PHARMACIST2
	const GOLDENRODGAMECORNER_POKEFAN_M1
	const GOLDENRODGAMECORNER_COOLTRAINER_M
	const GOLDENRODGAMECORNER_POKEFAN_F
	const GOLDENRODGAMECORNER_COOLTRAINER_F
	const GOLDENRODGAMECORNER_GENTLEMAN
	const GOLDENRODGAMECORNER_POKEFAN_M2
	const GOLDENRODGAMECORNER_POKEFAN_M3

GoldenrodGameCorner_MapScripts:
	def_scene_scripts

	def_callbacks

GoldenrodGameCornerCoinVendorScript:
	jumpstd GameCornerCoinVendorScript

GoldenrodGameCornerTMVendorScript:
	faceplayeropentext
	writetext GoldenrodGameCornerPrizeVendorIntroText
	waitbutton
	checkitem COIN_CASE
	iffalse GoldenrodGameCornerPrizeVendor_NoCoinCaseScript
	writetext GoldenrodGameCornerPrizeVendorWhichPrizeText
GoldenrodGameCornerTMVendor_LoopScript:
	special DisplayCoinCaseBalance
	loadmenu GoldenrodGameCornerTMVendorMenuHeader
	verticalmenu
	closewindow
	ifequal 1, .ThunderBolt
	ifequal 2, .IceBeam
	ifequal 3, .Flamethrower
	sjump GoldenrodGameCornerPrizeVendor_CancelPurchaseScript

; TODOTEXT - uh... change these to the right TMs
.ThunderBolt:
	checkcoins GOLDENRODGAMECORNER_TM_COINS
	ifequal HAVE_LESS, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	getitemname STRING_BUFFER_3, TM_THUNDER
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	giveitem TM_THUNDER
	iffalse GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	takecoins GOLDENRODGAMECORNER_TM_COINS
	sjump GoldenrodGameCornerTMVendor_FinishScript

.IceBeam:
	checkcoins GOLDENRODGAMECORNER_TM_COINS
	ifequal HAVE_LESS, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	getitemname STRING_BUFFER_3, TM_BLIZZARD
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	giveitem TM_BLIZZARD
	iffalse GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	takecoins GOLDENRODGAMECORNER_TM_COINS
	sjump GoldenrodGameCornerTMVendor_FinishScript

.Flamethrower:
	checkcoins GOLDENRODGAMECORNER_TM_COINS
	ifequal HAVE_LESS, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	getitemname STRING_BUFFER_3, TM_FIRE_BLAST
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	giveitem TM_FIRE_BLAST
	iffalse GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	takecoins GOLDENRODGAMECORNER_TM_COINS
	sjump GoldenrodGameCornerTMVendor_FinishScript

GoldenrodGameCornerTMVendor_FinishScript:
	waitsfx
	playsound SFX_TRANSACTION
	writetext GoldenrodGameCornerPrizeVendorHereYouGoText
	waitbutton
	sjump GoldenrodGameCornerTMVendor_LoopScript

GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript:
	jumpthisopenedtext
		text "Sorry! You need"
		line "more coins."
		done

GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript:
	jumpthisopenedtext
		text "Sorry. You can't"
		line "carry any more."
		done

GoldenrodGameCornerPrizeVendor_CancelPurchaseScript:
	jumpthisopenedtext
		text "OK. Please save"
		line "your coins and"
		cont "come again!"
		done

GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript:
	writetext GoldenrodGameCornerPrizeVendorConfirmPrizeText
	yesorno
	end

GoldenrodGameCornerPrizeVendorConfirmPrizeText:
		text_ram wStringBuffer3
		text "."
		line "Is that right?"
		done

GoldenrodGameCornerTMVendorMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 2, 15, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
	db 4 ; items
	db "TM25    9000@" ; TODOTEXT - ensure these are right eventually
	db "TM14    9000@"
	db "TM38    9000@"
	db "Cancel@"

GoldenrodGameCornerPrizeMonVendorScript:
	faceplayeropentext
	writetext GoldenrodGameCornerPrizeVendorIntroText
	waitbutton
	checkitem COIN_CASE
	iffalse GoldenrodGameCornerPrizeVendor_NoCoinCaseScript
.loop
	writetext GoldenrodGameCornerPrizeVendorWhichPrizeText
	special DisplayCoinCaseBalance
	loadmenu .MenuHeader
	verticalmenu
	closewindow
	ifequal 1, .Smeargle
	ifequal 2, .Axew
	ifequal 3, .Porygon
	sjump GoldenrodGameCornerPrizeVendor_CancelPurchaseScript

.Smeargle:
	checkcoins GOLDENRODGAMECORNER_SMEARGLE_COINS
	ifequal HAVE_LESS, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	getmonname STRING_BUFFER_3, SMEARGLE
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	waitsfx
	playsound SFX_TRANSACTION
	writetext GoldenrodGameCornerPrizeVendorHereYouGoText
	waitbutton
	setval SMEARGLE
	special GameCornerPrizeMonCheckDex
	givepoke SMEARGLE, 5, MIRACLEBERRY
	takecoins GOLDENRODGAMECORNER_SMEARGLE_COINS
	sjump .loop

.Axew:
	checkcoins GOLDENRODGAMECORNER_AXEW_COINS
	ifequal HAVE_LESS, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	getmonname STRING_BUFFER_3, AXEW
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	waitsfx
	playsound SFX_TRANSACTION
	writetext GoldenrodGameCornerPrizeVendorHereYouGoText
	waitbutton
	setval AXEW
	special GameCornerPrizeMonCheckDex
	givepoke AXEW, 5, SILVER_BERRY
	takecoins GOLDENRODGAMECORNER_AXEW_COINS
	sjump .loop

.Porygon:
	checkcoins GOLDENRODGAMECORNER_PORYGON_COINS
	ifequal HAVE_LESS, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	getmonname STRING_BUFFER_3, PORYGON
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	waitsfx
	playsound SFX_TRANSACTION
	writetext GoldenrodGameCornerPrizeVendorHereYouGoText
	waitbutton
	setval PORYGON
	special GameCornerPrizeMonCheckDex
	givepoke PORYGON, 5, GOLD_BERRY
	takecoins GOLDENRODGAMECORNER_PORYGON_COINS
	sjump .loop

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 2, 17, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
	db 4 ; items
	db "Smeargle   7777@"
	db "Axew       8888@"
	db "Porygon    9999@"
	db "Cancel@"

GoldenrodGameCornerPrizeVendorIntroText:
	text "Welcome!"

	para "We exchange your"
	line "game coins for"
	cont "fabulous prizes!"
	done

GoldenrodGameCornerPrizeVendor_NoCoinCaseScript:
	jumpthisopenedtext
		text "Oh? You don't have"
		line "a Coin Case."
		done

GoldenrodGameCornerPrizeVendorWhichPrizeText:
	text "Which prize would"
	line "you like?"
	done

GoldenrodGameCornerPrizeVendorHereYouGoText:
	text "Here you go!"
	done

GoldenrodGameCornerPokeFanMScript:
	showthistextfaceplayer
		text "Wahahah! The coins"
		line "keep rolling in!"
		done
	turnobject LAST_TALKED, RIGHT
	end

GoldenrodGameCornerPharmacistScript:
	showthistextfaceplayer
		text "I always play this"
		line "slot machine."

		para "This like all the"
		line "corner machines"
		cont "here, it has a"
		cont "greater chance to"
		cont "hit 777."
		done
	turnobject LAST_TALKED, LEFT
	end

GoldenrodGameCornerPokefanM1Script:
	showthistextfaceplayer
		text "Voltorb Flip is"
		line "the newest game."

		para "It's a bit more"
		line "strategic than the"
		cont "others."
		done
	turnobject LAST_TALKED, RIGHT
	end

GoldenrodGameCornerCooltrainerMScript:
	showthistextfaceplayer
		text "Life is a gamble."
		line "I'm going to flip"
		cont "cards till I drop!"
		done
	turnobject LAST_TALKED, LEFT
	end

GoldenrodGameCornerPokefanFScript:
	showthistextfaceplayer
		text "Card flip…"

		para "I prefer it over"
		line "the slots because"
		cont "it's easier to"
		cont "figure the odds."

		para "But the payout is"
		line "much lower."
		done
	turnobject LAST_TALKED, RIGHT
	end

GoldenrodGameCornerGentlemanScript:
	showthistextfaceplayer
	text "I taught Ice Beam"
	line "to my #mon."

	para "It was hard to get"
	line "enough coins for"
	cont "it, but it was"
	cont "worth it."
	done
	turnobject LAST_TALKED, RIGHT
	end

GoldenrodGameCornerLeftTheirDrinkScript:
	jumpthistext
		text "Someone left their"
		line "drink."

		para "It smells sweet."
		done

GoldenrodGameCornerSlotsMachineScript:
	random 6
	ifequal 0, GoldenrodGameCornerLuckySlotsMachineScript
	reanchormap
	setval FALSE
	special SlotMachine
	endtext

GoldenrodGameCornerLuckySlotsMachineScript:
	reanchormap
	setval TRUE
	special SlotMachine
	endtext

GoldenrodGameCornerVoltorbFlipMachineScript:
	opentext
	checkitem COIN_CASE
	iftrue .GoldenrodGameCornerWanttoPlayVoltorbFlip
	jumpthisopenedtext
		text "You don't have a"
		line "Coin Case."
		done

.GoldenrodGameCornerWanttoPlayVoltorbFlip
	special DisplayCoinCaseBalance
	writethistext
		text "Play Voltorb Flip?"
		done
	yesorno
	iftrue .PlayVoltorbFlip
	endtext

.PlayVoltorbFlip
	refreshscreen
	special _VoltorbFlip
	endtext

GoldenrodGameCornerCardFlipMachineScript:
	reanchormap
	special CardFlip
	endtext

GoldenrodGameCornerMemoryGameScript:
	reanchormap
	special MemoryGame
	endtext

GoldenrodGameCornerCooltrainerFText:
	text "I won't quit until"
	line "I win!"
	done

GoldenrodGameCornerPokefanM2Text:
	text "I couldn't win at"
	line "the slots, and I"
	cont "blew it on card"
	cont "flipping…"

	para "I got so furious,"
	line "I tossed out my"
	cont "Coin Case in the"
	cont "Underground."
	done
