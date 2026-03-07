DayCare_MapEvents:
	def_warp_events
	warp_event  0,  5, ROUTE_6, 3
	warp_event  0,  6, ROUTE_6, 4
	warp_event  2,  7, ROUTE_6, 5
	warp_event  3,  7, ROUTE_6, 5

	def_coord_events
	coord_event  2,  7, SCENE_DAYCARE_GRANDMA_PREVENTS_ENTRY, DayCareGrandsonBlocksPreventsAcess
	coord_event  3,  7, SCENE_DAYCARE_GRANDMA_PREVENTS_ENTRY, DayCareGrandsonBlocksPreventsAcess

	def_bg_events
	bg_event  0,  1, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT
	bg_event  1,  1, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT

	def_object_events
	object_event  2,  4, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DayCareManScript_Inside, EVENT_DAY_CARE_MAN_IN_DAY_CARE
	object_event  5,  4, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, DayCareLadyScript, -1
	object_event  6,  5, SPRITE_TWIN, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, DayCareGrandDaughterScript, -1

	object_const_def
	const DAYCARE_GRAMPS
	const DAYCARE_GRANNY
	const DAYCARE_GRANDDAUGHTER

DayCare_MapScripts:
	def_scene_scripts
	scene_script DayCareNoop1Scene, SCENE_DAYCARE_GRANDMA_PREVENTS_ENTRY
	scene_script DayCareNoop2Scene, SCENE_DAYCARE_NOOP

	def_callbacks
	callback MAPCALLBACK_OBJECTS, DayCareEggCheckCallback

DayCareNoop1Scene:
DayCareNoop2Scene:
	end

DayCareEggCheckCallback:
	checkflag ENGINE_DAY_CARE_MAN_HAS_EGG
	iftrue .PutDayCareManOutside
	clearevent EVENT_DAY_CARE_MAN_IN_DAY_CARE
	setevent EVENT_DAY_CARE_MAN_ON_ROUTE_6
	endcallback

.PutDayCareManOutside:
	setevent EVENT_DAY_CARE_MAN_IN_DAY_CARE
	clearevent EVENT_DAY_CARE_MAN_ON_ROUTE_6
	endcallback

DayCareManScript_Inside:
	faceplayeropentext
	checkevent EVENT_GOT_ODD_EGG
	iftrue .AlreadyHaveOddEgg
	writethistext
		text "I'm the Day-Care"
		line "Man."

		para "Do you know about"
		line "Eggs?"

		para "I was raising"
		line "#mon with my"
		cont "wife, you see."

		para "We were shocked to"
		line "find an Egg!"

		para "How incredible is"
		line "that?"

		para "You know, your"
	 	line "#dex shows Egg"
	 	cont "groups, and how"
	  	cont "long they take to"
	 	cont "hatch!"

		para "Well, wouldn't you"
		line "like this Egg?"

		para "Then fine, this is"
		line "yours to keep!"
		done
	waitclosetext
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .PartyFull
	special GiveOddEgg
	opentext
	writethistext
		text "<PLAYER> received"
		line "Odd Egg!"
		done
	playsound SFX_KEY_ITEM
	waitsfx
	setevent EVENT_GOT_ODD_EGG
	jumpthisopenedtext
		text "I found that when"
		line "I was caring for"
		cont "someone's #mon"
		cont "before."

		para "But the trainer"
		line "didn't want the"
		cont "Egg, so I'd kept"
		cont "it around."
		done

.PartyFull:
	jumpthisopenedtext
		text "You've no room for"
		line "this."
		done

.AlreadyHaveOddEgg:
	special DayCareMan
	waitendtext

DayCareLadyScript:
	faceplayeropentext
	checkflag ENGINE_DAY_CARE_MAN_HAS_EGG
	iftrue .GrampsWasLookingForYou
	special DayCareLady
	waitendtext

.GrampsWasLookingForYou:
	jumpthisopenedtext
		text "Gramps was looking"
		line "for you."
		done

