Route2BerryHouse_MapEvents:
	def_warp_events
	warp_event  2,  7, ROUTE_2, 1
	warp_event  3,  7, ROUTE_2, 1

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_JUMPSTD, MAGAZINE_BOOKSHELF_SCRIPT
	bg_event  1,  1, BGEVENT_JUMPSTD, MAGAZINE_BOOKSHELF_SCRIPT

	def_object_events
	object_event  2,  3, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Route2BerryHousePokefanMScript, -1

	object_const_def
	const ROUTE2BERRYHOUSE_TEACHER

Route2BerryHouse_MapScripts:
	def_scene_scripts

	def_callbacks

Route2BerryHousePokefanMScript:
	faceplayeropentext
	checkevent EVENT_GOT_BERRY_FROM_ROUTE_2_HOUSE
	iftrue .GotBerry
	writethistext
		text "You know, #mon"
		line "eat berries."

		para "Well, my #mon"
		line "got healthier by"
		cont "eating a Berry."

		para "Here. I'll share"
		line "one with you!"
		done
	promptbutton
	verbosegiveitem BERRY
	iffalse .NoRoom
	setevent EVENT_GOT_BERRY_FROM_ROUTE_2_HOUSE
	setmapscene ROUTE_2, SCENE_ROUTE_2_NOOP
.GotBerry:
	writethistext
		text "Check trees for"
		line "fruits."

		para "They drop right"
		line "off."

		para "Picked fruits re-"
		line "grow as you travel"
		cont "1,000 steps or so."
		done
	waitbutton
.NoRoom:
	endtext
