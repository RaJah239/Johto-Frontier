MoveDeletersHouse_MapEvents:
	def_warp_events
	warp_event  2,  7, BLACKTHORN_CITY, 6
	warp_event  3,  7, BLACKTHORN_CITY, 6

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT
	bg_event  1,  1, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT

	def_object_events
	object_event  2,  2, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MoveDeleter, -1
	object_event  2,  4, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, EggTutorScript, -1
	object_event  5,  4, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BlackthornTutor1Script, -1

	object_const_def
	const MOVEDELETERSHOUSE_SUPER_NERD
	const MOVEDELETERSHOUSE_EGG_TUTOR
	const MOVEDELETERSHOUSE_OFFENSE_TUTOR

MoveDeletersHouse_MapScripts:
	def_scene_scripts

	def_callbacks

MoveDeleter:
	faceplayeropentext
	special MoveDeletion
	waitclosetext
	turnobject MOVEDELETERSHOUSE_SUPER_NERD, UP
	end

EggTutorScript:
	faceplayeropentext
	checkevent EVENT_MET_EGG_TUTOR
	iftrue .WantToTeachAnEggMove
	writethistext
	    text "I'm the one and"
	    line "only Egg Tutor!"

	    para "I can teach your"
	    line "#MON moves that"
	    cont "they'd normally"
	    cont "need crossbreeding"
	    cont "to inherit."

	    para "My service fee is"
	    line "¥500,000."

	    para "How about it?"
	    done
	setevent EVENT_MET_EGG_TUTOR
	sjump .WantToTeachAnEggMoveAfterIntro

.WantToTeachAnEggMove:
	writethistext
		text "Hi again! Want me"
		line "me to teach your"

		para "#mon an Egg"
		line "move for ¥500,000?"
		done
.WantToTeachAnEggMoveAfterIntro:
	special EggMaster
	waitclosetext
	turnobject MOVEDELETERSHOUSE_EGG_TUTOR, RIGHT
	end

BlackthornTutor1Script:
	faceplayeropentext
	writethistext
		text "Hello. I am a"
		line "Move Tutor."
		
		para "For 9,999 coins,"
		line "I'll teach your"
		cont "#MON some very"
		cont "powerful attacks!"
		
		para "Interested?"
		done 
	special DisplayCoinCaseBalance
	yesorno
	iffalse .Refused
	checkcoins 9999
	ifequal HAVE_LESS, .NotEnoughMoney
	writethistext
		text "Which move should"
		line "I teach?"
		done
	loadmenu .MoveMenuHeader
	verticalmenu
	closewindow
	ifequal 1, .RockSlide
	ifequal 2, .SkyAttack
	ifequal 3, .Outrage
.Cancel:
	writethistext
		text "Maybe next time?"
		done
	waitclosetext
	turnobject MOVEDELETERSHOUSE_OFFENSE_TUTOR, LEFT
	end

.RockSlide:
	setval ROCK_SLIDE
	writetext BlackthornTutorMoveText
	special MoveTutor
	ifequal FALSE, .TeachMove
	sjump .Cancel

.SkyAttack:
	setval SKY_ATTACK
	writetext BlackthornTutorMoveText
	special MoveTutor
	ifequal FALSE, .TeachMove
	sjump .Cancel

.Outrage:
	setval OUTRAGE 
	writetext BlackthornTutorMoveText
	special MoveTutor
	ifequal FALSE, .TeachMove
	sjump .Cancel

.Refused:
	writethistext
		text "Come again if you"
		line "change your mind."
		done
	waitclosetext
	turnobject MOVEDELETERSHOUSE_OFFENSE_TUTOR, LEFT
	end
	
.NotEnoughMoney:
	writethistext
		text "You don't have"
		line "enough coins…"
		done
	waitclosetext
	turnobject MOVEDELETERSHOUSE_OFFENSE_TUTOR, LEFT
	end

.TeachMove:
	special DisplayCoinCaseBalance
	playsound SFX_TRANSACTION
	takecoins 9999
	special DisplayCoinCaseBalance
	writethistext
		text "Come visit as much"
		line "as you want."
		done
	waitclosetext
	turnobject MOVEDELETERSHOUSE_OFFENSE_TUTOR, LEFT
	end 
	
.MoveMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 2, 15, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
	db 4 ; items
	db "Rock Slide@"
	db "Sky Attack@"
	db "Outrage@"
	db "Cancel@"
	
BlackthornTutorMoveText:
	text_start
	done
