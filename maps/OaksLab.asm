	object_const_def
	const OAKSLAB_OAK
	const OAKSLAB_SCIENTIST1
	const OAKSLAB_SCIENTIST2
	const OAKSLAB_PORYGON_PC
	const OAKSLAB_CHANSEY
	const OAKSLAB_NAYRU62

OaksLab_MapScripts:
	def_scene_scripts
	scene_script OaksLabNoop1Scene, SCENE_OAKS_LAB_NAYRU62
	scene_script OaksLabFNoop2Scene, SCENE_OAKS_LAB_NOOP

	def_callbacks

OaksLabNoop1Scene:
	; fallthrough
OaksLabFNoop2Scene:
	end

Oak:
	faceplayer
	opentext
	checkevent EVENT_OPENED_MT_SILVER
	iftrue .CheckPokedex
	checkevent EVENT_TALKED_TO_OAK_IN_KANTO
	iftrue .CheckBadges
	writetext OakWelcomeKantoText
	promptbutton
	setevent EVENT_TALKED_TO_OAK_IN_KANTO
.CheckBadges:
	readvar VAR_BADGES
	ifequal NUM_BADGES, .OpenMtSilver
	ifequal NUM_JOHTO_BADGES, .Complain
	sjump .AhGood

.CheckPokedex:
	writetext OakLabDexCheckText
	waitbutton
	special ProfOaksPCBoot
	writetext OakLabGoodbyeText
	waitbutton
	closetext
	end

.OpenMtSilver:
	writetext OakOpenMtSilverText
	promptbutton
	setevent EVENT_OPENED_MT_SILVER
	sjump .CheckPokedex

.Complain:
	writetext OakNoKantoBadgesText
	promptbutton
	sjump .CheckPokedex

.AhGood:
	writetext OakYesKantoBadgesText
	promptbutton
	sjump .CheckPokedex

OaksAssistant1Script:
	jumptextfaceplayer OaksAssistant1Text

OaksAssistant2Script:
	jumptextfaceplayer OaksAssistant2Text

OaksLabBookshelf:
	jumpstd DifficultBookshelfScript

OaksLabPoster1:
	jumptext OaksLabPoster1Text

OaksLabPoster2:
	jumptext OaksLabPoster2Text

OaksLabTrashcan:
	jumptext OaksLabTrashcanText

OaksLabPC:
	jumptext OaksLabPCText

OakWelcomeKantoText:
	text "OAK: Ah, <PLAY_G>!"
	line "It's good of you"

	para "to come all this"
	line "way to KANTO."

	para "What do you think"
	line "of the trainers"

	para "out here?"
	line "Pretty tough, huh?"
	done

OakLabDexCheckText:
	text "How is your #-"
	line "DEX coming?"

	para "Let's see…"
	done

OakLabGoodbyeText:
	text "If you're in the"
	line "area, I hope you"
	cont "come visit again."
	done

OakOpenMtSilverText:
	text "OAK: Wow! That's"
	line "excellent!"

	para "You collected the"
	line "BADGES of GYMS in"
	cont "KANTO. Well done!"

	para "I was right in my"
	line "assessment of you."

	para "Tell you what,"
	line "<PLAY_G>. I'll make"

	para "arrangements so"
	line "that you can go to"
	cont "MT.SILVER."

	para "MT.SILVER is a big"
	line "mountain that is"

	para "home to many wild"
	line "#MON."

	para "It's too dangerous"
	line "for your average"

	para "trainer, so it's"
	line "off limits. But"

	para "we can make an"
	line "exception in your"
	cont "case, <PLAY_G>."

	para "Go up to INDIGO"
	line "PLATEAU. You can"

	para "reach MT.SILVER"
	line "from there."
	done

OakNoKantoBadgesText:
	text "OAK: Hmm? You're"
	line "not collecting"
	cont "KANTO GYM BADGES?"

	para "The GYM LEADERS in"
	line "KANTO are as tough"

	para "as any you battled"
	line "in JOHTO."

	para "I recommend that"
	line "you challenge"
	cont "them."
	done

OakYesKantoBadgesText:
	text "OAK: Ah, you're"
	line "collecting KANTO"
	cont "GYM BADGES."

	para "I imagine that"
	line "it's hard, but the"

	para "experience is sure"
	line "to help you."

	para "Come see me when"
	line "you get them all."

	para "I'll have a gift"
	line "for you."

	para "Keep trying hard,"
	line "<PLAY_G>!"
	done

