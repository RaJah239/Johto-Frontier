Route7_MapEvents:
	def_warp_events
	warp_event  9, 33, ROUTE_7_GOLDENROD_GATE, 1
	warp_event 10, 33, ROUTE_7_GOLDENROD_GATE, 2
	warp_event  3,  5, ROUTE_7_NATIONAL_PARK_GATE, 3

	def_coord_events

	def_bg_events
	bg_event  1,  7, BGEVENT_READ, Route7SignText
	bg_event 11, 31, BGEVENT_READ, Route7SignText
	bg_event  2, 25, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event  2, 27, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 14, 29, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT
	bg_event 15, 28, BGEVENT_JUMPSTD, NO_BERRY_OR_FRUIT_SCRIPT

	def_object_events
	object_event  4, 19, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 2, TrainerCamperIvan, -1
	object_event  8, 20, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 3, TrainerCamperElliot, -1
	object_event  7, 20, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 3, TrainerPicnickerBrooke, -1
	object_event 10, 26, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 1, TrainerPicnickerKim, -1
	object_event 13, 28, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 0, TrainerBirdKeeperBryan, -1
	object_event  2, 10, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 2, TrainerFirebreatherWalt, -1
	object_event 16,  7, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 2, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_GENERICTRAINER, 3, TrainerBugCatcherArnie, -1
	object_event  5, 10, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 2, TrainerJugglerIrwin, -1
	object_event  5,  6, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, TrainerOfficerDirk, -1
	object_event  7, 11, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route7TMRollout, EVENT_ROUTE_7_TM_ROLLOUT
	object_event  2, 25, SPRITE_BERRY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_ORANGE, OBJECTTYPE_SCRIPT, 0, Route7BerryTree1, EVENT_ROUTE_7_BERRY_1
	object_event  0, 27, SPRITE_OTIS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route7OtisScript, EVENT_ROUTE_7_OTIS
	object_event  2, 27, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route7ApricornTree1, EVENT_ROUTE_7_APRICORN_1
	object_event 14, 29, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_YELLOW, OBJECTTYPE_SCRIPT, 0, Route7ApricornTree2, EVENT_ROUTE_7_APRICORN_2
	object_event 15, 28, SPRITE_APRICORN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route7ApricornTree3, EVENT_ROUTE_7_APRICORN_1

	object_const_def
	const ROUTE7_YOUNGSTER1
	const ROUTE7_YOUNGSTER2
	const ROUTE7_LASS1
	const ROUTE7_LASS2
	const ROUTE7_YOUNGSTER3
	const ROUTE7_FISHER
	const ROUTE7_BUG_CATCHER
	const ROUTE7_SUPER_NERD
	const ROUTE7_OFFICER
	const ROUTE7_POKE_BALL
	const ROUTE7_BERRY_TREE1
	const ROUTE7_OTIS
	const ROUTE7_APRICORN_TREE1
	const ROUTE7_APRICORN_TREE2
	const ROUTE7_APRICORN_TREE3

Route7_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, Route7OtisCallback

Route7OtisCallback:
	; 10% chance of otis appearing
	checkflag ENGINE_MET_OTIS_TODAY
	iftrue .done
	random 10
	ifequal 0, .AppearOtis
.done
	disappear ROUTE7_OTIS
	endcallback

.AppearOtis:
	appear ROUTE7_OTIS
	endcallback

TrainerBirdKeeperBryan:
	generictrainer BIRD_KEEPER, BRYAN, EVENT_BEAT_BIRD_KEEPER_BRYAN, .SeenText,.BeatenText

.BattleText
	text "Some #mon have"
	line "a high base speed"
	cont "of 100 or more."

	para "Try catching them"
	line "with Kurt's Fast"
	cont "Ball."

	para "Whenever I find a"
	line "Wht Apricorn, I"
	cont "take it to Kurt."

	para "He turns it into a"
	line "custom Ball."
	done

.SeenText
	text "What kinds of"
	line "Balls do you use?"
	done

.BeatenText
	text "Yikes! Not fast"
	line "enough!"
	done

TrainerJugglerIrwin:
	generictrainer JUGGLER, IRWIN, EVENT_BEAT_JUGGLER_IRWIN, .SeenText, .BeatenText

.AfterText
	text "I was going to"
	line "dazzle you with my"
	cont "prize #mon."

	para "But your prowess"
	line "electrified me!"
	done

.SeenText
	text "Behold my graceful"
	line "Ball dexterity!"
	done

.BeatenText
	text "Whew! That was a"
	line "jolt!"
	done

TrainerCamperIvan:
	generictrainer CAMPER, IVAN, EVENT_BEAT_CAMPER_IVAN, .SeenText, .BeatenText

.AfterText
	text "Music on the radio"
	line "changes the moods"
	cont "of wild #mon."
	done

.SeenText
	text "I've been getting"
	line "#mon data off"
	cont "my radio. I think"
	cont "I'm good."
	done

