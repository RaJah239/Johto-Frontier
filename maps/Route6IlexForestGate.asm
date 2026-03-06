Route6IlexForestGate_MapEvents:
	def_warp_events
	warp_event  4,  0, ROUTE_6, 1
	warp_event  5,  0, ROUTE_6, 2
	warp_event  4,  7, ILEX_FOREST, 1
	warp_event  5,  7, ILEX_FOREST, 1

	def_coord_events
	coord_event  4,  7, SCENE_ROUTE6ILEXFORESTGATE_TEACHER_BLOCKS_IF_FOREST_IS_RESTLESS, Route6IlexForestGateCelebiEvent

	def_bg_events

	def_object_events
	porygonpc_event 1, 2, PAL_NPC_RED
	object_event  9,  3, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route6IlexForestGateTeacherScript, EVENT_ROUTE_6_ILEX_FOREST_GATE_TEACHER_BEHIND_COUNTER
	object_event  9,  4, SPRITE_TANGELA, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_TEAL, OBJECTTYPE_SCRIPT, 0, Route6IlexForestGateButterfreeScript, -1
	object_event  3,  4, SPRITE_LASS, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route6IlexForestGateLassScript, EVENT_ROUTE_6_ILEX_FOREST_GATE_LASS
	object_event  5,  7, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route6IlexForestGateTeacherScript, EVENT_ROUTE_6_ILEX_FOREST_GATE_TEACHER_IN_WALKWAY

	object_const_def
	const ROUTE6ILEXFORESTGATE_PORYGON_PC
	const ROUTE6ILEXFORESTGATE_TEACHER1
	const ROUTE6ILEXFORESTGATE_BUTTERFREE
	const ROUTE6ILEXFORESTGATE_LASS
	const ROUTE6ILEXFORESTGATE_TEACHER2

Route6IlexForestGate_MapScripts:
	def_scene_scripts
	scene_const SCENE_ROUTE6ILEXFORESTGATE_TEACHER_BLOCKS_IF_FOREST_IS_RESTLESS

	def_callbacks
	callback MAPCALLBACK_OBJECTS, Route6IsForestRestlessCallback

Route6IsForestRestlessCallback:
	checkevent EVENT_FOREST_IS_RESTLESS
	iffalse .Normal
	disappear ROUTE6ILEXFORESTGATE_TEACHER1
	appear ROUTE6ILEXFORESTGATE_TEACHER2
	endcallback

.Normal:
	disappear ROUTE6ILEXFORESTGATE_TEACHER2
	appear ROUTE6ILEXFORESTGATE_TEACHER1
	endcallback

Route6IlexForestGateCelebiEvent:
	checkevent EVENT_FOREST_IS_RESTLESS
	iffalse .skip
	showemote EMOTE_SHOCK, ROUTE6ILEXFORESTGATE_TEACHER2, 20
	turnobject ROUTE6ILEXFORESTGATE_TEACHER2, LEFT
	turnobject PLAYER, RIGHT
	follow PLAYER, ROUTE6ILEXFORESTGATE_TEACHER2
	applymovement PLAYER, Route6IlexForestGateTeacherBlocksPlayerMovement
	stopfollow
	turnobject PLAYER, DOWN
	opentext
	writetext Route6IlexForestGateTeacher_ForestIsRestless
	waitbutton
	closetext
	applymovement ROUTE6ILEXFORESTGATE_TEACHER2, Route6IlexForestGateTeacherReturnsMovement
.skip:
	end

Route6IlexForestGateTeacherScript:
	faceplayer
	opentext
	checkevent EVENT_FOREST_IS_RESTLESS
	iftrue .ForestIsRestless
	checkevent EVENT_GOT_TANGELA_CALL
	iftrue .GotSweetScent
	writetext Route6IlexForestGateTeacherText
	promptbutton
	verbosegiveitem TANGELA_CALL
	iffalse .NoRoom
	setevent EVENT_GOT_TANGELA_CALL
.GotSweetScent:
	writetext Route6IlexForestGateTeacher_GotSweetScent
	waitbutton
.NoRoom:
	closetext
	end

.ForestIsRestless:
	writetext Route6IlexForestGateTeacher_ForestIsRestless
	promptbutton
	closetext
	end

Route6IlexForestGateButterfreeScript:
	opentext
	writetext Route6IlexForestGateButterfreeText
	waitbutton
	closetext
	end

Route6IlexForestGateLassScript:
	jumptextfaceplayer Route6IlexForestGateLassText

Route6IlexForestGateTeacherBlocksPlayerMovement:
	step UP
	step UP
	step_end

Route6IlexForestGateTeacherReturnsMovement:
	step DOWN
	step RIGHT
	step_end

Route6IlexForestGateTeacherText:
	text "Oh, honey. You're"
	line "making a #DEX?"

	para "It must be hard if"
	line "#MON won't"

	para "appear. Try using"
	line "this TM."
	done

Route6IlexForestGateTeacher_GotSweetScent:
	text "It's SWEET SCENT."

	para "Use it wherever"
	line "#MON appear."

	para "#MON will be"
	line "enticed by it."
	done

Route6IlexForestGateTeacher_ForestIsRestless:
	text "Something's wrong"
	line "in ILEX FOREST…"

	para "You should stay"
	line "away right now."
	done

Route6IlexForestGateButterfreeText:
	text "BUTTERFREE: Freeh!"
	done

Route6IlexForestGateLassText:
	text "Did you see the"
	line "shrine honoring"
	cont "the protector?"

	para "It watches over"
	line "the FOREST from"
	cont "across time."

	para "I think that it"
	line "must be a grass-"
	cont "type #MON."
	done
