Route4_MapEvents:
	def_warp_events
	warp_event 11, 73, ROUTE_4_POKECENTER_1F, 1
	warp_event  4,  2, ROUTE_4_RUINS_OF_ALPH_GATE, 3
	warp_event  4,  3, ROUTE_4_RUINS_OF_ALPH_GATE, 4
	warp_event  6, 79, UNION_CAVE_1F, 4

	def_coord_events

	def_bg_events
	bg_event 13,  5, BGEVENT_JUMPTEXT, Route4SignText
	bg_event  9,  1, BGEVENT_JUMPTEXT, Route4RuinsSignText
	bg_event 10, 84, BGEVENT_JUMPTEXT, Route4UnionCaveSignText
	bg_event 12, 73, BGEVENT_JUMPSTD, POKECENTER_SIGN_SCRIPT
	bg_event 12, 67, BGEVENT_ITEM + GREAT_BALL, EVENT_ROUTE_4_HIDDEN_GREAT_BALL
	bg_event 11, 40, BGEVENT_ITEM + SUPER_POTION, EVENT_ROUTE_4_HIDDEN_SUPER_POTION

	def_object_events
	object_event  8, 49, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 1, TrainerFisherJustin, -1
	object_event 12, 56, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 3, TrainerFisherRalph, -1
	object_event  6, 48, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 1, TrainerFisherHenry, -1
	object_event 12, 22, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerYoungsterAlbert, -1
	object_event  4, 63, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerYoungsterGordon, -1
	object_event  3, 45, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 3, TrainerCamperRoland, -1
	object_event 10, 30, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerPicnickerLiz1, -1
	object_event 19,  8, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route4CooltrainerMScript, -1
	object_event 11, 82, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperPeter, -1
	object_event  6, 53, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route4GreatBall, EVENT_ROUTE_4_GREAT_BALL
	object_event 15, 13, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route4RoarTMGuyScript, -1
	object_event 12, 67, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FriedaScript, EVENT_ROUTE_4_FRIEDA_OF_FRIDAY
	object_event  3, 30, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route4Repel, EVENT_ROUTE_4_REPEL
	object_event  8, 10, SPRITE_OTIS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route4OtisScript, EVENT_ROUTE_4_OTIS

	object_const_def
	const ROUTE4_FISHER1
	const ROUTE4_FISHER2
	const ROUTE4_FISHER3
	const ROUTE4_YOUNGSTER1
	const ROUTE4_YOUNGSTER2
	const ROUTE4_YOUNGSTER3
	const ROUTE4_LASS1
	const ROUTE4_COOLTRAINER_M
	const ROUTE4_YOUNGSTER4
	const ROUTE4_POKE_BALL1
	const ROUTE4_FISHER5
	const ROUTE4_FRIEDA
	const ROUTE4_POKE_BALL2
	const ROUTE4_OTIS

Route4_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, Route4FriedaAndOtisCallback
	callback MAPCALLBACK_NEWMAP, .Flypoint

.Flypoint:
	setflag ENGINE_FLYPOINT_UNION_CAVE
	endcallback

Route4FriedaAndOtisCallback:
	readvar VAR_WEEKDAY
	ifequal FRIDAY, .FriedaAppears
	disappear ROUTE4_FRIEDA

.OtisCheck
	; 10% chance of otis appearing
	checkflag ENGINE_MET_OTIS_TODAY
	iftrue .done
	random 10
	ifequal 0, .AppearOtis
.done
	disappear ROUTE4_OTIS
	endcallback

.FriedaAppears:
	appear ROUTE4_FRIEDA
	sjump .OtisCheck

.AppearOtis:
	appear ROUTE4_OTIS
	endcallback

