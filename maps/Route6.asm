Route6_MapEvents:
	def_warp_events
	warp_event 13, 37, ROUTE_6_ILEX_FOREST_GATE, 1
	warp_event 14, 37, ROUTE_6_ILEX_FOREST_GATE, 2
	warp_event 11, 14, DAY_CARE, 1
	warp_event 11, 15, DAY_CARE, 2
	warp_event 13, 15, DAY_CARE, 3
	warp_event 19, 16, HATCH_ROOM, 2
	warp_event 19, 17, HATCH_ROOM, 2
	def_coord_events

	def_bg_events
	bg_event 12,  6, BGEVENT_JUMPTEXT, Route6SignText
	bg_event 13, 33, BGEVENT_JUMPTEXT, Route6TrainerTipsText
	bg_event 10, 13, BGEVENT_JUMPTEXT, DayCareSignText
	bg_event 10, 36, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event  9, 36, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event  8, 32, BGEVENT_ITEM + RARE_CANDY, EVENT_ROUTE_6_HIDDEN_RARE_CANDY
	bg_event 17, 19, BGEVENT_ITEM + HYPER_POTION, EVENT_ROUTE_6_HIDDEN_HYPER_POTION
	bg_event  6,  6, BGEVENT_ITEM + FOCUS_SASH, EVENT_ROUTE_6_HIDDEN_FOCUS_SASH

	def_object_events
	object_event 13,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 5, TrainerCamperTodd, -1
	object_event 15, 32, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 3, TrainerYoungsterSamuel, -1
	object_event 11, 20, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 3, TrainerYoungsterIan, -1
	object_event 10, 26, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 3, TrainerPicnickerGina, -1
	object_event  9, 11, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, OfficerKeithScript, -1
	object_event 18, 28, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 3, TrainerPokefanmBrandon, -1
	object_event 13, 18, SPRITE_DAY_CARE_MON_1, SPRITEMOVEDATA_POKEMON, 2, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DayCareMon1Script, EVENT_DAY_CARE_MON_1
	object_event 16, 18, SPRITE_DAY_CARE_MON_2, SPRITEMOVEDATA_POKEMON, 2, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DayCareMon2Script, EVENT_DAY_CARE_MON_2
	object_event  8, 48, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 5, TrainerCooltrainerfIrene, -1
	object_event  4, 48, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerCooltrainerfJenn, -1
	object_event  6, 51, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerCooltrainerfKate, -1
	object_event  7, 30, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route6Nugget, EVENT_ROUTE_6_NUGGET
	object_event  9, 36, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route6BerryTree, EVENT_ROUTE_6_BERRY
	object_event 10, 36, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_WHITE, OBJECTTYPE_SCRIPT, 0, Route6ApricornTree, EVENT_ROUTE_6_APRICORN

	object_const_def
	const ROUTE6_YOUNGSTER1
	const ROUTE6_YOUNGSTER2
	const ROUTE6_YOUNGSTER3
	const ROUTE6_LASS
	const ROUTE6_OFFICER
	const ROUTE6_POKEFAN_M
	const ROUTE6_DAY_CARE_MON_1
	const ROUTE6_DAY_CARE_MON_2
	const ROUTE6_COOLTRAINER_F1
	const ROUTE6_COOLTRAINER_F2
	const ROUTE6_COOLTRAINER_F3
	const ROUTE6_POKE_BALL
	const ROUTE6_BERRY_TREE
	const ROUTE6_APRICORN_TREE

Route6_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, Route6EggCheckCallback

Route6EggCheckCallback:
.CheckMon1:
	checkflag ENGINE_DAY_CARE_MAN_HAS_MON
	iffalse .HideMon1
	clearevent EVENT_DAY_CARE_MON_1
	sjump .CheckMon2

.HideMon1:
	setevent EVENT_DAY_CARE_MON_1
.CheckMon2:
	checkflag ENGINE_DAY_CARE_LADY_HAS_MON
	iffalse .HideMon2
	clearevent EVENT_DAY_CARE_MON_2
	endcallback

