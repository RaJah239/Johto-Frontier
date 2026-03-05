AzaleaTown_MapEvents:
	def_warp_events
	warp_event 15,  9, AZALEA_POKECENTER_1F, 1
	warp_event 21, 13, CHARCOAL_KILN, 1
	warp_event 21,  5, AZALEA_MART, 2
	warp_event  9,  5, KURTS_HOUSE, 1
	warp_event 10, 15, AZALEA_GYM, 1
	warp_event 31,  7, SLOWPOKE_WELL_B1F, 1
	warp_event  2, 10, ILEX_FOREST_AZALEA_GATE, 3
	warp_event  2, 11, ILEX_FOREST_AZALEA_GATE, 4

	def_coord_events
	coord_event  9,  6, SCENE_AZALEATOWN_KURT_RETURNS_GS_BALL, AzaleaTownCelebiScene

	def_bg_events
	bg_event 19,  9, BGEVENT_JUMPTEXT, AzaleaTownSignText
	bg_event 10,  9, BGEVENT_JUMPTEXT, KurtsHouseSignText
	bg_event 14, 15, BGEVENT_JUMPTEXT, AzaleaGymSignText
	bg_event 29,  7, BGEVENT_JUMPTEXT, SlowpokeWellSignText
	bg_event 19, 13, BGEVENT_JUMPTEXT, CharcoalKilnSignText
	bg_event  3,  9, BGEVENT_JUMPTEXT, AzaleaTownIlexForestSignText
	bg_event 16,  9, BGEVENT_JUMPSTD, MART_SIGN_SCRIPT
	bg_event 22,  5, BGEVENT_JUMPSTD, POKECENTER_SIGN_SCRIPT
	bg_event 31,  6, BGEVENT_ITEM + FULL_HEAL, EVENT_AZALEA_TOWN_HIDDEN_FULL_HEAL
	bg_event  8,  2, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event  7,  2, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT

	def_object_events
	object_event 21,  9, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 1, 2, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, AzaleaTownGrampsText, -1
	object_event 15, 13, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 2, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, AzaleaTownTeacherText, -1
	object_event  7,  9, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, AzaleaTownYoungsterText, -1
	object_event  8, 17, SPRITE_SLOWPOKE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownSlowpokeScript, -1
	object_event 18,  9, SPRITE_SLOWPOKE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownSlowpokeScript, -1
	object_event 29,  9, SPRITE_SLOWPOKE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownSlowpokeScript, -1
	object_event 15, 15, SPRITE_SLOWPOKE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownSlowpokeScript, -1
	object_event  6,  5, SPRITE_KURT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownKurtScript, EVENT_AZALEA_TOWN_KURT
	object_event  8,  2, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_WHITE, OBJECTTYPE_SCRIPT, 0, AzaleaTownApricornTree1, EVENT_AZALEA_TOWN_APRICORN_1
	object_event  7,  2, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLACK, OBJECTTYPE_SCRIPT, 0, AzaleaTownApricornTree2, EVENT_AZALEA_TOWN_APRICORN_2

	object_const_def
	const AZALEATOWN_GRAMPS
	const AZALEATOWN_TEACHER
	const AZALEATOWN_YOUNGSTER
	const AZALEATOWN_SLOWPOKE1
	const AZALEATOWN_SLOWPOKE2
	const AZALEATOWN_SLOWPOKE3
	const AZALEATOWN_SLOWPOKE4
	const AZALEATOWN_KURT_OUTSIDE
	const AZALEATOWN_APRICORN_TREE1
	const AZALEATOWN_APRICORN_TREE2

AzaleaTown_MapScripts:
	def_scene_scripts
	scene_script AzaleaTownNoop1Scene, SCENE_AZALEATOWN_NOOP
	scene_script AzaleaTownNoop2Scene, SCENE_AZALEATOWN_KURT_RETURNS_GS_BALL

	def_callbacks
	callback MAPCALLBACK_NEWMAP, AzaleaTownFlypointCallback
	callback MAPCALLBACK_OBJECTS, AzaleaTownPermanentRainWeather

