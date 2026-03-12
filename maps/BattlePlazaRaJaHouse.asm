BattlePlazaRaJaHouse_MapEvents:
	def_warp_events
	warp_event  2,  7, BATTLE_PLAZA, 5
	warp_event  3,  7, BATTLE_PLAZA, 5

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_DOWN, 0, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BattlePlazaRaJaHouseRaJaScript, -1

	object_const_def
	const BATTLEPLAZARAJAHOUSE_RAJA

BattlePlazaRaJaHouse_MapScripts:
	def_scene_scripts

	def_callbacks

BattlePlazaRaJaHouseRaJaScript:
	faceplayeropentext
	checkevent EVENT_GOT_START_MENU_WARP
	iftrue .HopeYouHaveFunWithThisGame
	writethistext
		text "RaJa239: Yes, yes,"
		line "I made this ROM"
		cont "hack of my very"
		cont "favorite game,"
		cont "#mon Crystal."

		para "I could give you a"
		line "story of childhood"
		cont "and escapism but"
		cont "that would bore"
		cont "you and worse,"
		cont "waste ROM bytes."

		para "What's this? You"
		line "think I can gift"
		cont "you something as"
		cont "I made this?"

		para "Well of course!"

		para "But, you'll have"
		line "to beat me in a"
		cont "battle to earn it!"

		para "Or so you'd think"
		line "right? I'm no"
		cont "trainer."

		para "In fact, go on"
		line "please accept this"
		cont "just for playing"
		cont "my game!"
		done
	playsound SFX_DEX_FANFARE_50_79
	waitsfx
	setflag ENGINE_START_MENU_WARP
	setevent EVENT_GOT_START_MENU_WARP
	writethistext
		text "<PLAYER> received"
		line "Warp Option from"
		cont "RaJa239!"
		done
	waitbutton
	jumpthisopenedtext
	text "Have fun teleport-"
	line "ing! Swing by any"
	cont "time, why not."
	done

.HopeYouHaveFunWithThisGame:
	jumpthisopenedtext
		text "RaJa239: I hope"
		line "you're enjoying"
		cont "this game."
		done 
