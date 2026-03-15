BlackthornGym1F_MapEvents:
	def_warp_events
	warp_event  4, 17, BLACKTHORN_CITY, 2
	warp_event  5, 17, BLACKTHORN_CITY, 2
	warp_event  1,  7, BLACKTHORN_GYM_2F, 1
	warp_event  7,  9, BLACKTHORN_GYM_2F, 2
	warp_event  2,  6, BLACKTHORN_GYM_2F, 3
	warp_event  7,  7, BLACKTHORN_GYM_2F, 4
	warp_event  7,  6, BLACKTHORN_GYM_2F, 5

	def_coord_events

	def_bg_events
	bg_event  3, 15, BGEVENT_READ, BlackthornGymStatue
	bg_event  6, 15, BGEVENT_READ, BlackthornGymStatue

	def_object_events
	object_event  5,  3, SPRITE_CLAIR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BlackthornGymClairScript, -1
	object_event  3,  8, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerCooltrainermMike, -1
	object_event  1, 14, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerCooltrainermPaul, -1
	object_event  9,  2, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerCooltrainerfLola, -1
	object_event  7, 15, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BlackthornGymGuideScript, -1
	object_event  4, 16, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornGymRareCandyScript, EVENT_BLACKTHORN_GYM_7_RARE_CANDIES

	object_const_def
	const BLACKTHORNGYM1F_CLAIR
	const BLACKTHORNGYM1F_COOLTRAINER_M1
	const BLACKTHORNGYM1F_COOLTRAINER_M2
	const BLACKTHORNGYM1F_COOLTRAINER_F
	const BLACKTHORNGYM1F_GYM_GUIDE
	const BLACKTHORNGYM_POKE_BALL

BlackthornGym1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, BlackthornGym1FBouldersCallback

BlackthornGym1FBouldersCallback:
	checkevent EVENT_BOULDER_IN_BLACKTHORN_GYM_1
	iffalse .skip1
	changeblock 8, 2, $3b ; fallen boulder 2
.skip1
	checkevent EVENT_BOULDER_IN_BLACKTHORN_GYM_2
	iffalse .skip2
	changeblock 2, 4, $3a ; fallen boulder 1
.skip2
	checkevent EVENT_BOULDER_IN_BLACKTHORN_GYM_3
	iffalse .skip3
	changeblock 8, 6, $3b ; fallen boulder 2
.skip3
	endcallback

BlackthornGymClairScript:
	faceplayeropentext
	checkevent EVENT_PLAYER_IS_THE_POKEMON_LEAGUE_CHAMPION
	iftrue .ClairRematch
	checkevent EVENT_BEAT_CLAIR
	iftrue .GymBadgeBattleDone
	writethistext
		text "I am Clair."

		para "A dragon master!"

		para "I'm considered the"
		line "the strongest Gym"
		cont "Leader in Johto."

		para "You weren't ready"
		line "for a battle with"
		cont "me before but are"
		cont "you now?"

		para "Let's do it!"
		done
	waitclosetext
	winlosstext ClairLossText, 0
	loadtrainer CLAIR, CLAIR1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_CLAIR
	setevent EVENT_UNLOCK_STAT_SCREEN_EFFORT_VALUES
	opentext
	writethistext
		text "<PLAYER> received"
		line "Rising Badge."
		done
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_RISINGBADGE
.GymBadgeBattleDone:
	checkevent EVENT_GOT_BLACKTHORN_GYM_TM
	iftrue .SpeechAfterTM
	writethistext
		text "Allow me to give"
		line "you this TM too."
		done
	promptbutton
	verbosegiveitem TM_DRAGON_PULSE
	iffalse_endtext
	setevent EVENT_GOT_BLACKTHORN_GYM_TM
	jumpthisopenedtext
		text "You are free to"
		line "enter the Dragon"
		cont "Shrine behind this"
		cont "Gym now."

		para "Your next goal is"
		line "#mon League."

		para "From here, go to"
		line "New Bark Town."

		para "The direct route"
		line "to the east leads"
		cont "to the Indigo"
		cont "Plateau."

		para "Give it every-"
		line "thing you've got"
		cont "and come back with"
		cont "your victory tale."
		done

.SpeechAfterTM:
	jumpthisopenedtext
		text "Return as Champion"
		line "and we'll have a"
		cont "grand rematch."

		para "I will prepare for"
		line "it."
		done