OaksAssistant1Text:
	text "The PROF's #MON"
	line "TALK radio program"

	para "isn't aired here"
	line "in KANTO."

	para "It's a shame--I'd"
	line "like to hear it."
	done

OaksAssistant2Text:
	text "Don't tell anyone,"
	line "but PROF.OAK'S"

	para "#MON TALK isn't"
	line "a live broadcast."
	done

OaksLabPoster1Text:
	text "Press START to"
	line "open the MENU."
	done

OaksLabPoster2Text:
	text "The SAVE option is"
	line "on the MENU."

	para "Use it in a timely"
	line "manner."
	done

OaksLabTrashcanText:
	text "There's nothing in"
	line "here…"
	done

OaksLabPCText:
	text "There's an e-mail"
	line "message on the PC."

	para "…"

	para "PROF.OAK, how is"
	line "your research"
	cont "coming along?"

	para "I'm still plugging"
	line "away."

	para "I heard rumors"
	line "that <PLAY_G> is"

	para "getting quite a"
	line "reputation."

	para "I'm delighted to"
	line "hear that."

	para "ELM in NEW BARK"
	line "TOWN 8-)"
	done

OaksLabPorygonPCScript:
	jumpstd PorygonPCScript

OaksLabChanseyScript:
	jumpstd ChanseyHealsOWScript

Nayru62CoordScript1:
	turnobject PLAYER, LEFT
	turnobject OAKSLAB_NAYRU62, RIGHT
	showemote EMOTE_SHOCK, OAKSLAB_NAYRU62, 15
	waitsfx
	applymovement OAKSLAB_NAYRU62, OaksLabNayru62ApproachesMovement1
	turnobject OAKSLAB_NAYRU62, DOWN
	turnobject PLAYER, UP
	opentext
	writetext Nayru62IntroText
	waitbutton
	scall Nayru62Script
	applymovement OAKSLAB_NAYRU62, OaksLabNayru62LeavesMovement1
	setscene SCENE_OAKS_LAB_NOOP
	end

Nayru62CoordScript2:
	turnobject PLAYER, LEFT
	turnobject OAKSLAB_NAYRU62, RIGHT
	showemote EMOTE_SHOCK, OAKSLAB_NAYRU62, 15
	waitsfx
	applymovement OAKSLAB_NAYRU62, OaksLabNayru62ApproachesMovement2
	turnobject OAKSLAB_NAYRU62, DOWN
	turnobject PLAYER, UP
	opentext
	writetext Nayru62IntroText
	waitbutton
	scall Nayru62Script
	applymovement OAKSLAB_NAYRU62, OaksLabNayru62LeavesMovement2
	setscene SCENE_OAKS_LAB_NOOP
	end

Nayru62Script:
	faceplayer
	opentext
	checkevent EVENT_SHINY_CHARM_OBTAINED
	iftrue .AreYouMakingingUseOfTheShinyCharm
	writetext NayruHowsYourDexText
	promptbutton
	readvar VAR_DEXCAUGHT
	ifequal 252, .PokedexCompleted
	writetext NayruStillHaveABitMoreToCollectText
	waitbutton
	closetext
	end

.PokedexCompleted
	closetext
	playsound SFX_1ST_PLACE
	pause 100
	showemote EMOTE_SHOCK, OAKSLAB_NAYRU62, 15
	turnobject OAKSLAB_NAYRU62, LEFT
	turnobject OAKSLAB_NAYRU62, UP
	turnobject OAKSLAB_NAYRU62, DOWN
	turnobject OAKSLAB_NAYRU62, RIGHT
	turnobject OAKSLAB_NAYRU62, LEFT
	turnobject OAKSLAB_NAYRU62, UP
	turnobject OAKSLAB_NAYRU62, DOWN
	turnobject OAKSLAB_NAYRU62, RIGHT
	turnobject OAKSLAB_NAYRU62, LEFT
	turnobject OAKSLAB_NAYRU62, UP
	turnobject OAKSLAB_NAYRU62, DOWN
	turnobject OAKSLAB_NAYRU62, RIGHT
	faceplayer
	opentext
	writetext Nayru62IncredibleJobText
	promptbutton
	verbosegiveitem SHINY_CHARM
	writetext ShinyCharmExplanationText
	setevent EVENT_SHINY_CHARM_OBTAINED
	waitbutton
	closetext
	end

.AreYouMakingingUseOfTheShinyCharm
	writetext AreYouFindingUseOfTheShinyCharmText
	waitbutton
	closetext
	end

