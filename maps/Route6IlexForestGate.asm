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
	porygonpc_event 1, 1, PAL_NPC_RED
	object_event  9,  3, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route6IlexForestGateTeacherScript, EVENT_ROUTE_6_ILEX_FOREST_GATE_TEACHER_BEHIND_COUNTER
	object_event  5,  7, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route6IlexForestGateTeacherScript, EVENT_ROUTE_6_ILEX_FOREST_GATE_TEACHER_IN_WALKWAY
	object_event  3,  4, SPRITE_LASS, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route6IlexForestGateLassText, EVENT_ROUTE_6_ILEX_FOREST_GATE_LASS
	object_event  9,  4, SPRITE_TANGELA, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_TEAL, OBJECTTYPE_SCRIPT, 0, Route6IlexForestGateTangelaScript, -1

	object_const_def
	const ROUTE6ILEXFORESTGATE_PORYGON_PC
	const ROUTE6ILEXFORESTGATE_TEACHER1
	const ROUTE6ILEXFORESTGATE_TEACHER2
	const ROUTE6ILEXFORESTGATE_LASS
	const ROUTE6ILEXFORESTGATE_TANGELA

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
	waitclosetext
	applymovement ROUTE6ILEXFORESTGATE_TEACHER2, Route6IlexForestGateTeacherReturnsMovement
.skip:
	end

Route6IlexForestGateTeacherBlocksPlayerMovement:
	step UP
	step UP
	step_end

Route6IlexForestGateTeacherReturnsMovement:
	step DOWN
	step RIGHT
	step_end

Route6IlexForestGateTeacherScript:
	faceplayeropentext
	checkevent EVENT_FOREST_IS_RESTLESS
	iftrue .ForestIsRestless
	checkevent EVENT_GOT_TANGELA_CALL
	iftrue .GotTangelaCall
	writethistext
		text "Oh, honey. You're"
		line "making a #dex?"

		para "It must be hard if"
		line "#mon won't"
		cont "appear."

		para "Try using this."
		done
	promptbutton
	verbosegiveitem TANGELA_CALL
	setevent EVENT_GOT_TANGELA_CALL
.GotTangelaCall:
	jumpthisopenedtext
		text "It's Tangela Call."

		para "Use it wherever"
		line "#mon appear."

		para "#mon will be"
		line "ensnared."
		done

.ForestIsRestless:
	writetext Route6IlexForestGateTeacher_ForestIsRestless
	waitendtext

Route6IlexForestGateTeacher_ForestIsRestless:
	text "Something's wrong"
	line "in Ilex Forest…"

	para "You should stay"
	line "away right now."
	done

Route6IlexForestGateLassText:
	text "Did you see the"
	line "shrine honoring"
	cont "the protector?"

	para "It watches over"
	line "the Forest from"
	cont "across time."

	para "I think that it"
	line "must be a grass-"
	cont "type #mon."
	done

Route6IlexForestGateTangelaScript:
	setval TANGELA
	special SetMonAsSeen
	reanchormap
	pokepic TANGELA
	cry TANGELA
	waitbutton
	closepokepic
	jumpthistext
		text "Tangela: Tan tan!"
		done
