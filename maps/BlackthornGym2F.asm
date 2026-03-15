BlackthornGym2F_MapEvents:
	def_warp_events
	warp_event  1,  7, BLACKTHORN_GYM_1F, 3
	warp_event  7,  9, BLACKTHORN_GYM_1F, 4
	warp_event  2,  5, BLACKTHORN_GYM_1F, 5 ; hole
	warp_event  8,  7, BLACKTHORN_GYM_1F, 6 ; hole
	warp_event  8,  3, BLACKTHORN_GYM_1F, 7 ; hole

	def_coord_events

	def_bg_events

	def_object_events
	strengthboulder_event  8,  2, EVENT_BOULDER_IN_BLACKTHORN_GYM_1
	strengthboulder_event  2,  3, EVENT_BOULDER_IN_BLACKTHORN_GYM_2
	strengthboulder_event  6, 16, EVENT_BOULDER_IN_BLACKTHORN_GYM_3
	strengthboulder_event  3,  3
	strengthboulder_event  6,  1
	strengthboulder_event  8, 14
	object_event  5, 13, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerCooltrainermCody, -1
	object_event  4, 11, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerCooltrainerfFran, -1

	object_const_def
	const BLACKTHORNGYM2F_BOULDER1
	const BLACKTHORNGYM2F_BOULDER2
	const BLACKTHORNGYM2F_BOULDER3
	const BLACKTHORNGYM2F_BOULDER4
	const BLACKTHORNGYM2F_BOULDER5
	const BLACKTHORNGYM2F_BOULDER6

	const BLACKTHORNGYM2F_COOLTRAINER_M
	const BLACKTHORNGYM2F_COOLTRAINER_F

BlackthornGym2F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_STONETABLE, .SetUpStoneTable

.SetUpStoneTable:
	usestonetable .StoneTable
	endcallback

.StoneTable:
	stonetable 5, BLACKTHORNGYM2F_BOULDER1, .Boulder1
	stonetable 3, BLACKTHORNGYM2F_BOULDER2, .Boulder2
	stonetable 4, BLACKTHORNGYM2F_BOULDER3, .Boulder3
	db -1 ; end

.Boulder1:
	disappear BLACKTHORNGYM2F_BOULDER1
	sjump .Fall

.Boulder2:
	disappear BLACKTHORNGYM2F_BOULDER2
	sjump .Fall

.Boulder3:
	disappear BLACKTHORNGYM2F_BOULDER3
	; fallthrough

.Fall:
	pause 30
	scall .FX
	jumpthistext
		text "The boulder fell"
		line "through!"
		done

.FX:
	playsound SFX_STRENGTH
	earthquake 80
	end

TrainerCooltrainermCody:
	trainer COOLTRAINERM, CODY, EVENT_BEAT_COOLTRAINERM_CODY, .SeenText, .BeatenText, 0, .Script

.Script:
	loadmem wNoRematch, 1
	endifjustbattled
	jumpthistextfaceplayer
		text "Members of our"
		line "dragon-user clan"
		cont "can use dragon"
		cont "#mon only after"
		cont "our Master allows"
		cont "it."
		done

.SeenText
	text "We don't only use"
	line "dragon #mon."
	done

.BeatenText
	text "Damn! I need to"
	line "set up faster!"
	done

TrainerCooltrainerfFran:
	trainer COOLTRAINERF, FRAN, EVENT_BEAT_COOLTRAINERF_FRAN, .SeenText, .BeatenText, 0, .Script

.Script:
	loadmem wNoRematch, 1
	endifjustbattled
	jumpthistextfaceplayer
		text "Uh-oh… Clair is"
		line "going to be mad…"
		done

.SeenText
	text "I can't allow a"
	line "nameless trainer"
	cont "past me!"

	para "Clair would be"
	line "livid if I did!"
	done

.BeatenText
	text "Awww… I lost…"
	done
