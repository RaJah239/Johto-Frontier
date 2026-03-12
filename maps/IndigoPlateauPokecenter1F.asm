IndigoPlateauPokecenter1F_MapEvents:
	def_warp_events
	warp_event  5, 13, ROUTE_21, 1
	warp_event  6, 13, ROUTE_21, 2
	warp_event  0, 13, POKECENTER_2F, 1
	warp_event 14,  3, WILLS_ROOM, 1

	def_coord_events

	def_bg_events

	def_object_events
	heal_event  3,  7, PAL_NPC_PURPLE
	chansey_event  4,  7
	variable_mart_event 11,  7, PAL_NPC_PURPLE
	object_event  5, 10, SPRITE_POKEFAN_F, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, VioletScript, -1
	object_event  1,  9, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, TeleportGuyScript, -1
	object_event 11, 11, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, IndigoPlateauPokecenter1FCooltrainerMText, -1
	object_event  0,  9, SPRITE_NATU, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, NatuScript, -1

	object_const_def
	const INDIGOPLATEAUPOKECENTER1F_NURSE
	const INDIGOPLATEAUPOKECENTER1F_CHANSEY
	const INDIGOPLATEAUPOKECENTER1F_CLERK
	const INDIGOPLATEAUPOKECENTER1F_VIOLET
	const INDIGOPLATEAUPOKECENTER1F_GRAMPS
	const INDIGOPLATEAUPOKECENTER1F_COOLTRAINER_M
	const INDIGOPLATEAUPOKECENTER1F_NATU

IndigoPlateauPokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, IndigoPlateauPokecenter1FPrepareElite4Callback

VioletScript:
	faceplayeropentext
	checkevent EVENT_MET_VIOLET
	iftrue .LetsTrade
	writethistext
		text "Hello. I'm Violet."
		line "I enjoy collecting"
		cont "coins."

		para "A Coin Collector"
		line "of sorts."

		para "And you are?"

		para "…"

		para "<PLAY_G>? Nice to"
		line "meet you!"

		para "To make it here…"
		line "You must be quite"
		cont "the trainer!"

		para "I think we may be"
		line "able to help each-"
		cont "other out."

		para "For 9,999 coins or"
		line "a full Coin Case,"

		para "I'll trade you"
		line "something special."

		para "How about it?"
		done
	setevent EVENT_MET_VIOLET
	waitbutton
.LetsTrade
	writethistext
		text "Violet: Up for a"
		line "trade <PLAY_G>?"

		para "9,999 coins for"
		line "something special?"
		done
	special DisplayCoinCaseBalance
	yesorno
	iffalse .Refused
	loadmenu .MoveMenuHeader
	verticalmenu
	closewindow
	ifequal 1, .SacredAsh
	ifequal 2, .EonMail
	ifequal 3, .Crystals
	jumpthisopenedtext
		text "Not in a trading"
		line "mood?"
		done

.SacredAsh:
	checkcoins 9999
	ifequal HAVE_LESS, .CoinCaseNotAtMax
	giveitem SACRED_ASH, 3
	iffalse .NoRoom
	writetext PlayerGotFiveSacredAshText
	sjump .WrappingUpThisCoinTrade

.EonMail:
	checkcoins 9999
	ifequal HAVE_LESS, .CoinCaseNotAtMax
	giveitem EON_MAIL
	iffalse .NoRoom
	writetext PlayerGotEonMailText
	sjump .WrappingUpThisCoinTrade

.Crystals:
	checkcoins 9999
	ifequal HAVE_LESS, .CoinCaseNotAtMax
	giveitem CRYSTAL, 5
	iffalse .NoRoom
	writetext PlayerGotNinetyElevenCrystalsText
.WrappingUpThisCoinTrade:
	ifequal TRUE, .ConcludeTransaction
	waitendtext

.NoRoom:
	jumpthisopenedtext
		text "Make space to con-"
		line "clude our trade…"
		done

