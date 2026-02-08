	object_const_def
	const POKESEERSHOUSE_GRANNY

PokeSeersHouse_MapScripts:
	def_scene_scripts

	def_callbacks

SeerScript:
	faceplayer
	opentext
	special PokeSeer
	waitbutton
	closetext
	end

NuggetSellerScript:
	faceplayer
	opentext
	checkevent MET_NUGGET_SELLER
	iftrue .WantToBuySomeNuggets
	writetext ThisOldMansLifeStory
	waitbutton
	setevent MET_NUGGET_SELLER
.WantToBuySomeNuggets
	writetext WantToBuySomeNuggetsText
	yesorno
	iffalse .finish
	special PlaceMoneyTopRight
	loadmenu .MoveMenuHeader
	verticalmenu
	closewindow
	ifequal 1, .OneNugget
	ifequal 2, .TenNuggets
.finish
	closetext
	end

.OneNugget
	writetext OneNuggetCostText
	promptbutton
	checkmoney YOUR_MONEY, 7500
	ifequal HAVE_LESS, .NotEnoughMoney
	giveitem NUGGET, 1
	iffalse .NoRoom
	takemoney YOUR_MONEY, 7500
	special PlaceMoneyTopRight
	getitemname STRING_BUFFER_3, NUGGET
	writetext ReceivedOldManSingleNuggetText
	sjump .FinishTheScam

.TenNuggets
	writetext TenNuggetCostText
	promptbutton
	checkmoney YOUR_MONEY, 75000
	ifequal HAVE_LESS, .NotEnoughMoney
	giveitem NUGGET, 10
	iffalse .NoRoom
	takemoney YOUR_MONEY, 75000
	special PlaceMoneyTopRight
	getitemname STRING_BUFFER_3, NUGGET
	writetext ReceivedOldManTenNuggetText
.FinishTheScam
	playsound SFX_ITEM
	waitsfx
	closetext
	end

.NotEnoughMoney
	writetextend NotEnoughMoneyText

.NoRoom:
	writetextend NoNuggetRoomText

.MoveMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 3, 3, 16, 11
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
	db 3 ; items
	db "Nugget ×1@"
	db "Nugget ×10@"
	db "Cancel@"

ThisOldMansLifeStory:
	text "I've lived long,"
	line "explored much,"
	cont "adventured more"
	cont "than most…"

	para "Much knowledge I've"
	line "gained but more"
	cont "importantly, much"
	cont "treasure!"

	para "I've amassed a lot"
	line "of Nuggets but I'm"
	cont "not opposed to"
	cont "parting with some."
	done

WantToBuySomeNuggetsText:
	text "Do you want to buy"
	line "some Nuggets?"
	done

NotEnoughMoneyText:
	text "Your funds have"
	line "seen better days…"
	done

NoNuggetRoomText:
	text "Your pack's pocket"
	line "is full…"
	done

OneNuggetCostText:
	text "I'll take ¥7,500"
	line "for 1× Nugget."
	done

ReceivedOldManSingleNuggetText:
	text "<PLAYER> got"
	line "1× @"
	text_ram wStringBuffer3
	text "."
	done

TenNuggetCostText:
	text "I'll take ¥75,000"
	line "for 10× Nuggets."
	done

ReceivedOldManTenNuggetText:
	text "<PLAYER> got"
	line "10× @"
	text_ram wStringBuffer3
	text "."
	done

PokeSeersHouse_MapEvents:
	def_warp_events
	warp_event  2,  7, CIANWOOD_CITY, 7
	warp_event  3,  7, CIANWOOD_CITY, 7

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, SeerScript, -1
	object_event  5,  4, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, NuggetSellerScript, -1
