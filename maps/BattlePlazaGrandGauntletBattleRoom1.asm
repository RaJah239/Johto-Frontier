BattlePlazaGrandGauntletBattleRoom1_MapEvents:
	def_warp_events

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_UNKNOWN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 0, TrainerMaximaTest, -1
	object_event 4,  3, SPRITE_CHEST, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GGR1Item1, EVENT_FIRST_GG
	object_event 4,  4, SPRITE_CHEST, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GGR1Item2, GG_ROOM_1_ITEM_2
	object_event 4,  5, SPRITE_CHEST, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GGR1Item3, GG_ROOM_1_ITEM_3

	object_const_def
	const BATTLEPLAZAGRANDGAUNTLETBATTLEROOM1_MAXIMA
	const BATTLEPLAZAGRANDGAUNTLETBATTLEROOM1_CHEST1
	const BATTLEPLAZAGRANDGAUNTLETBATTLEROOM1_CHEST2
	const BATTLEPLAZAGRANDGAUNTLETBATTLEROOM1_CHEST3

BattlePlazaGrandGauntletBattleRoom1_MapScripts:
	def_scene_scripts

	def_callbacks

GGR1Item1:
GGR1Item2:
GGR1Item3:
	jumpstd GrandGauntletItemsScript

TrainerMaximaTest:
	generictrainer MAXIMA, MAXIMA1, EVENT_BEAT_YOUNGSTER_MIKEY, .SeenText, .BeatenText

.AfterText
	text "Keep it up!"
	done

.SeenText
	text "Go!"
	done

.BeatenText
	text "Not bad."
	done
