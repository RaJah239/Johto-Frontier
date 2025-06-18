	object_const_def
	const MOVEDELETERSHOUSE_SUPER_NERD
	const MOVEDELETERSHOUSE_EGG_TUTOR
	const MOVEDELETERSHOUSE_OFFENSE_TUTOR

MoveDeletersHouse_MapScripts:
	def_scene_scripts

	def_callbacks

MoveDeleter:
	faceplayer
	opentext
	special MoveDeletion
	waitbutton
	closetext
	end

EggTutorScript:
	faceplayer
	opentext
	checkevent EVENT_MET_EGG_TUTOR
	iftrue .WantToTeachAnEggMove
	writetext EggTutorIntroText
	setevent EVENT_MET_EGG_TUTOR
	sjump .WantToTeachAnEggMoveAfterIntro

.WantToTeachAnEggMove:
	writetext EggTutorMoneyForEggMoveText
.WantToTeachAnEggMoveAfterIntro:
	special EggMaster
	waitbutton
	closetext
	turnobject MOVEDELETERSHOUSE_EGG_TUTOR, RIGHT
	end

EggTutorIntroText:
    text "I'm the one and"
    line "only EGG TUTOR!"

    para "I can teach your"
    line "#MON moves that"

    para "they'd normally"
    line "need crossbreeding"
    cont "to inherit."

    para "My service fee is"
    line "¥500,000."

    para "How about it?"
    done

EggTutorMoneyForEggMoveText:
	text "Hi again! Want me"
	line "me to teach your"

	para "#MON an EGG"
	line "move for ¥500,000?"
	done

BlackthornTutor1Script:
	faceplayer
	opentext
	writetext BlackthornMoveTutor1IntroText
	special DisplayCoinCaseBalance
	yesorno
	iffalse .Refused
	checkcoins 9999
	ifequal HAVE_LESS, .NotEnoughMoney
	writetext BlackThornMoveTutor1WhatMoveShouldITeachText
	loadmenu .MoveMenuHeader
	verticalmenu
	closewindow
	ifequal 1, .RockSlide
	ifequal 2, .SkyAttack
	ifequal 3, .Outrage
.Cancel:
	writetext BlackThornMoveTutor1CancelText
	waitbutton
	closetext
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
	writetext BlackThornMoveTutor1ComeAgainText
	waitbutton
	closetext
	turnobject MOVEDELETERSHOUSE_OFFENSE_TUTOR, LEFT
	end
	
.NotEnoughMoney:
	writetext BlackthornMoveTutor1YouDontHaveEnoughMoneyText
	waitbutton
	closetext
	turnobject MOVEDELETERSHOUSE_OFFENSE_TUTOR, LEFT
	end

.TeachMove:
	special DisplayCoinCaseBalance
	playsound SFX_TRANSACTION
	takecoins 9999
	special DisplayCoinCaseBalance
	writetext BlackThornMoveTutor1ThankYouText
	waitbutton
	closetext
	turnobject MOVEDELETERSHOUSE_OFFENSE_TUTOR, LEFT
	end 
	
.MoveMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 2, 15, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 4 ; items
	db "ROCK SLIDE@"
	db "SKY ATTACK@"
	db "OUTRAGE@"
	db "CANCEL@"
	
BlackthornMoveTutor1IntroText:
	text "Hello. I am a"
	line "MOVE TUTOR."
	
	para "For 9,999 coins,"
	line "I'll teach your"

	para "#MON some very"
	line "powerful attacks!"
	
	para "Interested?"
	done 

BlackThornMoveTutor1ComeAgainText:
	text "Come again if you"
	line "change your mind."
	done

BlackThornMoveTutor1WhatMoveShouldITeachText:
	text "Which move should"
	line "I teach?"
	done

BlackThornMoveTutor1ThankYouText:
	text "Come visit as much"
	line "as you want."
	done 

BlackThornMoveTutor1CancelText:
	text "Maybe next time?"
	done 
	
BlackthornMoveTutor1YouDontHaveEnoughMoneyText:
	text "You don't have"
	line "enough coins…"
	done

BlackthornTutorMoveText:
	text_start
	done

MoveDeletersHouseBookshelf:
	jumpstd DifficultBookshelfScript

MoveDeletersHouse_MapEvents:
	def_warp_events
	warp_event  2,  7, BLACKTHORN_CITY, 6
	warp_event  3,  7, BLACKTHORN_CITY, 6

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, MoveDeletersHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, MoveDeletersHouseBookshelf

	def_object_events
	object_event  2,  3, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MoveDeleter, -1
	object_event  2,  4, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, EggTutorScript, -1
	object_event  5,  4, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BlackthornTutor1Script, -1
