RuinsOfAlphResearchCenter_MapEvents:
	def_warp_events
	warp_event  2,  7, RUINS_OF_ALPH_OUTSIDE, 1
	warp_event  3,  7, RUINS_OF_ALPH_OUTSIDE, 1

	def_coord_events

	def_bg_events
	bg_event  6,  5, BGEVENT_JUMPTEXT, RuinsOfAlphResearchCenterAcademicBooksText
	bg_event  3,  4, BGEVENT_READ, RuinsOfAlphResearchCenterComputer
	bg_event  7,  1, BGEVENT_READ, RuinsOfAlphResearchCenterPrinter

	def_object_events
	object_event  4,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphResearchCenterScientist1Script, -1
	object_event  5,  2, SPRITE_SCIENTIST, SPRITEMOVEDATA_WANDER, 2, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphResearchCenterScientist2Script, -1
	object_event  2,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphResearchCenterScientist3Script, EVENT_RUINS_OF_ALPH_RESEARCH_CENTER_SCIENTIST
	porygonpc_event 0, 2, PAL_NPC_RED
	object_event  2,  2, SPRITE_SCIENTIST, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, FossilScientist, -1

	object_const_def
	const RUINSOFALPHRESEARCHCENTER_SCIENTIST1
	const RUINSOFALPHRESEARCHCENTER_SCIENTIST2
	const RUINSOFALPHRESEARCHCENTER_SCIENTIST3
	const RUINSOFALPHRESEARCHCENTER_PORYGON_PC
	const RUINSOFALPHRESEARCHCENTER_FOSSIL_SCIENTIST

RuinsOfAlphResearchCenter_MapScripts:
	def_scene_scripts
	scene_script RuinsOfAlphResearchCenterNoopScene,        SCENE_RUINSOFALPHRESEARCHCENTER_NOOP
	scene_script RuinsOfAlphResearchCenterGetUnownDexScene, SCENE_RUINSOFALPHRESEARCHCENTER_GET_UNOWN_DEX

	def_callbacks
	callback MAPCALLBACK_OBJECTS, RuinsOfAlphResearchCenterScientistCallback

RuinsOfAlphResearchCenterGetUnownDexScene:
	sdefer RuinsOfAlphResearchCenterGetUnownDexScript
RuinsOfAlphResearchCenterNoopScene:
	end

RuinsOfAlphResearchCenterScientistCallback:
	checkscene
	ifequal SCENE_RUINSOFALPHRESEARCHCENTER_GET_UNOWN_DEX, .ShowScientist
	endcallback

.ShowScientist:
	moveobject RUINSOFALPHRESEARCHCENTER_SCIENTIST3, 3, 7
	appear RUINSOFALPHRESEARCHCENTER_SCIENTIST3
	endcallback

RuinsOfAlphResearchCenterGetUnownDexScript:
	applymovement RUINSOFALPHRESEARCHCENTER_SCIENTIST3, RuinsOfAlphResearchCenterApproachesComputerMovement
	playsound SFX_BOOT_PC
	pause 60
	playsound SFX_SWITCH_POKEMON
	pause 30
	playsound SFX_TALLY
	pause 30
	playsound SFX_TRANSACTION
	pause 30
	turnobject RUINSOFALPHRESEARCHCENTER_SCIENTIST3, DOWN
	showthistext
		text "Done!"

		para "I modified your"
		line "#dex."

		para "I added an"
		line "optional #dex"
		cont "to store Unown"
		cont "data."

		para "It records them in"
		line "the sequence that"
		cont "they were caught."
		done
	applymovement RUINSOFALPHRESEARCHCENTER_SCIENTIST3, RuinsOfAlphResearchCenterApproachesPlayerMovement
	opentext
	writethistext
		text "<PLAYER>'s #dex"
		line "was upgraded."
		done
	playsound SFX_ITEM
	waitsfx
	setflag ENGINE_UNOWN_DEX
	writetext RuinsOfAlphResearchCenterScientist3Text
	waitclosetext
	applymovement RUINSOFALPHRESEARCHCENTER_SCIENTIST3, RuinsOfAlphResearchCenterLeavesPlayerMovement
	setscene SCENE_RUINSOFALPHRESEARCHCENTER_NOOP
	special RestartMapMusic
	end

RuinsOfAlphResearchCenterApproachesPlayerMovement:
	step DOWN
	step_end

RuinsOfAlphResearchCenterLeavesPlayerMovement:
	step UP
	step_end

RuinsOfAlphResearchCenterApproachesComputerMovement:
	step UP
	step UP
	step LEFT
	turn_head UP
	step_end

RuinsOfAlphResearchCenterScientist3Script:
	faceplayer
	opentext
	readvar VAR_UNOWNCOUNT
	ifequal NUM_UNOWN, .PrinterAvailable
	writetext RuinsOfAlphResearchCenterScientist3Text
	waitbutton
	closetext
	end

