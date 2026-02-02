	object_const_def
	const MOUNTMORTARGIFTSHOP_GRAMPS1 ; morning only
	const MOUNTMORTARGIFTSHOP_GRAMPS2 ; day only
	const MOUNTMORTARGIFTSHOP_LASS1 ; morning only
	const MOUNTMORTARGIFTSHOP_LASS2 ; day only

MountMortarGiftShop_MapScripts:
	def_scene_scripts

	def_callbacks

MountMortarGiftShopClerkScript:
	faceplayer
	opentext
	pokemart MARTTYPE_STANDARD, MART_MT_MOON
	closetext
	end

MountMortarGiftShopLassScript:
	jumptextfaceplayer MountMortarGiftShopLassText

MountMortarGiftShopLassText:
	text "When the sun goes"
	line "down, CLEFAIRY"
	cont "come out to play."
	done

MountMortarGiftShop_MapEvents:
	def_warp_events
	warp_event  3,  7, MT_MORTAR_SQUARE, 1
	warp_event  4,  7, MT_MORTAR_SQUARE, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, MORN, 0, OBJECTTYPE_SCRIPT, 0, MountMortarGiftShopClerkScript, -1
	object_event  1,  2, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, DAY, 0, OBJECTTYPE_SCRIPT, 0, MountMortarGiftShopClerkScript, -1
	object_event  1,  6, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, MORN, 0, OBJECTTYPE_SCRIPT, 0, MountMortarGiftShopLassScript, -1
	object_event  5,  4, SPRITE_LASS, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, DAY, 0, OBJECTTYPE_SCRIPT, 0, MountMortarGiftShopLassScript, -1
