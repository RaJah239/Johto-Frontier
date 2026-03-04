	object_const_def
	const RUINSOFALPHLILEEPCHAMBER_RECEPTIONIST
	const RUINSOFALPHLILEEPCHAMBER_SCIENTIST

RuinsOfAlphLileepChamber_MapScripts:
	def_scene_scripts
	scene_script RuinsOfAlphLileepChamberCheckWallScene, SCENE_RUINSOFALPHLILEEPCHAMBER_CHECK_WALL
	scene_script RuinsOfAlphLileepChamberNoopScene,      SCENE_RUINSOFALPHLILEEPCHAMBER_NOOP

	def_callbacks
	callback MAPCALLBACK_TILES, RuinsOfAlphLileepChamberHiddenDoorsCallback

RuinsOfAlphLileepChamberCheckWallScene:
	checkevent EVENT_WALL_OPENED_IN_LILEEP_CHAMBER
	iftrue .OpenWall
	end

.OpenWall:
	sdefer RuinsOfAlphLileepChamberWallOpenScript
	end

RuinsOfAlphLileepChamberNoopScene:
	end

RuinsOfAlphLileepChamberHiddenDoorsCallback:
	checkevent EVENT_WALL_OPENED_IN_LILEEP_CHAMBER
	iftrue .WallOpen
	changeblock 4, 0, $2e ; closed wall
.WallOpen:
	checkevent EVENT_SOLVED_LILEEP_PUZZLE
	iffalse .FloorClosed
	endcallback

.FloorClosed:
	changeblock 2, 2, $01 ; left floor
	changeblock 4, 2, $02 ; right floor
	endcallback

RuinsOfAlphLileepChamberWallOpenScript:
	pause 30
	earthquake 30
	showemote EMOTE_SHOCK, PLAYER, 20
	pause 30
	playsound SFX_STRENGTH
	changeblock 4, 0, $30 ; open wall
	refreshmap
	earthquake 50
	setscene SCENE_RUINSOFALPHLILEEPCHAMBER_NOOP
	closetext
	end

RuinsOfAlphLileepChamberReceptionistScript:
	jumptextfaceplayer RuinsOfAlphLileepChamberReceptionistText

RuinsOfAlphLileepChamberPuzzle:
	reanchormap
	setval UNOWNPUZZLE_LILEEP
	special UnownPuzzle
	closetext
	iftrue .PuzzleComplete
	end

.PuzzleComplete:
	setevent EVENT_RUINS_OF_ALPH_INNER_CHAMBER_TOURISTS
	setevent EVENT_SOLVED_LILEEP_PUZZLE
	setflag ENGINE_UNLOCKED_UNOWNS_A_TO_K
	setevent EVENT_RUINS_OF_ALPH_LILEEP_CHAMBER_RECEPTIONIST
	setmapscene RUINS_OF_ALPH_INNER_CHAMBER, SCENE_RUINSOFALPHINNERCHAMBER_STRANGE_PRESENCE
	earthquake 30
	showemote EMOTE_SHOCK, PLAYER, 15
	changeblock 2, 2, $18 ; left hole
	changeblock 4, 2, $19 ; right hole
	refreshmap
	playsound SFX_STRENGTH
	earthquake 80
	applymovement PLAYER, RuinsOfAlphLileepChamberSkyfallTopMovement
	playsound SFX_KINESIS
	waitsfx
	pause 20
	warpcheck
	end

RuinsOfAlphLileepChamberScientistScript:
	faceplayer
	opentext
	readvar VAR_UNOWNCOUNT
	ifequal NUM_UNOWN, .AllUnownCaught
	checkevent EVENT_WALL_OPENED_IN_LILEEP_CHAMBER
	iftrue .WallOpen
	checkevent EVENT_SOLVED_LILEEP_PUZZLE
	iffalse .PuzzleIncomplete
	writetext RuinsOfAlphLileepChamberScientistTremorText
	promptbutton
.PuzzleIncomplete:
	writetext RuinsOfAlphLileepChamberScientistCrypticText
	waitbutton
	closetext
	turnobject RUINSOFALPHLILEEPCHAMBER_SCIENTIST, UP
	end

.WallOpen:
	writetext RuinsOfAlphLileepChamberScientistHoleText
	waitbutton
	closetext
	end

.AllUnownCaught:
	writetext RuinsOfAlphLileepChamberScientistText_GotAllUnown
	waitbutton
	closetext
	end