AzaleaTownNoop1Scene:
AzaleaTownNoop2Scene:
	end

AzaleaTownFlypointCallback:
	setflag ENGINE_FLYPOINT_AZALEA
	endcallback

AzaleaTownPermanentRainWeather:
	setval WEATHER_RAIN
	writemem wFieldWeather
	endcallback

AzaleaTownCelebiScene:
	applymovement PLAYER, AzaleaTownPlayerLeavesKurtsHouseMovement
	opentext
	writethistext
		text "Ilex Forest is"
		line "restless!"

		para "What is going on?"
		done
	promptbutton
	turnobject AZALEATOWN_KURT_OUTSIDE, RIGHT
	writethistext
		text "<PLAYER>, here's"
		line "your GS Ball back!"
		done
	promptbutton
	writethistext
		text "Could you go see"
		line "why Ilex Forest is"
		cont "so restless?"
		done
	waitbutton
	verbosegiveitem GS_BALL
	turnobject AZALEATOWN_KURT_OUTSIDE, LEFT
	setflag ENGINE_FOREST_IS_RESTLESS
	clearevent EVENT_ILEX_FOREST_LASS
	setevent EVENT_ROUTE_6_ILEX_FOREST_GATE_LASS
	setscene SCENE_AZALEATOWN_NOOP
	endtext

AzaleaTownPlayerLeavesKurtsHouseMovement:
	step LEFT
	step LEFT
	step UP
	turn_head LEFT
	step_end

AzaleaTownKurtScript:
	showthistextfaceplayer
		text "Could you go see"
		line "why Ilex Forest is"
		cont "so restless?"
		done
	turnobject AZALEATOWN_KURT_OUTSIDE, LEFT
	end

AzaleaTownSlowpokeScript:
	isfieldactionssettoquick
	iftrue .skipthis
	reanchormap
	pokepic SLOWPOKE
	waitbutton
	closepokepic
.skipthis
	opentext
	writethistext
		text "Slowpoke: …"

		para "<……> <……> <……>"
		pause 20
		done
	writethistext
		text "<……> <……>Yawn?"
		done
	cry SLOWPOKE
	waitendtext

AzaleaTownGrampsText:
	text "Even though the"
	line "Slowpoke seem to"
	cont "only goof off, we"
	cont "appreciate their"
	cont "presence."
	done

AzaleaTownTeacherText:
	text "Did you come to"
	line "get Kurt to make"
	cont "some Balls?"

	para "A lot of people do"
	line "just that."
	done

AzaleaTownYoungsterText:
	text "Cut through Azalea"
	line "and you'll be in"
	cont "Ilex Forest."

	para "There's something"
	line "ominous about that"
	cont "place."
	done

AzaleaTownSignText:
	text "Azalea Town"
	line "Where People and"
	cont "#mon Live in"
	line "Happy Harmony"
	done

KurtsHouseSignText:
	text "Kurt's House"
	done

AzaleaGymSignText:
	text "Azalea Town"
	line "#mon Gym"
	cont "Leader: Bugsy"

	para "The Walking"
	line "Bug #mon"
	cont "Encyclopedia"
	done

SlowpokeWellSignText:
	text "Slowpoke Well"

	para "Also known as the"
	line "Rainmaker Well."

	para "Locals believe"
	line "that a Slowpoke's"
	cont "yawn summons rain."

	para "Records show that"
	line "a Slowpoke's yawn"
	cont "ended a drought"
	cont "400 years ago."
	done

CharcoalKilnSignText:
	text "Charcoal Kiln"
	done

AzaleaTownIlexForestSignText:
	text "Ilex Forest"

	para "Enter through the"
	line "gate."
	done

AzaleaTownApricornTree1:
	setval WHT_APRICORN
	setlasttalked AZALEATOWN_APRICORN_TREE1
	jumpstd BerryOrFruitScript
AzaleaTownApricornTree2:
	setval BLK_APRICORN
	setlasttalked AZALEATOWN_APRICORN_TREE2
	jumpstd BerryOrFruitScript
