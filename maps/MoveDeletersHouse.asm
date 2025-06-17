	object_const_def
	const MOVEDELETERSHOUSE_SUPER_NERD
	const MOVEDELETERSHOUSE_EGG_TUTOR

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
