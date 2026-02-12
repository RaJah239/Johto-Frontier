	object_const_def
	const ROUTE20HEALHOUSE_TEACHER
	const ROUTE20HEALHOUSE_PORYGON_PC

Route20HealHouse_MapScripts:
	def_scene_scripts

	def_callbacks

Route20HealHouseTeacherScript:
	faceplayer
	opentext
	writetext Route20HealHouseRestAWhileText
	waitbutton
	closetext
	special FadeOutPalettes
	special LoadMapPalettes
	playsound SFX_FULL_HEAL
	special HealParty
	special FadeInPalettes_EnableDynNoApply
	opentext
	writetext Route20HealHouseKeepAtItText
	pause 20
	closetext
	turnobject PLAYER, DOWN
	end

Route20HealHouseBookshelf:
	jumpstd PictureBookshelfScript

Route20HealHouseRestAWhileText:
	text "Your #MON look"
	line "a little tired."

	para "You should rest"
	line "them a while."
	done

Route20HealHouseKeepAtItText:
	text "There!"
	line "Keep at it!"
	done

Route20HealHousePorygonPCScript:
	jumpstd PorygonPCScript

Route20HealHouse_MapEvents:
	def_warp_events
	warp_event  2,  7, ROUTE_20, 1
	warp_event  3,  7, ROUTE_20, 1

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, Route20HealHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, Route20HealHouseBookshelf

	def_object_events
	object_event  2,  4, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route20HealHouseTeacherScript, -1
	object_event  6,  5, SPRITE_PORYGON_OW, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route20HealHousePorygonPCScript, -1
