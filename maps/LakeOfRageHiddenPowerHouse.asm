	object_const_def
	const LAKEOFRAGEHIDDENPOWERHOUSE_FISHER
	const LAKEOFRAGEHIDDENPOWERHOUSE_TM_HIDDEN_POWER
	const LAKEOFRAGEHIDDENPOWERHOUSE_TM_HIDDEN_FORCE

LakeOfRageHiddenPowerHouse_MapScripts:
	def_scene_scripts

	def_callbacks

HiddenPowerGuy:
	faceplayer
	opentext
	checkevent EVENT_MET_HIDDEN_POWER_GUY
	iftrue .AlreadyMet
	setevent EVENT_MET_HIDDEN_POWER_GUY
	writetextend HiddenPowerGuyText1

.AlreadyMet:
	writetextend HiddenPowerGuyText2

HiddenPowerGuyText1:
	text "…You have strayed"
	line "far…"

	para "Here I have medi-"
	line "tated. Inside me,"

	para "a new power has"
	line "been awakened."

	para "Let me share my"
	line "power with your"

	para "#mon. Take"
	line "them both from the"
	cont "table."

	para "Do you see them?"
	line "Hidden Power and"
	cont "Hidden Force!"

	para "They draw out the"
	line "core trait of"
	cont "#mon to attack."

	para "Remember this: its"
	line "type and power de-"
	cont "pend on the #-"
	cont "mon using it"
	cont "and can't be either"
	cont "Fairy or Normal."
	done

HiddenPowerGuyText2:
	text "Remember this: its"
	line "type and power de-"
	cont "pend on the #-"
	cont "mon using it"
	cont "and can't be either"
	cont "Fairy or Normal."
	done

LakeOfRageHiddenPowerHouseTMHiddenPower:
	itemball TM_HIDDEN_POWER

LakeOfRageHiddenPowerHouseTMHiddenForce:
	itemball TM_HIDDEN_FORCE

HiddenPowerHouseBookshelf:
	jumpstd DifficultBookshelfScript

LakeOfRageHiddenPowerHouse_MapEvents:
	def_warp_events
	warp_event  2,  7, LAKE_OF_RAGE, 2
	warp_event  3,  7, LAKE_OF_RAGE, 2

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, HiddenPowerHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, HiddenPowerHouseBookshelf

	def_object_events
	object_event  2,  4, SPRITE_FISHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, HiddenPowerGuy, -1
	object_event  3,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, LakeOfRageHiddenPowerHouseTMHiddenPower, EVENT_TM_HIDDEN_POWER
	object_event  4,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, LakeOfRageHiddenPowerHouseTMHiddenForce, EVENT_TM_HIDDEN_FORCE
