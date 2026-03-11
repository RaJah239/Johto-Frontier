LakeOfRageHiddenPowerHouse_MapEvents:
	def_warp_events
	warp_event  2,  7, LAKE_OF_RAGE, 2
	warp_event  3,  7, LAKE_OF_RAGE, 2

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT
	bg_event  1,  1, BGEVENT_JUMPSTD, DIFFICULT_BOOKSHELF_SCRIPT

	def_object_events
	object_event  2,  4, SPRITE_FISHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, HiddenPowerGuy, -1
	object_event  3,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, LakeOfRageHiddenPowerHouseTMHiddenPower, EVENT_TM_HIDDEN_POWER
	object_event  4,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, LakeOfRageHiddenPowerHouseTMHiddenForce, EVENT_TM_HIDDEN_FORCE

	object_const_def
	const LAKEOFRAGEHIDDENPOWERHOUSE_FISHER
	const LAKEOFRAGEHIDDENPOWERHOUSE_TM_HIDDEN_POWER
	const LAKEOFRAGEHIDDENPOWERHOUSE_TM_HIDDEN_FORCE

LakeOfRageHiddenPowerHouse_MapScripts:
	def_scene_scripts

	def_callbacks

HiddenPowerGuy:
	checkevent EVENT_MET_HIDDEN_POWER_GUY
	iftrue .AlreadyMet
	setevent EVENT_MET_HIDDEN_POWER_GUY
	jumpthistextfaceplayer
		text "…You have strayed"
		line "far…"

		para "Here I have medi-"
		line "tated. Inside me,"
		cont "a new power has"
		cont "been awakened."

		para "Let me share my"
		line "power with your"
		cont "#mon."

		para "Take both from the"
		line "table."

		para "Do you see them?"

		para "Hidden Power and"
		line "Hidden Force!"

		para "They draw out the"
		line "core trait of"
		cont "#mon to attack."

		para "Remember this: its"
		line "type depends on"
		cont "the #mon using"
		cont "it and can't be"
		cont "Fairy or Normal."
		done

.AlreadyMet:
	jumpthistextfaceplayer
		text "Remember this: its"
		line "type depends on"
		cont "the #mon using"
		cont "it and can't be"
		cont "Fairy or Normal."
		done

LakeOfRageHiddenPowerHouseTMHiddenPower:
	itemball TM_HIDDEN_POWER
LakeOfRageHiddenPowerHouseTMHiddenForce:
	itemball TM_HIDDEN_FORCE