.BeatenText
	text "I give!"
	done

TrainerCamperElliot:
	generictrainer CAMPER, ELLIOT, EVENT_BEAT_CAMPER_ELLIOT, .SeenText, .BeatenText

.AfterText
	text "I was humiliated"
	line "in front of my"
	cont "girlfriend…"
	done

.SeenText
	text "I'm gonna show my"
	line "girlfriend I'm hot"
	cont "stuff!"
	done

.BeatenText
	text "I wish you would"
	line "have lost for me…"
	done

TrainerPicnickerBrooke:
	generictrainer PICNICKER, BROOKE, EVENT_BEAT_PICNICKER_BROOKE, .SeenText, .BeatenText

.AfterText
	text "I can count on my"
	line "#mon more than"
	cont "my boyfriend."
	done

.SeenText
	text "My boyfriend's"
	line "weak, so I can't"
	cont "rely on him."
	done

.BeatenText
	text "Oh, my! You're so"
	line "strong!"
	done

TrainerPicnickerKim:
	generictrainer PICNICKER, KIM, EVENT_BEAT_PICNICKER_KIM, .SeenText, .BeatenText

.AfterText
	text "The Gym Badges are"
	line "pretty. I collect"
	cont "them."
	done

.SeenText
	text "Are you going to"
	line "the Gym? Me too!"
	done

.BeatenText
	text "Oh. I couldn't"
	line "win…"
	done

TrainerBugCatcherArnie:
	generictrainer BUG_CATCHER, ARNIE, EVENT_BEAT_BUG_CATCHER_ARNIE, .SeenText, .BeatenText

.ArnieAfterText
	text "My Venonat won me"
	line "the Bug-Catching"
	cont "Contest at the"
	cont "National Park."
	done

.SeenText
	text "I'll go anywhere"
	line "if bug #mon"
	cont "appear there."
	done

.BeatenText
	text "Huh? I shouldn't"
	line "have lost that…"
	done

TrainerFirebreatherWalt:
	generictrainer FIREBREATHER, WALT, EVENT_BEAT_FIREBREATHER_WALT, .SeenText, .BeatenText

.AfterText
	text "The #mon March"
	line "on the radio lures"
	cont "wild #mon."
	done

.SeenText
	text "I'm practicing my"
	line "fire breathing."
	done

.BeatenText
	text "Ow! I scorched the"
	line "tip of my nose!"
	done

TrainerOfficerDirk:
	faceplayeropentext
	checkevent EVENT_BEAT_OFFICER_DIRK
	special SaveMusic
	iftrue .AfterScript
	checktime NITE
	iffalse .NoFight
	playmusic MUSIC_OFFICER_ENCOUNTER
	writethistext
		text "Danger lurks in"
		line "the night!"
		done
	waitclosetext
	winlosstext .BeatenText, 0
	loadtrainer OFFICER, DIRK
	startbattle
	reloadmapafterbattle
	special RestoreMusic
	setevent EVENT_BEAT_OFFICER_DIRK
	endtext

.AfterScript:
	writethistext
		text "You know, night-"
		line "time is fun in its"
		cont "own ways."

		para "But don't overdo"
		line "it, OK?"

		para "Up for a rematch?"
		done
	yesorno
	iffalse_endtext
	playmusic MUSIC_OFFICER_ENCOUNTER
	promptbutton
	closetext
	winlosstext .BeatenText, 0
	loadtrainer OFFICER, DIRK
	startbattle
	reloadmapafterbattle
	special RestoreMusic
	end

.NoFight:
	jumpthisopenedtext
		text "Your #mon look"
		line "pretty tough."

		para "You could go any-"
		line "where safely."
		done

.BeatenText
	text "Whoops!"
	done

Route7OtisScript:
	callstd WanderingOddEggNPCScript
	playsound SFX_WARP_TO
	applymovement ROUTE7_OTIS, Route7OtisTeleportAwayMovement
	disappear ROUTE7_OTIS
	setflag ENGINE_MET_OTIS_TODAY
	end

Route7OtisTeleportAwayMovement:
	teleport_from
	step_end

Route7SignText:
	text "Route 7"
	done

Route7TMRollout:
	itemball TM_ROLLOUT

Route7BerryTree1:
	setval MYSTERYBERRY
	setlasttalked ROUTE7_BERRY_TREE1
	jumpstd BerryOrFruitScript
Route7ApricornTree1:
	setval BLU_APRICORN
	setlasttalked ROUTE7_APRICORN_TREE1
	jumpstd BerryOrFruitScript
Route7ApricornTree2:
	setval YLW_APRICORN
	setlasttalked ROUTE7_APRICORN_TREE2
	jumpstd BerryOrFruitScript
Route7ApricornTree3:
	setval RED_APRICORN
	setlasttalked ROUTE7_APRICORN_TREE3
	jumpstd BerryOrFruitScript
