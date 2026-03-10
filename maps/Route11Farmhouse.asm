DEF ROUTE11FARMHOUSE_MILK_PRICE EQU 500

Route11Farmhouse_MapEvents:
	def_warp_events
	warp_event  2,  7, ROUTE_11, 2
	warp_event  3,  7, ROUTE_11, 2

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_JUMPSTD, PICTURE_BOOKSHELF_SCRIPT
	bg_event  1,  1, BGEVENT_JUMPSTD, PICTURE_BOOKSHELF_SCRIPT

	def_object_events
	object_event  3,  2, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, PokefanM_DairyFarmer, -1
	object_event  5,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, PokefanF_SnoreFarmer, -1

	object_const_def
	const ROUTE11FARMHOUSE_POKEFAN_M
	const ROUTE11FARMHOUSE_POKEFAN_F

Route11Farmhouse_MapScripts:
	def_scene_scripts

	def_callbacks

PokefanM_DairyFarmer:
	faceplayeropentext
	checkevent EVENT_HEALED_MOOMOO
	iftrue FarmerMScript_SellMilk
	setevent EVENT_TALKED_TO_FARMER_ABOUT_MOOMOO
	jumpthisopenedtext
		text "My Miltank ain't"
		line "givin' me milk"
		cont "n'more."

		para "This here FARM's"
		line "got famous milk."

		para "Most everyone"
		line "wants a drink."

		para "It'll give me lots"
		line "o' milk if'n I"
		cont "feed it lots o'"
		cont "Berries, I reckon."
		done

; TODOTEXT make this sell 1 or a dozen, and chance the aftertext for Route 10 beauty about they only selling a bottle at a time
FarmerMScript_SellMilk:
	checkitem MOOMOO_MILK
	iftrue FarmerMScript_Milking
	writethistext
		text "How'd you like my"
		line "Moomoo Milk?"

		para "It's my pride and"
		line "joy, there."

		para "Give it to #mon"
		line "to restore HP!"

		para "I'll give it to ya"
		line "fer just ¥{d:ROUTE11FARMHOUSE_MILK_PRICE}."
		done
	special PlaceMoneyTopRight
	yesorno
	iffalse FarmerMScript_NoSale
	checkmoney YOUR_MONEY, ROUTE11FARMHOUSE_MILK_PRICE
	ifequal HAVE_LESS, FarmerMScript_NoMoney
	giveitem MOOMOO_MILK
	iffalse FarmerMScript_NoRoom
	takemoney YOUR_MONEY, ROUTE11FARMHOUSE_MILK_PRICE
	special PlaceMoneyTopRight
	waitsfx
	playsound SFX_TRANSACTION
	writethistext
		text "Here ya go!"
		line "Drink up'n enjoy!"
		done
	promptbutton
	itemnotify
	endtext

FarmerMScript_NoMoney:
	jumpthisopenedtext
		text "Sorry, there."
		line "No cash, no sale!"
		done

FarmerMScript_NoRoom:
	jumpthisopenedtext
		text "I reckon yer"
		line "Bag's full."
		done

FarmerMScript_NoSale:
	jumpthisopenedtext
		text "You don't want it?"
		line "Come again, hear?"
		done

FarmerMScript_Milking:
	jumpthisopenedtext
		text "I best go do my"
		line "milkin'."
		done

PokefanF_SnoreFarmer:
	faceplayeropentext
	checkevent EVENT_GOT_TM13_SNORE_FROM_MOOMOO_FARM ; TODOTEXT chance this when tms get sorted
	iftrue FarmerFScript_GotSnore
	checkevent EVENT_HEALED_MOOMOO
	iftrue FarmerFScript_GiveSnore
	jumpthisopenedtext
		text "Our milk even goes"
		line "over seas."

		para "So if our own"
		line "Miltank won't give"
		cont "us any milk, we're"
		cont "in trouble."
		done

FarmerFScript_GiveSnore:
	writethistext
		text "You fixed our"
		line "Miltank, hon. Now"
		cont "it gives Moomoo"
		cont "Milk again."

		para "Here's somethin'"
		line "fer your trouble."
		done
	promptbutton
	verbosegiveitem TM_SNORE
	iffalse_endtext
	setevent EVENT_GOT_TM13_SNORE_FROM_MOOMOO_FARM
FarmerFScript_GotSnore:
	jumpthisopenedtext
		text "That there's"
		line "Snore."

		para "It's a rare move"
		line "that only works"
		cont "while the #mon"
		cont "is asleep."

		para "You best think how"
		line "you ought to use"
		cont "it, hon."
		done
