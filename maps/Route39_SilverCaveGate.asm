	object_const_def
	const ROUTE39MTSILVERGATE_OFFICER

Route39_SilverCaveGate_MapScripts:
	def_scene_scripts

	def_callbacks
 	callback MAPCALLBACK_TILES, Route39MtSilverGateClearDoorCallback

Route39MtSilverGateClearDoorCallback:
	checkevent EVENT_OPENED_MT_SILVER
	iftrue .Done
	changeblock  4,  0, $40 ; closed doors
	changeblock  5,  0, $40 ; closed doors
.Done:
	endcallback

Route39MtSilverGateOfficerScript:
	faceplayer
	opentext
	checkevent EVENT_OPENED_MT_SILVER
	iftrue .MtSilverIsOpenedForYou
	writetext LeadsToMtSilverText
	waitbutton
	closetext
	end

.MtSilverIsOpenedForYou
	writetext MtSilverIsOpenedForYouText
	waitbutton
	closetext
	end

LeadsToMtSilverText:
	text "This way leads to"
	line "MT.SILVER."

	para "You'll see scary-"
	line "strong #MON out"
	cont "there."
	
	para "I cannot permit"
	line "you passage as you"
	cont "are presently."
	done

MtSilverIsOpenedForYouText:
	text "A supreme trainer!"
	line "Go forth!" 
	done	

Route39_SilverCaveGate_MapEvents:
	def_warp_events
	warp_event  4,  7, ROUTE_39, 4
	warp_event  5,  7, ROUTE_39, 4
	warp_event  4,  0, SILVER_CAVE_OUTSIDE, 3
	warp_event  5,  0, SILVER_CAVE_OUTSIDE, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, Route39MtSilverGateOfficerScript, -1