.HideMon2:
	setevent EVENT_DAY_CARE_MON_2
	endcallback

DayCareMon1Script:
	opentext
	special DayCareMon1
	endtext

DayCareMon2Script:
	opentext
	special DayCareMon2
	endtext

TrainerCamperTodd:
	generictrainer CAMPER, TODD, EVENT_BEAT_CAMPER_TODD, .SeenText, .BeatenText

.AfterText
	text "Maybe I should"
	line "take one to a Day-"
	cont "Care or maybe use"
	cont "some items…"
	done

.SeenText
	text "I'm confident in"
	line "my ability to"
	cont "raise #mon."

	para "Want to see?"
	done

.BeatenText
	text "Did I screw up my"
	line "training?"
	done

TrainerPicnickerGina:
	generictrainer PICNICKER, GINA, EVENT_BEAT_PICNICKER_GINA, .SeenText, .BeatenText

.AfterText
	text "You're a perfect"
	line "practice partner."
	done

.SeenText
	text "Hi. Let's have a"
	line "practice battle."
	done

.BeatenText
	text "Oh, no! I just"
	line "can't win…"
	done

OfficerKeithScript:
	faceplayeropentext
	checkevent EVENT_BEAT_OFFICER_KEITH
	special SaveMusic
	iftrue .AfterScript
	checktime NITE
	iffalse .NoFight
	playmusic MUSIC_OFFICER_ENCOUNTER
	writethistext
		text "Who goes there?"
		line "What are you up"
		cont "to?"
		done
	waitclosetext
	winlosstext .BeatenText, 0
	loadtrainer OFFICER, KEITH
	startbattle
	reloadmapafterbattle
	special RestoreMusic
	setevent EVENT_BEAT_OFFICER_KEITH
	endtext

.AfterScript:
	writethistext
		text "Yep, I see nothing"
		line "wrong today. You"
		cont "be good and stay"
		cont "out of trouble."

		para "Up for a rematch?"
		done
	yesorno
	iffalse_endtext
	playmusic MUSIC_OFFICER_ENCOUNTER
	promptbutton
	closetext
	winlosstext .BeatenText, 0
	loadtrainer OFFICER, KEITH
	startbattle
	reloadmapafterbattle
	special RestoreMusic
	end

.NoFight:
	jumpthisopenedtext
	text "I'm on patrol for"
	line "suspicious indi-"
	cont "viduals."
	done

.BeatenText
	text "You're a tough"
	line "little kid."
	done

TrainerYoungsterSamuel:
	generictrainer YOUNGSTER, SAMUEL, EVENT_BEAT_YOUNGSTER_SAMUEL, .SeenText, .BeatenText

.AfterText
	text "I'm going to train"
	line "even harder."

	para "After all, I'm"
	line "trying to become"
	cont "a Gym Leader."
	done

.SeenText
	text "This is where I do"
	line "my training!"
	done

.BeatenText
	text "Beaten by a"
	line "passing stranger!"
	done

TrainerYoungsterIan:
	generictrainer YOUNGSTER, IAN, EVENT_BEAT_YOUNGSTER_IAN, .SeenText, .BeatenText

.AfterText
	text "I'm trying hard so"
	line "I can be the star"
	cont "in my class."
	done

.SeenText
	text "I'm the best in my"
	line "class at #mon."
	done

.BeatenText
	text "No! There are bet-"
	line "ter trainers…"
	done

TrainerPokefanmBrandon:
	generictrainer POKEFANM, BRANDON, EVENT_BEAT_POKEFANM_BRANDON, .SeenText, .BeatenText

.AfterText
	text "My #mon knew"
	line "moves I didn't"
	cont "know it had."

	para "That confounded me"
	line "to no end!"
	done

.SeenText
	text "I just got my"
	line "#mon back from"
	cont "Day-Care."

	para "Let's see how much"
	line "stronger it got!"
	done

