MahoganyTradeBackKidHouse_MapEvents:
	def_warp_events
	warp_event  2,  7, MAHOGANY_TOWN, 6
	warp_event  3,  7, MAHOGANY_TOWN, 6

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, TradebackKidScript, -1

	object_const_def
	const MAHOGANYTRADEBACKKIDHOUSE_TRADEKID

MahoganyTradeBackKidHouse_MapScripts:
	def_scene_scripts

	def_callbacks

TradebackKidScript:
	faceplayeropentext
	clearevent EVENT_COMPLETED_TRADE_WITH_TRADE_BACK_KID
	checkevent EVENT_MET_TRADE_KID
	iftrue .WantToTrade
	writethistext
		text "Hello there! I'm"
		line "the Tradeback Kid."

		para "Some #mon can"
		line "only evolve by"
		cont "being traded."

		para "Your #dex has"
		line "this information."

		para "I can trade any"
		line "#mon you want"
		cont "back to you for a"
		cont "Silver Leaf."
		done
	setevent EVENT_MET_TRADE_KID
	waitbutton
.WantToTrade
	writethistext
		text "Want me to trade"
		line "back one of your"
		cont "own #mon for"
		cont "a Silver Leaf?"
		done
	yesorno
	iftrue .DoYouHaveASilverLeaf
	writethistext
		text "Oh, ok then."

		para "Come back if you"
		line "change your mind."
		done
	waitclosetext
	turnobject MAHOGANYTRADEBACKKIDHOUSE_TRADEKID, DOWN
	end

.DoYouHaveASilverLeaf
	checkitem SILVER_LEAF
	iftrue .LetsLinkUp
	writethistext
		text "Aww… You don't have"
		line "a Silver Leaf…"

		para "Come back when you"
		line "get one alright?"
		done
	waitclosetext
	turnobject MAHOGANYTRADEBACKKIDHOUSE_TRADEKID, DOWN
	end

.LetsLinkUp
	special TradebackNPC
	checkevent EVENT_COMPLETED_TRADE_WITH_TRADE_BACK_KID
	iftrue .TakeSilverLeaf
	waitclosetext
	turnobject MAHOGANYTRADEBACKKIDHOUSE_TRADEKID, DOWN
	end

.TakeSilverLeaf
	writethistext
		text "And… Done!"

		para "I'll take that"
		line "Silver Leaf now."

		para "Swing by anytime."
		done
	takeitem SILVER_LEAF
	waitsfx
	playsound SFX_TRANSACTION
	waitclosetext
	turnobject MAHOGANYTRADEBACKKIDHOUSE_TRADEKID, DOWN
	end
