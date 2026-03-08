GoldenrodPokecenter1F_MapEvents:
	def_warp_events
	warp_event  3,  7, GOLDENROD_CITY, 1
	warp_event  4,  7, GOLDENROD_CITY, 1
	warp_event  0,  6, POKECOM_CENTER_ADMIN_OFFICE_MOBILE, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	heal_event  3,  1, PAL_NPC_BROWN
	chansey_event  4,  1
	object_event  6,  1, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodPokecenter1FGameboyKidText, -1
	object_event  1,  4, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodPokecenter1FLassText, -1
	object_event  7,  5, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FPokefanF, -1

	object_const_def
	const GOLDENRODPOKECENTER1F_NURSE
	const GOLDENRODPOKECENTER1F_CHANSEY
	const GOLDENRODPOKECENTER1F_GAMEBOY_KID
	const GOLDENRODPOKECENTER1F_LASS
	const GOLDENRODPOKECENTER1F_POKEFAN_F

GoldenrodPokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks

GoldenrodPokecenter1FPokefanF:
	faceplayeropentext
	writethistext
		text "Oh my, your pack"
		line "looks so heavy!"

		para "Oh! Do you happen"
		line "to have something"
		cont "named Eon Mail?"

		para "My daughter is"
		line "after some."

		para "You can part with"
		line "one, can't you?"

		para "Give away an Eon"
		line "Mail?"
		done
	yesorno
	iffalse_endtext
	takeitem EON_MAIL
	iffalse .NoEonMail
	writethistext
		text "<PLAYER> gave away"
		line "the Eon Mail."
		done
	waitbutton
	writethistext
		text "Oh, that's great!"
		line "Thank you, honey!"

		para "Here, this is for"
		line "you in return!"
		done
	waitbutton
	verbosegiveitem MASTER_BALL
	iffalse .NoRoom
	jumpthisopenedtext
		text "My daughter will"
		line "be delighted!"
		done

.NoEonMail:
	jumpthisopenedtext
		text "Oh? You don't have"
		line "one? Too bad."
		done

.NoRoom:
	giveitem EON_MAIL
	jumpthisopenedtext
		text "Oh… Well, another"
		line "time, then."
		done

GoldenrodPokecenter1FGameboyKidText:
	text "The Colosseum"
	line "upstairs is for"
	cont "link battles."

	para "Battle records are"
	line "posted on the"
	cont "wall, so I can't"
	cont "afford to lose."
	done

GoldenrodPokecenter1FLassText:
	text "A higher level"
	line "#mon doesn't"
	cont "always win."

	para "After all, it will"
	line "have a type dis-"
	cont "advantage."

	para "A well balanced"
	line "team is of utmost"
	cont "importance."
	done
