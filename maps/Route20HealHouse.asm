Route20HealHouse_MapEvents:
	def_warp_events
	warp_event  2,  7, ROUTE_20, 1
	warp_event  3,  7, ROUTE_20, 1

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_JUMPSTD, PICTURE_BOOKSHELF_SCRIPT
	bg_event  1,  1, BGEVENT_JUMPSTD, PICTURE_BOOKSHELF_SCRIPT

	def_object_events
	porygonpc_event 6, 5, PAL_NPC_RED
	object_event  2,  4, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route20HealHouseTeacherScript, -1

	object_const_def
	const ROUTE20HEALHOUSE_PORYGON_PC
	const ROUTE20HEALHOUSE_TEACHER

Route20HealHouse_MapScripts:
	def_scene_scripts

	def_callbacks

Route20HealHouseTeacherScript:
	showthistextfaceplayer
		text "Your #mon look"
		line "a little tired."

		para "You should rest"
		line "them a while."
		done
	special FadeOutPalettes
	special LoadMapPalettes
	playsound SFX_FULL_HEAL
	special HealParty
	special FadeInPalettes_EnableDynNoApply
	opentext
	writethistext
		text "There!"
		line "Keep at it!"
		done
	pause 20
	closetext
	turnobject PLAYER, DOWN
	end
