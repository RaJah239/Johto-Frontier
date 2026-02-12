	object_const_def
	const ROUTE2BERRYHOUSE_TEACHER

Route2BerryHouse_MapScripts:
	def_scene_scripts

	def_callbacks

Route2BerryHousePokefanMScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_BERRY_FROM_ROUTE_2_HOUSE
	iftrue .GotBerry
	writetext Route2BerrySpeechHouseMonEatBerriesText
	promptbutton
	verbosegiveitem BERRY
	iffalse .NoRoom
	setevent EVENT_GOT_BERRY_FROM_ROUTE_2_HOUSE
	setmapscene ROUTE_2, SCENE_ROUTE_2_NOOP
.GotBerry:
	writetext Route2BerrySpeechHouseCheckTreesText
	waitbutton
.NoRoom:
	closetext
	end

Route2BerryHouseBookshelf:
	jumpstd MagazineBookshelfScript

Route2BerrySpeechHouseMonEatBerriesText:
	text "You know, #MON"
	line "eat BERRIES."

	para "Well, my #MON"
	line "got healthier by"
	cont "eating a BERRY."

	para "Here. I'll share"
	line "one with you!"
	done

Route2BerrySpeechHouseCheckTreesText:
	text "Check trees for"
	line "BERRIES. They just"
	cont "drop right off."

	para "Picked BERRIES re-"
	line "grow you travel."
	done

Route2BerryHouse_MapEvents:
	def_warp_events
	warp_event  2,  7, ROUTE_2, 1
	warp_event  3,  7, ROUTE_2, 1

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, Route2BerryHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, Route2BerryHouseBookshelf

	def_object_events
	object_event  2,  3, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Route2BerryHousePokefanMScript, -1
