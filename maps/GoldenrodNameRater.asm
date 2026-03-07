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
	object_event  3,  4, SPRITE_POKEDEX, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodNameRaterSwarmPokemonBook, -1

	object_const_def
	const GOLDENRODNAMERATER_NAME_RATER
	const GOLDENRODNAMERATER_SWARM_GRAMPS
	const GOLDENRODNAMERATER_MOVE_RELEARNER
	const GOLDENRODNAMERATER_MOVE_DELETER
	const GOLDENRODNAMERATER_HELP_GUY
	const GOLDENRODNAMERATER_SWARMBOOK

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
	random 27
.resample:
	ifequal  0, .Bagon
	ifequal  1, .Bellsprout
	ifequal  2, .Charmander
	ifequal  3, .Chikorita
	ifequal  4, .Clefairy
	ifequal  5, .Cyndaquil
	ifequal  6, .Delibird
	ifequal  7, .Ditto
	ifequal  8, .Eevee
	ifequal  9, .Elekid
	ifequal 10, .Feebas
	ifequal 11, .Houndour
	ifequal 12, .Larvitar
	ifequal 13, .Meowth
	ifequal 14, .Phanpy
	ifequal 15, .Ralts
	ifequal 16, .Riolu
	ifequal 17, .Rowlet
	ifequal 18, .Shroomish
	ifequal 19, .Smoochum
	ifequal 20, .Snubbull
	ifequal 21, .Squirtle
	ifequal 22, .Teddiursa
	ifequal 23, .Togepi
	ifequal 24, .Torchic
	ifequal 25, .Totodile
	ifequal 26, .Turtwig
	sjump .resample

.Bagon:
	setflag ENGINE_SWARM
	swarm DRAGONS_DEN_B1F
	jumpthisopenedtext
		text "There's a swarm of"
		line "Bagon at"
		cont "Dragon's Den B1!"
		done

.Bellsprout:
	setflag ENGINE_SWARM
	swarm ROUTE_3
	jumpthisopenedtext
		text "There's a swarm of"
		line "Bellsprout at"
		cont "Route 3!"
		done

.Charmander:
	setflag ENGINE_SWARM
	swarm BURNED_TOWER_1F
	jumpthisopenedtext
		text "There's a swarm of"
		line "Charmander at"
		cont "Burned Tower 1F!"
		done

.Chikorita:
	setflag ENGINE_SWARM
	swarm ROUTE_9
	jumpthisopenedtext
		text "There's a swarm of"
		line "Chikorita at"
		cont "Route 9!"
		done

.Clefairy:
	setflag ENGINE_SWARM
	swarm MOUNT_MORTAR_1F_OUTSIDE
	jumpthisopenedtext
		text "There's a swarm of"
		line "Clefairy at"
		cont "Mt.Mortar Outside!"
		done

.Cyndaquil:
	setflag ENGINE_SWARM
	swarm ROUTE_11
	jumpthisopenedtext
		text "There's a swarm of"
		line "Cyndaquil at"
		cont "Route 11!"
		done

.Delibird:
	setflag ENGINE_SWARM
	swarm ICE_PATH_1F
	jumpthisopenedtext
		text "There's a swarm of"
		line "Delibird at"
		cont "Ice Path 1F!"
		done

.Ditto:
	setflag ENGINE_SWARM
	swarm ROUTE_7
	jumpthisopenedtext
		text "There's a swarm of"
		line "Ditto at"
		cont "Route 7!"
		done

.Eevee:
	setflag ENGINE_SWARM
	swarm RUINS_OF_ALPH_OUTSIDE
	jumpthisopenedtext
		text "There's a swarm of"
		line "Eevee at"
		cont "Ruins of Alph!"
		done

.Elekid:
	setflag ENGINE_SWARM
	swarm POWER_PLANT_OUTSIDE
	jumpthisopenedtext
		text "There's a swarm of"
		line "Elekid at Power"
		cont "Plant Outside!"
		done

.Feebas:
	setflag ENGINE_SWARM
	swarm LAKE_OF_RAGE
	jumpthisopenedtext
		text "There's a swarm of"
		line "Feebas in the"
		cont "Lake of Rage!"
		done

.Houndour:
	setflag ENGINE_SWARM
	swarm ROUTE_8
	jumpthisopenedtext
		text "There's a swarm of"
		line "Houndour at"
		cont "Route 8!"
		done

.Larvitar:
	setflag ENGINE_SWARM
	swarm VICTORY_ROAD
	jumpthisopenedtext
		text "There's a swarm of"
		line "Larvitar at"
		cont "Victory Road!"
		done

