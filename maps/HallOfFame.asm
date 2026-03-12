HallOfFame_MapEvents:
	def_warp_events
	warp_event  4, 13, LANCES_ROOM, 3
	warp_event  5, 13, LANCES_ROOM, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4, 12, SPRITE_LANCE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1

	object_const_def
	const HALLOFFAME_LANCE

HallOfFame_MapScripts:
	def_scene_scripts
	scene_script HallOfFameEnterScene, SCENE_HALLOFFAME_ENTER
	scene_script HallOfFameNoopScene,  SCENE_HALLOFFAME_NOOP

	def_callbacks

HallOfFameEnterScene:
	sdefer HallOfFameEnterScript
HallOfFameNoopScene:
	end

HallOfFameEnterScript:
	follow HALLOFFAME_LANCE, PLAYER
	applymovement HALLOFFAME_LANCE, HallOfFame_WalkUpWithLance
	stopfollow
	turnobject PLAYER, RIGHT
	showthistext
		text "Lance: It's been a"
		line "long time since I"
		cont "last came here."

		para "This is where we"
		line "honor the League"
		cont "Champions for all"
		cont "eternity."

		para "Their courageous"
		line "#mon are also"
		cont "inducted."

		para "Here today, we"
		line "witnessed the rise"
		cont "of a new League"
		cont "Champion--a"
		cont "trainer who feels"
		cont "compassion for,"
		cont "and trust toward,"
		cont "all #mon."

		para "A trainer who"
		line "succeeded through"
		cont "perseverance and"
		cont "determination."

		para "The new League"
		line "Champion who has"
		cont "all the makings"
		cont "of greatness!"

		para "<PLAY_G>, allow me"
		line "to register you"
		cont "and your partners"
		cont "as Champions!"
		done
	turnobject HALLOFFAME_LANCE, UP
	applymovement PLAYER, HallOfFame_SlowlyApproachMachine
	setscene SCENE_HALLOFFAME_NOOP
	pause 15
	setval HEALMACHINE_HALL_OF_FAME
	special HealMachineAnim
	setevent EVENT_BEAT_ELITE_FOUR
	clearevent EVENT_RED_IN_MT_SILVER
	special HealParty
	halloffame
	end

HallOfFame_WalkUpWithLance:
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step RIGHT
	turn_head LEFT
	step_end

HallOfFame_SlowlyApproachMachine:
	slow_step UP
	step_end
