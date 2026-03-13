MountMortarSquare_MapEvents:
	def_warp_events
	warp_event 13,  7, MT_MORTAR_GIFT_SHOP, 1
	warp_event 20,  5, MOUNT_MORTAR_2F_INSIDE, 3

	def_coord_events
	coord_event  7, 11, SCENE_MOUNTMORTARSQUARE_CLEFAIRY_DANCE, ClefairyDance

	def_bg_events
	bg_event  7,  7, BGEVENT_ITEM + MOON_STONE, EVENT_MT_MORTAR_SQUARE_HIDDEN_MOON_STONE
	bg_event 17,  7, BGEVENT_JUMPTEXT, DontLitterSignText

	def_object_events
	object_event  6,  6, SPRITE_FAIRY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_MT_MORTAR_SQUARE_CLEFAIRY
	object_event  7,  6, SPRITE_FAIRY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_MT_MORTAR_SQUARE_CLEFAIRY
	rocksmash_event  7,  7, EVENT_MT_MORTAR_SQUARE_ROCK

	object_const_def
	const MOUNTMORTARSQUARE_FAIRY1
	const MOUNTMORTARSQUARE_FAIRY2
	const MOUNTMORTARSQUARE_ROCK

MountMortarSquare_MapScripts:
	def_scene_scripts
	scene_script MountMortarSquareNoopScene, SCENE_MOUNTMORTARSQUARE_CLEFAIRY_DANCE

	def_callbacks
	callback MAPCALLBACK_OBJECTS, MountMortarSquareDisappearRockCallback

MountMortarSquareNoopScene:
	end


MountMortarSquareDisappearRockCallback:
	disappear MOUNTMORTARSQUARE_ROCK
	endcallback

ClefairyDance:
	checkflag ENGINE_MT_MOON_SQUARE_CLEFAIRY
	iftrue .NoDancing
	readvar VAR_WEEKDAY
	ifnotequal MONDAY, .NoDancing
	checktime NITE
	iffalse .NoDancing
	appear MOUNTMORTARSQUARE_FAIRY1
	appear MOUNTMORTARSQUARE_FAIRY2
	applymovement PLAYER, PlayerWalksUpToDancingClefairies
	pause 15
	appear MOUNTMORTARSQUARE_ROCK
	turnobject MOUNTMORTARSQUARE_FAIRY1, RIGHT
	cry CLEFAIRY
	waitsfx
	pause 30
	follow MOUNTMORTARSQUARE_FAIRY1, MOUNTMORTARSQUARE_FAIRY2
	cry CLEFAIRY
	applymovement MOUNTMORTARSQUARE_FAIRY1, ClefairyDanceStep1
	cry CLEFAIRY
	applymovement MOUNTMORTARSQUARE_FAIRY1, ClefairyDanceStep2
	cry CLEFAIRY
	applymovement MOUNTMORTARSQUARE_FAIRY1, ClefairyDanceStep3
	cry CLEFAIRY
	applymovement MOUNTMORTARSQUARE_FAIRY1, ClefairyDanceStep4
	cry CLEFAIRY
	applymovement MOUNTMORTARSQUARE_FAIRY1, ClefairyDanceStep5
	stopfollow
	applymovement MOUNTMORTARSQUARE_FAIRY2, ClefairyDanceStep6
	follow MOUNTMORTARSQUARE_FAIRY1, MOUNTMORTARSQUARE_FAIRY2
	applymovement MOUNTMORTARSQUARE_FAIRY1, ClefairyDanceStep7
	stopfollow
	turnobject MOUNTMORTARSQUARE_FAIRY1, DOWN
	pause 10
	showemote EMOTE_SHOCK, MOUNTMORTARSQUARE_FAIRY1, 15
	turnobject MOUNTMORTARSQUARE_FAIRY1, DOWN
	cry CLEFAIRY
	pause 15
	follow MOUNTMORTARSQUARE_FAIRY1, MOUNTMORTARSQUARE_FAIRY2
	applymovement MOUNTMORTARSQUARE_FAIRY1, ClefairyFleeMovement
	disappear MOUNTMORTARSQUARE_FAIRY1
	disappear MOUNTMORTARSQUARE_FAIRY2
	stopfollow
	clearevent EVENT_MT_MORTAR_SQUARE_HIDDEN_MOON_STONE
	setflag ENGINE_MT_MOON_SQUARE_CLEFAIRY
	end

.NoDancing:
	end

PlayerWalksUpToDancingClefairies:
	step UP
	step_end

ClefairyDanceStep1:
	slow_step DOWN
	slow_jump_step DOWN
	step_end

ClefairyDanceStep2:
	slow_jump_step RIGHT
	step_end

ClefairyDanceStep3:
	slow_step UP
	slow_jump_step UP
	step_end

ClefairyDanceStep4:
	slow_jump_step LEFT
	step_end

ClefairyDanceStep5:
	slow_step DOWN
	slow_jump_step DOWN
	step_end

ClefairyDanceStep6:
	slow_step DOWN
	step_end

ClefairyDanceStep7:
	slow_step RIGHT
	step_end

ClefairyFleeMovement:
	step RIGHT
	step RIGHT
	step RIGHT
	jump_step RIGHT
	step RIGHT
	step RIGHT
	step_end

DontLitterSignText:
	text "Mt.Mortar Square"
	line "Don't Litter"
	done