.ConcludeTransaction:
	writethistext
		text "I hope you value"
		line "our trade!"
		done
	waitbutton
	takecoins 9999
	waitsfx
	playsound SFX_TRANSACTION
	special DisplayCoinCaseBalance
	jumpthisopenedtext
		text "Let's trade again"
		line "sometime!"
		done

.Refused:
	jumpthisopenedtext
		text "Come trade with me"
		line "anytime."
		done

.CoinCaseNotAtMax:
	jumpthisopenedtext
		text "Hm… You're short on"
		line "coins…"
		done

.MoveMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 2, 15, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
	db 4 ; items
	db "Sacred Ash ×3@"
	db "Eon Mail   ×1@"
	db "Crystal    ×5@"
	db "Cancel@"

PlayerGotFiveSacredAshText:
	text "<PLAYER> got"
	line "3× Sacred Ashes!@"
	sound_item
	text_promptbutton
	text_end

PlayerGotEonMailText:
	text "<PLAYER> got"
	line "Eon Mail!@"
	sound_item
	text_promptbutton
	text_end

PlayerGotNinetyElevenCrystalsText:
	text "<PLAYER> got"
	line "5× Crystals!@"
	sound_item
	text_promptbutton
	text_end

TeleportGuyScript:
	faceplayeropentext
	writethistext
		text "Want my Natu to"
		line "Teleport you home?"
		done
	yesorno
	iffalse_endtext
	writethistext
		text "OK! Picture your"
		line "house mentally…"
		done
	waitclosetext
	playsound SFX_WARP_TO
	special FadeOutPalettes
	waitsfx
	warp NEW_BARK_TOWN, 13, 6
	end

IndigoPlateauPokecenter1FCooltrainerMText:
	text "At the #mon"
	line "League, you'll get"
	cont "tested by the"
	cont "Elite Four."

	para "You have to beat"
	line "them all. If you"
	cont "lose, you have to"
	cont "start all over!"
	done

NatuScript:
	setval NATU
	special SetMonAsSeen
	isfieldactionssettoquick
	iftrue .skipthis
	reanchormap
	pokepic NATU
	cry NATU
	waitbutton
	closepokepic
.skipthis
	jumpthistext
		text "Natu: Natu…"
		done

IndigoPlateauPokecenter1FPrepareElite4Callback:
	setmapscene WILLS_ROOM, SCENE_WILLSROOM_LOCK_DOOR
	setmapscene KOGAS_ROOM, SCENE_KOGASROOM_LOCK_DOOR
	setmapscene BRUNOS_ROOM, SCENE_BRUNOSROOM_LOCK_DOOR
	setmapscene KARENS_ROOM, SCENE_KARENSROOM_LOCK_DOOR
	setmapscene LANCES_ROOM, SCENE_LANCESROOM_LOCK_DOOR
	setmapscene HALL_OF_FAME, SCENE_HALLOFFAME_ENTER
	clearevent EVENT_WILLS_ROOM_ENTRANCE_CLOSED
	clearevent EVENT_WILLS_ROOM_EXIT_OPEN
	clearevent EVENT_KOGAS_ROOM_ENTRANCE_CLOSED
	clearevent EVENT_KOGAS_ROOM_EXIT_OPEN
	clearevent EVENT_BRUNOS_ROOM_ENTRANCE_CLOSED
	clearevent EVENT_BRUNOS_ROOM_EXIT_OPEN
	clearevent EVENT_KARENS_ROOM_ENTRANCE_CLOSED
	clearevent EVENT_KARENS_ROOM_EXIT_OPEN
	clearevent EVENT_LANCES_ROOM_ENTRANCE_CLOSED
	clearevent EVENT_LANCES_ROOM_EXIT_OPEN
	clearevent EVENT_BEAT_ELITE_4_WILL
	clearevent EVENT_BEAT_ELITE_4_KOGA
	clearevent EVENT_BEAT_ELITE_4_BRUNO
	clearevent EVENT_BEAT_ELITE_4_KAREN
	clearevent EVENT_BEAT_CHAMPION_LANCE
	setevent EVENT_LANCES_ROOM_OAK_AND_MARY
	endcallback
