LakeOfRage_MapEvents:
	def_warp_events
	warp_event 27, 31, LAKE_OF_RAGE_MAGIKARP_HOUSE, 1
	warp_event  7,  3, LAKE_OF_RAGE_HIDDEN_POWER_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 21, 27, BGEVENT_JUMPTEXT, LakeOfRageSignText
	bg_event 25, 31, BGEVENT_JUMPTEXT, MagikarpHouseSignText
	bg_event 11, 28, BGEVENT_ITEM + FULL_RESTORE, EVENT_LAKE_OF_RAGE_HIDDEN_FULL_RESTORE
	bg_event  4,  4, BGEVENT_ITEM + RARE_CANDY, EVENT_LAKE_OF_RAGE_HIDDEN_RARE_CANDY
	bg_event 35,  5, BGEVENT_ITEM + MAX_POTION, EVENT_LAKE_OF_RAGE_HIDDEN_MAX_POTION

	def_object_events
	object_event 20, 26, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, LakeOfRageGrampsText, -1
	object_event 30, 23, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, TrainerFisherAndre, -1
	object_event 24, 26, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, TrainerFisherRaymond, -1
	object_event  4, 15, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 1, TrainerCooltrainermAaron, -1
	object_event 36,  7, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 0, TrainerCooltrainerfLois, -1
	object_event 18, 22, SPRITE_GYARADOS, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RedGyaradosScript, EVENT_LAKE_OF_RAGE_RED_GYARADOS
	object_event  4,  4, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, WesleyScript, EVENT_LAKE_OF_RAGE_WESLEY_OF_WEDNESDAY
	object_event  2, 28, SPRITE_OTIS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LakeOfRageOtisScript, EVENT_MET_OTIS_TODAY
	object_event  7, 10, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, LakeOfRageElixer, EVENT_LAKE_OF_RAGE_ELIXER
	object_event 35,  2, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, LakeOfRageTMDetect, EVENT_LAKE_OF_RAGE_TM_DETECT

	object_const_def
	const LAKEOFRAGE_GRAMPS
	const LAKEOFRAGE_FISHER1
	const LAKEOFRAGE_FISHER2
	const LAKEOFRAGE_COOLTRAINER_M
	const LAKEOFRAGE_COOLTRAINER_F2
	const LAKEOFRAGE_GYARADOS
	const LAKEOFRAGE_WESLEY
	const LAKEOFRAGE_OTIS
	const LAKEOFRAGE_POKE_BALL1
	const LAKEOFRAGE_POKE_BALL2

LakeOfRage_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, LakeOfRageFlypointCallback
	callback MAPCALLBACK_OBJECTS, LakeOfRageWesleyAndOtisCallback

LakeOfRageFlypointCallback:
	setflag ENGINE_FLYPOINT_LAKE_OF_RAGE
	endcallback

LakeOfRageWesleyAndOtisCallback:
	setval WEATHER_RAIN
	writemem wFieldWeather

	readvar VAR_WEEKDAY
	ifequal WEDNESDAY, .WesleyAppears
	disappear LAKEOFRAGE_WESLEY

.OtisCheck
	; 10% chance of otis appearing
	checkflag ENGINE_MET_OTIS_TODAY
	iftrue .done
	random 10
	ifequal 0, .AppearOtis
.done
	disappear LAKEOFRAGE_OTIS
	endcallback

.WesleyAppears:
	appear LAKEOFRAGE_WESLEY
	sjump .OtisCheck

.AppearOtis:
	appear LAKEOFRAGE_OTIS
	endcallback

WesleyScript:
	faceplayeropentext
	checkevent EVENT_GOT_BLACKBELT_FROM_WESLEY
	iftrue WesleyWednesdayScript
	readvar VAR_WEEKDAY
	ifnotequal WEDNESDAY, WesleyNotWednesdayScript
	checkevent EVENT_MET_WESLEY_OF_WEDNESDAY
	iftrue .MetWesley
	writethistext
		text "Wesley: Well, how"
		line "do you do?"

		para "Seeing as how it's"
		line "Wednesday today,"
		cont "I'm Wesley of"
		cont "Wednesday."
		done
	promptbutton
	setevent EVENT_MET_WESLEY_OF_WEDNESDAY
