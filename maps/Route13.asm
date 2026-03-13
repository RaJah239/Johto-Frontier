Route13_MapEvents:
	def_warp_events
	warp_event 12, 17, WHIRL_ISLAND_NW, 1
	warp_event 36, 19, WHIRL_ISLAND_NE, 1
	warp_event 12, 37, WHIRL_ISLAND_SW, 1
	warp_event 36, 45, WHIRL_ISLAND_SE, 1

	def_coord_events

	def_bg_events
	bg_event  9, 35, BGEVENT_ITEM + MAX_ETHER, EVENT_ROUTE_13_HIDDEN_MAX_ETHER

	def_object_events
	object_event 32,  6, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 3, TrainerSwimmermCharlie, -1
	object_event 46,  8, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 3, TrainerSwimmermGeorge, -1
	object_event 20, 26, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 3, TrainerSwimmermBerke, -1
	object_event 32, 30, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 3, TrainerSwimmermKirk, -1
	object_event 19, 46, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 3, TrainerSwimmermMathew, -1
	object_event 17,  4, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 3, TrainerSwimmerfKaylee, -1
	object_event 23, 19, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 3, TrainerSwimmerfSusie, -1
	object_event 27, 34, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 3, TrainerSwimmerfDenise, -1
	object_event 44, 28, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 4, TrainerSwimmerfKara, -1
	object_event  9, 50, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 2, TrainerSwimmerfWendy, -1
	object_event 28, 43, SPRITE_OTIS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route13OtisScript, EVENT_MET_OTIS_TODAY

	object_const_def
	const ROUTE13_SWIMMER_BOY1
	const ROUTE13_SWIMMER_BOY2
	const ROUTE13_SWIMMER_BOY3
	const ROUTE13_SWIMMER_BOY4
	const ROUTE13_SWIMMER_BOY5
	const ROUTE13_SWIMMER_GIRL1
	const ROUTE13_SWIMMER_GIRL2
	const ROUTE13_SWIMMER_GIRL3
	const ROUTE13_SWIMMER_GIRL4
	const ROUTE13_SWIMMER_GIRL5
	const ROUTE13_OTIS

Route13_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, Route13OtisCallback

Route13OtisCallback:
	; 10% chance of otis appearing
	checkflag ENGINE_MET_OTIS_TODAY
	iftrue .done
	random 10
	ifequal 0, .AppearOtis
.done
	disappear ROUTE13_OTIS
	endcallback

.AppearOtis:
	appear ROUTE13_OTIS
	endcallback

TrainerSwimmerfKaylee:
	generictrainer SWIMMERF, KAYLEE, EVENT_BEAT_SWIMMERF_KAYLEE, .SeenText, .BeatenText

.AfterText
	text "There's supposed"
	line "to be a big #-"
	cont "mon deep beneath"
	cont "Whirl Islands."

	para "I wonder what it"
	line "could be?"
	done

.SeenText
	text "I'm on my way to"
	line "Whirl Islands."

	para "I'm going explor-"
	line "ing with friends."
	done

.BeatenText
	text "Is that how you do"
	line "it?"
	done

TrainerSwimmerfSusie:
	generictrainer SWIMMERF, SUSIE, EVENT_BEAT_SWIMMERF_SUSIE, .SeenText, .BeatenText

.AfterText
	text "TODOTEXT"
	done

.SeenText
	text "TODOTEXT"
	done

.BeatenText
	text "I'm crushed…"
	done

TrainerSwimmerfDenise:
	generictrainer SWIMMERF, DENISE, EVENT_BEAT_SWIMMERF_DENISE, .SeenText, .BeatenText

.AfterText
	text "A sunburn is the"
	line "worst for skin."

	para "But I don't use a"
	line "sunblock."

	para "I won't pollute"
	line "the water."
	done

.SeenText
	text "The weather is so"
	line "beautiful, I'm in"
	cont "a daze!"
	done

.BeatenText
	text "Ohhh!"
	done

