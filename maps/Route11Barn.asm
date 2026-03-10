	object_const_def
	const ROUTE11BARN_TWIN1
	const ROUTE11BARN_TWIN2
	const ROUTE11BARN_MOOMOO

Route11Barn_MapScripts:
	def_scene_scripts

	def_callbacks

Route11BarnTwin1Script:
	faceplayer
	opentext
	checkevent EVENT_HEALED_MOOMOO
	iftrue .FeedingMooMoo
	writetext Route11BarnTwinMoomooIsSickText
	waitbutton
	closetext
	turnobject ROUTE11BARN_TWIN1, RIGHT
	end

.FeedingMooMoo:
	writetext Route11BarnTwinWereFeedingMoomooText
	waitbutton
	closetext
	turnobject ROUTE11BARN_TWIN1, RIGHT
	end

Route11BarnTwin2Script:
	faceplayer
	opentext
	checkevent EVENT_HEALED_MOOMOO
	iftrue .FeedingMooMoo
	writetext Route11BarnTwinMoomooIsSickText
	waitbutton
	closetext
	turnobject ROUTE11BARN_TWIN2, LEFT
	end

.FeedingMooMoo:
	writetext Route11BarnTwinWereFeedingMoomooText
	waitbutton
	closetext
	turnobject ROUTE11BARN_TWIN2, LEFT
	end

MoomooScript:
	opentext
	checkevent EVENT_HEALED_MOOMOO
	iftrue .HappyCow
	writetext MoomooWeakMooText
	setval MILTANK
	special PlaySlowCry
	promptbutton
	writetext Route11BarnItsCryIsWeakText
	checkevent EVENT_TALKED_TO_FARMER_ABOUT_MOOMOO
	iftrue .GiveBerry
	waitbutton
	closetext
	end

.GiveBerry:
	promptbutton
	writetext Route11BarnAskGiveBerryText
	yesorno
	iffalse .Refused
	checkitem BERRY
	iffalse .NoBerriesInBag
	takeitem BERRY
	readmem wMooMooBerries
	addval 1
	writemem wMooMooBerries
	ifequal 3, .ThreeBerries
	ifequal 5, .FiveBerries
	ifequal 7, .SevenBerries
	writetext Route11BarnGaveBerryText
	waitbutton
	closetext
	end

.ThreeBerries:
	writetext Route11BarnGaveBerryText
	promptbutton
	writetext Route11BarnLittleHealthierText
	waitbutton
	closetext
	end

.FiveBerries:
	writetext Route11BarnGaveBerryText
	promptbutton
	writetext Route11BarnQuiteHealthyText
	waitbutton
	closetext
	end

.SevenBerries:
	playmusic MUSIC_HEAL
	writetext Route11BarnGaveBerryText
	pause 60
	promptbutton
	special RestartMapMusic
	writetext Route11BarnTotallyHealthyText
	waitbutton
	closetext
	setevent EVENT_HEALED_MOOMOO
	end

.NoBerriesInBag:
	writetext Route11BarnNoBerriesText
	waitbutton
	closetext
	end

.Refused:
	writetext Route11BarnRefusedBerryText
	waitbutton
	closetext
	end

.HappyCow:
	writetext MoomooHappyMooText
	cry MILTANK
	closetext
	special FadeOutPalettes
	special LoadMapPalettes
	playsound SFX_FULL_HEAL
	special HealParty
	special FadeInPalettes_EnableDynNoApply
	end

Route11BarnTwinMoomooIsSickText:
	text "MOOMOO is sick…"

	para "She needs lots of"
	line "BERRIES."
	done

Route11BarnTwinWereFeedingMoomooText:
	text "We're feeding"
	line "MOOMOO!"
	done

MoomooWeakMooText:
	text "MILTANK: …Moo…"
	done

Route11BarnItsCryIsWeakText:
	text "Its cry is weak…"
	done

MoomooHappyMooText:
	text "MILTANK: Mooo!"
	done

Route11BarnAskGiveBerryText:
	text "Give a BERRY to"
	line "MILTANK?"
	done

Route11BarnGaveBerryText:
	text "<PLAYER> gave a"
	line "BERRY to MILTANK."
	done

Route11BarnLittleHealthierText:
	text "MILTANK became a"
	line "little healthier!"
	done

Route11BarnQuiteHealthyText:
	text "MILTANK became"
	line "quite healthy!"
	done

Route11BarnTotallyHealthyText:
	text "MILTANK became"
	line "totally healthy!"
	done

Route11BarnNoBerriesText:
	text "<PLAYER> has no"
	line "BERRIES…"
	done

Route11BarnRefusedBerryText:
	text "<PLAYER> wouldn't"
	line "give a BERRY."

	para "MILTANK looks sad."
	done

Route11Barn_MapEvents:
	def_warp_events
	warp_event  3,  7, ROUTE_11, 1
	warp_event  4,  7, ROUTE_11, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route11BarnTwin1Script, -1
	object_event  4,  3, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route11BarnTwin2Script, -1
	object_event  3,  3, SPRITE_MILTANK, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, MoomooScript, -1