RuinsOfAlphLileepChamberAncientReplica:
	jumptext RuinsOfAlphLileepChamberAncientReplicaText

RuinsOfAlphLileepChamberDescriptionSign:
	jumptext RuinsOfAlphLileepChamberDescriptionText

RuinsOfAlphLileepChamberWallPatternLeft:
	opentext
	writetext RuinsOfAlphLileepChamberWallPatternText
	setval UNOWNWORDS_ESCAPE
	special DisplayUnownWords
	closetext
	end

RuinsOfAlphLileepChamberWallPatternRight:
	checkevent EVENT_WALL_OPENED_IN_LILEEP_CHAMBER
	iftrue .WallOpen
	opentext
	writetext RuinsOfAlphLileepChamberWallPatternText
	setval UNOWNWORDS_ESCAPE
	special DisplayUnownWords
	closetext
	end

.WallOpen:
	opentext
	writetext RuinsOfAlphLileepChamberWallHoleText
	waitbutton
	closetext
	end

RuinsOfAlphLileepChamberSkyfallTopMovement:
	skyfall_top
	step_end

RuinsOfAlphLileepChamberReceptionistText:
	text "Welcome to this"
	line "chamber."

	para "There are sliding"
	line "panels that depict"

	para "a #MON drawn by"
	line "the ancients."

	para "Slide the panels"
	line "around to form the"
	cont "picture."

	para "To the right is a"
	line "description of the"
	cont "#MON."

	para "Scientists in the"
	line "back are examining"

	para "some newly found"
	line "patterns."
	done

RuinsOfAlphLileepChamberScientistCrypticText:
	text "Recently, strange,"
	line "cryptic patterns"
	cont "have appeared."

	para "It's odd. They"
	line "weren't here a"
	cont "little while ago…"

	para "You should take a"
	line "look at the walls."
	done

RuinsOfAlphLileepChamberScientistHoleText:
	text "Ah! Here's another"
	line "huge hole!"

	para "It's big enough to"
	line "go through!"
	done

RuinsOfAlphLileepChamberScientistTremorText:
	text "That tremor was"
	line "pretty scary!"

	para "But I'm more"
	line "concerned about"
	cont "this wall here…"
	done

RuinsOfAlphLileepChamberWallPatternText:
	text "Patterns appeared"
	line "on the walls…"
	done

RuinsOfAlphLileepChamberWallHoleText:
	text "There's a big hole"
	line "in the wall!"
	done

RuinsOfAlphLileepChamberAncientReplicaText:
	text "It's a replica of"
	line "an ancient #-"
	cont "MON."
	done

RuinsOfAlphLileepChamberDescriptionText:
	text "A #MON that hid"
	line "on the sea floor."

	para "Eyes on its back"
	line "scanned the area."
	done

RuinsOfAlphLileepChamberScientistText_GotAllUnown:
	text "Our investigation"
	line "is going well!"
	done

RuinsOfAlphLileepChamber_MapEvents:
	def_warp_events
	warp_event  3,  9, RUINS_OF_ALPH_OUTSIDE, 3
	warp_event  4,  9, RUINS_OF_ALPH_OUTSIDE, 3
	warp_event  3,  3, RUINS_OF_ALPH_INNER_CHAMBER, 4
	warp_event  4,  3, RUINS_OF_ALPH_INNER_CHAMBER, 5
	warp_event  4,  0, RUINS_OF_ALPH_LILEEP_ITEM_ROOM, 1

	def_coord_events

	def_bg_events
	bg_event  2,  3, BGEVENT_READ, RuinsOfAlphLileepChamberAncientReplica
	bg_event  5,  3, BGEVENT_READ, RuinsOfAlphLileepChamberAncientReplica
	bg_event  3,  2, BGEVENT_UP, RuinsOfAlphLileepChamberPuzzle
	bg_event  4,  2, BGEVENT_UP, RuinsOfAlphLileepChamberDescriptionSign
	bg_event  3,  0, BGEVENT_UP, RuinsOfAlphLileepChamberWallPatternLeft
	bg_event  4,  0, BGEVENT_UP, RuinsOfAlphLileepChamberWallPatternRight

	def_object_events
	object_event  5,  5, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphLileepChamberReceptionistScript, EVENT_RUINS_OF_ALPH_LILEEP_CHAMBER_RECEPTIONIST
	object_event  3,  1, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphLileepChamberScientistScript, -1
