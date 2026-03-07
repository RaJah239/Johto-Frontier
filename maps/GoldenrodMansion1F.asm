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
	bg_event  0,  3, BGEVENT_JUMPSTD, PICTURE_BOOKSHELF_SCRIPT
	bg_event  2,  3, BGEVENT_JUMPSTD, PICTURE_BOOKSHELF_SCRIPT

	def_object_events
	object_event  1,  5, SPRITE_GRANNY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonMansionManager, -1
	object_event  2,  6, SPRITE_GROWLITHE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodMansion1FGrowlithe, -1
	object_event  3,  4, SPRITE_CLEFAIRY, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodMansion1FClefairy, -1

	object_const_def
	const GOLDENRODMANSION1F_GRANNY
	const GOLDENRODMANSION1F_GROWLITHE
	const GOLDENRODMANSION1F_CLEFAIRY

GoldenrodMansion1F_MapScripts:
	def_scene_scripts

	def_callbacks

CeladonMansionManager:
	faceplayeropentext
	checkevent EVENT_MET_GOLDENROD_MANSION_OWNER
	iftrue .CheckIfSaleIsToday
	setevent EVENT_MET_GOLDENROD_MANSION_OWNER
	jumpthisopenedtext
		text "My husand and I,"
		line "did a lot of work,"
		cont "over many years to"
		cont "bring our dream,"
		cont "Goldenrod's Dept."
		cont "Store, to reality."

		para "It's given us much"
		line "joy…"

		para "Alas… It's been so"
		line "long now…"

		para "He's no longer with"
		line "us and I want to"
		cont "share some of that"
		cont "joy with everyone."

		para "Every so often I'll"
		line "hire a vendor with"
		cont "lots of bargains"
		cont "to sell at the"
		cont "Dept.Store's roof."

		para "<PLAYER> is it?"
		line "You're a trainer so"
		cont "it'll definitely"
		cont "benefit you."

		para "Just come talk to"
		line "to me and I'll let"
		cont "you know if there's"
		cont "a sale that day."
		done

.CheckIfSaleIsToday:
	; check if sale is ON
	random 10
	ifequal 0, .SaleIsToday
	clearflag ENGINE_GOLDENROD_DEPT_STORE_SALE_IS_ON
	; sale is not today
	jumpthisopenedtext
		text "Today seems like"
		line "an ordinary day."
		done

.SaleIsToday:
	setflag ENGINE_GOLDENROD_DEPT_STORE_SALE_IS_ON
	jumpthisopenedtext
		text "Today seems like a"
		line "lovely day."

		para "I'll have a vendor"
		line "at Goldenrod Dept."
		cont "Store's roof with"
		cont "some great deals!"

		para "Go on <PLAYER>."

		para "Remember that the"
		line "vendor leaves at"
		cont "midnight."
		done

CeladonMansionManagersSuiteSign:
	jumpthistext
		text "Celadon Mansion"
		line "Owner's Suite"
		done

GoldenrodMansion1FGrowlithe:
	setval GROWLITHE
	special SetMonAsSeen
	isfieldactionssettoquick
	iftrue .skipthis
	reanchormap
	pokepic GROWLITHE
	cry GROWLITHE
	waitbutton
	closepokepic
.skipthis
	jumpthistext
		text "Growlithe: Roff!"
		done

GoldenrodMansion1FClefairy:
	setval CLEFAIRY
	special SetMonAsSeen
	isfieldactionssettoquick
	iftrue .skipthis
	reanchormap
	pokepic CLEFAIRY
	cry CLEFAIRY
	waitbutton
	closepokepic
.skipthis
	jumpthistext
		text "Clefairy: Clef"
		line "cleff!"
		done
