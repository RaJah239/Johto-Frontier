Route20_MapEvents:
	def_warp_events
	warp_event 15, 57, ROUTE_20_HEAL_HOUSE, 1
	warp_event  7,  5, VICTORY_ROAD_GATE, 1
	warp_event  5, 71, DAY_OF_WEEK_SIBLINGS_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event  8,  6, BGEVENT_JUMPTEXT, Route20SignText
	bg_event 14, 54, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 14, 53, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 13, 53, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 13, 54, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event  4, 95, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event  4, 96, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event  5, 96, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT

	def_object_events
	object_event 14, 24, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 2, TrainerCooltrainermJake, -1
	object_event  9, 38, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 3, TrainerCooltrainermGaven, -1
	object_event 10, 56, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 3, TrainerCooltrainerfJoyce, -1
	object_event  5,  8, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 4, TrainerCooltrainerfBeth, -1
	object_event 13, 79, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 2, TrainerPsychicRichard, -1
	object_event 10, 92, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 3, TrainerFisherScott, -1
	object_event  9, 15, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route20MaxElixer, EVENT_ROUTE_20_MAX_ELIXER
	object_event 14, 54, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, Route20BerryTree1, EVENT_ROUTE_20_BERRY_1
	object_event 14, 53, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route20BerryTree2, EVENT_ROUTE_20_BERRY_2
	object_event 13, 53, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, Route20BerryTree3, EVENT_ROUTE_20_BERRY_3
	object_event 13, 54, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route20BerryTree4, EVENT_ROUTE_20_BERRY_4
	object_event  4, 95, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, Route20BerryTree5, EVENT_ROUTE_20_BERRY_5
	object_event  4, 96, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route20ApricornTree1, EVENT_ROUTE_20_APRICORN_1
	object_event  5, 96, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route20ApricornTree2, EVENT_ROUTE_20_APRICORN_2

	object_const_def
	const ROUTE20_COOLTRAINER_M1
	const ROUTE20_COOLTRAINER_M2
	const ROUTE20_COOLTRAINER_F1
	const ROUTE20_COOLTRAINER_F2
	const ROUTE20_YOUNGSTER
	const ROUTE20_FISHER
	const ROUTE20_POKE_BALL
	const ROUTE20_BERRY_TREE1
	const ROUTE20_BERRY_TREE2
	const ROUTE20_BERRY_TREE3
	const ROUTE20_BERRY_TREE4
	const ROUTE20_BERRY_TREE5
	const ROUTE20_APRICORN_TREE1
	const ROUTE20_APRICORN_TREE2

Route20_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .Flypoint

.Flypoint:
	setflag ENGINE_FLYPOINT_ROUTE_20
	endcallback

TrainerCooltrainermJake:
	generictrainer COOLTRAINERM, JAKE, EVENT_BEAT_COOLTRAINERM_JAKE, .SeenText, .BeatenText

.AfterText
	text "It's going to be"
	line "tough to win at"
	cont "the League."

	para "I need to do some"
	line "more training."

	para "I hear that the"
	line "League's Elite"
	cont "Four are tougher"
	cont "than Gym Leaders."
	done

.SeenText
	text "I'm making my"
	line "final preparations"
	cont "for the #mon"
	cont "League."
	done

.BeatenText
	text "I blew it!"
	done

TrainerCooltrainermGaven:
	generictrainer COOLTRAINERM, GAVEN, EVENT_BEAT_COOLTRAINERM_GAVEN, .SeenText, .BeatenText

.AfterText
	text "To get to #mon"
	line "League, you have"
	cont "to get through"
	cont "Victory Road."

	para "But Victory Road"
	line "is tough."

	para "Practically nobody"
	line "goes there!"
	done

.SeenText
	text "By experiencing"
	line "tough battles, you"
	cont "gain power."
	done

.BeatenText
	text "Gaah! Life is even"
	line "tougher!"
	done

TrainerCooltrainerfJoyce:
	generictrainer COOLTRAINERF, JOYCE, EVENT_BEAT_COOLTRAINERF_JOYCE, .SeenText, .BeatenText

.AfterText
	text "I've defeated"
	line "eight Gym Leaders,"
	cont "so I was feeling"
	cont "confident."

	para "I'll have to try"
	line "harder next time."
	done

.SeenText
	text "Since you've come"
	line "this far, you must"
	cont "be good."

	para "I'm going to give"
	line "this battle every-"
	cont "thing I've got!"
	done

.BeatenText
	text "No! I don't"
	line "believe this!"
	done

TrainerCooltrainerfBeth:
	generictrainer COOLTRAINERF, BETH, EVENT_BEAT_COOLTRAINERF_BETH, .SeenText, .BeatenText

.AfterText
	text "TODOTEXT"
	done

.SeenText
	text "TODOTEXT"
	done

.BeatenText
	text "TODOTEXT"
	done

TrainerPsychicRichard:
	generictrainer PSYCHIC_T, RICHARD, EVENT_BEAT_PSYCHIC_RICHARD, .SeenText, .BeatenText

.AfterText
	text "People and #mon"
	line "grow from their"
	cont "experiences."

	para "Don't get lazy and"
	line "complacent."
	done

.SeenText
	text "How long have you"
	line "spent with your"
	cont "#mon?"
	done

.BeatenText
	text "That long huh?"
	done

TrainerFisherScott:
	generictrainer FISHER, SCOTT, EVENT_BEAT_FISHER_SCOTT, .SeenText, .BeatenText

.AfterText
	text "Just like in fish-"
	line "ing, it's all over"
	cont "in #mon if you"
	cont "give up."
	done

.SeenText
	text "I'm feeling great"
	line "today!"

	para "I feel like I"
	line "could boot even"
	cont "the League Champ!"
	done

.BeatenText
	text "No! Not in this"
	line "battle!"
	done

Route20SignText:
	text "Route 20"

	para "#mon League"
	line "Reception Gate"
	done

Route20MaxElixer:
	itemball MAX_ELIXER

Route20BerryTree1:
	setval GOLD_BERRY
	jumpstd BerryOrFruitScript
Route20BerryTree2:
	setval MIRACLEBERRY
	jumpstd BerryOrFruitScript
Route20BerryTree3:
	setval GOLD_BERRY
	jumpstd BerryOrFruitScript
Route20BerryTree4:
	setval MIRACLEBERRY
	jumpstd BerryOrFruitScript
Route20BerryTree5:
	setval MINT_BERRY
	jumpstd BerryOrFruitScript
Route20ApricornTree1:
	setval RED_APRICORN
	jumpstd BerryOrFruitScript
Route20ApricornTree2:
	setval BLU_APRICORN
	jumpstd BerryOrFruitScript
