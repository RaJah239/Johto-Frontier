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

	object_const_def
	const ROUTE11BARN_TWIN1
	const ROUTE11BARN_TWIN2
	const ROUTE11BARN_MOOMOO

Route11Barn_MapScripts:
	def_scene_scripts

	def_callbacks

Route11BarnTwin1Script:
	faceplayeropentext
	checkevent EVENT_HEALED_MOOMOO
	iftrue .FeedingMooMoo
	writetext Route11BarnTwinMoomooIsSickText
	waitclosetext
	turnobject ROUTE11BARN_TWIN1, RIGHT
	end

.FeedingMooMoo:
	writetext Route11BarnTwinWereFeedingMoomooText
	waitclosetext
	turnobject ROUTE11BARN_TWIN1, RIGHT
	end

Route11BarnTwin2Script:
	faceplayeropentext
	checkevent EVENT_HEALED_MOOMOO
	iftrue .FeedingMooMoo
	writetext Route11BarnTwinMoomooIsSickText
	waitclosetext
	turnobject ROUTE11BARN_TWIN2, LEFT
	end

.FeedingMooMoo:
	writetext Route11BarnTwinWereFeedingMoomooText
	waitclosetext
	turnobject ROUTE11BARN_TWIN2, LEFT
	end

Route11BarnTwinMoomooIsSickText:
	text "Moomoo is sick…"

	para "She needs lots of"
	line "Berries."
	done

Route11BarnTwinWereFeedingMoomooText:
	text "We're feeding"
	line "Moomoo!"
	done

MoomooScript:
	checkevent EVENT_HEALED_MOOMOO
	iftrue .HappyCow
	setval MILTANK
	special SetMonAsSeen
	isfieldactionssettoquick
	iftrue .skipthis1
	reanchormap
	pokepic MILTANK
	setval MILTANK
	special PlaySlowCry
	waitbutton
	closepokepic
.skipthis1
	opentext
	writethistext
		text "Miltank: …Moo…"
		done
	promptbutton
	writethistext
		text "Its cry is weak…"
		done
	checkevent EVENT_TALKED_TO_FARMER_ABOUT_MOOMOO
	iftrue .GiveBerry
	waitendtext

.GiveBerry:
	promptbutton
	writethistext
		text "Give a Berry to"
		line "Miltank?"
		done
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
	waitendtext

.ThreeBerries:
	writetext Route11BarnGaveBerryText
	promptbutton
	jumpthisopenedtext
		text "Miltank became a"
		line "little healthier!"
		done

.FiveBerries:
	writetext Route11BarnGaveBerryText
	promptbutton
	jumpthisopenedtext
		text "Miltank became"
		line "quite healthy!"
		done

.SevenBerries:
	playmusic MUSIC_HEAL
	writetext Route11BarnGaveBerryText
	pause 60
	promptbutton
	special RestartMapMusic
	writethistext
		text "Miltank became"
		line "totally healthy!"
		done
	waitclosetext
	setevent EVENT_HEALED_MOOMOO
	end

.NoBerriesInBag:
	jumpthisopenedtext
		text "<PLAYER> has no"
		line "Berries…"
		done

.Refused:
	jumpthisopenedtext
		text "<PLAYER> wouldn't"
		line "give a Berry."

		para "Miltank looks sad."
		done

.HappyCow:
	isfieldactionssettoquick
	iftrue .skipthis2
	reanchormap
	pokepic MILTANK
	cry MILTANK
	waitbutton
	closepokepic
.skipthis2
	opentext
	writethistext
		text "Miltank: Mooo!"
		done
	waitclosetext
	special FadeOutPalettes
	special LoadMapPalettes
	playsound SFX_FULL_HEAL
	special HealParty
	special FadeInPalettes_EnableDynNoApply
	end

Route11BarnGaveBerryText:
	text "<PLAYER> gave a"
	line "Berry to Miltank."
	done
