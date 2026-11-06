ShowBattleMoveInfo:
; Draw Eff% and move description under the move info box, wait for A/B,
; then clear the overlay. Called via farcall from MoveSelectionScreen
; in Battle Core (wCurSpecies/wCurPlayerMove already hold the move).
	call ClearSprites
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 12
	lb bc, 4, 18
	call Textbox

; Eff: X% (effect chance, fraction as percent)
	ld de, .eff_label
	hlcoord 1, 13
	call PlaceString

	ld a, [wCurSpecies]
	ld bc, MOVE_LENGTH
	ld hl, (Moves + MOVE_CHANCE) - MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	cp 1
	jr c, .no_eff
	call ConvertPercentages
	ld [wBuffer1], a
	ld de, wBuffer1
	lb bc, 1, 3
	hlcoord 6, 13
	call PrintNum
	ld [hl], "<%>"
	jr .do_desc

.no_eff
	ld de, .blank
	hlcoord 6, 13
	call PlaceString

.do_desc
	hlcoord 1, 15
	predef PrintMoveDescription
	ld a, $1
	ldh [hBGMapMode], a
	call WaitBGMap

.wait_ab
	call DelayFrame
	call GetJoypad
	ldh a, [hJoyPressed]
	and A_BUTTON | B_BUTTON
	jr z, .wait_ab
	jmp SafeLoadTempTilemapToTilemap

.eff_label db "Eff: @"
.blank db "---@"
