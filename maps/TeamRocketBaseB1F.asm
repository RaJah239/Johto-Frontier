TeamRocketBaseB1F_MapEvents:
	def_warp_events
	warp_event 27,  2, MAHOGANY_MART_1F, 3
	warp_event  3, 14, TEAM_ROCKET_BASE_B2F, 1
	warp_event  5, 15, TEAM_ROCKET_BASE_B1F, 4
	warp_event 25,  2, TEAM_ROCKET_BASE_B1F, 3

	def_coord_events
	; There are spots on the floor that trigger a Pokémon battle.
	; Each Pokémon (Voltorb, Koffing, Magnemite) knows Selfdestruct.
	coord_event  2,  7, SCENE_TEAMROCKETBASEB1F_TRAPS, ExplodingTrap1
	coord_event  3,  7, SCENE_TEAMROCKETBASEB1F_TRAPS, ExplodingTrap2
	coord_event  4,  7, SCENE_TEAMROCKETBASEB1F_TRAPS, ExplodingTrap3
	coord_event  1,  8, SCENE_TEAMROCKETBASEB1F_TRAPS, ExplodingTrap4
	coord_event  3,  8, SCENE_TEAMROCKETBASEB1F_TRAPS, ExplodingTrap5
	coord_event  5,  8, SCENE_TEAMROCKETBASEB1F_TRAPS, ExplodingTrap6
	coord_event  3,  9, SCENE_TEAMROCKETBASEB1F_TRAPS, ExplodingTrap7
	coord_event  4,  9, SCENE_TEAMROCKETBASEB1F_TRAPS, ExplodingTrap8
	coord_event  1, 10, SCENE_TEAMROCKETBASEB1F_TRAPS, ExplodingTrap9
	coord_event  2, 10, SCENE_TEAMROCKETBASEB1F_TRAPS, ExplodingTrap10
	coord_event  3, 10, SCENE_TEAMROCKETBASEB1F_TRAPS, ExplodingTrap11
	coord_event  5, 10, SCENE_TEAMROCKETBASEB1F_TRAPS, ExplodingTrap12
	coord_event  2, 11, SCENE_TEAMROCKETBASEB1F_TRAPS, ExplodingTrap13
	coord_event  4, 11, SCENE_TEAMROCKETBASEB1F_TRAPS, ExplodingTrap14
	coord_event  1, 12, SCENE_TEAMROCKETBASEB1F_TRAPS, ExplodingTrap15
	coord_event  2, 12, SCENE_TEAMROCKETBASEB1F_TRAPS, ExplodingTrap16
	coord_event  4, 12, SCENE_TEAMROCKETBASEB1F_TRAPS, ExplodingTrap17
	coord_event  5, 12, SCENE_TEAMROCKETBASEB1F_TRAPS, ExplodingTrap18
	coord_event  1, 13, SCENE_TEAMROCKETBASEB1F_TRAPS, ExplodingTrap19
	coord_event  3, 13, SCENE_TEAMROCKETBASEB1F_TRAPS, ExplodingTrap20
	coord_event  4, 13, SCENE_TEAMROCKETBASEB1F_TRAPS, ExplodingTrap21
	coord_event  5, 13, SCENE_TEAMROCKETBASEB1F_TRAPS, ExplodingTrap22

	def_bg_events
	bg_event  3, 11, BGEVENT_ITEM + REVIVE, EVENT_TEAM_ROCKET_BASE_B1F_HIDDEN_REVIVE

	def_object_events
	object_event 27,  6, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TeamRocketBaseB1FHyperPotion, EVENT_TEAM_ROCKET_BASE_B1F_HYPER_POTION
	object_event 14, 15, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TeamRocketBaseB1FNugget, EVENT_TEAM_ROCKET_BASE_B1F_NUGGET
	object_event 21, 12, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TeamRocketBaseB1FZoomLens, EVENT_TEAM_ROCKET_BASE_B1F_ZOOM_LENS


	object_const_def
	const TEAMROCKETBASEB1F_POKE_BALL1
	const TEAMROCKETBASEB1F_POKE_BALL2
	const TEAMROCKETBASEB1F_POKE_BALL3

TeamRocketBaseB1F_MapScripts:
	def_scene_scripts
	scene_script TeamRocketBaseB1FNoopScene, SCENE_TEAMROCKETBASEB1F_TRAPS

	def_callbacks

TeamRocketBaseB1FNoopScene:
	end

ExplodingTrap1:
	checkevent EVENT_EXPLODING_TRAP_1
	iftrue NoExplodingTrap
	scall KoffingExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_1
	end