.PrinterAvailable:
	setevent EVENT_CAUGHT_ALL_UNOWN
	jumpthisopenedtext
		text "You caught all the"
		line "Unown variations?"

		para "That's a great"
		line "achievement!"

		para "I've set up the"
		line "printer here for"
		cont "handling Unown."

		para "Feel free to use"
		line "it anytime."
		done

RuinsOfAlphResearchCenterScientist3Text:
	text "The Unown you"
	line "catch will all be"
	cont "recorded."

	para "Check to see how"
	line "many kinds exist."
	done

RuinsOfAlphResearchCenterScientist1Script:
	faceplayeropentext
	readvar VAR_UNOWNCOUNT
	ifequal NUM_UNOWN, .GotAllUnown
	checkflag ENGINE_UNOWN_DEX
	iftrue .GotUnownDex
	checkevent EVENT_MADE_UNOWN_APPEAR_IN_RUINS
	iftrue .UnownAppeared
	jumpthisopenedtext
		text "The ruins are"
		line "about 1500 years"
		cont "old."

		para "But it's not known"
		line "why they were"
		cont "built--or by whom."
		done

.UnownAppeared:
	jumpthisopenedtext
		text "#mon appeared"
		line "in the ruins?"

		para "That's incredible"
		line "news!"

		para "We'll need to"
		line "investigate this."
		done

.GotUnownDex:
	jumpthisopenedtext
		text "I wonder how many"
		line "kinds of #mon"
		cont "are in the ruins?"
		done

.GotAllUnown:
	clearevent EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_YOUNGSTERS
	jumpthisopenedtext
		text "Our investigation,"
		line "with your help, is"
		cont "giving us insight"
		cont "into the ruins."

		para "The ruins appear"
		line "to have been built"
		cont "as a habitat for"
		cont "#mon."
		done

RuinsOfAlphResearchCenterScientist2Script:
	faceplayeropentext
	readvar VAR_UNOWNCOUNT
	ifequal NUM_UNOWN, .GotAllUnown
	checkevent EVENT_MADE_UNOWN_APPEAR_IN_RUINS
	iftrue .UnownAppeared
	jumpthisopenedtext
		text "There are odd pat-"
		line "terns drawn on the"
		cont "walls of the"
		cont "ruins."

		para "They must be the"
		line "keys for unravel-"
		cont "ing the mystery"
		cont "of the ruins."
		done

.UnownAppeared:
	jumpthisopenedtext
		text "The strange #-"
		line "mon you saw in the"
		cont "ruins?"

		para "They appear to be"
		line "very much like the"
		cont "drawings on the"
		cont "walls there."

		para "Hmm…"

		para "That must mean"
		line "there are many"
		cont "kinds of them…"
		done

.GotAllUnown:
	jumpthisopenedtext
		text "Why did those"
		line "ancient patterns"
		cont "appear on the wall"
		cont "now?"

		para "The mystery"
		line "deepens…"
		done

RuinsOfAlphResearchCenterComputer:
	opentext
	checkevent EVENT_RUINS_OF_ALPH_RESEARCH_CENTER_SCIENTIST
	iftrue .SkipChecking
	readvar VAR_UNOWNCOUNT
	ifequal NUM_UNOWN, .GotAllUnown
.SkipChecking:
	jumpthisopenedtext
		text "Ruins Of Alph"

		para "Exploration"
		line "Year 25"
		done

.GotAllUnown:
	jumpthisopenedtext
		text "Mystery #mon"
		line "Name: Unown"

		para "A total of {d:NUM_UNOWN}"
		line "kinds found."
		done

RuinsOfAlphResearchCenterPrinter:
	opentext
	checkevent EVENT_RUINS_OF_ALPH_RESEARCH_CENTER_SCIENTIST
	iftrue .SkipChecking
	readvar VAR_UNOWNCOUNT
	ifequal NUM_UNOWN, .PrinterAvailable
.SkipChecking:
	jumpthisopenedtext
		text "This doesn't seem"
		line "to work yet."
		done

.PrinterAvailable:
	writethistext
		text "Unown may be"
		line "printed out."
		done
	waitbutton
	special UnownPrinter
	endtext

FossilScientist:
	faceplayeropentext
.FossilScientistAgain:
	checkevent EVENT_MET_FOSSIL_SCIENTIST
	iftrue .HaveAFossilForMe
	writethistext
		text "Well, Hello there."
		line "I'm a researcher."

		para "I study ancient"
		line "#mon fossils."

		para "Do you have a"
		line "fossil?"
		done
	setevent EVENT_MET_FOSSIL_SCIENTIST
	sjump .FirstVisit

.HaveAFossilForMe:
	writethistext
		text "Welcome once more!"
		line "Found any fossils?"
		done
