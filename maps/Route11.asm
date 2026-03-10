Route11_MapEvents:
	def_warp_events
	warp_event  1, 17, ROUTE_11_BARN, 1
	warp_event  5, 17, ROUTE_11_FARMHOUSE, 1
	warp_event  1, 17, ROUTE_11_BARN, 1
	warp_event  9,  5, ROUTE_11_SILVER_CAVE_GATE, 1

	def_coord_events

	def_bg_events
	bg_event  5, 45, BGEVENT_JUMPTEXT, Route11TrainerTipsText
	bg_event  9, 19, BGEVENT_JUMPTEXT, MoomooFarmSignText
	bg_event 15, 21, BGEVENT_JUMPTEXT, Route11SignText
	bg_event 11,  7, BGEVENT_JUMPTEXT, Route11MtSilverSignText
	bg_event  9, 17, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event  8, 17, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event  5, 27, BGEVENT_ITEM + NUGGET, EVENT_ROUTE_11_HIDDEN_NUGGET

	def_object_events
	object_event 13, 43, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 5, TrainerSailorEugene, -1
	object_event 10, 36, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 4, TrainerPokefanmDerek, -1
	object_event 11, 33, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 2, TrainerPokefanfRuth, -1
	object_event 13, 21, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, TrainerPsychicNorman, -1
	object_event  4, 36, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, TrainerPokefanfJaime, -1
	object_event  9, 17, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, Route11BerryTree1, EVENT_ROUTE_11_BERRY_1
	object_event  8, 17, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route11ApricornTree1, EVENT_ROUTE_11_APRICORN_1
	object_event  3, 26, SPRITE_MILTANK, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Route11Miltank, -1
	object_event  6, 25, SPRITE_MILTANK, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Route11Miltank, -1
	object_event  4, 29, SPRITE_MILTANK, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Route11Miltank, -1
	object_event  8, 27, SPRITE_MILTANK, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Route11Miltank, -1

	object_const_def
	const ROUTE11_SAILOR
	const ROUTE11_POKEFAN_M
	const ROUTE11_POKEFAN_F1
	const ROUTE11_PSYCHIC_NORMAN
	const ROUTE11_POKEFAN_F2
	const ROUTE11_BERRY_TREE1
	const ROUTE11_APRICORN_TREE1
	const ROUTE11_MILTANK1
	const ROUTE11_MILTANK2
	const ROUTE11_MILTANK3
	const ROUTE11_MILTANK4

Route11_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerPokefanmDerek:
	generictrainer POKEFANM, DEREK, EVENT_BEAT_POKEFANM_DEREK, .SeenText, .BeatenText

.AfterText
	text "I'm not listening"
	line "to your bragging!"

	para "We # Fans have"
	line "a policy of not"
	cont "listening to other"
	cont "people brag!"
	done

.SeenText
	text "This is a good"
	line "time to brag about"
	cont "my Pikachu!"
	done

.BeatenText
	text "I had no time to"
	line "show off Pikachu…"
	done

TrainerPokefanfRuth:
	generictrainer POKEFANF, RUTH, EVENT_BEAT_POKEFANF_RUTH, .SeenText, .BeatenText

.AfterText
	text "Do you know about"
	line "baby #mon?"

	para "I bet they're just"
	line "adorable!"
	done

.SeenText
	text "Such darling"
	line "#mon."

	para "Let's show our"
	line "#mon together"
	cont "at the same time."
	done

.BeatenText
	text "I don't mind"
	line "losing."
	done

TrainerSailorEugene:
	generictrainer SAILOR, EUGENE, EVENT_BEAT_SAILOR_EUGENE, .SeenText, .BeatenText

.AfterText
	text "My #mon were"
	line "caught and raised"
	cont "overseas."

	para "They're my compan-"
	line "ions on those long"
	cont "voyages."
	done

.SeenText
	text "I just got back to"
	line "Olivine."

	para "So how about a"
	line "#mon battle?"
	done

.BeatenText
	text "Awaaargh!"
	done

TrainerPsychicNorman:
	generictrainer PSYCHIC_T, NORMAN, EVENT_BEAT_PSYCHIC_NORMAN, .SeenText, .BeatenText

.AfterText
	text "You know how #-"
	line "mon have different"
	cont "abilities?"

	para "People are like"
	line "that too. Every-"
	cont "one has different"
	cont "potential."
	done

.SeenText
	text "Let me see what"
	line "your #mon are"
	cont "capable of."
	done

.BeatenText
	text "Ooh, your #mon"
	line "have potential."
	done

TrainerPokefanfJaime:
	faceplayeropentext
	checkevent EVENT_BEAT_POKEFANF_JAIME
	special SaveMusic
	iftrue .AfterScript
	checktime NITE
	iffalse .NoFight
	playmusic MUSIC_BEAUTY_ENCOUNTER
	writethistext
		text "You came at just"
		line "the right time."

		para "Let's battle."
		done
	waitclosetext
	winlosstext .BeatenText, 0
	loadtrainer POKEFANF, JAIME
	startbattle
	reloadmapafterbattle
	special RestoreMusic
	setevent EVENT_BEAT_POKEFANF_JAIME
	endtext

.AfterScript:
	writethistext
		text "I met my #mon"
		line "at night, right"
		cont "here on Route 11."

		para "I'm not sure why,"
		line "but it seems to"
		cont "like it when I"
		cont "train here."

		para "It seems to become"
		line "friendlier by"
		cont "training here than"
		cont "anywhere else."

		para "Up for a rematch?"
		done
	yesorno
	iffalse_endtext
	playmusic MUSIC_BEAUTY_ENCOUNTER
	promptbutton
	closetext
	winlosstext .BeatenText, 0
	loadtrainer POKEFANF, JAIME
	startbattle
	reloadmapafterbattle
	special RestoreMusic
	end

.NoFight:
	jumpthisopenedtext
		text "Ufufufu… I hope it"
		line "gets dark soon."
		done

.BeatenText
	text "Oh, how disap-"
	line "pointing…"
	done

Route11SignText:
	text "Route 11"

	para "Olivine City -"
	line "Ecruteak City"
	done

Route11MtSilverSignText:
	text "Danger!"
	line "Mt.Silver Ahead!"
	done

MoomooFarmSignText:
	text "Moomoo Farm"

	para "Enjoy Our Fresh"
	line "and Tasty Milk"
	done

Route11TrainerTipsText:
	text "Trainer Tips"

	para "Use Headbutt on"
	line "trees to shake"
	cont "#mon out."

	para "Every tree has a"
	line "different chance"
	cont "to drop #mon"
	cont "but they all have"
	cont "the same #mon."
	done

Route11Miltank:
	setval MILTANK
	special SetMonAsSeen
	isfieldactionssettoquick
	iftrue .skipthis
	reanchormap
	pokepic MILTANK
	cry MILTANK
	waitbutton
	closepokepic
.skipthis
	jumpthistext
		text "Miltank: Mooo!"
		done

Route11BerryTree1:
	setval MINT_BERRY
	setlasttalked ROUTE11_BERRY_TREE1
	jumpstd BerryOrFruitScript
Route11ApricornTree1:
	setval GRN_APRICORN
	setlasttalked ROUTE11_APRICORN_TREE1
	jumpstd BerryOrFruitScript