ExplodingTrap2:
	checkevent EVENT_EXPLODING_TRAP_2
	iftrue NoExplodingTrap
	scall VoltorbExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_2
	end

ExplodingTrap3:
	checkevent EVENT_EXPLODING_TRAP_3
	iftrue NoExplodingTrap
	scall MagnemiteExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_3
	end

ExplodingTrap4:
	checkevent EVENT_EXPLODING_TRAP_4
	iftrue NoExplodingTrap
	scall VoltorbExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_4
	end

ExplodingTrap5:
	checkevent EVENT_EXPLODING_TRAP_5
	iftrue NoExplodingTrap
	scall MagnemiteExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_5
	end

ExplodingTrap6:
	checkevent EVENT_EXPLODING_TRAP_6
	iftrue NoExplodingTrap
	scall KoffingExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_6
	end

ExplodingTrap7:
	checkevent EVENT_EXPLODING_TRAP_7
	iftrue NoExplodingTrap
	scall VoltorbExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_7
	end

ExplodingTrap8:
	checkevent EVENT_EXPLODING_TRAP_8
	iftrue NoExplodingTrap
	scall KoffingExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_8
	end

ExplodingTrap9:
	checkevent EVENT_EXPLODING_TRAP_9
	iftrue NoExplodingTrap
	scall KoffingExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_9
	end

ExplodingTrap10:
	checkevent EVENT_EXPLODING_TRAP_10
	iftrue NoExplodingTrap
	scall VoltorbExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_10
	end

ExplodingTrap11:
	checkevent EVENT_EXPLODING_TRAP_11
	iftrue NoExplodingTrap
	scall MagnemiteExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_11
	end

ExplodingTrap12:
	checkevent EVENT_EXPLODING_TRAP_12
	iftrue NoExplodingTrap
	scall MagnemiteExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_12
	end

ExplodingTrap13:
	checkevent EVENT_EXPLODING_TRAP_13
	iftrue NoExplodingTrap
	scall MagnemiteExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_13
	end

ExplodingTrap14:
	checkevent EVENT_EXPLODING_TRAP_14
	iftrue NoExplodingTrap
	scall KoffingExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_14
	end

ExplodingTrap15:
	checkevent EVENT_EXPLODING_TRAP_15
	iftrue NoExplodingTrap
	scall VoltorbExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_15
	end

ExplodingTrap16:
	checkevent EVENT_EXPLODING_TRAP_16
	iftrue NoExplodingTrap
	scall KoffingExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_16
	end

ExplodingTrap17:
	checkevent EVENT_EXPLODING_TRAP_17
	iftrue NoExplodingTrap
	scall VoltorbExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_17
	end

ExplodingTrap18:
	checkevent EVENT_EXPLODING_TRAP_18
	iftrue NoExplodingTrap
	scall MagnemiteExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_18
	end

ExplodingTrap19:
	checkevent EVENT_EXPLODING_TRAP_19
	iftrue NoExplodingTrap
	scall MagnemiteExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_19
	end

ExplodingTrap20:
	checkevent EVENT_EXPLODING_TRAP_20
	iftrue NoExplodingTrap
	scall VoltorbExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_20
	end

ExplodingTrap21:
	checkevent EVENT_EXPLODING_TRAP_21
	iftrue NoExplodingTrap
	scall KoffingExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_21
	end

ExplodingTrap22:
	checkevent EVENT_EXPLODING_TRAP_22
	iftrue NoExplodingTrap
	scall VoltorbExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_22
	end

VoltorbExplodingTrap:
	special FadeOutPalettes
	special LoadMapPalettes
	cry VOLTORB
	special FadeInPalettes_EnableDynNoApply
	setlasttalked -1
	loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
	loadwildmon VOLTORB, 27
	startbattle
	end

MagnemiteExplodingTrap:
	special FadeOutPalettes
	special LoadMapPalettes
	special FadeInPalettes_EnableDynNoApply
	setlasttalked -1
	loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
	loadwildmon MAGNEMITE, 27
	startbattle
	end

KoffingExplodingTrap:
	special FadeOutPalettes
	special LoadMapPalettes
	cry KOFFING
	special FadeInPalettes_EnableDynNoApply
	setlasttalked -1
	loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
	loadwildmon KOFFING, 27
	startbattle
	end

NoExplodingTrap:
	end

TeamRocketBaseB1FHyperPotion:
	itemball HYPER_POTION
TeamRocketBaseB1FNugget:
	itemball NUGGET
TeamRocketBaseB1FZoomLens:
	itemball ZOOM_LENS
