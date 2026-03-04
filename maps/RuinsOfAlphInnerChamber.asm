RuinsOfAlphInnerChamber_MapEvents:
	def_warp_events
	warp_event 10, 13, RUINS_OF_ALPH_OUTSIDE, 6
	warp_event  3, 15, RUINS_OF_ALPH_HO_OH_CHAMBER, 3
	warp_event  4, 15, RUINS_OF_ALPH_HO_OH_CHAMBER, 4
	warp_event 15,  3, RUINS_OF_ALPH_LILEEP_CHAMBER, 3
	warp_event 16,  3, RUINS_OF_ALPH_LILEEP_CHAMBER, 4
	warp_event  3, 21, RUINS_OF_ALPH_OMANYTE_CHAMBER, 3
	warp_event  4, 21, RUINS_OF_ALPH_OMANYTE_CHAMBER, 4
	warp_event 15, 24, RUINS_OF_ALPH_AERODACTYL_CHAMBER, 3
	warp_event 16, 24, RUINS_OF_ALPH_AERODACTYL_CHAMBER, 4

	def_coord_events

	def_bg_events
	bg_event  2,  3, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event  5,  3, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event  8,  3, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event 11,  3, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event 14,  3, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event 17,  3, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event  2,  8, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event  5,  8, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event  8,  8, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event 11,  8, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event 14,  8, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event 17,  8, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event  2, 13, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event 17, 13, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event  2, 18, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event  5, 18, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event  8, 18, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event 11, 18, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event 14, 18, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event 17, 18, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event  2, 24, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event  5, 24, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event  8, 24, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event 11, 24, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event 14, 24, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText
	bg_event 17, 24, BGEVENT_JUMPTEXT, RuinsOfAlphStatueText

	def_object_events
	chanseyheal_event  8, 11
	object_event  3,  7, SPRITE_FISHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, RuinsOfAlphInnerChamberFisherText, EVENT_RUINS_OF_ALPH_INNER_CHAMBER_TOURISTS
	object_event 14, 13, SPRITE_TEACHER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, RuinsOfAlphInnerChamberTeacherText, EVENT_RUINS_OF_ALPH_INNER_CHAMBER_TOURISTS
	object_event 11, 19, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, RuinsOfAlphInnerChamberGrampsText, EVENT_RUINS_OF_ALPH_INNER_CHAMBER_TOURISTS

	object_const_def
	const RUINSOFALPHINNERCHAMBER_CHANSEY
	const RUINSOFALPHINNERCHAMBER_FISHER
	const RUINSOFALPHINNERCHAMBER_TEACHER
	const RUINSOFALPHINNERCHAMBER_GRAMPS

RuinsOfAlphInnerChamber_MapScripts:
	def_scene_scripts
	scene_script RuinsOfAlphInnerChamberNoopScene,            SCENE_RUINSOFALPHINNERCHAMBER_NOOP
	scene_script RuinsOfAlphInnerChamberStrangePresenceScene, SCENE_RUINSOFALPHINNERCHAMBER_STRANGE_PRESENCE

	def_callbacks

RuinsOfAlphInnerChamberStrangePresenceScene:
	sdefer RuinsOfAlphInnerChamberStrangePresenceScript
RuinsOfAlphInnerChamberNoopScene:
	end

RuinsOfAlphInnerChamberStrangePresenceScript:
	showthistext
		text "There is a strange"
		line "presence here…"
		done
	setscene SCENE_RUINSOFALPHINNERCHAMBER_NOOP
	setevent EVENT_MADE_UNOWN_APPEAR_IN_RUINS
	clearevent EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_FISHER
	end

RuinsOfAlphInnerChamberFisherText:
	text "This is a big"
	line "room, but there's"
	cont "nothing here."
	done

RuinsOfAlphInnerChamberTeacherText:
	text "This place has a"
	line "mystical quality"
	cont "to it."

	para "It feels sort of"
	line "ethereal even."
	done

RuinsOfAlphInnerChamberGrampsText:
	text "Ancient buildings"
	line "are often tombs of"
	cont "kings."

	para "Like the pyramids,"
	line "for instance."
	done

RuinsOfAlphStatueText:
	text "It's a replica of"
	line "an ancient #-"
	cont "mon."
	done
