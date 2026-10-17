BattlePlazaGrandGauntletBattleRoom1_MapEvents:
	def_warp_events

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  0, SPRITE_CRYSTAL, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GGR1Crystal, -1
	object_event  1,  3, SPRITE_UNKNOWN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GG1Trainer1, -1
	object_event  4,  1, SPRITE_UNKNOWN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GG1Trainer2, -1
	object_event  4,  3, SPRITE_UNKNOWN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GG1Trainer3, -1
	object_event  1,  5, SPRITE_CHEST, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GGR1Item1, EVENT_GG_ROOM_ITEM_1
	object_event  0,  2, SPRITE_CHEST, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GGR1Item2, EVENT_GG_ROOM_ITEM_2
	object_event  4,  5, SPRITE_CHEST, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GGR1Item3, EVENT_GG_ROOM_ITEM_3

	object_const_def
	const BATTLEPLAZAGRANDGAUNTLETBATTLEROOM1_CRYSTAL
	const BATTLEPLAZAGRANDGAUNTLETBATTLEROOM1_TRAINER1
	const BATTLEPLAZAGRANDGAUNTLETBATTLEROOM1_TRAINER2
	const BATTLEPLAZAGRANDGAUNTLETBATTLEROOM1_TRAINER3
	const BATTLEPLAZAGRANDGAUNTLETBATTLEROOM1_CHEST1
	const BATTLEPLAZAGRANDGAUNTLETBATTLEROOM1_CHEST2
	const BATTLEPLAZAGRANDGAUNTLETBATTLEROOM1_CHEST3

BattlePlazaGrandGauntletBattleRoom1_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, GrandGauntletBattleRoom1Entered

GrandGauntletBattleRoom1Entered:
	callasm SetGrandGauntletRun
	endcallback

SetGrandGauntletRun:
	ld a, [wGrandGauntletRun]
	and a
	jr nz, .already_running

	; First entry of the run
	; remember the current Experience Gain mode and 
	; Exp Share setting so they can be put back when the run ends.

	call GetExpMode
	ld [wGrandGauntletPrevExpMode], a
	call GetExpShare
	ld [wGrandGauntletPrevExpShare], a

.already_running
	ld a, 1
	ld [wGrandGauntletRun], a
	; Experience Gain is locked to Scaled and Exp. Share is on for the run.
	ld a, 1 ; Scaled
	call ApplyExpMode
	ld a, 1 ; on
	jr ApplyExpShare

; Returns the current Experience Gain mode in a:
; 0 = Normal, 1 = Scaled, 2 = Zero
GetExpMode:
	ld c, 0
	ld a, [wOptions2]
	bit SCALED_EXP, a
	jr z, .not_scaled
	inc c
.not_scaled
	ld a, [wTextboxFlags]
	bit ZERO_EXP_F, a
	jr z, .not_zero
	inc c
	inc c
.not_zero
	ld a, c
	ret

; Applies the Experience Gain mode in a (0 = Normal, 1 = Scaled, 2 = Zero)
ApplyExpMode:
	ld b, a
	ld a, [wOptions2]
	res SCALED_EXP, a
	bit 0, b
	jr z, .not_scaled
	set SCALED_EXP, a
.not_scaled
	ld [wOptions2], a
	ld a, [wTextboxFlags]
	res ZERO_EXP_F, a
	bit 1, b
	jr z, .not_zero
	set ZERO_EXP_F, a
.not_zero
	ld [wTextboxFlags], a
	ret

; Returns the current Exp. Share setting in a: 0 = off, 1 = on
GetExpShare:
	ld hl, wExpShareToggle
	xor a
	bit EXP_SHARE, [hl]
	ret z
	inc a
	ret

; Applies the Exp. Share setting in a (0 = off, 1 = on)
ApplyExpShare:
	ld hl, wExpShareToggle
	bit 0, a
	jr z, .off
	set EXP_SHARE, [hl]
	ret

.off
	res EXP_SHARE, [hl]
	ret

GG1Trainer1:
	gg_trainer EVENT_GG_ROOM_TRAINER_1, SCARLET1
GG1Trainer2:
	gg_trainer EVENT_GG_ROOM_TRAINER_2, SCARLET1
GG1Trainer3:
	gg_trainer EVENT_GG_ROOM_TRAINER_3, SCARLET1
NoText:
	no_text

GGR1Crystal:
	gg_room_crystal EVENT_GG_ROOM_TRAINER_1, EVENT_GG_ROOM_TRAINER_2, EVENT_GG_ROOM_TRAINER_3, BATTLE_PLAZA_GRAND_GAUNTLET_BATTLE_ROOM_2, 2, 5

GGR1Item1:
GGR1Item2:
GGR1Item3:
	jumpstd GrandGauntletItemsScript
