Route15Gate_MapEvents:
	def_warp_events
	warp_event  4,  0, ROUTE_15, 4
	warp_event  5,  0, ROUTE_15, 5
	warp_event  4,  7, ROUTE_15, 3
	warp_event  5,  7, ROUTE_15, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, OfficerScript, -1

	object_const_def
	const ROUTE15GATE_OFFICER

Route15Gate_MapScripts:
	def_scene_scripts

	def_callbacks

OfficerScript:
	faceplayeropentext
	checkevent EVENT_GOT_TM_SLUDGE_BOMB
	iftrue .GotSludgeBomb
	writethistext
		text "I've been holding"
		line "onto this awhile"
		cont "now."

		para "Could you take it"
		line "away?"
		done
	promptbutton
	verbosegiveitem TM_SLUDGE_BOMB
	iffalse_endtext
	setevent EVENT_GOT_TM_SLUDGE_BOMB
.GotSludgeBomb
	jumpthisopenedtext
		text "Use this gate to"
		line "avoid walking in"
		cont "the grass."
		done
