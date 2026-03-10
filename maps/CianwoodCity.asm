CianwoodCity_MapEvents:
	def_warp_events
	warp_event 23, 43, CIANWOOD_POKECENTER_1F, 1
	warp_event 17, 41, MANIAS_HOUSE, 1
	warp_event  8, 43, CIANWOOD_GYM, 1
	warp_event 15, 47, CIANWOOD_PHARMACY, 1
	warp_event  9, 31, CIANWOOD_PHOTO_STUDIO, 1
	warp_event 15, 37, CIANWOOD_LUGIA_SPEECH_HOUSE, 1
	warp_event  5, 17, POKE_SEERS_HOUSE, 1
	warp_event 15, 51, CIANWOOD_PORT_PASSAGE, 1
	warp_event 16, 51, CIANWOOD_PORT_PASSAGE, 2

	def_coord_events
	coord_event 11, 16, SCENE_CIANWOODCITY_SUICUNE_AND_EUSINE, CianwoodCitySuicuneAndEusine

	def_bg_events
	bg_event 20, 34, BGEVENT_JUMPTEXT, CianwoodCitySignText
	bg_event  7, 45, BGEVENT_JUMPTEXT, CianwoodGymSignText
	bg_event 24, 43, BGEVENT_JUMPSTD, POKECENTER_SIGN_SCRIPT
	bg_event 19, 47, BGEVENT_JUMPTEXT, CianwoodPharmacySignText
	bg_event  8, 32, BGEVENT_JUMPTEXT, CianwoodPhotoStudioSignText
	bg_event  8, 24, BGEVENT_JUMPTEXT, CianwoodPokeSeerSignText
	bg_event 17, 50, BGEVENT_JUMPTEXT, CianwoodCityPortSignText
	bg_event  4, 19, BGEVENT_ITEM + REVIVE, EVENT_CIANWOOD_CITY_HIDDEN_REVIVE
	bg_event  5, 29, BGEVENT_ITEM + MAX_ETHER, EVENT_CIANWOOD_CITY_HIDDEN_MAX_ETHER

	def_object_events
	rocksmash_event  8, 16
	rocksmash_event  9, 17
	rocksmash_event  4, 25
	rocksmash_event  5, 29
	rocksmash_event 10, 27
	rocksmash_event  4, 19
	object_event 21, 36, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CianwoodCityYoungsterText1, -1
	object_event 11, 38, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CianwoodCityPokefanMText, -1
	object_event 14, 42, SPRITE_LASS, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 2, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CianwoodCityLassText, -1
	object_event 10, 46, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodCityChucksWife, -1
	object_event 14, 33, SPRITE_SAILOR, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CianwoodCitySailorText, -1
	object_event 10, 14, SPRITE_SUICUNE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_SAW_SUICUNE_AT_CIANWOOD_CITY

	object_const_def
	const CIANWOODCITY_ROCK1
	const CIANWOODCITY_ROCK2
	const CIANWOODCITY_ROCK3
	const CIANWOODCITY_ROCK4
	const CIANWOODCITY_ROCK5
	const CIANWOODCITY_ROCK6
	const CIANWOODCITY_STANDING_YOUNGSTER1
	const CIANWOODCITY_POKEFAN_M
	const CIANWOODCITY_LASS
	const CIANWOODCITY_POKEFAN_F
	const CIANWOODCITY_SAILOR
	const CIANWOODCITY_SUICUNE

CianwoodCity_MapScripts:
	def_scene_scripts
	scene_script CianwoodCityNoop1Scene, SCENE_CIANWOODCITY_NOOP
	scene_script CianwoodCityNoop2Scene, SCENE_CIANWOODCITY_SUICUNE_AND_EUSINE

	def_callbacks
	callback MAPCALLBACK_NEWMAP, CianwoodCityFlypointAndSuicuneCallback

CianwoodCityNoop1Scene:
CianwoodCityNoop2Scene:
	end

CianwoodCityFlypointAndSuicuneCallback:
	setflag ENGINE_FLYPOINT_CIANWOOD
	setevent EVENT_EUSINE_IN_BURNED_TOWER
	endcallback