.MetWesley:
	writethistext
		text "Pleased to meet"
		line "you. Please take a"
		cont "souvenir."
		done
	promptbutton
	verbosegiveitem BLACKBELT_I
	iffalse_endtext
	setevent EVENT_GOT_BLACKBELT_FROM_WESLEY
	jumpthisopenedtext
		text "Wesley: Blackbelt"
		line "beefs up the power"
		cont "of fighting moves."
		done

WesleyWednesdayScript:
	jumpthisopenedtext
		text "Wesley: Since you"
		line "found me, you must"
		cont "have met my broth-"
		cont "ers and sisters."

		para "Or did you just"
		line "get lucky?"
		done

WesleyNotWednesdayScript:
	jumpthisopenedtext
		text "Wesley: Today's"
		line "not Wednesday."
		cont "That's too bad."
		done

TrainerFisherAndre:
	generictrainer FISHER, ANDRE, EVENT_BEAT_FISHER_ANDRE, .SeenText, .BeatenText

.AfterText
	text "I won't lose as an"
	line "angler! I catch"
	cont "#mon all day."
	done

.SeenText
	text "Let me battle with"
	line "the #mon I just"
	cont "caught!"
	done

.BeatenText
	text "I might be an ex-"
	line "pert angler, but"
	cont "I stink as a #-"
	cont "mon trainer…"
	done

TrainerFisherRaymond:
	generictrainer FISHER, RAYMOND, EVENT_BEAT_FISHER_RAYMOND, .SeenText, .BeatenText

.AfterText
	text "Why can't I catch"
	line "any good #mon?"
	done

.SeenText
	text "No matter what I"
	line "do, all I catch"
	cont "are the same #-"
	cont "mon…"
	done

.BeatenText
	text "My line's all"
	line "tangled up…"
	done

TrainerCooltrainermAaron:
	generictrainer COOLTRAINERM, AARON, EVENT_BEAT_COOLTRAINERM_AARON, .SeenText, .BeatenText

.AfterText
	text "#mon and their"
	line "trainer become"
	cont "powerful through"
	cont "constant battling."
	done

.SeenText
	text "If a trainer spots"
	line "another trainer,"
	cont "he has to make a"
	cont "challenge."

	para "That is our"
	line "destiny."
	done

.BeatenText
	text "Whew…"
	line "Good battle."
	done

TrainerCooltrainerfLois:
	generictrainer COOLTRAINERF, LOIS, EVENT_BEAT_COOLTRAINERF_LOIS, .SeenText, .BeatenText

.AfterText
	text "TODOTEXT"
	done

.SeenText
	text "I'm bored!"

	para "I know--let's"
	line "battle!"
	done

.BeatenText
	text "Good going!"
	done

LakeOfRageGrampsText:
	text "The Magikarp are"
	line "are as lively as"
	cont "ever!"
	done

LakeOfRageSignText:
	text "Lake Of Rage,"
	line "also known as"
	cont "Gyarados Lake."
	done

MagikarpHouseSignText:
	text "Fishing Guru's"
	line "House"
	done

RedGyaradosScript:
	isfieldactionssettoquick
	iftrue .skipthis
	reanchormap
	pokepic GYARADOS
	cry GYARADOS
	waitbutton
	closepokepic
.skipthis
	showthistext
		text "Gyarados: Gyashaa!"
		done
	loadvar VAR_BATTLETYPE, BATTLETYPE_FORCESHINY
	loadwildmon GYARADOS, 30
	startbattle
	disappear LAST_TALKED
	reloadmapafterbattle
	end

LakeOfRageElixer:
	itemball ELIXER
LakeOfRageTMDetect:
	itemball TM_DISARM_VOICE

LakeOfRageOtisScript:
	callstd WanderingOddEggNPCScript
	playsound SFX_WARP_TO
	applymovement LAKEOFRAGE_OTIS, LakeOfRageOtisTeleportAwayMovement
	disappear LAST_TALKED
	setflag ENGINE_MET_OTIS_TODAY
	end

LakeOfRageOtisTeleportAwayMovement:
	teleport_from
	step_end
