SilverCaveRoom3_MapEvents:
	def_warp_events
	warp_event  9, 33, SILVER_CAVE_ROOM_2, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  9, 10, SPRITE_RED, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Red, EVENT_RED_IN_MT_SILVER

	object_const_def
	const SILVERCAVEROOM3_RED

SilverCaveRoom3_MapScripts:
	def_scene_scripts

	def_callbacks

; TODOTEXT not sure what to do with this room yet or RED
Red:
	special FadeOutMusic
	faceplayeropentext
	writethistext
		text "<……>"
		line "<……>"
		done
	waitclosetext
	winlosstext RedWinLossText, 0
	loadtrainer RED, RED1
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	special FadeOutMusic
	showthistextfaceplayer
		text "<……>"
		line "<……>"
		done
	special FadeOutToBlack
	special ReloadSpritesNoPalettes
	disappear SILVERCAVEROOM3_RED
	pause 15
	special FadeInFromBlack
	pause 30
	special HealParty
	reanchormap
	credits
	end

RedWinLossText:
	text "…"
	done
