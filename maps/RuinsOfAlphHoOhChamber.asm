RuinsOfAlphHoOhChamber_MapEvents:
	def_warp_events
	warp_event  3,  9, RUINS_OF_ALPH_OUTSIDE, 2
	warp_event  4,  9, RUINS_OF_ALPH_OUTSIDE, 2
	warp_event  3,  3, RUINS_OF_ALPH_INNER_CHAMBER, 2
	warp_event  4,  3, RUINS_OF_ALPH_INNER_CHAMBER, 3
	warp_event  4,  0, RUINS_OF_ALPH_HO_OH_ITEM_ROOM, 1

	def_coord_events

	def_bg_events
	bg_event  2,  3, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event  5,  3, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event  3,  2, BGEVENT_UP, RuinsOfAlphHoOhChamberPuzzle
	bg_event  4,  2, BGEVENT_JUMPTEXT, RuinsOfAlphHoOhChamberDescriptionText
	bg_event  3,  0, BGEVENT_UP, RuinsOfAlphHoOhChamberWallPatternLeft
	bg_event  4,  0, BGEVENT_UP, RuinsOfAlphHoOhChamberWallPatternRight

	def_object_events

RuinsOfAlphHoOhChamber_MapScripts:
	def_scene_scripts
	scene_script RuinsOfAlphHoOhChamberCheckWallScene, SCENE_RUINSOFALPHHOOHCHAMBER_CHECK_WALL
	scene_script RuinsOfAlphHoOhChamberNoopScene,      SCENE_RUINSOFALPHHOOHCHAMBER_NOOP

	def_callbacks
	callback MAPCALLBACK_TILES, RuinsOfAlphHoOhChamberHiddenDoorsCallback

RuinsOfAlphHoOhChamberCheckWallScene:
	special HoOhChamber
	checkevent EVENT_WALL_OPENED_IN_HO_OH_CHAMBER
	iftrue .OpenWall
	end

.OpenWall:
	sdefer RuinsOfAlphHoOhChamberWallOpenScript
RuinsOfAlphHoOhChamberNoopScene:
	end

RuinsOfAlphHoOhChamberHiddenDoorsCallback:
	checkevent EVENT_WALL_OPENED_IN_HO_OH_CHAMBER
	iftrue .WallOpen
	changeblock 4, 0, $2e ; closed wall
.WallOpen:
	checkevent EVENT_SOLVED_HO_OH_PUZZLE
	iffalse .FloorClosed
	endcallback

.FloorClosed:
	changeblock 2, 2, $01 ; left floor
	changeblock 4, 2, $02 ; right floor
	endcallback

RuinsOfAlphHoOhChamberWallOpenScript:
	pause 30
	earthquake 30
	showemote EMOTE_SHOCK, PLAYER, 20
	pause 30
	playsound SFX_STRENGTH
	changeblock 4, 0, $30 ; open wall
	refreshmap
	earthquake 50
	setscene SCENE_RUINSOFALPHHOOHCHAMBER_NOOP
	endtext

RuinsOfAlphHoOhChamberPuzzle:
	reanchormap
	setval UNOWNPUZZLE_HO_OH
	special UnownPuzzle
	closetext
	iftrue .PuzzleComplete
	end

.PuzzleComplete:
	setevent EVENT_RUINS_OF_ALPH_INNER_CHAMBER_TOURISTS
	setevent EVENT_SOLVED_HO_OH_PUZZLE
	setflag ENGINE_UNLOCKED_UNOWNS_X_TO_Z
	setmapscene RUINS_OF_ALPH_INNER_CHAMBER, SCENE_RUINSOFALPHINNERCHAMBER_STRANGE_PRESENCE
	earthquake 30
	showemote EMOTE_SHOCK, PLAYER, 15
	changeblock 2, 2, $18 ; left hole
	changeblock 4, 2, $19 ; right hole
	refreshmap
	playsound SFX_STRENGTH
	earthquake 80
	applymovement PLAYER, RuinsOfAlphChamberSkyfallTopMovement
	playsound SFX_KINESIS
	waitsfx
	pause 20
	warpcheck
	end

RuinsOfAlphHoOhChamberWallPatternLeft:
	opentext
	writetext RuinsOfAlphChamberWallPatternText
	setval UNOWNWORDS_HO_OH
	special DisplayUnownWords
	endtext

RuinsOfAlphHoOhChamberWallPatternRight:
	checkevent EVENT_WALL_OPENED_IN_HO_OH_CHAMBER
	iftrue .WallOpen
	opentext
	writetext RuinsOfAlphChamberWallPatternText
	setval UNOWNWORDS_HO_OH
	special DisplayUnownWords
	endtext

.WallOpen:
	jumptextfaceplayer RuinsOfAlphChamberWallHoleText

RuinsOfAlphHoOhChamberDescriptionText:
	text "A #mon that"
	line "flew gracefully on"
	cont "rainbow-colored"
	cont "wings."
	done
