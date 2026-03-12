BlackthornDragonSpeechHouse_MapEvents:
	def_warp_events
	warp_event  2,  7, BLACKTHORN_CITY, 3
	warp_event  3,  7, BLACKTHORN_CITY, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_GRANNY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, BlackthornDragonSpeechHouseGrannyText, -1
	object_event  5,  5, SPRITE_CHARMANDER, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BlackthornDragonSpeechHouseCharmanderScript, -1

	object_const_def
	const BLACKTHORNDRAGONSPEECHHOUSE_GRANNY
	const BLACKTHORNDRAGONSPEECHHOUSE_CHARMANDER

BlackthornDragonSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks

BlackthornDragonSpeechHouseGrannyText:
	text "A clan of trainers"
	line "who can freely"
	cont "command dragons"
	cont "live right here in"
	cont "Blackthorn."

	para "As a result, there"
	line "are many legends"
	cont "about dragons in"
	cont "this town."
	done

BlackthornDragonSpeechHouseCharmanderScript:
	setval CHARMANDER
	special SetMonAsSeen
	isfieldactionssettoquick
	iftrue .skipthis
	reanchormap
	pokepic CHARMANDER
	cry CHARMANDER
	waitbutton
	closepokepic
.skipthis
	jumpthistext
		text "Charmander: Charr!"
		done
