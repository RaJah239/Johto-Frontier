DEF GOLDENRODDEPTSTORE6F_FRESH_WATER_PRICE EQU 200
DEF GOLDENRODDEPTSTORE6F_SODA_POP_PRICE    EQU 300
DEF GOLDENRODDEPTSTORE6F_LEMONADE_PRICE    EQU 350

GoldenrodDeptStore6F_MapEvents:
	def_warp_events
	warp_event 15,  0, GOLDENROD_DEPT_STORE_5F, 2
	warp_event  2,  0, GOLDENROD_DEPT_STORE_ELEVATOR, 1
	warp_event 13,  0, GOLDENROD_DEPT_STORE_ROOF, 1

	def_coord_events

	def_bg_events
	bg_event 14,  0, BGEVENT_JUMPTEXT, GoldenrodDeptStore6FDirectoryText
	bg_event  3,  0, BGEVENT_JUMPSTD, ELEVATOR_BUTTON_SCRIPT
	bg_event  8,  1, BGEVENT_UP, GoldenrodVendingMachineScript
	bg_event  9,  1, BGEVENT_UP, GoldenrodVendingMachineScript
	bg_event 10,  1, BGEVENT_UP, GoldenrodVendingMachineScript
	bg_event 11,  1, BGEVENT_UP, GoldenrodVendingMachineScript

	def_object_events
	object_event 10,  2, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodDeptStore6FLassText, -1
	object_event  8,  2, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodDeptStore6FSuperNerdText, -1

	object_const_def
	const GOLDENRODDEPTSTORE6F_LASS
	const GOLDENRODDEPTSTORE6F_SUPER_NERD

GoldenrodDeptStore6F_MapScripts:
	def_scene_scripts

	def_callbacks

GoldenrodVendingMachineScript:
	opentext
	writethistext
		text "A vending machine!"
		line "Here's the menu."
		done
.Start:
	special PlaceMoneyTopRight
	loadmenu .MenuHeader
	verticalmenu
	closewindow
	ifequal 1, .FreshWater
	ifequal 2, .SodaPop
	ifequal 3, .Lemonade
	endtext

.FreshWater:
	checkmoney YOUR_MONEY, GOLDENRODDEPTSTORE6F_FRESH_WATER_PRICE
	ifequal HAVE_LESS, .NotEnoughMoney
	giveitem FRESH_WATER
	iffalse .NotEnoughSpace
	takemoney YOUR_MONEY, GOLDENRODDEPTSTORE6F_FRESH_WATER_PRICE
	getitemname STRING_BUFFER_3, FRESH_WATER
	sjump .VendItem

.SodaPop:
	checkmoney YOUR_MONEY, GOLDENRODDEPTSTORE6F_SODA_POP_PRICE
	ifequal HAVE_LESS, .NotEnoughMoney
	giveitem SODA_POP
	iffalse .NotEnoughSpace
	takemoney YOUR_MONEY, GOLDENRODDEPTSTORE6F_SODA_POP_PRICE
	getitemname STRING_BUFFER_3, SODA_POP
	sjump .VendItem

.Lemonade:
	checkmoney YOUR_MONEY, GOLDENRODDEPTSTORE6F_LEMONADE_PRICE
	ifequal HAVE_LESS, .NotEnoughMoney
	giveitem LEMONADE
	iffalse .NotEnoughSpace
	takemoney YOUR_MONEY, GOLDENRODDEPTSTORE6F_LEMONADE_PRICE
	getitemname STRING_BUFFER_3, LEMONADE
.VendItem:
	pause 10
	playsound SFX_ENTER_DOOR
	writetext GoldenrodClangText
	promptbutton
	itemnotify
	sjump .Start

.NotEnoughMoney:
	writethistext
		text "Oops, not enough"
		line "money."
		done
	waitbutton
	sjump .Start

.NotEnoughSpace:
	writethistext
		text "There's no more"
		line "room for stuff."
		done
	waitbutton
	sjump .Start

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 2, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
	db 4 ; items
	db "Fresh Water  ¥{d:GOLDENRODDEPTSTORE6F_FRESH_WATER_PRICE}@"
	db "Soda Pop     ¥{d:GOLDENRODDEPTSTORE6F_SODA_POP_PRICE}@"
	db "Lemonade     ¥{d:GOLDENRODDEPTSTORE6F_LEMONADE_PRICE}@"
	db "Cancel@"

GoldenrodClangText:
	text "Clang! A can of"
	line "@"
	text_ram wStringBuffer3
	text_start
	cont "popped out!"
	done

GoldenrodDeptStore6FLassText:
	text "I love listening"
	line "to the National"
	cont "Park Radio Station"
	cont "everywhere I go."
	done

GoldenrodDeptStore6FSuperNerdText:
	text "If you're tired,"
	line "try the vending"
	cont "machine's drinks."

	para "Your #mon will"
	line "love them too."
	done

GoldenrodDeptStore6FDirectoryText:
	text "Take a Break from"
	line "Shopping!"

	para "6F Tranquil Square"
	done
