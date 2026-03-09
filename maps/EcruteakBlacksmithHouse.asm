EcruteakBlacksmithHouse_MapEvents:
	def_warp_events
	warp_event  3,  7, ECRUTEAK_CITY, 16
	warp_event  4,  7, ECRUTEAK_CITY, 16

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  4, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLACK, OBJECTTYPE_SCRIPT, 0, EcruteakBlacksmithHouse_BlacksmithScript, -1
	object_event  4,  4, SPRITE_POKEDEX, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakBlacksmithHouseShinyMonCodex, EVENT_SHINY_MON_CODEX

	object_const_def
	const ECRUTEAKBLACKSMITHHOUSE_BLACKSMITH
	const ECRUTEAKBLACKSMITHHOUSE_SHINY_MON_CODEX

EcruteakBlacksmithHouse_MapScripts:
	def_scene_scripts

	def_callbacks

EcruteakBlacksmithHouse_BlacksmithScript:
	opentext
	checkevent EVENT_ECRUTEAK_BLACKSMITH_FINDS_HIS_PASSION
	iftrue .ShinyBallScript
	setevent EVENT_I_WANT_TO_DO_SOMETHING
	writethistext
		text "Ah…"
		line "I'm so bored…"

		para "The vibe of this"
		line "city is relaxing,"
		cont "with its respect"
		cont "to the past… but I"
		cont "want to do some-"
		cont "thing! No! I…"

		para "I want to create"
		line "something new!"

		para "But what… That is"
		line "the question…"
		done
	waitbutton
	showemote EMOTE_SHOCK, ECRUTEAKBLACKSMITHHOUSE_BLACKSMITH, 15
	faceplayer
	writethistext
		text "Hi, and you are?"
		line "<PLAYER> is it?"
		cont "Thanks for passing"
		cont "by."
		
		para "You have a glow?"
		line "No, a fire in you!"

		para "What was I even"
		line "thinking before?"
		done
	waitendtext

.ShinyBallScript
	faceplayer
	checkevent EVENT_GOT_FIRST_SHINY_BALL_FOR_FREE
	iffalse .MyCraftingPeak
	special CrystalCountInBag
	writethistext
		text "<PLAYER>, nice to"
		line "see you again."

		para "Would you like to"
		line "trade 99× Crystal"
		cont "for a Shiny Ball?"
		done
	yesorno
	iffalse .DropByAnytime
	checkitem CRYSTAL, 99
	iffalse .YouNeedMoreCrystals
	verbosegiveitem SHINY_BALL
	iffalse .NoRoom
	takeitem CRYSTAL, 99
	writethistext
		text "Thanks and hop on"
		line "by anytime you're"
		cont "in the area."
		done
	waitsfx
	playsound SFX_TRANSACTION
    special CrystalCountInBag
	waitendtext

.MyCraftingPeak
	writethistext
		text "I've been dabbled"
		line "in a great many"
		cont "crafting pursuits."

		para "None has tested my"
		line "smithing skills as"
		cont "much as this!"

		para "Take it!"
		done
	waitbutton
	verbosegiveitem SHINY_BALL
	iffalse .NoRoom
	setevent EVENT_GOT_FIRST_SHINY_BALL_FOR_FREE
	jumpthisopenedtext
		text "It's the first"
		line "ever Shiny Ball!"

		para "Any #mon that"
		line "enters it becomes"
		cont "an alternate"
		cont "color!"

		para "This means that it"
		line "doesn't necessarily"
		cont "need to capture a"
		cont "#mon with it…"

		para "The #mon just"
		line "needs to enter it"
		cont "once and be caught"
		cont "somehow after."

		para "It is my gift to"
		line "you, <PLAYER>."

		para "It seems meeting"
		line "you ignited a"
		cont "flame that I didn't"
		cont "know was in me!"

		para "I can make more"
		line "but it was very"
		cont "expensive just to"
		cont "gather materials."

		para "To make a single"
		line "takes 99× Crystal."
		
		para "So, if you gather"
		line "that many and want"
		cont "another, visit as"
		cont "much as you want."
		done

.DropByAnytime
	jumpthisopenedtext
		text "I see, I see."
		line "How nice of you"
		cont "visit then!"

		para "Have a seat and"
		line "relax a bit."
		done

.YouNeedMoreCrystals
	jumpthisopenedtext
		text "You need more"
		line "Crystals…"
		
		para "There's a place"
		line "that rewards"
		cont "Crystals for win-"
		cont "ing battles."

		para "You might want to"
		line "check it out."
		done

.NoRoom
	jumpthisopenedtext
		text "You don't have the"
		line "space to take it."
		done

EcruteakBlacksmithHouseShinyMonCodex:
	opentext
	writethistext
		text "It's a book about"
		line "Shiny #mon and"
		cont "their Hidden Power"
		cont "types."

		para "Read it?"
		done
	yesorno
	iffalse_endtext
	writethistext
		text "Shiny #mon,"
		line "like regular"
		cont "#mon can't have"
		cont "a Hidden Power of"
		cont "Normal or Fairy."

		para "Keep Reading?"
		done
	yesorno
	iffalse_endtext
.GenderMenu
	loadmenu .MoveMenuHeader
	verticalmenu
	closewindow
	ifequal 1, .Male
	ifequal 2, .Female
	ifequal 3, .Genderless
	iffalse_endtext

.Male
	writethistext
		text "These can have all"
		line "Hidden Power types"
		cont "except Normal or"
		cont "Fairy."
		done
	waitbutton
	sjump .GenderMenu

.Female
	writethistext
		text "Hidden Power types"
		line "include:"
		cont "Bug,"
		cont "Fighting,"
		cont "Flying,"
		cont "Ghost,"
		cont "Ground,"
		cont "Poison,"
		cont "Rock and"
		cont "Steel."
		done
	waitbutton
	sjump .GenderMenu

.Genderless
	writethistext
		text "Same as Male"
		line "#mon can."
		done
	waitbutton
	sjump .GenderMenu

.MoveMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 2, 12, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
	db 4 ; items
	db "Male@"
	db "Female@"
	db "Genderless@"
	db "Cancel@"
