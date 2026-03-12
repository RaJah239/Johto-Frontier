DayOfWeekSiblingsHouse_MapEvents:
	def_warp_events
	warp_event  2,  7, ROUTE_20, 3
	warp_event  3,  7, ROUTE_20, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  3, SPRITE_POKEDEX, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DayOfWeekSiblingsHousePokedexScript, -1

	object_const_def
	const DAYOFWEEKSIBLINGSHOUSE_POKEDEX

DayOfWeekSiblingsHouse_MapScripts:
	def_scene_scripts

	def_callbacks

DayOfWeekSiblingsHousePokedexScript:
	opentext
	writethistext
		text "There's something"
		line "written here."

		para "Read it?"
		done
	yesorno
	iffalse_endtext
	writethistext
		text "To my brothers and"
		line "sisters:"

		para "We take pride in"
		line "serving #mon"
		cont "trainers."

		para "When trainers talk"
		line "to you, give them"
		cont "something useful."

		para "Love,"
		line "Monica"

		para "Keep reading?"
		done
	yesorno
	iffalse_endtext
	jumpthisopenedtext
		text "Monday, Monica"
		line "Route 12"

		para "Tuesday, Tuscany"
		line "Route 1"

		para "Wednesday, Wesley"
		line "Lake Of Rage"

		para "Thursday, Arthur"
		line "Route 8"

		para "Friday, Frieda"
		line "Route 4"

		para "Saturday, Santos"
		line "Blackthorn City"

		para "Sunday, Sunny"
		line "Route 9"
		done