.FirstVisit:
	checkevent EVENT_GAVE_SCIENTIST_OLD_AMBER
	iftrue .GiveAerodactyl
	checkevent EVENT_GAVE_SCIENTIST_ROOT_FOSSIL
	iftrue .GiveLileep
	checkevent EVENT_GAVE_SCIENTIST_HELIX_FOSSIL
	iftrue .GiveOmanyte
	waitbutton
	loadmenu .MoveMenuHeader
	verticalmenu
	closewindow
	ifequal REVIVE_OLD_AMBER, .OldAmber
	ifequal REVIVE_ROOT_FOSSIL, .RootFossil
	ifequal REVIVE_HELIX_FOSSIL, .HelixFossil
	sjump .No
 
.OldAmber:
	checkitem OLD_AMBER
	iffalse .No
	getmonname STRING_BUFFER_3, AERODACTYL
	writetext FossilScientistMonText
	promptbutton
	setevent EVENT_GAVE_SCIENTIST_OLD_AMBER
	takeitem OLD_AMBER
	writetext FossilScientistGiveText
	waitbutton
	sjump .GaveScientistFossil
 
.RootFossil:
	checkitem ROOT_FOSSIL
	iffalse .No
	getmonname STRING_BUFFER_3, LILEEP
	writetext FossilScientistMonText
	promptbutton
	setevent EVENT_GAVE_SCIENTIST_ROOT_FOSSIL
	takeitem ROOT_FOSSIL
	writetext FossilScientistGiveText
	waitbutton
	sjump .GaveScientistFossil
 
.HelixFossil:
	checkitem HELIX_FOSSIL
	iffalse .No
	getmonname STRING_BUFFER_3, OMANYTE
	writetext FossilScientistMonText
	promptbutton
	setevent EVENT_GAVE_SCIENTIST_HELIX_FOSSIL
	takeitem HELIX_FOSSIL
	writetext FossilScientistGiveText
	waitbutton
	sjump .GaveScientistFossil
 
.No:
	jumpthisopenedtext
		text "No? That's alright."

		para "Fossils may be"
		line "found inside of"
		cont "breakable rocks."

		para "Come visit again"
		line "if you find any."
		done 
 
.GaveScientistFossil:
	writethistext
		text "This'll just"
		line "take a moment!"
		done
	playsound SFX_ZAP_CANNON
	waitsfx
	promptbutton
	sjump .FossilScientistAgain
 
.GiveAerodactyl:
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .NoRoom
	clearevent EVENT_GAVE_SCIENTIST_OLD_AMBER
	writetext FossilScientistDoneText
	promptbutton
	getmonname STRING_BUFFER_3, AERODACTYL
	writetext FossilScientistReceiveText
	playsound SFX_CAUGHT_MON
	waitsfx
	waitbutton
	givepoke AERODACTYL, 5
	writetext DropByWithFossilsText
	waitendtext
 
.GiveLileep:
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .NoRoom
	clearevent EVENT_GAVE_SCIENTIST_ROOT_FOSSIL
	writetext FossilScientistDoneText
	promptbutton
	getmonname STRING_BUFFER_3, LILEEP
	writetext FossilScientistReceiveText
	playsound SFX_CAUGHT_MON
	waitsfx
	waitbutton
	givepoke LILEEP, 5
	writetext DropByWithFossilsText
	waitendtext
 
.GiveOmanyte:
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .NoRoom
	clearevent EVENT_GAVE_SCIENTIST_HELIX_FOSSIL
	writetext FossilScientistDoneText
	promptbutton
	getmonname STRING_BUFFER_3, OMANYTE
	writetext FossilScientistReceiveText
	playsound SFX_CAUGHT_MON
	waitsfx
	waitbutton
	givepoke OMANYTE, 5
	writetext DropByWithFossilsText
	waitendtext
 
.NoRoom:
	jumpthisopenedtext
		text "Hmmm…?"

		para "Your party is"
		line "already full…"
		
		para "Return when you"
		line "have a free slot."
		done
 
.MoveMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 2, 15, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option
 
.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
	db 4 ; items
	db "Old Amber@"
	db "Root Fossil@"
	db "Helix Fossil@"
	db "Cancel@"

FossilScientistMonText:
	text "Oh? That's"
	line "a fossil!"

	para "It's a fossil of"
	line "@"
	text_ram wStringBuffer3
	text ", a"

	para "#mon that is"
	line "already extinct!"

	para "My Resurrection"
	line "Machine will make"

	para "that #mon live"
	line "again!"
	done

FossilScientistGiveText:
	text "Allow me to have"
	line "it for a moment?"

	para "<PLAYER> handed"
	line "over the fossil."
	done

FossilScientistDoneText:
	text "Your fossil has"
	line "been resurrected!"
	done

FossilScientistReceiveText:
	text "<PLAYER> received"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done

DropByWithFossilsText:
	text "Drop in if you get"
	line "more fossils."
	done

RuinsOfAlphResearchCenterAcademicBooksText:
	text "There are many"
	line "academic books."

	para "Ancient Ruins…"
	line "Mysteries of the"
	cont "Ancients…"
	done
