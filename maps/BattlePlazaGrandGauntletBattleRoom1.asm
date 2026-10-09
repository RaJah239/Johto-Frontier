BattlePlazaGrandGauntletBattleRoom1_MapEvents:
	def_warp_events

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_UNKNOWN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 0, TrainerMaximaTest, -1
	object_event 4,  2, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route1Potion22, EVENT_ROUTE_1_POTION

	object_const_def
	const BATTLEPLAZAGRANDGAUNTLETBATTLEROOM1_MAXIMA
	const BATTLEPLAZAGRANDGAUNTLETBATTLEROOM1_POKE_BALL

BattlePlazaGrandGauntletBattleRoom1_MapScripts:
	def_scene_scripts

	def_callbacks

Route1Potion22:
	itemball POTION

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
