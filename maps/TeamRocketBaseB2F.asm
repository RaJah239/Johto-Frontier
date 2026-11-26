TeamRocketBaseB2F_MapEvents:
	def_warp_events
	warp_event  3, 14, TEAM_ROCKET_BASE_B1F, 2
	warp_event  3,  2, TEAM_ROCKET_BASE_B3F, 1
	warp_event 27,  2, TEAM_ROCKET_BASE_B3F, 2
	warp_event  3,  6, TEAM_ROCKET_BASE_B3F, 3
	warp_event 27, 14, TEAM_ROCKET_BASE_B3F, 4

	def_coord_events

	def_bg_events
	bg_event 26,  7, BGEVENT_ITEM + FULL_HEAL, EVENT_TEAM_ROCKET_BASE_B2F_HIDDEN_FULL_HEAL

	def_object_events
	object_event  7,  5, SPRITE_PIKACHU, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RocketPikachu, EVENT_TEAM_ROCKET_BASE_B2F_PIKACHU_1
	object_event 21,  7, SPRITE_PIKACHU, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RocketPikachu, EVENT_TEAM_ROCKET_BASE_B2F_PIKACHU_2
	object_event  3, 10, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TeamRocketBaseB2FTMKnockOff, EVENT_TEAM_ROCKET_BASE_B2F_TM_KNOCK_OFF
	object_event 22,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_ITEMBALL, 0, TeamRocketBaseB2FKingdraCall, EVENT_GOT_KINGDRA_CALL

	object_const_def
	const TEAMROCKETBASEB2F_PIKACHU1
	const TEAMROCKETBASEB2F_PIKACHU2
	const TEAMROCKETBASEB2F_POKE_BALL1
	const TEAMROCKETBASEB2F_POKE_BALL2

TeamRocketBaseB2F_MapScripts:
	def_scene_scripts

	def_callbacks

RocketPikachu:
	ispokepicsonoroff
	iftrue .skipthis
	reanchormap
	wildpokepic PIKACHU
	cry PIKACHU
	waitbutton
	closepokepic
.skipthis
	showthistext
		text "Pikachu: Pika!"
		done
	loadwildmon PIKACHU, 30
	loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
	startbattle
	disappear LAST_TALKED
	reloadmapafterbattle
	end

TeamRocketBaseB2FKingdraCall:
	itemball KINGDRA_CALL
TeamRocketBaseB2FTMKnockOff:
	itemball TM_KNOCK_OFF
