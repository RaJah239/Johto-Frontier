MobileTradeRoom_MapScripts:
	def_scene_scripts
	scene_script MobileTradeRoomInitializeScene, SCENE_MOBILETRADEROOM_INITIALIZE
	scene_script MobileTradeRoomNoopScene,       SCENE_MOBILETRADEROOM_NOOP

	def_callbacks
; TODOTEXT to remove this
MobileTradeRoomInitializeScene:
	sdefer MobileTradeRoomInitializeAndPreparePokecenter2FScript
	end

MobileTradeRoomNoopScene:
	end

MobileTradeRoomInitializeAndPreparePokecenter2FScript:
	setscene SCENE_MOBILETRADEROOM_NOOP
	end

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