.ClairRematch:
	writethistext
		text "Clair: Welcome"
		line "back <PLAYER>, no"
		cont "Champion <PLAYER>."
		
		para "It looks like"
		line "our first battle"
		cont "was just a step-"
		cont "ping stone for one"
		cont "with so much po-"
		cont "tential."
		
		para "I too have gained"
		line "more strength."
		
		para "I wonder if I can"
		line "hold my own again-"
		cont "st you now…"
		
		para "Would you allow me"
		line "the opportunity to"
		cont "find out?"
		done 
	yesorno
	iffalse_endtext
	writethistext
		text "…Great. Let's do"
		line "it!"
		done
	waitbutton
	winlosstext ClairRematchLossText, 0
	loadtrainer CLAIR, CLAIR2 ; super boss team
	startbattle
	reloadmapafterbattle
	clearevent EVENT_BEAT_COOLTRAINERM_PAUL
	clearevent EVENT_BEAT_COOLTRAINERM_CODY
	clearevent EVENT_BEAT_COOLTRAINERM_MIKE
	clearevent EVENT_BEAT_COOLTRAINERF_FRAN
	clearevent EVENT_BEAT_COOLTRAINERF_LOLA
	appear BLACKTHORNGYM_POKE_BALL
	showthistext
		text "Clair: I wonder…"

		para "…Just how far you"
		line "can go with your"
		cont "skill…"
		done
	playsound SFX_WARP_TO
	special FadeOutPalettes
	waitsfx
	warp BLACKTHORN_GYM_1F, 4, 17
	end

ClairLossText:
	text "Ah… Yes you were."

	para "You deserve this"
	line "Badge."
	done

ClairRematchLossText:
    text "You're powerful."

	para "There is no"
	line "mistake…"
	done

TrainerCooltrainermPaul:
	trainer COOLTRAINERM, PAUL, EVENT_BEAT_COOLTRAINERM_PAUL, .SeenText, .BeatenText, 0, .Script

.Script:
	loadmem wNoRematch, 1
	endifjustbattled
	jumpthistextfaceplayer
		text "Not bad."
		done

.SeenText
	text "Your first battle"
	line "against dragons?"

	para "I'll show you how"
	line "tough they are!"
	done

.BeatenText
	text "My dragon #mon"
	line "lost?"
	done

TrainerCooltrainermMike:
	trainer COOLTRAINERM, MIKE, EVENT_BEAT_COOLTRAINERM_MIKE, .SeenText, .BeatenText, 0, .Script

.Script:
	loadmem wNoRematch, 1
	endifjustbattled
	jumpthistextfaceplayer
		text "I know my short-"
		line "comings now."

		para "Thanks for showing"
		line "me!"
		done

.SeenText
	text "My chance of"
	line "losing? Not even"
	cont "one percent!"
	done

.BeatenText
	text "That's odd."
	done

TrainerCooltrainerfLola:
	trainer COOLTRAINERF, LOLA, EVENT_BEAT_COOLTRAINERF_LOLA, .SeenText, .BeatenText, 0, .Script

.Script:
	loadmem wNoRematch, 1
	endifjustbattled
	jumpthistextfaceplayer
		text "Dragons are weak"
		line "against dragon-"
		cont "type moves."
		done

.SeenText
	text "Dragons are sacred"
	line "#mon."

	para "They are full of"
	line "life energy."

	para "If you're not"
	line "serious, you won't"
	cont "be able to beat"
	cont "them."
	done

.BeatenText
	text "Way to go!"
	done

BlackthornGymGuideScript:
	checkevent EVENT_PLAYER_IS_THE_POKEMON_LEAGUE_CHAMPION
	iftrue .BlackthornGymGuideChampScript
	checkevent EVENT_BEAT_CLAIR
	iftrue .BlackthornGymGuideWinScript
	jumpthistextfaceplayer
		text "Yo! Champ in"
		line "making!"

		para "It's been a long"
		line "journey, but we"
		cont "are almost done!"

		para "Count on me!"

		para "Clair uses the"
		line "mythical and sac-"
		cont "red dragon-type"
		cont "#mon."

		para "You can't damage"
		line "them very easily."

		para "Ice and Fairy #-"
		line "mon are useful"
		cont "against them."
		
		para "Dragon too but"
		line "that's a double"
		cont "edged sword."
		done

.BlackthornGymGuideWinScript:
	jumpthistextfaceplayer
		text "You were great to"
		line "beat Clair!"

		para "All that's left is"
		line "the #mon League"
		cont "challenge."

		para "You're on the way"
		line "to becoming the"
		cont "#mon Champion!"
		done

.BlackthornGymGuideChampScript:
	jumpthistextfaceplayer
		text "Champ, here to"
		line "catch up with"
		cont "Clair?"

		para "She'll be pleased"
		line "with your success."
		done

BlackthornGymStatue:
	checkflag ENGINE_RISINGBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, CLAIR, CLAIR1
	jumpstd GymStatue2Script

BlackthornGymRareCandyScript:
	disappear LAST_TALKED
	opentext
	giveitem RARE_CANDY, 7
	iffalse BlackthornGymPlayersPackIsFull
	jumpthisopenedtext
		text "<PLAYER> got"
		line "7× Rare Candies!@"
		sound_item
		text_end

BlackthornGymPlayersPackIsFull:
	appear BLACKTHORNGYM_POKE_BALL
	jumpthisopenedtext
		text "The Item Pocket"
		line "is full…"
		done
