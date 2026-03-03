EarlsPokemonAcademy_MapEvents:
	def_warp_events
	warp_event  3, 15, VIOLET_CITY, 4
	warp_event  4, 15, VIOLET_CITY, 4

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT
	bg_event  1,  1, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT
	bg_event  3,  0, BGEVENT_READ, AcademyBlackboard
	bg_event  4,  0, BGEVENT_READ, AcademyBlackboard

	def_object_events
	object_event  4,  2, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, AcademyEarl, -1
	object_event  2,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, EarlsPokemonAcademyYoungster1Text, -1
	object_event  4,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, EarlsPokemonAcademyYoungster2Text, -1
	object_event  3, 11, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EarlsPokemonAcademyGameboyKid1Script, -1
	object_event  4, 11, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EarlsPokemonAcademyGameboyKid2Script, -1
	object_event  4, 10, SPRITE_POKEDEX, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AcademyNotebook, -1
	object_event  3, 10, SPRITE_POKEDEX, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MoveEnchancingAbilitiesNotebook, -1
	object_event  2, 10, SPRITE_POKEDEX, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FleeMonsNotebook, -1
	object_event  6, 13, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_TEAL, OBJECTTYPE_SCRIPT, 0, EarlsPokemonAcademyYoungsterHardModeScript, -1

	object_const_def
	const EARLSPOKEMONACADEMY_EARL
	const EARLSPOKEMONACADEMY_YOUNGSTER1
	const EARLSPOKEMONACADEMY_YOUNGSTER2
	const EARLSPOKEMONACADEMY_GAMEBOY_KID1
	const EARLSPOKEMONACADEMY_GAMEBOY_KID2
	const EARLSPOKEMONACADEMY_POKEDEX1
	const EARLSPOKEMONACADEMY_POKEDEX2
	const EARLSPOKEMONACADEMY_POKEDEX3
	const EARLSPOKEMONACADEMY_YOUNGSTER3

EarlsPokemonAcademy_MapScripts:
	def_scene_scripts

	def_callbacks

AcademyEarl:
	applymovement EARLSPOKEMONACADEMY_EARL, AcademyEarlSpinMovement
	faceplayer
	opentext
	writetext AcademyEarlIntroText
	yesorno
	iffalse .Part1
	writetext AcademyEarlTeachHowToWinText
	yesorno
	iffalse .Done
.Part1:
	writetext AcademyEarlTeachMoreText
	yesorno
	iffalse .Done
	writetext AcademyEarlTeachHowToRaiseWellText
	waitbutton
	closetext
	end

.Done:
	writetext AcademyEarlNoMoreToTeachText
	waitbutton
	closetext
	end

AcademyNotebook:
	opentext
	writetext AcademyNotebookText
	yesorno
	iffalse .Done
	writetext AcademyNotebookText1
	yesorno
	iffalse .Done
	writetext AcademyNotebookText2
	yesorno
	iffalse .Done
	writetext AcademyNotebookText3
	waitbutton
.Done:
	closetext
	end

AcademyEarlSpinMovement:
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	step_end

AcademyEarlIntroText:
	text "EARL, I am!"

	para "Wonderful are"
	line "#MON, yes!"

	para "Teach you I will"
	line "to be a better"
	cont "trainer!"

	para "What you want to"
	line "know? Want to be"
	cont "a winner is you?"
	done

AcademyEarlTeachHowToWinText:
	text "Good! Teach you,"
	line "I will!"

	para "In battle, #MON"
	line "top on list jump"
	cont "out first!"

	para "Change order in"
	line "list, make battle"
	cont "easy, maybe!"

	para "More from me you"
	line "want to hear?"
	done

AcademyEarlTeachMoreText:
	text "So, want to know"
	line "how to raise"
	cont "#MON well?"
	done

AcademyEarlTeachHowToRaiseWellText:
	text "Fine! Teach you,"
	line "I will!"

	para "If #MON come"
	line "out in battle even"

	para "briefly, some EXP."
	line "Points it gets."

	para "At top of list put"
	line "weak #MON."

	para "Switch in battle"
	line "quick!"

	para "This way, weak"
	line "#MON strong"
	cont "become!"
	done

AcademyEarlNoMoreToTeachText:
	text "Oh! Smart student"
	line "you are! Nothing"
	cont "more do I teach!"

	para "Good to #MON"
	line "you must be!"
	done

AcademyNotebookText:
	text "It's this kid's"
	line "notebook…"

	para "Catch #MON"
	line "using # BALLS."

	para "Up to six can be"
	line "in your party."

	para "Keep reading?"
	done

AcademyNotebookText1:
	text "Before throwing a"
	line "# BALL, weaken"
	cont "the target first."

	para "A poisoned or"
	line "burned #MON is"
	cont "easier to catch."

	para "Keep reading?"
	done

