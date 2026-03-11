MahoganyMart1F_MapEvents:
	def_warp_events
	warp_event  3,  7, MAHOGANY_TOWN, 2
	warp_event  4,  7, MAHOGANY_TOWN, 2
	warp_event  7,  3, TEAM_ROCKET_BASE_B1F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  1,  3, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyMart1FGrannyScript, -1

	object_const_def
	const MAHOGANYMART1F_GRANNY

MahoganyMart1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, MahoganyMart1FStaircaseCallback

MahoganyMart1FStaircaseCallback:
	checkevent EVENT_UNCOVERED_STAIRCASE_IN_MAHOGANY_MART
	; supposed to be iftrue .ShowStairs when the event gets sets
	iffalse .ShowStairs
	endcallback

; if used in a script to instandly make it appear, do this:
;	changeblock 6, 2, $1e ; stairs
;	refreshmap
.ShowStairs:
	changeblock 6, 2, $1e ; stairs
	endcallback

MahoganyMart1FGrannyScript:
	faceplayeropentext
	pokemart MARTTYPE_STANDARD, MART_MAHOGANY
	endtext
