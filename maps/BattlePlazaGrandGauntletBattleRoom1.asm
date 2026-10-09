BattlePlazaGrandGauntletBattleRoom1_MapEvents:
	def_warp_events

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  0, SPRITE_CRYSTAL, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GGR1Crystal, -1
	object_event  1,  3, SPRITE_UNKNOWN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GG1Trainer1, EVENT_GG_ROOM_1_TRAINER_1
	object_event  4,  1, SPRITE_UNKNOWN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GG1Trainer2, EVENT_GG_ROOM_1_TRAINER_2
	object_event  4,  3, SPRITE_UNKNOWN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GG1Trainer3, EVENT_GG_ROOM_1_TRAINER_3
	object_event  1,  5, SPRITE_CHEST, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GGR1Item1, EVENT_FIRST_GG
	object_event  0,  2, SPRITE_CHEST, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GGR1Item2, EVENT_GG_ROOM_1_ITEM_2
	object_event 4,  5, SPRITE_CHEST, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GGR1Item3, EVENT_GG_ROOM_1_ITEM_3

	object_const_def
	const BATTLEPLAZAGRANDGAUNTLETBATTLEROOM1_TRAINER1
	const BATTLEPLAZAGRANDGAUNTLETBATTLEROOM1_TRAINER2
	const BATTLEPLAZAGRANDGAUNTLETBATTLEROOM1_TRAINER3
	const BATTLEPLAZAGRANDGAUNTLETBATTLEROOM1_CHEST1
	const BATTLEPLAZAGRANDGAUNTLETBATTLEROOM1_CHEST2
	const BATTLEPLAZAGRANDGAUNTLETBATTLEROOM1_CHEST3

BattlePlazaGrandGauntletBattleRoom1_MapScripts:
	def_scene_scripts

	def_callbacks

GG1Trainer1:
	gg_trainer EVENT_GG_ROOM_1_TRAINER_1, SCARLET1
GG1Trainer2:
	gg_trainer EVENT_GG_ROOM_1_TRAINER_2, SCARLET1
GG1Trainer3:
	gg_trainer EVENT_GG_ROOM_1_TRAINER_3, SCARLET1
NoText:
	no_text

GGR1Crystal:
	checkevent EVENT_GG_ROOM_1_TRAINER_1
	iffalse .done
	checkevent EVENT_GG_ROOM_1_TRAINER_2
	iffalse .done
	checkevent EVENT_GG_ROOM_1_TRAINER_3
	iffalse .done
	opentext
	writethistext
		text "Warp to the next"
		line "floor?"
		done
	yesorno
	iffalse_endtext
	closetext
	playsound SFX_WARP_TO
	special FadeOutPalettes
	waitsfx
	warp BATTLE_PLAZA_GRAND_GAUNTLET, 3, 13
.done
	end

GGR1Item1:
GGR1Item2:
GGR1Item3:
	jumpstd GrandGauntletItemsScript