AcademyNotebookText2:
	text "Some moves may"
	line "cause confusion."

	para "Confusion may make"
	line "a #MON attack"
	cont "itself."

	para "Leaving battle"
	line "clears up any"
	cont "confusion."

	para "Keep reading?"
	done

AcademyNotebookText3:
	text "People who catch"
	line "and use #MON"

	para "in battle are"
	line "#MON trainers."

	para "They are expected"
	line "to visit #MON"

	para "GYMS and defeat"
	line "other trainers."

	para "The next page"
	line "is… Blank!"

	para "Boy: E-he-he…"

	para "I haven't written"
	line "anymore…"
	done

EarlsPokemonAcademyYoungsterHardModeScript:
	jumptextfaceplayer EarlsPokemonAcademyYoungsterHardModeText

EarlsPokemonAcademyYoungsterHardModeText:
	text "Have you tried out"
	line "Hard Mode in your"
	cont "Options menu?"

	para "It ups all enemy"
	line "trainer's attack"
	cont "and defense stats"
	cont "by 20<%>!"

	para "It doesn't effect"
	line "their hit points."
	
	para "An unforgiving but"
	line "worthy challenge!"
	done

MoveEnchancingAbilitiesNotebook:
	opentext
	writetext MoveEnchancingAbilitiesText
	yesorno
	iffalse .Done
.list:
	loadmenu .MoveEnchancingAbilitiesHeader
	verticalmenu
	closewindow
	ifequal 1, .BallisticsMoves
	ifequal 2, .PunchingMoves
	ifequal 3, .SharpnessMoves
	ifequal 4, .StrongJawMoves
.Done:
	closetext
	end

.MoveEnchancingAbilitiesHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 19, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
	db 5 ; items
	db "Ballistics Moves@"
	db "Punching Moves@"
	db "Sharpness Moves@"
	db "Strong Jaw Moves@"
	db "Cancel@"

.BallisticsMoves
	writetext BallisticsMovesText
	sjump .list

.PunchingMoves
	writetext PunchingMovesText
	sjump .list

.SharpnessMoves
	writetext SharpnessMovesText
	sjump .list

.StrongJawMoves
	writetext StrongJawMovesText
	sjump .list

MoveEnchancingAbilitiesText:
	text "It's about move"
	line "buffing abilities."

	para "These moves aren't"
	line "boosted if they're"
	cont "already the same"
	cont "type as the user."

	para "Want to read more?"
	done

PunchingMovesText:
	text "It's a list of all"
	line "Punching Moves!"

	para "In alphabetical"
	line "order, it goes:"

	para "Bullet Punch,"
	line "Drain Punch,"
	cont "Fire Punch,"
	cont "Ice Punch,"
	cont "Mach Punch,"
	cont "Meteor Mash,"
	cont "Shadow Punch and"
	cont "Thunder Punch."
	done

SharpnessMovesText:
	text "It's a list of all"
	line "Sharpness Moves!"

	para "In alphabetical"
	line "order, it goes:"

	para "Cross Chop, Cut,"
	line "Dragon Claw,"
	cont "Leaf Blade,"
	cont "Night Slash,"
	cont "Psycho Cut, Slash,"
	cont "Throat Chop and"
	cont "X-Scissor."
	done

BallisticsMovesText:
	text "It's a list of all"
	line "Ballistics Moves!"

	para "They are all guns,"
	line "blast and beams."

	para "In alphabetical"
	line "order, it goes:"

	para "Aurora Beam,"
	line "Bubblebeam,"
	cont "Fire Blast,"
	cont "Flash Cannon,"
	cont "Gunk Shot,"
	cont "Hyper Beam"
	cont "Ice Beam,"
	cont "Psybeam,"
	cont "Rock Blast,"
	cont "Signal Beam,"
	cont "Sludge Bomb and"
	cont "Water Gun."
	done

StrongJawMovesText:
	text "It's a list of all"
	line "Strong Jaw Moves!"

	para "In alphabetical"
	line "order, it goes:"

	para "Bite,"
	line "Crunch,"
	cont "Fire Fang,"
	cont "Ice Fang and"
	cont "Thunder Fang."
	done

FleeMonsNotebook:
	opentext
	writetext FleeMonsNotebookText
	yesorno
	iffalse .done
	writetext ListofAllFleeMonsText
	waitbutton
.done
	closetext
	end

FleeMonsNotebookText:
	text "It's a list of all"
	line "wild #mon that"
	cont "have a 30<%> chance"
	cont "to flee each turn."

	para "Trapping moves or"
	line "abilities or if"
	cont "asleep will bar"
	cont "escape."

	para "They all appear"
	line "in swarms."

	para "Read the list?"
	done

