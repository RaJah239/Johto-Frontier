OlivinePort_MapEvents:
	def_warp_events
	warp_event 11,  7, OLIVINE_PORT_PASSAGE, 5

	def_coord_events

	def_bg_events

	def_object_events
	object_event  7, 15, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivinePortSailor1Script, -1

	object_const_def
	const OLIVINEPORT_SAILOR1

OlivinePort_MapScripts:
	def_scene_scripts

	def_callbacks

; TODOTEXT to populate this area

OlivinePortSailor1Script:
	faceplayeropentext
	writethistext
		text "Would you like to"
		line "sail to Cianwood"
		cont "City?"
		done
	yesorno
	iffalse_endtext
	special PlaceMoneyTopRight
	writethistext
		text "It'll cost ¥2,000."
		line "Board?"
		done
	yesorno
	iffalse_endtext
	checkmoney YOUR_MONEY, 2000
	ifequal HAVE_LESS, .NeedMoreMoney
	takemoney YOUR_MONEY, 2000
	special PlaceMoneyTopRight
	waitsfx
	playsound SFX_TRANSACTION
	writethistext
		text "Right this way"
		line "please."
		done
	waitclosetext
	playmusic MUSIC_SHOW_ME_AROUND
	follow OLIVINEPORT_SAILOR1, PLAYER
	applymovement OLIVINEPORT_SAILOR1, OlivinePortSailor1Movement
	pause 10
	playsound SFX_EXIT_BUILDING
	disappear OLIVINEPORT_SAILOR1
	waitsfx
	applymovement PLAYER, OlivinePortEnterFastShipMovement
	playsound SFX_EXIT_BUILDING
	disappear PLAYER
	pause 30
	playsound SFX_BOAT
	earthquake 30
	special FadeOutToWhite
	waitsfx
	warp CIANWOOD_PORT, 7, 17
	applymovement PLAYER, CianwoodPortExitFastShipMovement1
	showemote EMOTE_SHOCK, CIANWOODPORT_SAILOR1, 15
	applymovement CIANWOODPORT_SAILOR1, CianwoodPort_SAILOR1_MovesLeft
	applymovement PLAYER, CianwoodPortExitFastShipMovement2
	applymovement CIANWOODPORT_SAILOR1, CianwoodPort_SAILOR1_MovesRight
	end

.NeedMoreMoney:
	jumpthisopenedtext
		text "Sorry, you don't"
		line "have enough money."
		done

OlivinePortSailor1Movement:
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end

OlivinePortEnterFastShipMovement:
	step DOWN
	step_end

CianwoodPortExitFastShipMovement1:
	step UP
	step UP
	step UP
	step UP
	step UP
	step_end

CianwoodPort_SAILOR1_MovesLeft:
	step LEFT
	turn_head UP
	step_end

CianwoodPortExitFastShipMovement2:
	step UP
	step RIGHT
	turn_head UP
	step_end

CianwoodPort_SAILOR1_MovesRight:
	step RIGHT
	turn_head UP
	step_end
