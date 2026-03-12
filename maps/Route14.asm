Route14_MapEvents:
	def_warp_events
	warp_event  0,  8, ROUTE_14_ECRUTEAK_GATE, 3
	warp_event  0,  9, ROUTE_14_ECRUTEAK_GATE, 4
	warp_event 10,  5, MOUNT_MORTAR_1F_OUTSIDE, 1
	warp_event 28,  9, MOUNT_MORTAR_1F_OUTSIDE, 2
	warp_event 46,  7, MOUNT_MORTAR_1F_OUTSIDE, 3

	def_coord_events
	coord_event 24, 14, SCENE_ROUTE14_SUICUNE, Route14SuicuneScript

	def_bg_events
	bg_event  4, 10, BGEVENT_JUMPTEXT, Route14Sign1Text
	bg_event  7,  5, BGEVENT_JUMPTEXT, MtMortarSign1Text
	bg_event 45,  9, BGEVENT_JUMPTEXT, MtMortarSign2Text
	bg_event 54,  8, BGEVENT_JUMPTEXT, Route14Sign2Text
	bg_event 16, 11, BGEVENT_ITEM + MAX_POTION, EVENT_ROUTE_14_HIDDEN_MAX_POTION
	bg_event 27, 16, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 28, 16, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 29, 16, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT

	def_object_events
	object_event 40, 10, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 1, TrainerFisherTully, -1
	object_event 51,  9, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_GENERICTRAINER, 3, TrainerHikerBenjamin, -1
	object_event 47,  8, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 3, TrainerPokemaniacShane, -1
	object_event  6,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route14UltraBall, EVENT_ROUTE_14_ULTRA_BALL
	object_event 33,  8, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route14SuperPotion, EVENT_ROUTE_14_SUPER_POTION
	object_event 26, 16, SPRITE_SUICUNE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_SAW_SUICUNE_ON_ROUTE_14
	object_event 27, 16, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Route14ApricornTree1, EVENT_ROUTE_14_APRICORN_1
	object_event 28, 16, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route14ApricornTree2, EVENT_ROUTE_14_APRICORN_2
	object_event 29, 16, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_YELLOW, OBJECTTYPE_SCRIPT, 0, Route14ApricornTree3, EVENT_ROUTE_14_APRICORN_3

	object_const_def
	const ROUTE14_FISHER
	const ROUTE14_POKEFAN_M
	const ROUTE14_SUPER_NERD
	const ROUTE14_POKE_BALL1
	const ROUTE14_POKE_BALL2
	const ROUTE14_SUICUNE
	const ROUTE14_APRICORN_TREE1
	const ROUTE14_APRICORN_TREE2
	const ROUTE14_APRICORN_TREE3

Route14_MapScripts:
	def_scene_scripts
	scene_script Route14Noop1Scene, SCENE_ROUTE14_NOOP
	scene_script Route14Noop2Scene, SCENE_ROUTE14_SUICUNE

	def_callbacks

Route14Noop1Scene:
Route14Noop2Scene:
	end

Route14SuicuneScript:
	showemote EMOTE_SHOCK, PLAYER, 15
	pause 15
	playsound SFX_WARP_FROM
	applymovement ROUTE14_SUICUNE, Route14SuicuneMovement
	disappear ROUTE14_SUICUNE
	pause 10
	setscene SCENE_ROUTE14_NOOP
	clearevent EVENT_SAW_SUICUNE_ON_ROUTE_8
	setmapscene ROUTE_8, SCENE_ROUTE8_SUICUNE
	end

Route14SuicuneMovement:
	set_sliding
	fast_jump_step UP
	fast_jump_step UP
	fast_jump_step UP
	fast_jump_step RIGHT
	fast_jump_step RIGHT
	fast_jump_step RIGHT
	remove_sliding
	step_end

TrainerFisherTully:
	generictrainer FISHER, TULLY, EVENT_BEAT_FISHER_TULLY, .SeenText, .BeatenText

.AfterText
	text "I want to become"
	line "the trainer Champ"
	cont "using the #mon"
	cont "I caught."

	para "That's the best"
	line "part of fishing!"
	done

.SeenText
	text "Let me demonstrate"
	line "the power of the"
	cont "#mon I caught!"
	done

.BeatenText
	text "What? That's not"
	line "right."
	done

TrainerPokemaniacShane:
	generictrainer POKEMANIAC, SHANE, EVENT_BEAT_POKEMANIAC_SHANE, .SeenText, .BeatenText

.AfterText
	text "You're working on"
	line "a #dex?"

	para "Wow, you must know"
	line "some pretty rare"
	cont "#mon!"

	para "May I please see"
	line "it. Please?"
	done

.SeenText
	text "Hey!"

	para "This is my secret"
	line "place! Get lost,"
	cont "you outsider!"
	done

.BeatenText
	text "I should have used"
	line "my Moon Stone…"
	done

TrainerHikerBenjamin:
	generictrainer HIKER, BENJAMIN, EVENT_BEAT_HIKER_BENJAMIN, .SeenText, .BeatenText

.AfterText
	text "Losing feels in-"
	line "significant if you"
	cont "look up at the big"
	cont "sky!"
	done

.SeenText
	text "Ah, it's good to"
	line "be outside!"
	cont "I feel so free!"
	done

.BeatenText
	text "Gahahah!"
	done

Route14Sign1Text:
	text "Route 14"

	para "Ecruteak City -"
	line "Mahogany Town"
	done

MtMortarSign1Text:
	text "Mt.Mortar"

	para "Waterfall Cave"
	line "Inside"
	done

MtMortarSign2Text:
	text "Mt.Mortar"

	para "Waterfall Cave"
	line "Inside"
	done

Route14Sign2Text:
	text "Route 14"

	para "Ecruteak City -"
	line "Mahogany Town"
	done

Route14UltraBall:
	itemball ULTRA_BALL
Route14SuperPotion:
	itemball SUPER_POTION

Route14ApricornTree1:
	setval PNK_APRICORN
	jumpstd BerryOrFruitScript
Route14ApricornTree2:
	setval GRN_APRICORN
	jumpstd BerryOrFruitScript
Route14ApricornTree3:
	setval YLW_APRICORN
	jumpstd BerryOrFruitScript
