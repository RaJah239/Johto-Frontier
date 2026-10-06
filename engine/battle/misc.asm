_DisappearUser:
	xor a
	ldh [hBGMapMode], a
	ldh a, [hBattleTurn]
	and a
	jr z, .player
	call GetEnemyFrontpicCoords
	jr .okay
.player
	call GetPlayerBackpicCoords
.okay
	call ClearBox
	jr FinishAppearDisappearUser

_AppearUserRaiseSub:
	farcall BattleCommand_RaiseSubNoAnim
	jr AppearUser

_AppearUserLowerSub:
	farcall BattleCommand_LowerSubNoAnim
	; fallthrough

AppearUser:
	xor a
	ldh [hBGMapMode], a
	ldh a, [hBattleTurn]
	and a
	jr z, .player
	call GetEnemyFrontpicCoords
	xor a
	jr .okay
.player
	call GetPlayerBackpicCoords
	ld a, $31
.okay
	ldh [hGraphicStartTile], a
	predef PlaceGraphic
FinishAppearDisappearUser:
	ld a, $1
	ldh [hBGMapMode], a
	ret

GetEnemyFrontpicCoords:
	hlcoord 12, 0
	lb bc, 7, 7
	ret

GetPlayerBackpicCoords:
	hlcoord 2, 6
	lb bc, 6, 6
	ret

DoWeatherModifiers:
	ld de, WeatherTypeModifiers
	ld a, [wBattleWeather]
	ld b, a
	ld a, [wCurType]
	ld c, a

.CheckWeatherType:
	ld a, [de]
	inc de
	cp -1
	jr z, .done_weather_types

	cp b
	jr nz, .NextWeatherType

	ld a, [de]
	cp c
	jr z, .ApplyModifier

.NextWeatherType:
	inc de
	inc de
	jr .CheckWeatherType

.done_weather_types
	ld de, WeatherMoveModifiers

	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	ld c, a

.CheckWeatherMove:
	ld a, [de]
	inc de
	cp -1
	ret z

	cp b
	jr nz, .NextWeatherMove

	ld a, [de]
	cp c
	jr z, .ApplyModifier

.NextWeatherMove:
	inc de
	inc de
	jr .CheckWeatherMove

.ApplyModifier:
	xor a
	ldh [hMultiplicand + 0], a
	ld hl, wCurDamage
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hl]
	ldh [hMultiplicand + 2], a

	inc de
	ld a, [de]
	ldh [hMultiplier], a

	call Multiply

	ld a, 10
	ldh [hDivisor], a
	ld b, 4
	call Divide

	ldh a, [hQuotient + 1]
	and a
	ld bc, -1
	jr nz, .Update

	ldh a, [hQuotient + 2]
	ld b, a
	ldh a, [hQuotient + 3]
	ld c, a
	or b
	jr nz, .Update

	ld bc, 1

.Update:
	ld a, b
	ld [wCurDamage], a
	ld a, c
	ld [wCurDamage + 1], a
	ret

INCLUDE "data/battle/weather_modifiers.asm"

; =====================
; === Ability Popup ===
; =====================

assert ABILITY_POPUP_OAM_BYTES == 2 * PARTY_LENGTH * SPRITEOAMSTRUCT_LENGTH

ShowAbilityPopup::
; Slides a two-line "Ability:" popup over a battle HUD box.
; No-op outside of battle (wBattleMode = 0).
; Call it with a plain farcall:
;   b = bank of the second line's text
;   c = side: ABILITY_POPUP_PLAYER or ABILITY_POPUP_ENEMY
;   de = second line, terminated with "@" or $00 and at most
;        ABILITY_POPUP_WIDTH - 2 chars long
; The box slides in over ABILITY_POPUP_SLIDE_FRAMES frames, stays
; for ABILITY_POPUP_HOLD_FRAMES frames, then slides out again.
; The player's box comes in from the right and leaves to the
; right; the enemy's comes in from the left and leaves to the
; left. The ball strips are hidden while it is up.
	ld a, [wBattleMode]
	and a
	ret z

	ld a, [wOptions4]
	bit ABILITY_BANNERS, a
	ret nz

	ld a, c
	and a
	jr nz, .enemy

; player: covers rows 8-11 (BG third 1), resting at x = 8
	ld a, 8
	ld [wAbilityPopupTopRow], a
	ld a, 8
	ld [wAbilityPopupRestX], a
	ld a, 1
	ld [wAbilityPopupThird], a
	ld hl, AbilityPopupSlideIn_Player
	jr .got_side

