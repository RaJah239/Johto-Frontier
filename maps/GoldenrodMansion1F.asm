	object_const_def
	const GOLDENRODMANSION1F_GRANNY
	const GOLDENRODMANSION1F_GROWLITHE1
	const GOLDENRODMANSION1F_CLEFAIRY
	const GOLDENRODMANSION1F_GROWLITHE2

GoldenrodMansion1F_MapScripts:
	def_scene_scripts

	def_callbacks

CeladonMansionManager:
	jumptextfaceplayer CeladonMansionManagerText

GoldenrodMansion1FMeowth:
	opentext
	writetext GoldenrodMansion1FMeowthText
	cry MEOWTH
	waitbutton
	closetext
	end

GoldenrodMansion1FClefairy:
	opentext
	writetext GoldenrodMansion1FClefairyText
	cry CLEFAIRY
	waitbutton
	closetext
	end

GoldenrodMansion1FNidoranF:
	opentext
	writetext GoldenrodMansion1FNidoranFText
	cry NIDORAN_F
	waitbutton
	closetext
	end

CeladonMansionManagersSuiteSign:
	jumptext CeladonMansionManagersSuiteSignText

GoldenrodMansion1FBookshelf:
	jumpstd PictureBookshelfScript

CeladonMansionManagerText:
	text "My dear #MON"
	line "keep me company,"

	para "so I don't ever"
	line "feel lonely."

	para "MEOWTH even brings"
	line "money home."
	done

GoldenrodMansion1FMeowthText:
	text "MEOWTH: Meow!"
	done

GoldenrodMansion1FClefairyText:
	text "CLEFAIRY: Clef"
	line "cleff!"
	done

GoldenrodMansion1FNidoranFText:
	text "NIDORAN: Kya"
	line "kyaoo!"
	done

CeladonMansionManagersSuiteSignText:
	text "CELADON MANSION"
	line "MANAGER'S SUITE"
	done

GoldenrodMansion1F_MapEvents:
	def_warp_events
	warp_event  0,  0, GOLDENROD_MANSION_2F, 1
	warp_event  7,  0, GOLDENROD_MANSION_2F, 4
	warp_event  6,  9, GOLDENROD_CITY, 18
	warp_event  7,  9, GOLDENROD_CITY, 18
	warp_event  3,  0, GOLDENROD_CITY, 16

	def_coord_events

	def_bg_events
	bg_event  5,  8, BGEVENT_UP, CeladonMansionManagersSuiteSign
	bg_event  0,  3, BGEVENT_READ, GoldenrodMansion1FBookshelf
	bg_event  2,  3, BGEVENT_READ, GoldenrodMansion1FBookshelf

	def_object_events
	object_event  1,  5, SPRITE_GRANNY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonMansionManager, -1
	object_event  2,  6, SPRITE_GROWLITHE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodMansion1FMeowth, -1
	object_event  3,  4, SPRITE_CLEFAIRY, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodMansion1FClefairy, -1
	object_event  4,  4, SPRITE_GROWLITHE, SPRITEMOVEDATA_POKEMON, 2, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodMansion1FNidoranF, -1
