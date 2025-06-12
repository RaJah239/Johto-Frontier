	object_const_def
	const MAHOGANYTRADEBACKKIDHOUSE_TRADEKID

MahoganyTradeBackKidHouse_MapScripts:
	def_scene_scripts

	def_callbacks

TradebackKidScript:
	faceplayer
	opentext
	clearevent EVENT_COMPLETED_TRADE_WITH_TRADE_BACK_KID
	checkevent EVENT_MET_TRADE_KID
	iftrue .WantToTrade
	writetext TradebackIntroKidText
	setevent EVENT_MET_TRADE_KID
	waitbutton
.WantToTrade
	writetext TradebackKidWantToTradeText
	yesorno
	iftrue .DoYouHaveASilverLeaf
	writetext TradebackKidNoTradeText
	waitbutton
	closetext
	turnobject MAHOGANYTRADEBACKKIDHOUSE_TRADEKID, DOWN
	end

.DoYouHaveASilverLeaf
	checkitem SILVER_LEAF
	iftrue .LetsLinkUp
	writetext TradeBackKidNoSilverLeafText
	waitbutton
	closetext
	turnobject MAHOGANYTRADEBACKKIDHOUSE_TRADEKID, DOWN
	end

.LetsLinkUp
	special TradebackNPC
	checkevent EVENT_COMPLETED_TRADE_WITH_TRADE_BACK_KID
	iftrue .TakeSilverLeaf
	waitbutton
	closetext
	turnobject MAHOGANYTRADEBACKKIDHOUSE_TRADEKID, DOWN
	end

.TakeSilverLeaf
	writetext ThanksForTheSilverLeafText
	takeitem SILVER_LEAF
	waitsfx
	playsound SFX_TRANSACTION
	waitbutton
	closetext
	turnobject MAHOGANYTRADEBACKKIDHOUSE_TRADEKID, DOWN
	end

TradebackIntroKidText:
	text "Hello there! I'm"
	line "the TRADEBACK KID."

	para "Some #MON can"
	line "only evolve by"
	cont "being traded."

	para "Your #DEX has"
	line "this information."

	para "I can trade any"
	line "#MON you want"

	para "back to you for a"
	line "SILVER LEAF."
	done

TradebackKidWantToTradeText:
	text "Want me to trade"
	line "back one of your"

	para "own #MON for"
	line "a SILVER LEAF?"
	done

TradebackKidNoTradeText:
	text "Oh, ok then."

	para "Come back if you"
	line "change your mind."
	done

TradeBackKidNoSilverLeafText:
	text "Aww… You don't have"
	line "a SILVER LEAF…"

	para "Come back when you"
	line "get one alright?"
	done

ThanksForTheSilverLeafText:
	text "And… Done!"

	para "I'll take that"
	line "SILVER LEAF now."

	para "Swing by anytime."
	done

MahoganyTradeBackKidHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, MAHOGANY_TOWN, 6
	warp_event  3,  7, MAHOGANY_TOWN, 6

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, TradebackKidScript, -1
