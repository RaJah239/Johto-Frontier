GoldenrodBikeShop_MapEvents:
	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 3
	warp_event  3,  7, GOLDENROD_CITY, 3

	def_coord_events

	def_bg_events
	bg_event  1,  2, BGEVENT_JUMPTEXT, GoldenrodBikeShopBicycleText
	bg_event  0,  3, BGEVENT_JUMPTEXT, GoldenrodBikeShopBicycleText
	bg_event  1,  3, BGEVENT_JUMPTEXT, GoldenrodBikeShopBicycleText
	bg_event  0,  5, BGEVENT_JUMPTEXT, GoldenrodBikeShopBicycleText
	bg_event  1,  5, BGEVENT_JUMPTEXT, GoldenrodBikeShopBicycleText
	bg_event  0,  6, BGEVENT_JUMPTEXT, GoldenrodBikeShopBicycleText
	bg_event  1,  6, BGEVENT_JUMPTEXT, GoldenrodBikeShopBicycleText
	bg_event  6,  6, BGEVENT_JUMPTEXT, GoldenrodBikeShopBicycleText
	bg_event  7,  6, BGEVENT_JUMPTEXT, GoldenrodBikeShopBicycleText

	def_object_events
	object_event  7,  2, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodBikeShopClerkScript, -1

	object_const_def
	const GOLDENRODBIKESHOP_CLERK

GoldenrodBikeShop_MapScripts:
	def_scene_scripts

	def_callbacks

GoldenrodBikeShopClerkScript:
	faceplayeropentext
	checkevent EVENT_GOT_BICYCLE
	iftrue .GotBicycle
	writethistext
		text "…sigh… I moved"
		line "here, but I can't"
		cont "sell my Bicycles."

		para "Why is that?"

		para "Could you ride a"
		line "Bicycle and adver-"
		cont "tise for me?"
		done
	yesorno
	iffalse .Refused
	writethistext
		text "Really? Great!"

		para "Give me your name"
		line "and phone number,"
		cont "and I'll loan you"
		cont "a Bicycle."
		done
	promptbutton
	waitsfx
	giveitem BICYCLE
	writethistext
		text "<PLAYER> borrowed a"
		line "Bicycle."
		done
	playsound SFX_KEY_ITEM
	waitsfx
	itemnotify
	setflag ENGINE_BIKE_SHOP_CALL_ENABLED
	setevent EVENT_GOT_BICYCLE
	setmapscene DAY_CARE, SCENE_DAYCARE_NOOP
.GotBicycle:
	jumpthisopenedtext
		text "You may want to"
		line "turn on the Option"
		cont "Auto Bicycle to"
		cont "ride automatically"
		cont "outdoors."

		para "My Bicycles are"
		line "top-notch! You"
		cont "can ride them"
		cont "anywhere!"
		done

.Refused:
	jumpthisopenedtext
		text "…sigh… Oh, for"
		line "the kindness of"
		cont "people…"
		done

GoldenrodBikeShopJustReleasedCompactBikeText:
	text "Just released!"

	para "First-rate compact"
	line "Bicycles!"
	done

GoldenrodBikeShopBicycleText:
	text "It's a shiny new"
	line "Bicycle!"
	done