Route4CooltrainerMScript:
	faceplayeropentext
	checkevent EVENT_GOT_MIRACLE_SEED_IN_ROUTE_4
	iftrue .GotMiracleSeed
	checkflag ENGINE_ZEPHYRBADGE
	iffalse .DontHaveZephyrBadge
	writethistext
		text "You have some good"
		line "#mon there."

		para "It must be from"
		line "the training you"
		cont "gave them around"
		cont "Violet City."

		para "The training at"
		line "the Gym must have"
		cont "been especially"
		cont "helpful."

		para "As a souvenir of"
		line "Violet City, take"
		cont "this."

		para "It increases the"
		line "power of grass-"
		cont "type moves."
		done
	promptbutton
	verbosegiveitem MIRACLE_SEED
	iffalse_endtext
	setevent EVENT_GOT_MIRACLE_SEED_IN_ROUTE_4
.GotMiracleSeed:
	jumpthisopenedtext
		text "Your experiences"
		line "in Violet City"
		cont "should be useful"
		cont "for your journey."
		done

.DontHaveZephyrBadge:
	jumpthisopenedtext
		text "You should try get"
		line "Violet Gym's badge."
		done

Route4RoarTMGuyScript:
	faceplayeropentext
	checkevent EVENT_GOT_TM05_ROAR
	iftrue .AlreadyHaveRoar
	writethistext
	text "WROOOOAR!"
	line "PEOPLE RUN WHEN I"
	cont "ROAR! BUT YOU"
	cont "CAME LOOKING!"

	para "THAT PLEASES ME!"
	line "NOW TAKE THIS!"
	done

	para "TODOTEXT this"
	line "entire script."
	promptbutton
	verbosegiveitem TM_ROAR
	iffalse_endtext
	setevent EVENT_GOT_TM05_ROAR
.AlreadyHaveRoar:
	writethistext
		text "WROOOAR!"
		line "IT'S ROAR!"

		para "EVEN #MON RUN"
		line "FROM A GOOD ROAR!"
		done
	waitbutton
.Finish:
	endtext

TrainerCamperRoland:
	generictrainer CAMPER, ROLAND, EVENT_BEAT_CAMPER_ROLAND, .SeenText, .BeatenText

.AfterText
	text "If you don't want"
	line "to battle, just"
	cont "avoid eye contact."
	done

.SeenText
	text "That glance…"
	line "It's intriguing."
	done

.BeatenText
	text "Hmmm. This is"
	line "disappointing."
	done

TrainerFisherJustin:
	generictrainer FISHER, JUSTIN, EVENT_BEAT_FISHER_JUSTIN, .SeenText, .BeatenText

.AfterText
	text "Calm, collected…"
	line "The essence of"
	cont "fishing and #-"
	cont "mon is the same."
	done

.SeenText
	text "Whoa!"

	para "You made me lose"
	line "that fish!"
	done

.BeatenText
	text "Sploosh!"
	done

TrainerFisherRalph:
	generictrainer FISHER, RALPH, EVENT_BEAT_FISHER_RALPH, .SeenText, .BeatenText

.AfterText
	text "Fishing is a life-"
	line "long passion."
	cont "#mon are life-"
	cont "long friends!"
	done

.SeenText
	text "I'm really good at"
	line "both fishing and"
	cont "#mon."

	para "I'm not about to"
	line "lose to any kid!"
	done

.BeatenText
	text "Tch! I tried to"
	line "rush things…"
	done

TrainerFisherHenry:
	generictrainer FISHER, HENRY, EVENT_BEAT_FISHER_HENRY, .SeenText, .BeatenText

.AfterText
	text "Freshly caught"
	line "#mon are no"
	cont "match for properly"
	cont "raised ones."
	done

.SeenText
	text "My #mon?"
	line "Freshly caught!"
	done

.BeatenText
	text "Splash?"
	done

