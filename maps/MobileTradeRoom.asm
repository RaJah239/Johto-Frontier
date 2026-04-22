MobileTradeRoom_MapScripts:
	def_scene_scripts

	def_callbacks

MobileTradeRoomConsoleScript:
	reanchormap
	special Function1037c2
	writetext MobileTradeRoom_EstablishingCommsText
	waitbutton
	refreshmap
	special Function101231
	closetext
	end

MobileTradeRoom_EstablishingCommsText:
	text "Establishing"
	line "communications…"
	done

MobileTradeRoom_MapEvents:
	def_warp_events

	def_coord_events

	def_bg_events
	bg_event  4,  2, BGEVENT_UP, MobileTradeRoomConsoleScript

	def_object_events
