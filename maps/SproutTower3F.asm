SproutTower3F_MapEvents:
	def_warp_events
	warp_event 10, 14, SPROUT_TOWER_2F, 4

	def_coord_events

	def_bg_events
	bg_event  8,  1, BGEVENT_JUMPTEXT, SproutTowerStatueText
	bg_event 11,  1, BGEVENT_JUMPTEXT, SproutTowerStatueText
	bg_event  9,  0, BGEVENT_JUMPTEXT, SproutTower3FPaintingText
	bg_event 10,  0, BGEVENT_JUMPTEXT, SproutTower3FPaintingText
	bg_event  5, 15, BGEVENT_JUMPTEXT, SproutTowerStatueText
	bg_event 14, 15, BGEVENT_JUMPTEXT, SproutTowerStatueText

	def_object_events
	chanseyheal_event 14,  1
	object_event  8, 13, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 3, TrainerSageJin, -1
	object_event  8,  8, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 2, TrainerSageTroy, -1
	object_event 10,  2, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SageLiScript, -1
	object_event 11, 11, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 3, TrainerSageNeal, -1
	object_event  6, 14, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SproutTower3FPotion, EVENT_SPROUT_TOWER_3F_POTION
	object_event  6,  1, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SproutTower3FEscapeRope, EVENT_SPROUT_TOWER_3F_ESCAPE_ROPE

	object_const_def
	const SPROUTTOWER3F_CHANSEY
	const SPROUTTOWER3F_SAGE1
	const SPROUTTOWER3F_SAGE2
	const SPROUTTOWER3F_SAGE3
	const SPROUTTOWER3F_SAGE4
	const SPROUTTOWER3F_POKE_BALL1
	const SPROUTTOWER3F_POKE_BALL2
	const SPROUTTOWER3F_RIVAL


SproutTower3F_MapScripts:
	def_scene_scripts

	def_callbacks

SageLiScript:
	faceplayeropentext
	checkevent EVENT_GOT_MAREEP_CALL
	iftrue .GotMareepCall
	writethistext
		text "So good of you to"
		line "come here!"

		para "Sprout Tower is a"
		line "place of training."

		para "People and #mon"
		line "test their bonds"
		cont "to build a bright"
		cont "future together."

		para "I am the final"
		line "test."

		para "Allow me to check"
		line "the ties between"
		cont "your #mon and"
		cont "you!"
		done
	waitclosetext
	winlosstext SageLiBeatenText, 0
	loadtrainer SAGE, LI
	startbattle
	reloadmapafterbattle
	opentext
	writethistext
		text "You and your #-"
		line "mon should have"
		cont "no problem using"
		cont "this Call."
		done
	promptbutton
	verbosegiveitem MAREEP_CALL
	setevent EVENT_GOT_MAREEP_CALL
	jumpthisopenedtext
		text "Mareep Call lights"
		line "up even the dark-"
		cont "est of all places."
		
		para "Simply press A in"
		line "any dark area to"
		cont "use."
		
		para "You may be wonder-"
		line "ing why not a"
		cont "Bellsprout Call?"
		
		para "Bellsprout needs"
		line "light while Mareep"
		cont "provides it."
		done

.GotMareepCall:
	writethistext
		text "I hope you learn"
		line "and grow from your"
		cont "journey."

		para "Up for a rematch?"
		done
	yesorno
	iffalse_endtext
	closetext
	winlosstext SageLiBeatenText, 0
	loadtrainer SAGE, LI
	startbattle
	reloadmapafterbattle
	end

SageLiBeatenText:
	text "Ah, excellent!"
	done

TrainerSageJin:
	generictrainer SAGE, JIN, EVENT_BEAT_SAGE_JIN, .SeenText, .BeatenText

.AfterText
	text "As #mon grow"
	line "stronger, so does"
	cont "the trainer."

	para "No, wait. As the"
	line "trainer grows"
	cont "stronger, so do"
	cont "the #mon."
	done

.SeenText
	text "I train to find"
	line "enlightenment in"
	cont "#mon!"
	done

.BeatenText
	text "My training is"
	line "incomplete…"
	done

TrainerSageTroy:
	generictrainer SAGE, TROY, EVENT_BEAT_SAGE_TROY, .SeenText, .BeatenText

.AfterText
	text "Walk the path"
	line "ahead."
	done

.SeenText
	text "Let me see how"
	line "much you trust"
	cont "your #mon."
	done

.BeatenText
	text "Yes, your trust is"
	line "real!"
	done

TrainerSageNeal:
	generictrainer SAGE, NEAL, EVENT_BEAT_SAGE_NEAL, .SeenText, .BeatenText

.AfterText
	text "Let there be light"
	line "on your journey."
	done

.SeenText
	text "The elder's Call"
	line "lights even pitch-"
	cont "black darkness."
	done

.BeatenText
	text "It is my head that"
	line "is bright!"
	done

SproutTower3FPaintingText:
	text "It's a powerful"
	line "painting of a"
	cont "Bellsprout."
	done

SproutTower3FPotion:
	itemball POTION
SproutTower3FEscapeRope:
	itemball ESCAPE_ROPE