TrainerPicnickerLiz1:
	trainer PICNICKER, LIZ1, EVENT_BEAT_PICNICKER_LIZ, PicnickerLiz1SeenText, PicnickerLiz1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_PICNICKER_LIZ
	opentext
	checkevent EVENT_LIZ_MAX_REVIVE
	iftrue .RematchGift
	checkflag ENGINE_LIZ_READY_FOR_REMATCH
	iftrue .Rematch
	checkcellnum PHONE_PICNICKER_LIZ
	iftrue .NumberAccepted
	checkevent EVENT_LIZ_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext PicnickerLiz1AfterText
	promptbutton
	setevent EVENT_LIZ_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber
	sjump .AskForNumber

.AskAgain:
	scall .AskNumber
.AskForNumber:
	askforphonenumber PHONE_PICNICKER_LIZ
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, PICNICKER, LIZ1
	scall .RegisteredNumber
	sjump .NumberAccepted

.Rematch:
	scall .RematchStd
	winlosstext PicnickerLiz1BeatenText, 0
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight4
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight3
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue .LoadFight2
	checkflag ENGINE_FLYPOINT_ECRUTEAK
	iftrue .LoadFight1
	loadtrainer PICNICKER, LIZ1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_LIZ_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer PICNICKER, LIZ2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_LIZ_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer PICNICKER, LIZ3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_LIZ_READY_FOR_REMATCH
	end

.LoadFight3:
	loadtrainer PICNICKER, LIZ4
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_LIZ_READY_FOR_REMATCH
	end

.LoadFight4:
	loadtrainer PICNICKER, LIZ5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_LIZ_READY_FOR_REMATCH
	opentext
	writetext PicnickerLiz_GiveMaxReviveAfterBattleText
	waitbutton
	verbosegiveitem MAX_REVIVE
	iffalse .PackFull
	closetext
	end

.RematchGift
	writetext PicnickerLiz_AgainGiveMaxReviveAfterBattleText
	waitbutton
	verbosegiveitem MAX_REVIVE
	iffalse .PackFull
	clearevent EVENT_LIZ_MAX_REVIVE
	closetext
	end

.PackFull:
	setevent EVENT_LIZ_MAX_REVIVE
	jumpstd PackFullFScript
	end

.AskNumber:
	jumpstd AskNumberFScript
	end

.RegisteredNumber:
	jumpstd RegisteredNumberFScript
	end

.NumberAccepted:
	jumpstd NumberAcceptedFScript
	end

.NumberDeclined:
	jumpstd NumberDeclinedFScript
	end

.RematchStd:
	jumpstd RematchFScript
	end

TrainerYoungsterAlbert:
	trainer YOUNGSTER, ALBERT, EVENT_BEAT_YOUNGSTER_ALBERT, YoungsterAlbertSeenText, YoungsterAlbertBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext YoungsterAlbertAfterText
	waitbutton
	closetext
	end

TrainerYoungsterGordon:
	trainer YOUNGSTER, GORDON, EVENT_BEAT_YOUNGSTER_GORDON, YoungsterGordonSeenText, YoungsterGordonBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext YoungsterGordonAfterText
	waitbutton
	closetext
	end

TrainerBirdKeeperPeter:
	trainer BIRD_KEEPER, PETER, EVENT_BEAT_BIRD_KEEPER_PETER, BirdKeeperPeterSeenText, BirdKeeperPeterBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BirdKeeperPeterAfterText
	waitbutton
	closetext
	end

FriedaScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_POISON_BARB_FROM_FRIEDA
	iftrue .Friday
	readvar VAR_WEEKDAY
	ifnotequal FRIDAY, .NotFriday
	checkevent EVENT_MET_FRIEDA_OF_FRIDAY
	iftrue .MetFrieda
	writetext MeetFriedaText
	promptbutton
	setevent EVENT_MET_FRIEDA_OF_FRIDAY
.MetFrieda:
	writetext FriedaGivesGiftText
	promptbutton
	verbosegiveitem POISON_BARB
	iffalse .Done
	setevent EVENT_GOT_POISON_BARB_FROM_FRIEDA
	writetext FriedaGaveGiftText
	waitbutton
	closetext
	end

