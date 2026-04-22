MobileBattleRoom_MapScripts:
	def_scene_scripts

	def_callbacks

MobileBattleRoomConsoleScript:
	reanchormap
	special Function1037c2
	ifequal $1, .one
	special Function1037eb
	iffalse .false
	ifequal $1, .one_
	ifequal $2, .two_
	sjump .false

.one_
	writetext MobileBattleRoom_HealText
	pause 20
	closetext
	special FadeOutToWhite
	playmusic MUSIC_HEAL
	special LoadMapPalettes
	pause 60
	special FadeInFromWhite
	special RestartMapMusic
	reanchormap
.two_
	special HealParty
	special Function10383c
	iftrue .false
.one
	special Function10387b
	writetext MobileBattleRoom_EstablishingCommsText
	waitbutton
	refreshmap
	special Function101225
.false
	closetext
	end

MobileBattleRoom_EstablishingCommsText:
	text "Establishing"
	line "communications…"
	done

MobileBattleRoom_HealText:
	text "Your #MON will"
	line "be fully healed"
	cont "before battle."
	done

MobileBattleRoom_MapEvents:
	def_warp_events

	def_coord_events

	def_bg_events
	bg_event  4,  2, BGEVENT_UP, MobileBattleRoomConsoleScript

	def_object_events