ListofAllFleeMonsText:
	text "In alphabetical"
	line "order, they are:"

	para "Bagon,"
	line "Charmander,"
	cont "Chikorita"
	cont "Clefairy,"
	cont "Cyndaquil,"
	cont "Delibird,"
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
	cont "Smoochum,"
	cont "Snubbull,"
	cont "Squirtle,"
	cont "Teddiursa,"
	cont "Togepi,"
	cont "Torchic,"
	cont "Totodile and"
	cont "Turtwig."
	done

EarlsPokemonAcademyGameboyKid1Script:
	faceplayeropentext
	writethistext
		text "I'm battling my pal"
		line "here."
	
		para "He's not going to"
		line "see this strategy!"
		done
	waitclosetext
	turnobject EARLSPOKEMONACADEMY_GAMEBOY_KID1, DOWN
	end

EarlsPokemonAcademyGameboyKid2Script:
	faceplayeropentext
	writethistext
		text "Bro here is play-"
		line "ing Checkers while"
		cont "I'm playing Chess!"
		done
	waitclosetext
	turnobject EARLSPOKEMONACADEMY_GAMEBOY_KID2, DOWN
	end

EarlsPokemonAcademyYoungster2Text:
	text "A #mon holding"
	line "a Berry will heal"
	cont "itself in battle."

	para "Many other items"
	line "can be held by"
	cont "#mon…"

	para "It sure is tough"
	line "taking notes…"
	done

EarlsPokemonAcademyYoungster1Text:
	text "I'm taking notes"
	line "of the teacher's"
	cont "lecture."

	para "I'd better copy"
	line "the stuff on the"
	cont "blackboard too."
	done

AcademyBlackboard:
	opentext
	writethistext
		text "The blackboard"
		line "describes #mon"
		cont "status changes in"
		cont "battle."
		done
.Loop:
	loadmenu .BlackboardMenuHeader
	_2dmenu
	closewindow
	ifequal 1, .Poison
	ifequal 2, .Paralysis
	ifequal 3, .Sleep
	ifequal 4, .Burn
	ifequal 5, .Frostbite
	endtext

.Poison:
	writethistext
		text "If poisoned, a"
		line "#mon looses 1/8"
		cont "of their Max HP at"
		cont "the of each turn"
		cont "unless they knock-"
		cont "out their foe."

		para "TOX is a stronger"
		line "version of Poison."

		para "#mon loose 1/16"
		line "of Max HP first"
		cont "turn and then it"
		cont "doubles each turn"
		cont "after."

		para "Switching #mon"
		line "changes it to PSN."

		para "Poison lingers"
		line "after the battle,"
		cont "and HP is lost as"
		cont "you walk."

		para "To cure it, use an"
		line "Antidote."
		done
	waitbutton
	sjump .Loop

.Paralysis:
	writethistext
		text "Paralysis quarters"
		line "speed."

		para "It also has a 50<%>"
		line "chance to prevent"
		cont "acting each turn."

		para "It remains after"
		line "battle, so use"
		cont "a Parlyz Heal."
		done
	waitbutton
	sjump .Loop

.Sleep:
	writethistext
		text "If asleep, your"
		line "#mon can't make"
		cont "a move."

		para "Sleep lasts 1 to 3"
		line "turns."

		para "A sleeping #mon"
		line "doesn't wake up"
		cont "after battle."

		para "Wake it up with"
		line "an Awakening."
		done
	waitbutton
	sjump .Loop

.Burn:
	writethistext
		text "A burn steadily"
		line "consumes 1/8 Max"
		cont "HP at the end of"
		cont "each turn provided"
		cont "the foe doesn't"
		cont "get knocked out."

		para "It also halves"
		line "attack power."

		para "A burn lingers"
		line "after battle."

		para "Use a Burn Heal as"
		line "the cure."
		done
	waitbutton
	sjump .Loop

.Frostbite:
	writethistext
		text "If your #mon is"
		line "frostbitten, it'll"
		cont "loose 1/8 of their"
		cont "Max HP at the end"
		cont "of each turn if"
		cont "their foe doesn't"
		cont "get knocked out."

		para "Its Spcl.Atk will"
		line "also be halved."

		para "Thaw it out with"
		line "an Ice Heal."
		done
	waitbutton
	sjump .Loop

.BlackboardMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 11, 8
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
	dn 3, 2 ; rows, columns
	db 5 ; spacing
	dba .Text
	dbw BANK(@), NULL

.Text:
	db "PSN@"
	db "PAR@"
	db "SLP@"
	db "BRN@"
	db "FRB@"
	db "QUIT@"