.Friday:
	writetext FriedaFridayText
	waitbutton
.Done:
	closetext
	end

.NotFriday:
	writetext FriedaNotFridayText
	waitbutton
	closetext
	end







YoungsterAlbertSeenText:
	text "I haven't seen you"
	line "around before."

	para "So you think you"
	line "are pretty tough?"
	done

YoungsterAlbertBeatenText:
	text "You're strong!"
	done

YoungsterAlbertAfterText:
	text "I'm going to try"
	line "to be the best"
	cont "with my favorites."

	para "I'm not using the"
	line "same tough #MON"
	cont "as everyone else."
	done

YoungsterGordonSeenText:
	text "I found some good"
	line "#MON in the"
	cont "grass!"

	para "I think they'll do"
	line "it for me!"
	done

YoungsterGordonBeatenText:
	text "Darn. I thought I"
	line "could win."
	done

YoungsterGordonAfterText:
	text "The grass is full"
	line "of clingy things."
	done



PicnickerLiz1SeenText:
	text "Uh-huh. Yeah, and"
	line "you know…"

	para "Pardon? Battle?"
	line "I'm on the phone."

	para "Oh, all right. But"
	line "make it fast."
	done

PicnickerLiz1BeatenText:
	text "Oh! I've got to"
	line "relieve my anger!"
	done

PicnickerLiz1AfterText:
	text "I was having a"
	line "nice chat too."
	done

BirdKeeperPeterSeenText:
	text "That BADGE! It's"
	line "from VIOLET CITY!"

	para "You beat FALKNER?"
	done

BirdKeeperPeterBeatenText:
	text "I know what my"
	line "weaknesses are."
	done

BirdKeeperPeterAfterText:
	text "I should train"
	line "again at the GYM"
	cont "in VIOLET CITY."
	done





MeetFriedaText:
	text "FRIEDA: Yahoo!"
	line "It's Friday!"

	para "I'm FRIEDA of"
	line "Friday!"

	para "Nice to meet you!"
	done

FriedaGivesGiftText:
	text "Here's a POISON"
	line "BARB for you!"
	done

FriedaGaveGiftText:
	text "FRIEDA: Give it to"
	line "a #MON that has"
	cont "poison-type moves."

	para "Oh!"

	para "It's wicked!"

	para "You'll be shocked"
	line "how good it makes"
	cont "poison moves!"
	done

FriedaFridayText:
	text "FRIEDA: Hiya! What"
	line "day do you like?"

	para "I love Friday. No"
	line "doubt about it!"

	para "Don't you think"
	line "it's great too?"
	done

FriedaNotFridayText:
	text "FRIEDA: Isn't it"
	line "Friday today?"

	para "It's so boring"
	line "when it's not!"
	done

PicnickerLiz_GiveMaxReviveAfterBattleText:
	text "That was a great"
	line "battle! Have this!"
	done

PicnickerLiz_AgainGiveMaxReviveAfterBattleText:
	text "Made room right?"
	line "All yours!"
	done

Route4OtisScript:
	callstd WanderingOddEggNPCScript
	playsound SFX_WARP_TO
	applymovement ROUTE4_OTIS, Route4OtisTeleportAwayMovement
	disappear ROUTE4_OTIS
	setflag ENGINE_MET_OTIS_TODAY
	end

Route4OtisTeleportAwayMovement:
	teleport_from
	step_end

Route4SignText:
	text "Route 4"

	para "Violet City -"
	line "Azalea Town"
	done

Route4RuinsSignText:
	text "Ruins Of Alph"
	line "East Entrance"
	done

Route4UnionCaveSignText:
	text "Union Cave"
	line "Ahead"
	done

Route4GreatBall:
	itemball GREAT_BALL
Route4Repel:
	itemball REPEL