OaksLabNayru62ApproachesMovement1:
	step RIGHT
	step_end

OaksLabNayru62LeavesMovement1:
	step LEFT
	step_end

OaksLabNayru62ApproachesMovement2:
	step RIGHT
	step RIGHT
	step_end

OaksLabNayru62LeavesMovement2:
	step LEFT
	step LEFT
	step_end

Nayru62IntroText:
	text "<PLAY_G>! Prof.Oak"
	line "has told me loads"
	cont "about you!"

	para "He's mighty proud"
	line "of you!"

	para "I've not introduced"
	line "myself yet!"

	para "I'm Nayru62!"

	para "I'm the one who"
	line "upgraded the Prof's"
	cont "#dex that you"
	cont "have been using."
	
	para "His previous need-"
	line "ed some augments."
	
	para "What? You've really"
	line "enjoyed it!?"
	
	para "Well, I'm thrilled!"
	
	para "Say, if you record"
	line "the data of all"
	
	para "252 #mon on it,"
	line "come see me. Wait,"
	cont "let's check now?"
	done

NayruHowsYourDexText:
	text "Nayru62: Have you"
	line "registered all 252"
	cont "#mon yet?"
	done

NayruStillHaveABitMoreToCollectText:
	text "Seems like you've"
	line "a bit more to go."
	
	para "Come visit me when"
	line "it's completed."
	
	para "I'll have a gift"
	line "for you then."
	
	para "In the meantime,"
	line "work hard on it!"
	
	para "I'm cheering for"
	line "you!"
	done

Nayru62IncredibleJobText:
	text "OH MY!!!"
	
	para "This is incredibly"
	line "rare and amazing!"
	
	para "Fantastic job on"
	line "your endeavor!"
	
	para "I know it must've"
	line "taken you a long"
	
	para "time to accomplish"
	line "this feat!"
	
	para "I have this item"
	line "for you! Take it!"
	done
	
ShinyCharmExplanationText:
	text "That's the one and"
	line "only Shiny Charm!"
	
	para "With this item in"
	line "your bag, the odds"
	
	para "of finding a shiny"
	line "#mon jumps to"
	
	para "3.125<%> per"
	line "encounter!"
	
	para "Isn't that just"
	line "awesome! Have fun"
	cont "shiny hunting!"
	done

AreYouFindingUseOfTheShinyCharmText:
	text "Nayru62: Why hello"
	line "there <PLAY_G>."
	
	para "Making use of the"
	line "Shiny Charm?"
	
	para "Recall, with it in"
	line "your bag, there's"
	
	para "a 3.125<%> chance"
	line "to find a"
	
	para "Shiny #mon"
	line "per encounter!"
	done

OaksLab_MapEvents:
	def_warp_events
	warp_event  4, 11, PALLET_TOWN, 1
	warp_event  5, 11, PALLET_TOWN, 1

	def_coord_events
	coord_event  4,  6, SCENE_OAKS_LAB_NAYRU62, Nayru62CoordScript1
	coord_event  5,  6, SCENE_OAKS_LAB_NAYRU62, Nayru62CoordScript2

	def_bg_events
	bg_event  6,  1, BGEVENT_READ, OaksLabBookshelf
	bg_event  7,  1, BGEVENT_READ, OaksLabBookshelf
	bg_event  8,  1, BGEVENT_READ, OaksLabBookshelf
	bg_event  9,  1, BGEVENT_READ, OaksLabBookshelf
	bg_event  0,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  1,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  2,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  3,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  6,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  7,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  8,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  9,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  4,  0, BGEVENT_READ, OaksLabPoster1
	bg_event  5,  0, BGEVENT_READ, OaksLabPoster2
	bg_event  9,  3, BGEVENT_READ, OaksLabTrashcan
	bg_event  0,  1, BGEVENT_READ, OaksLabPC

	def_object_events
	object_event  4,  2, SPRITE_OAK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Oak, -1
	object_event  1,  8, SPRITE_SCIENTIST, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, OaksAssistant1Script, -1
	object_event  7,  8, SPRITE_SCIENTIST, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, OaksAssistant2Script, -1
	object_event  0,  4, SPRITE_PORYGON_OW, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OaksLabPorygonPCScript, -1
	object_event  8,  4, SPRITE_CHANSEY_OW, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OaksLabChanseyScript, -1
	object_event  3,  5, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Nayru62Script, EVENT_OAKSLAB_NAYRU62
