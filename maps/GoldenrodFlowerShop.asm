GoldenrodFlowerShop_MapEvents:
	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 7
	warp_event  3,  7, GOLDENROD_CITY, 7

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FlowerShopTeacherScript, -1
	object_event  5,  6, SPRITE_LASS, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, FlowerShopFloriaScript, -1

	object_const_def
	const GOLDENRODFLOWERSHOP_TEACHER
	const GOLDENRODFLOWERSHOP_FLORIA

GoldenrodFlowerShop_MapScripts:
	def_scene_scripts

	def_callbacks

FlowerShopTeacherScript:
	faceplayeropentext
	checkevent EVENT_FOUGHT_SUDOWOODO
	iftrue .Lalala
	checkevent EVENT_GOT_SQUIRTBOTTLE
	iftrue .GotSquirtbottle
	checkflag ENGINE_PLAINBADGE
	iffalse .NoPlainBadge
	writethistext
		text "Oh, you're better"
		line "than Whitney…"

		para "You'll be OK,"
		line "then. Here's the"
		cont "Squirtbottle!"
		done
	promptbutton
	verbosegiveitem SQUIRTBOTTLE
	setevent EVENT_GOT_SQUIRTBOTTLE
	endtext

.Lalala:
	turnobject GOLDENRODFLOWERSHOP_TEACHER, LEFT
	jumpthisopenedtext
		text "Lalala lalalala."
		line "Have plenty of"
		cont "water, my lovely!"
		done

.GotSquirtbottle:
	jumpthisopenedtext
		text "Don't do anything"
		line "too dangerous!"
		done

.NoPlainBadge:
	jumpthisopenedtext
		text "Do you want to"
		line "have this Squirt-"
		cont "bottle?"

		para "I don't want you"
		line "doing anything"
		cont "dangerous with it."
		done

FlowerShopFloriaScript:
	faceplayeropentext
	checkevent EVENT_FOUGHT_SUDOWOODO
	iftrue .FoughtSudowoodo
	checkevent EVENT_GOT_SQUIRTBOTTLE
	iftrue .GotSquirtbottle
	jumpthisopenedtext
		text "When I told my sis"
		line "about the jiggly"
		cont "tree at Route 8,"
		cont "she told me it's"
		cont "dangerous."

		para "If I beat Whitney,"
		line "I wonder if she'll"
		cont "lend me her water"
		cont "bottle…"
		done

.GotSquirtbottle:
	jumpthisopenedtext
		text "Wow, you beat"
		line "Whitney? Cool!"
		done

.FoughtSudowoodo:
	jumpthisopenedtext
		text "So it really was a"
		line "#mon!"
		done