.enemy
; enemy: covers rows 1-4 (BG third 0), resting at x = 0
	ld a, 1
	ld [wAbilityPopupTopRow], a
	ld a, 0
	ld [wAbilityPopupRestX], a
	xor a
	ld [wAbilityPopupThird], a
	ld hl, AbilityPopupSlideIn_Enemy
.got_side
	ld a, l
	ld [wAbilityPopupSlideTbl], a
	ld a, h
	ld [wAbilityPopupSlideTbl + 1], a

	call AbilityPopupBuildBox
	call AbilityPopupSaveRows

; Hide the party ball strips for the duration of the popup.
; Their Y bytes are parked on the stack (there is no room for
; them in WRAM) and are popped back before returning.
	ld hl, wShadowOAMSprite00
	ld b, ABILITY_POPUP_OAM_SPRITES
.hide_sprites
	ld a, [hl]
	push af
	ld a, 160 ; off-screen
	ld [hl], a
	inc hl
	inc hl
	inc hl
	inc hl
	dec b
	jr nz, .hide_sprites

	ld de, SFX_MENU
	call PlaySFX

; slide in
	ld a, [wAbilityPopupSlideTbl]
	ld l, a
	ld a, [wAbilityPopupSlideTbl + 1]
	ld h, a
	call AbilityPopupSlideFrames

; stay on screen
	ld c, ABILITY_POPUP_HOLD_FRAMES
	call DelayFrames

; slide out (the out table follows the in table)
	ld a, [wAbilityPopupSlideTbl]
	ld l, a
	ld a, [wAbilityPopupSlideTbl + 1]
	ld h, a
	ld de, ABILITY_POPUP_SLIDE_FRAMES
	add hl, de
	call AbilityPopupSlideFrames

; show the party ball strips again
	ld hl, wShadowOAMSprite00 + (ABILITY_POPUP_OAM_SPRITES - 1) * SPRITEOAMSTRUCT_LENGTH
	ld b, ABILITY_POPUP_OAM_SPRITES
.restore_sprites
	pop af
	ld [hl], a
	dec hl
	dec hl
	dec hl
	dec hl
	dec b
	jr nz, .restore_sprites
	ret

AbilityPopupSlideFrames:
; Run the ABILITY_POPUP_SLIDE_FRAMES frames of the table at hl.
	ld b, ABILITY_POPUP_SLIDE_FRAMES
.frame_loop
	ld a, [hl]
	inc hl
	push hl
	push bc
	call AbilityPopupDrawFrame
	pop bc
	pop hl
	dec b
	jr nz, .frame_loop
	ret

AbilityPopupDrawFrame:
; Draw one frame of the slide; a = offset from the rest position.
	ld b, a
	ld a, [wAbilityPopupRestX]
	add a, b
	ld [wAbilityPopupBoxX], a

; Edit the tilemap with BG transfers off, then flush exactly the
; third that holds the box's rows in the same frame.
	xor a
	ldh [hBGMapMode], a
	call AbilityPopupRestoreRows
	call AbilityPopupDrawSlice
	ld a, [wAbilityPopupThird]
	ldh [hBGMapThird], a
	ld a, 1
	ldh [hBGMapMode], a
	jmp DelayFrame

AbilityPopupBuildBox:
; Build the popup box into wAbilityPopupStaging.
; b = text bank, de = text pointer.
	push de ; the text pointer, across the box drawing

	; start from all spaces
	ld hl, wAbilityPopupStaging
	ld c, SCREEN_WIDTH * ABILITY_POPUP_HEIGHT
	ld a, " "