DayCareGrandsonBlocksPreventsAcess:
	showemote EMOTE_SHOCK, DAYCARE_GRANNY, 15
	turnobject DAYCARE_GRANNY, DOWN
	showthistext
		text "Sorry! I can't let"
		line "you enter back."
		
		para "We've a new hatch-"
		line "ing room there."
		
		para "Only bicycle own-"
		line "ers are allowed."
		
		para "Goldenrod City now"
		line "has bicycle shop."
		
		para "If you get one, I"
		line "will let you pass."
		
		para "Also, if gramps is"
		line "not around, he'd"

		para "be in the hatching"
		line "room."
		done
	applymovement PLAYER, DayCareMovePlayerWalkUp
	turnobject DAYCARE_GRANNY, LEFT
	end

DayCareMovePlayerWalkUp:
	step UP
	step_end

DayCareGrandDaughterScript:
	faceplayeropentext
	clearevent EVENT_DAY_CARE_GRANDDAUGHTER_THIS_IS_NOT_AN_EGG
	clearevent EVENT_DAY_CARE_GRANDDAUGHTER_ADOPTS_AN_EGG
	checkevent EVENT_DAY_CARE_GRANDDAUGHTER_HAS_A_TINYMUSHROOM_FOR_PLAYER
	iftrue .DayCareGrandDaughterGiveATinyMushroom
	checkevent EVENT_MET_DAY_CARE_GRANDDAUGHTER
	iftrue .PutUpAnEggForAdoptionForATinyMushroom
	writethistext
		text "Salutations!"

		para "Huh? I sound old?"

		para "Well, I live with"
		line "my Mamaw and Papaw"
		cont "here so they are"
		cont "bound to rub off"
		cont "on me. Hehe."

		para "Thing is, trainers"
		line "may not always be"
		cont "able to care for"
		cont "an Egg, so those"
		cont "need a home."

		para "That's where I can"
		line "help!"

		para "I will adopt any"
		line "Egg you want."

		para "Living near the"
		line "Ilex Forest, I've"
		cont "a collection of"
		cont "Tiny Mushrooms!"

		para "I'll give you one"
		line "for each!"

		para "Do you have any"
		line "Eggs in need"
		cont "of a new home?"
		done
	setevent EVENT_MET_DAY_CARE_GRANDDAUGHTER
	sjump .FirstTimeEggAdoption

.PutUpAnEggForAdoptionForATinyMushroom:
	writethistext
		text "Salutations! Hehe."

		para "Do you have an Egg"
		line "in need of a home?"

		para "You can take this"
		line "Tiny Mushroom in"
		cont "return?"
		done
.FirstTimeEggAdoption:
	yesorno
	iffalse .DontHaveAnEggThatNeedsAdopting
	special PlayerGivesAwayAnEggForAdoption
	checkevent EVENT_DAY_CARE_GRANDDAUGHTER_THIS_IS_NOT_AN_EGG
	iftrue .ThisIsNotAnEgg
	checkevent EVENT_DAY_CARE_GRANDDAUGHTER_ADOPTS_AN_EGG
	iffalse .DontHaveAnEggThatNeedsAdopting
	writethistext
		text "I'll take care of"
		line "this! And for you…"
		done
	promptbutton
	verbosegiveitem TINYMUSHROOM
	iffalse .YouDontHaveSpace
	writetext DayCareDaughterImAlwaysHereToHelpText
	waitbutton
	closetext
	end

.DontHaveAnEggThatNeedsAdopting:
	jumpthisopenedtext
		text "No? Stop by if"
		line "ever you do."
		done

.ThisIsNotAnEgg:
	jumpthisopenedtext
		text "I'm sorry. This is"
		line "not an Egg."
		done

.YouDontHaveSpace:
	setevent EVENT_DAY_CARE_GRANDDAUGHTER_HAS_A_TINYMUSHROOM_FOR_PLAYER
	jumpthisopenedtext
		text "You don't have any"
		line "room for this."

		para "Come back when you"
		line "do."
		done

.DayCareGrandDaughterGiveATinyMushroom:
	writethistext
		text "Are you ready for"
		line "a Tiny Mushroom?"
		done
	promptbutton
	verbosegiveitem TINYMUSHROOM
	iffalse .YouDontHaveSpace
	writetext DayCareDaughterImAlwaysHereToHelpText
	clearevent EVENT_DAY_CARE_GRANDDAUGHTER_HAS_A_TINYMUSHROOM_FOR_PLAYER
	waitendtext

DayCareDaughterImAlwaysHereToHelpText:
	text "Stop by if ever an"
	line "Egg needs a home."
	done