.Meowth:
	setflag ENGINE_SWARM
	swarm ROUTE_6
	jumpthisopenedtext
		text "There's a swarm of"
		line "Meowth at"
		cont "Route 6!"
		done

.Phanpy:
	setflag ENGINE_SWARM
	swarm ROUTE_18
	jumpthisopenedtext
		text "There's a swarm of"
		line "Phanpy at"
		cont "Route 18!"
		done

.Ralts:
	setflag ENGINE_SWARM
	swarm ROUTE_1
	jumpthisopenedtext
		text "There's a swarm of"
		line "Ralts at"
		cont "Route 1!"
		done

.Riolu:
	setflag ENGINE_SWARM
	swarm UNION_CAVE_1F
	jumpthisopenedtext
		text "There's a swarm of"
		line "Riolu at"
		cont "Union Cave 1F!"
		done

.Rowlet:
	setflag ENGINE_SWARM
	swarm ROUTE_2
	jumpthisopenedtext
		text "There's a swarm of"
		line "Rowlet at"
		cont "Route 2!"
		done

.Shroomish:
	setflag ENGINE_SWARM
	swarm ILEX_FOREST
	jumpthisopenedtext
		text "There's a swarm of"
		line "Shroomish at"
		cont "Ilex Forest!"
		done

.Smoochum:
	setflag ENGINE_SWARM
	swarm ICE_PATH_B3F
	jumpthisopenedtext
		text "There's a swarm of"
		line "Smoochum at"
		cont "Ice Path B3F!"
		done

.Snubbull:
	setflag ENGINE_SWARM
	swarm NATIONAL_PARK
	jumpthisopenedtext
		text "There's a swarm of"
		line "Snubbull at"
		cont "National Park!"
		done

.Squirtle:
	setflag ENGINE_SWARM
	swarm ROUTE_15
	jumpthisopenedtext
		text "There's a swarm of"
		line "Squirtle at"
		cont "Route 15!"
		done

.Teddiursa:
	setflag ENGINE_SWARM
	swarm DARK_CAVE_VIOLET_ENTRANCE
	jumpthisopenedtext
		text "There's a swarm of"
		line "Teddiursa in"
		cont "Dark Cave, West!"
		done

.Togepi:
	setflag ENGINE_SWARM
	swarm SILVER_CAVE_OUTSIDE
	jumpthisopenedtext
		text "There's a swarm of"
		line "Togepi at Mt."
		cont "Silver Outside!"
		done

.Torchic:
	setflag ENGINE_SWARM
	swarm ROUTE_10
	jumpthisopenedtext
		text "There's a swarm of"
		line "Torchic at"
		cont "Route 10!"
		done

.Totodile:
	setflag ENGINE_SWARM
	swarm ROUTE_14
	jumpthisopenedtext
		text "There's a swarm of"
		line "Totodile at"
		cont "Route 14!"
		done

.Turtwig:
	setflag ENGINE_SWARM
	swarm ROUTE_17
	jumpthisopenedtext
		text "There's a swarm of"
		line "Turtwig at"
		cont "Route 17!"
		done


.skiprandomswarm
	jumpthisopenedtext
		text "You forgot which"
		line "#mon is swarm-"
		cont "ing?"
		
		para "Me too! I'm old."

		para "What I do remember"
		line "is there are 26"
		cont "#mon swarms and"
		cont "they change at"
		cont "midnight daily."

		para "You ought to visit"
		line "another day too."
		done

GoldenrodNameRaterSwarmPokemonBook:
	opentext
	writethistext
		text "It's a list of all"
		line "wild #mon that"
		cont "appear in swarms."

		para "Aside from Ditto,"
		line "Bellsprout and"
		cont "Shroomish, they"
		cont "all have a 30<%>"
		cont "chance to flee"
		cont "each turn."
	
		para "Read the list?"
		done
	yesorno
	iffalse_endtext
	jumpthisopenedtext
		text "In alphabetical"
		line "order, they are:"

		para "Bagon,"
		line "Bellsprout,"
		cont "Charmander,"
		cont "Chikorita"
		cont "Clefairy,"
		cont "Cyndaquil,"
		cont "Delibird,"
		cont "Ditto,"
		cont "Eevee,"
		cont "Elekid,"
		cont "Feebas,"
		cont "Houndour,"
		cont "Larvitar,"
		cont "Meowth,"
		cont "Phanpy,"
		cont "Ralts,"
		cont "Riolu,"
		cont "Rowlet,"
		cont "Shroomish,"
		cont "Smoochum,"
		cont "Snubbull,"
		cont "Squirtle,"
		cont "Teddiursa,"
		cont "Togepi,"
		cont "Torchic,"
		cont "Totodile and"
		cont "Turtwig."
		done
