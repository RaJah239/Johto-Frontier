ElmsHouse_MapEvents:
	def_warp_events
	warp_event  2,  7, NEW_BARK_TOWN, 4
	warp_event  3,  7, NEW_BARK_TOWN, 4

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, ElmsHousePC
	bg_event  6,  1, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT
	bg_event  7,  1, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT

	def_object_events
	object_event  1,  5, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, ElmsWifeText, -1
	object_event  5,  4, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, ElmsSonText, -1

	object_const_def
	const ELMSHOUSE_ELMS_WIFE
	const ELMSHOUSE_ELMS_SON

ElmsHouse_MapScripts:
	def_scene_scripts

	def_callbacks

ElmsWifeText:
	text "Hi, <PLAY_G>! My"
	line "husband's always"
	cont "so busy--I hope"
	cont "he's OK."

	para "When he's caught"
	line "up in his #mon"
	cont "research, he even"
	cont "forgets to eat."
	done

ElmsSonText:
	text "When I grow up,"
	line "I'm going to help"
	cont "my dad!"

	para "I'm going to be a"
	line "great #mon"
	cont "professor!"
	done

ElmsHousePC:
	jumpthistext
		text "#mon…"

		para "Endless mysteries!"
		line "Endless wonder!"

		para "I want to know it"
		line "all!"

		para "I will dedicate my"
		line "life to the study"
		cont "of #mon!"

		para "…"

		para "It's a part of"
		line "Prof.Elm's research"
		cont "papers."
		done
