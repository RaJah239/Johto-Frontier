DragonsDenB1F_MapEvents:
	def_warp_events
	warp_event 20,  3, DRAGONS_DEN_1F, 3
	warp_event 19, 29, DRAGON_SHRINE, 1

	def_coord_events

	def_bg_events
	bg_event 18, 24, BGEVENT_JUMPTEXT, DragonShrineSignpostText
	bg_event 33, 29, BGEVENT_ITEM + MAX_REVIVE, EVENT_DRAGONS_DEN_B1F_HIDDEN_MAX_REVIVE
	bg_event 21, 17, BGEVENT_ITEM + FULL_RESTORE, EVENT_DRAGONS_DEN_B1F_HIDDEN_FULL_RESTORE
	bg_event 31, 15, BGEVENT_ITEM + MAX_ELIXER, EVENT_DRAGONS_DEN_B1F_HIDDEN_MAX_ELIXER

	def_object_events
	object_event 22,  4, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 4, TrainerCooltrainermDarin, -1
	object_event  8,  8, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 3, TrainerCooltrainerfCara, -1
	object_event  4, 17, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 1, TrainerTwinsLeaandpia1, -1
	object_event  4, 18, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 1, TrainerTwinsLeaandpia2, -1
	object_event 35, 16, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, DragonsDenB1FDragonFangScript, EVENT_DRAGONS_DEN_B1F_DRAGON_FANG
	object_event 30,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, DragonsDenB1FHyperEvUp, EVENT_DRAGONS_DEN_B1F_HYPER_EV_UP
	object_event  5, 20, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, DragonsDenB1FMaxElixer, EVENT_DRAGONS_DEN_B1F_MAX_ELIXER

	object_const_def
	const DRAGONSDENB1F_COOLTRAINER_M
	const DRAGONSDENB1F_COOLTRAINER_F
	const DRAGONSDENB1F_TWIN1
	const DRAGONSDENB1F_TWIN2
	const DRAGONSDENB1F_POKE_BALL1
	const DRAGONSDENB1F_POKE_BALL2
	const DRAGONSDENB1F_POKE_BALL3

DragonsDenB1F_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerCooltrainermDarin:
	generictrainer COOLTRAINERM, DARIN, EVENT_BEAT_COOLTRAINERM_DARIN, .SeenText, .BeatenText

.AfterText
	text "The Shrine ahead"
	line "is home to the"
	cont "Master of our"
	cont "dragon-user clan."
	done

.SeenText
	text "Now, what do we"
	line "have here?"
	done

.BeatenText
	text "S-strong!"
	done

TrainerCooltrainerfCara:
	generictrainer COOLTRAINERF, CARA, EVENT_BEAT_COOLTRAINERF_CARA, .SeenText, .BeatenText

.AfterText
	text "Soon I'm going to"
	line "get permission"
	cont "from our Master to"
	cont "use dragons."

	para "When I do, I'm"
	line "going to become an"
	cont "admirable dragon"
	cont "trainer and gain"
	cont "our Master's"
	cont "approval."
	done

.SeenText
	text "You shouldn't be"
	line "in here!"
	done

.BeatenText
	text "Oh yikes, I lost!"
	done

TrainerTwinsLeaandpia1:
	generictrainer TWINS, LEAANDPIA1, EVENT_BEAT_TWINS_LEA_AND_PIA, .SeenText, .BeatenText

.AfterText
	text "It was like having"
	line "to battle Lance."
	done

.SeenText
	text "It's a stranger we"
	line "don't know."
	done

.BeatenText
	text "Ouchies."
	done

TrainerTwinsLeaandpia2:
	generictrainer TWINS, LEAANDPIA2, EVENT_BEAT_TWINS_LEA_AND_PIA, .SeenText, .BeatenText

.AfterText
	text "We'll tell on you."

	para "Master will be"
	line "angry with you."
	done

.SeenText
	text "Who are you?"
	done

.BeatenText
	text "Meanie."
	done

DragonShrineSignpostText:
	text "Dragon Shrine"

	para "A shrine honoring"
	line "the dragon #mon"
	cont "said to have lived"
	cont "in Dragon's Den."
	done

DragonsDenB1FHyperEvUp:
	itemball HYPER_EV_UP
DragonsDenB1FMaxElixer:
	itemball MAX_ELIXER
DragonsDenB1FDragonFangScript:
	itemball DRAGON_FANG
