GoldenrodNameRater_MapEvents:
	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 9
	warp_event  3,  7, GOLDENROD_CITY, 9

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT
	bg_event  1,  1, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT
	bg_event  7,  1, BGEVENT_JUMPSTD, RADIO2SCRIPT

	def_object_events
	object_event  5,  3, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_LEFT, 2, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodNameRater, -1
	object_event  2,  4, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, SwarmGrampsScript, -1
	object_event  2,  3, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_RIGHT, 2, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, MoveRelearnerScript, -1
	object_event  5,  4, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodNameRaterMoveDeleterScript, -1
	object_event  0,  5, SPRITE_FISHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, HelpGuyText, -1

	object_const_def
	const GOLDENRODNAMERATER_NAME_RATER
	const GOLDENRODNAMERATER_SWARM_GRAMPS
	const GOLDENRODNAMERATER_MOVE_RELEARNER
	const GOLDENRODNAMERATER_MOVE_DELETER
	const GOLDENRODNAMERATER_HELP_GUY

GoldenrodNameRater_MapScripts:
	def_scene_scripts

	def_callbacks

GoldenrodNameRater:
	faceplayeropentext
	special NameRater
	waitclosetext
	turnobject GOLDENRODNAMERATER_NAME_RATER, LEFT
	end

MoveRelearnerScript:
	faceplayeropentext
	special MoveRelearner
	waitclosetext
	turnobject GOLDENRODNAMERATER_MOVE_RELEARNER, RIGHT
	end

GoldenrodNameRaterMoveDeleterScript:
	faceplayeropentext
	special MoveDeletion
	waitclosetext
	turnobject GOLDENRODNAMERATER_MOVE_DELETER, LEFT
	end

HelpGuyText:
	text "Hi! We're your"
	line "one-stop #-"
	cont "solution!"
	
	para "The man wearing"
	line "the hat, changes"
	cont "nicknames."

	para "Next to him, he"
	line "deletes moves."
	
	para "The man above"
	line "gramps teaches"
	cont "forgotten moves…"
	cont "for a fee!"
	
	para "Gramps tells of"
	line "#mon swarms."
	
	para "And me? I'm here"
	line "to help too!"
	done

SwarmGrampsScript:
	faceplayeropentext
	checkflag ENGINE_SWARM
	iftrue .skiprandomswarm
	writethistext
		text "Let me see…"
		line "What did the news"
		cont "say?"
		done
	promptbutton
	random 8
	ifequal 0, .bulbasaur
	ifequal 1, .charmander
	ifequal 2, .squirtle
	ifequal 3, .chikorita
	ifequal 4, .cyndaquil
	ifequal 5, .totodile
	ifequal 6, .togepi
	ifequal 7, .ditto

.bulbasaur
	setflag ENGINE_SWARM
	swarm ROUTE_8
	writetext SwarmBulbasaurText
	sjump .WrappingUpSwarms

.charmander
	setflag ENGINE_SWARM
	swarm BURNED_TOWER_1F
	writetext SwarmCharmanderText
	sjump .WrappingUpSwarms

.squirtle
	setflag ENGINE_SWARM
	swarm ROUTE_15
	writetext SwarmSquirtleText
	sjump .WrappingUpSwarms

.chikorita
	setflag ENGINE_SWARM
	swarm ROUTE_9
	writetext SwarmChikoritaText
	sjump .WrappingUpSwarms

.cyndaquil
	setflag ENGINE_SWARM
	swarm ROUTE_11
	writetext SwarmCyndaquilText
	sjump .WrappingUpSwarms

.totodile
	setflag ENGINE_SWARM
	swarm ROUTE_14
	writetext SwarmTotodileText
	sjump .WrappingUpSwarms

.togepi
	setflag ENGINE_SWARM
	swarm ROUTE_6
	writetext SwarmTogepiText
	sjump .WrappingUpSwarms

.ditto
	setflag ENGINE_SWARM
	swarm ROUTE_7
	writetext SwarmDittoText
	sjump .WrappingUpSwarms

.skiprandomswarm
	writethistext
		text "You forgot which"
		line "#mon is swarm-"
		cont "ing?"
		
		para "Me too! I'm old."

		para "What I do remember"
		line "is there are 8"
		cont "#mon swarms and"
		cont "they change at"
		cont "midnight daily."

		para "You ought to visit"
		line "another day too."
		done
.WrappingUpSwarms:
	waitclosetext
	turnobject GOLDENRODNAMERATER_SWARM_GRAMPS, DOWN
	end

SwarmBulbasaurText:
	text "There's a swarm of"
	line "BULBASAUR at"
	cont "ROUTE 8!"
	done
	
SwarmCharmanderText:
	text "There's a swarm of"
	line "CHARMANDER in the"
	cont "BURNED TOWER!"
	done
	
SwarmSquirtleText:
	text "There's a swarm of"
	line "SQUIRTLE on"
	cont "ROUTE 15!"
	done

SwarmChikoritaText:
	text "There's a swarm of"
	line "CHIKORITA on"
	cont "ROUTE 37!"
	done

SwarmCyndaquilText:
	text "There's a swarm of"
	line "CYNDAQUIL on"
	cont "ROUTE 11!"
	done

SwarmTotodileText:
	text "There's a swarm of"
	line "TOTODILE on"
	cont "ROUTE 14!"
	done

SwarmPichuText:
	text "There's a swarm of"
	line "PICHU on"
	cont "ROUTE 3!"
	done

SwarmCleffaText:
	text "There's a swarm of"
	line "CLEFFA in the"
	cont "SLOWPOKE WELL!"
	done

SwarmIgglybuffText:
	text "There's a swarm of"
	line "IGGLYBUFF on"
	cont "ROUTE 46!"
	done

SwarmTogepiText:
	text "There's a swarm of"
	line "TOGEPI on"
	cont "ROUTE 6!"
	done

SwarmTyrogueText:
	text "There's a swarm of"
	line "TYROGUE in the"
	cont "UNION CAVE!"
	done

SwarmDittoText:
	text "There's a swarm of"
	line "DITTO on"
	cont "ROUTE 7!"
	done