CianwoodCitySuicuneAndEusine:
	turnobject PLAYER, UP
	showemote EMOTE_SHOCK, PLAYER, 15
	pause 15
	playsound SFX_WARP_FROM
	applymovement CIANWOODCITY_SUICUNE, CianwoodCitySuicuneApproachMovement
	turnobject PLAYER, DOWN
	pause 15
	playsound SFX_WARP_FROM
	applymovement CIANWOODCITY_SUICUNE, CianwoodCitySuicuneDepartMovement
	disappear CIANWOODCITY_SUICUNE
	pause 10
	setscene SCENE_CIANWOODCITY_NOOP
	clearevent EVENT_SAW_SUICUNE_ON_ROUTE_14
	setmapscene ROUTE_14, SCENE_ROUTE14_SUICUNE
	end

CianwoodCitySuicuneApproachMovement:
	set_sliding
	fast_jump_step DOWN
	fast_jump_step DOWN
	fast_jump_step RIGHT
	remove_sliding
	step_end

CianwoodCitySuicuneDepartMovement:
	set_sliding
	fast_jump_step RIGHT
	fast_jump_step UP
	fast_jump_step RIGHT
	fast_jump_step RIGHT
	remove_sliding
	step_end

CianwoodCityChucksWife:
	faceplayeropentext
	checkevent EVENT_GOT_HM01_FLY
	iftrue .GotFly
	writethistext
		text "It must've be tough"
		line "to get here."

		para "It would be much"
		line "easier if your"
		cont "#mon knew how"
		cont "to Fly…"
		done
	promptbutton
	checkevent EVENT_BEAT_CHUCK
	iftrue .BeatChuck
	jumpthisopenedtext
		text "If you beat the"
		line "Gym Leader here,"
		cont "come see me."

		para "I'll have a nice"
		line "gift for you."
		done

.BeatChuck:
	writethistext
		text "That's Cianwood's"
		line "Gym Badge!"

		para "Then you should"
		line "take this HM."
		done
	promptbutton
	verbosegiveitem HM_FLY
	setevent EVENT_GOT_HM01_FLY
	writethistext
		text "It's the only HM."

		para "You can use it as"
		line "many times as you"
		cont "want."

		text "Teach Fly to your"
		line "#mon."

		para "You will be able"
		line "to Fly instantly"
		cont "to anywhere you "
		cont "have visited."
		done
	promptbutton
.GotFly:
	jumpthisopenedtext
		text "My husband lost to"
		line "you, so he needs"
		cont "to train harder."

		para "That's good, since"
		line "he was getting a"
		cont "little chubby."
		done

CianwoodCityLassText:
	text "Chuck, the Gym"
	line "Leader, spars with"
	cont "his fighting #-"
	cont "mon."
	done

CianwoodCityYoungsterText1:
	text "If you use Fly,"
	line "you can get back"
	cont "to Olivine in-"
	cont "stantly."
	done

CianwoodCitySailorText:
	text "There are several"
	line "islands between"
	cont "here and Olivine."

	para "A mythical sea"
	line "creature supposed-"
	cont "ly lives there."
	done

CianwoodCityPokefanMText:
	text "Boulders to the"
	line "north of town can"
	cont "be crushed."

	para "They may be hiding"
	line "something."

	para "Your #mon could"
	line "use Brick Break to"
	cont "smash them."
	done

CianwoodCitySignText:
	text "Cianwood City"

	para "A Port Surrounded"
	line "by Rough Seas"
	done

CianwoodGymSignText:
	text "Cianwood City"
	line "#mon Gym"

	para "Leader: Chuck"

	para "His Roaring Fists"
	line "Do the Talking"
	done

CianwoodPharmacySignText:
	text "500 Years of"
	line "Tradition"

	para "Cianwood City"
	line "Pharmacy"

	para "We Await Your"
	line "Medicinal Queries"
	done

CianwoodPhotoStudioSignText:
	text "Cianwood City"
	line "Photo Studio"

	para "Boost affection"
	line "with a picture!"
	done

CianwoodCityPortSignText:
	text "Cianwood Port"
	line "Fast Ship Pier"
	done

CianwoodPokeSeerSignText:
	text "The # Seer"
	line "Ahead"
	done