.fill_loop
	ld [hli], a
	dec c
	jr nz, .fill_loop

	; border; b and de survive it, c is the interior width.
	; Stage the box at the width that actually gets drawn, so
	; the right border is part of the slice instead of sitting
	; in columns the draw pass skips.
	push bc
	ld hl, wAbilityPopupStaging
	ld b, ABILITY_POPUP_HEIGHT - 2
	ld c, ABILITY_POPUP_WIDTH - 2
	call TextboxBorder
	pop bc

	; first line (this bank)
	ld hl, wAbilityPopupStaging + SCREEN_WIDTH + 1
	ld de, AbilityPopupLine1
	call AbilityPopupCopyLine

	; second line (the caller's bank). Read it one byte at a
	; time with GetFarByte: this routine itself lives in the
	; switchable window, so switching banks here would pull the
	; code out from under the CPU. GetFarByte does the switch
	; and the restore from home, where the window does not reach.
	pop de
	ld hl, wAbilityPopupStaging + 2 * SCREEN_WIDTH + 1
	ld c, ABILITY_POPUP_WIDTH - 2
.far_loop
	push hl
	ld h, d
	ld l, e
	ld a, b ; the text's bank
	call GetFarByte
	pop hl
	cp "@"
	ret z
	and a
	ret z
	ld [hli], a
	inc de
	dec c
	jr nz, .far_loop
	ret

AbilityPopupLine1:
	db "Ability:@"

AbilityPopupCopyLine:
; Copy up to the box's interior width (ABILITY_POPUP_WIDTH - 2)
; bytes from de to hl, stopping at "@" or $00. The destination is
; pre-filled with spaces, so no terminator is written.
	ld c, ABILITY_POPUP_WIDTH - 2
.loop
	ld a, [de]
	cp "@"
	ret z
	and a
	ret z
	ld [hl], a
	inc de
	inc hl
	dec c
	jr nz, .loop
	ret

AbilityPopupSaveRows:
; Set aside the four rows the box is about to cover.
	ld a, [wAbilityPopupTopRow]
	call AbilityPopupMulATimes20
	ld de, wTilemap
	add hl, de ; hl = source
	ld de, wAbilityPopupSaved
	ld bc, SCREEN_WIDTH * ABILITY_POPUP_HEIGHT
	jmp CopyBytes

AbilityPopupRestoreRows:
; Put the four covered rows back into the tilemap.
	ld a, [wAbilityPopupTopRow]
	call AbilityPopupMulATimes20
	ld de, wTilemap
	add hl, de
	ld d, h
	ld e, l ; de = destination
	ld hl, wAbilityPopupSaved
	ld bc, SCREEN_WIDTH * ABILITY_POPUP_HEIGHT
	jmp CopyBytes

AbilityPopupDrawSlice:
; Copy the on-screen part of the box over the restored rows.
; Uses wAbilityPopupBoxX and wAbilityPopupTopRow.
	ld a, [wAbilityPopupTopRow]
	call AbilityPopupMulATimes20
	ld de, wTilemap
	add hl, de
	ld d, h
	ld e, l ; de = destination row
	ld hl, wAbilityPopupStaging ; source row

.row_loop
	ld b, 0 ; column
.col_loop
	; distance from the left edge of the box
	ld a, [wAbilityPopupBoxX]
	cpl
	inc a
	add a, b
	bit 7, a
	jr nz, .advance ; left of the box
	cp ABILITY_POPUP_WIDTH
	jr nc, .advance ; right of the box

	; staging[row * 20 + a] -> tilemap
	ld c, a
	push hl
	ld a, l
	add a, c
	ld l, a
	jr nc, .got_tile
	inc h
.got_tile
	ld a, [hl]
	pop hl
	ld [de], a
.advance
	inc de
	inc b
	ld a, b
	cp SCREEN_WIDTH
	jr c, .col_loop

	; next staging row (the tilemap pointer moved along already)
	ld a, l
	add a, SCREEN_WIDTH
	ld l, a
	jr nc, .next_row
	inc h
.next_row
	ld a, h
	cp HIGH(wAbilityPopupStagingEnd)
	jr nz, .row_loop
	ld a, l
	cp LOW(wAbilityPopupStagingEnd)
	jr nz, .row_loop
	ret

AbilityPopupMulATimes20:
; a -> hl (a * SCREEN_WIDTH)
; Clobbers de.
	ld l, a
	ld h, 0
	add hl, hl ; 2a
	add hl, hl ; 4a
	ld d, h
	ld e, l ; de = 4a
	add hl, hl ; 8a
	add hl, hl ; 16a
	add hl, de ; 20a
	ret

; Offsets from the rest position, one per frame. The out table
; must follow the in table, since it is reached by adding
; ABILITY_POPUP_SLIDE_FRAMES to its address.
AbilityPopupSlideIn_Player:
	db 15, 14, 12, 10, 9, 7, 5, 3, 2, 0
AbilityPopupSlideOut_Player:
	db 2, 3, 5, 7, 9, 10, 12, 14, 15, 17

AbilityPopupSlideIn_Enemy:
	db -16, -14, -13, -11, -9, -7, -5, -4, -2, 0
AbilityPopupSlideOut_Enemy:
	db -2, -4, -5, -7, -9, -11, -13, -14, -16, -18