TrainerSwimmerfKara:
	generictrainer SWIMMERF, KARA, EVENT_BEAT_SWIMMERF_KARA, .SeenText, .BeatenText

.AfterText
	text "I heard roars from"
	line "deep inside the"
	cont "Islands."
	done

.SeenText
	text "If you need to"
	line "rest, just tread"
	cont "water."

	para "You'll get your"
	line "wind back, so you"
	cont "can keep on going"
	cont "strong."
	done

.BeatenText
	text "Oh! You have more"
	line "energy than I do."
	done

TrainerSwimmerfWendy:
	generictrainer SWIMMERF, WENDY, EVENT_BEAT_SWIMMERF_WENDY, .SeenText, .BeatenText

.AfterText
	text "The clusters of"
	line "Staryu light up"
	cont "at the same time."

	para "It's so beautiful,"
	line "it's scary."
	done

.SeenText
	text "At night, Staryu"
	line "gather near the"
	cont "water's surface."
	done

.BeatenText
	text "Oh, dear…"
	done

TrainerSwimmermCharlie:
	generictrainer SWIMMERM, CHARLIE, EVENT_BEAT_SWIMMERM_CHARLIE, .SeenText, .BeatenText

.AfterText
	text "Isn't it relaxing"
	line "just floating like"
	cont "this?"
	done

.SeenText
	text "The water's warm"
	line "here. I'm loose"
	cont "and limber."

	para "Sure, I'll take"
	line "you on!"
	done

.BeatenText
	text "Yikes! I've got"
	line "prune skin!"
	done

TrainerSwimmermGeorge:
	generictrainer SWIMMERM, GEORGE, EVENT_BEAT_SWIMMERM_GEORGE, .SeenText, .BeatenText

.AfterText
	text "It's so far to"
	line "Cianwood."

	para "But it's no easy"
	line "return trip to"
	cont "Olivine either."

	para "What should I do?"
	done

.SeenText
	text "I'm a bit tired."
	line "If I win, lend me"
	cont "your #mon."
	done

.BeatenText
	text "Pant, pant…"
	done

TrainerSwimmermBerke:
	generictrainer SWIMMERM, BERKE, EVENT_BEAT_SWIMMERM_BERKE, .SeenText, .BeatenText

.AfterText
	text "It was a dark and"
	line "stormy night…"

	para "I saw this giant"
	line "#mon flying"
	cont "from the islands."

	para "It was scattering"
	line "feathers from its"
	cont "silver wings."
	done

.SeenText
	text "See those islands"
	line "that are blocked"
	cont "by whirlpools?"

	para "There just has to"
	line "be a secret!"
	done

.BeatenText
	text "What's the secret"
	line "to your strength?"
	done

TrainerSwimmermKirk:
	generictrainer SWIMMERM, KIRK, EVENT_BEAT_SWIMMERM_KIRK, .SeenText, .BeatenText

.AfterText
	text "The currents keep"
	line "me from reaching"
	cont "that island."
	done

.SeenText
	text "The waves are wild"
	line "here."

	para "They tire you out"
	line "while you swim."
	done

.BeatenText
	text "I'm beat!"
	done

TrainerSwimmermMathew:
	generictrainer SWIMMERM, MATHEW, EVENT_BEAT_SWIMMERM_MATHEW, .SeenText, .BeatenText

.AfterText
	text "A secret about"
	line "Whirl Islands…"

	para "It's pitch-black"
	line "inside!"
	done

.SeenText
	text "Are you seeking"
	line "the secrets of"
	cont "Whirl Islands?"
	done

.BeatenText
	text "Ooh, you've got"
	line "great endurance!"
	done

Route13OtisScript:
	callstd WanderingOddEggNPCScript
	playsound SFX_WARP_TO
	applymovement ROUTE13_OTIS, Route13OtisTeleportAwayMovement
	disappear LAST_TALKED
	setflag ENGINE_MET_OTIS_TODAY
	end

Route13OtisTeleportAwayMovement:
	teleport_from
	step_end