.BeatenText
	text "Why does it end"
	line "this way?"
	done

TrainerCooltrainerfIrene:
	trainer COOLTRAINERF, IRENE, EVENT_BEAT_COOLTRAINERF_IRENE, .SeenText, .BeatenText, 0, .Script

.SeenText
	text "Irene: Kyaaah!"
	line "Someone found us!"
	done

.BeatenText
	text "Irene: Ohhh!"
	line "Too strong!"
	done

.Script:
	endifjustbattled
	opentext
	checkevent EVENT_GOT_LEFTOVERS_FROM_KATE
	iftrue .GotLeftoversFromKate
	writethistext
		text "Irene: My sister"
		line "Kate will get you"
		cont "for this!"
		done
	waitbutton
	end

.GotLeftoversFromKate:
	writethistext
		text "Irene: Isn't this"
		line "beach great?"

		para "It's our secret"
		line "little getaway!"
		done
	waitbutton
	end

TrainerCooltrainerfJenn:
	trainer COOLTRAINERF, JENN, EVENT_BEAT_COOLTRAINERF_JENN, .SeenText, .BeatenText, 0, .Script

.SeenText
	text "Jenn: You can't"
	line "beat Irene and go"
	cont "unpunished!"
	done

.BeatenText
	text "Jenn: So sorry,"
	line "Irene! Sis!"
	done

.Script:
	endifjustbattled
	opentext
	checkevent EVENT_GOT_LEFTOVERS_FROM_KATE
	iftrue .GotLeftoversFromKate
	writethistext
		text "Jenn: Don't get"
		line "cocky! My sister"
		cont "Kate is tough!"
		done
	waitbutton
	end

.GotLeftoversFromKate:
	writethistext
		text "Jenn: Sunlight"
		line "makes your body"
		cont "stronger."
		done
	waitbutton
	end

TrainerCooltrainerfKate:
	trainer COOLTRAINERF, KATE, EVENT_BEAT_COOLTRAINERF_KATE, .SeenText, .BeatenText, 0, .Script

.SeenText
	text "Kate: You sure"
	line "were mean to my"
	cont "little sisters!"
	done

.BeatenText
	text "Kate: No! I can't"
	line "believe I lost."
	done

.Script:
	endifjustbattled
	opentext
	checkevent EVENT_GOT_LEFTOVERS_FROM_KATE
	iftrue .GotLeftoversFromKate
	writethistext
		text "Kate: You're too"
		line "strong. I didn't"
		cont "stand a chance."

		para "Here. You deserve"
		line "this."
		done
	promptbutton
	verbosegiveitem LEFTOVERS
	iffalse_endtext
	setevent EVENT_GOT_LEFTOVERS_FROM_KATE
.GotLeftoversFromKate:
	writethistext
		text "Kate: I'm sorry we"
		line "jumped you."

		para "We never expected"
		line "anyone to find us"
		cont "here. You sure"
		cont "startled us."
		done
	waitbutton
	end

DayCareSignText:
	text "Day-Care"

	para "Let Us Raise Your"
	line "#mon For You!"
	done

Route6TrainerTipsText:
	text "Trainer Tips"

	para "The Day Care gives"
	line "more Exp. Points"
	cont "to higher level"
	cont "#mon."

	para "This means that"
	line "any #mon left"
	cont "at the Day Care is"
	cont "a viable option"
	cont "for leveling up."
	
	para "#mon left in"
	line "the Day Care also"
	cont "gain 1 level every"
	cont "other day the game"
	cont "isn't turned on."
	done

Route6SignText:
	text "Route 6"

	para "Goldenrod City -"
	line "Azalea Town"

	para "Ilex Forest"
	line "Somewhere Between"
	done

Route6Nugget:
	itemball NUGGET

Route6BerryTree:
	setval MIRACLEBERRY
	jumpstd BerryOrFruitScript
Route6ApricornTree:
	setval WHT_APRICORN
	jumpstd BerryOrFruitScript
