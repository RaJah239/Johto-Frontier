; Modes for the shared move screen, used when picking a move to forget.
	const_def
	const MOVESCREEN_NORMAL
	const MOVESCREEN_NEWMOVE

DEF MOVESCREEN_LIST_LENGTH EQU NUM_MOVES + 1 ; the move being learned is listed too
DEF MAX_LIST_OFFSET EQU MOVESCREEN_LIST_LENGTH - NUM_MOVES ; four slots, five moves

LearnMove:
	call LoadTilemapToTempTilemap
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNickname
	ld hl, wStringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, MON_NAME_LENGTH
	call CopyBytes

.loop
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	ld d, h
	ld e, l
	ld b, NUM_MOVES
; Get the first empty move slot.  This routine also serves to
; determine whether the Pokemon learning the moves already has
; all four slots occupied, in which case one would need to be
; deleted.
.next
	ld a, [hl]
	and a
	jr z, .learn
	inc hl
	dec b
	jr nz, .next
; If we're here, we enter the routine for forgetting a move
; to make room for the new move we're trying to learn.
	push de
	call ForgetMove
	pop de
	jr c, .cancel

	push hl
	push de
	ld [wNamedObjectIndex], a

	ld b, a
	ld a, [wBattleMode]
	and a
	jr z, .not_disabled
	ld a, [wDisabledMove]
	cp b
	jr nz, .not_disabled
	xor a
	ld [wDisabledMove], a
	ld [wPlayerDisableCount], a
.not_disabled

	call GetMoveName
	ld hl, Text_1_2_and_Poof ; 1, 2 and…
	call PrintText
	pop de
	pop hl

.learn
	ld a, [wPutativeTMHMMove]
	ld [hl], a
	ld bc, MON_PP - MON_MOVES
	add hl, bc

	push hl
	push de
	dec a
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop de
	pop hl

	ld [hl], a

	ld a, [wBattleMode]
	and a
	jr z, .learned

	ld a, [wCurPartyMon]
	ld b, a
	ld a, [wCurBattleMon]
	cp b
	jr nz, .learned

	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_TRANSFORMED, a
	jr nz, .learned

	ld h, d
	ld l, e
	ld de, wBattleMonMoves
	ld bc, NUM_MOVES
	call CopyBytes
	ld bc, wPartyMon1PP - (wPartyMon1Moves + NUM_MOVES)
	add hl, bc
	ld de, wBattleMonPP
	ld bc, NUM_MOVES
	call CopyBytes
.learned
	ld hl, LearnedMoveText
	call PrintText
	ld b, 1
	ret

.cancel
	ld hl, StopLearningMoveText
	call PrintText
	call YesNoBox
	jmp c, .loop

	ld b, 0
	ret

ForgetMove:
	push hl
	ld hl, AskForgetMoveText
	call PrintText
	call DisplayMoveInfo
	call YesNoBox
	pop hl
	ret c
.loop
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	push de
	call ChooseMoveToForget
	pop de
	jr c, .cancel
	ld c, a
	ld b, 0
	ld h, d
	ld l, e
	add hl, bc
	ld a, [hl]
	ld d, a
	and a
	ret

.cancel
	farcall GetBattleMonBackpic
	farcall SafeLoadTempTilemapToTilemap
	scf
	ret

DisplayMoveInfo:
	xor a
	ldh [hBGMapMode], a

	hlcoord 3, 8 ; upper right corner of the textbox
	lb bc, 3, 9
	call Textbox
	call MobileTextBorder

	ld a, [wPutativeTMHMMove] ; the memory location holding the new move
	ld [wCurMove], a

	; move types
	ld a, [wCurSpecies]
	ld b, a
	hlcoord 5, 9
	predef PrintMoveType

	ld hl, Moves + MOVE_PP
	call GetCurMovePropertyLearn
	hlcoord 8, 11
	ld [wTextDecimalByte], a
	ld de, wTextDecimalByte
	lb bc, 1, 2
	call PrintNum
	ld [hl], "/"
	inc hl
	lb bc, 1, 2
	call PrintNum

	hlcoord 7, 10
	ld de, .PowAcc
	call PlaceString

	ld hl, Moves + MOVE_POWER
	call GetCurMovePropertyLearn
	hlcoord 4, 10
	cp 2
	jr c, .no_power
	ld [wTextDecimalByte], a
	ld de, wTextDecimalByte
	lb bc, 1, 3
	call PrintNum
	jr .place_accuracy

.no_power
	ld de, .NA
	call PlaceString

.place_accuracy
	ld hl, Moves + MOVE_POWER
	call GetCurMovePropertyLearn

	ld a, [wCurSpecies]
	ld bc, MOVE_LENGTH

	ld hl, (Moves + MOVE_EFFECT) - MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte

	ld hl, PerfectAccuracyEffects
	call IsInByteArray
	jr nc, .imperfect

	ld de, .NA
	ld bc, 3
	hlcoord 9, 10
	call PlaceString
	jr .category_icon

.imperfect
	ld hl, Moves + MOVE_ACC
	call GetCurMovePropertyLearn
	call ConvertPercentages
	ld [wBuffer1], a
	ld de, wBuffer1
	hlcoord 9, 10
	lb bc, 1, 3
	call PrintNum

.category_icon
; Get move struct pointer
	ld a, [wCurSpecies]
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes

; Check MOVE_POWER
	push hl
	ld de, MOVE_POWER
	add hl, de
	ld a, BANK(Moves)
	call GetFarByte
	pop hl

	cp 2
	jr c, .status_move

; Check MOVE_TYPE
	push hl
	ld de, MOVE_TYPE
	add hl, de
	ld a, BANK(Moves)
	call GetFarByte
	pop hl

	cp SPECIAL
	jr nc, .special_category

.physical_category
	hlcoord 4, 9
	ld de, .String_MovePhy
	jmp PlaceString

.special_category
	hlcoord 4, 9
	ld de, .String_MoveSpe
	jmp PlaceString

.status_move
	hlcoord 4, 9
	ld de, .String_MoveSta
	jmp PlaceString

.PowAcc: db "p/   <%>@"
.NA: db "---@"
.String_MovePhy: db "<physical>@"
.String_MoveSpe: db "<special>@"
.String_MoveSta: db "<other>@"

GetCurMovePropertyLearn:
	ld a, [wCurMove]
	dec a
; Assuming hl = Moves + x, return attribute x of move a.
	push bc
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop bc
	ret

ChooseMoveToForget:
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	ld a, [wPutativeTMHMMove]
	push af
	ld a, [wItemQuantity]
	push af
	ld a, [wCurItemQuantity]
	push af
	ld a, [wCurItem]
	push af
	call .BuildMoveList
	farcall ChooseMoveToLearn
	pop af
	ld [wCurItem], a
	pop af
	ld [wCurItemQuantity], a
	pop af
	ld [wItemQuantity], a
	pop af
	ld [wPutativeTMHMMove], a
	pop bc
	ld a, b
	ld [wOptions], a
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .cancel

	ld a, [wMenuSelection]
	ld hl, wPutativeTMHMMove
	cp [hl]
	jr z, .cancel ; the move being learned, so declining it
	ld d, a ; the chosen move, in d: ld bc below would wipe b
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld c, NUM_MOVES
.find_slot
	ld a, [hl]
	cp d
	jr z, .found_slot
	inc hl
	dec c
	jr nz, .find_slot
	jr .cancel ; not one of the mon's moves after all
.found_slot
	ld a, NUM_MOVES
	sub c
	push af
	call ClearSprites
	call ClearTilemap
	call .Teardown
	pop af
	and a
	ret

.cancel
	call ClearSprites
	call ClearTilemap
	call .Teardown
	scf
	ret

.BuildMoveList
	ld a, NUM_MOVES
	ld [wd002], a
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld de, wd002 + 1
	ld bc, NUM_MOVES
	call CopyBytes
	ld a, [wPutativeTMHMMove]
	ld [de], a
	inc de
	xor a
	ld [de], a ; the move list is zero terminated, as CheckAlreadyInList expects
	ret

; Rebuild whichever screen we interrupted.
.Teardown
	call ClearBGPalettes
	ld a, [wBattleMode]
	and a
	jr z, .overworld
	call ClearTilemap
	call ClearSprites
	call ClearPalettes
	farcall GetBattleMonBackpic
	farcall GetEnemyMonFrontpic
	farcall _LoadBattleFontsHPBar
	call UpdateSprites
	call SafeLoadTempTilemapToTilemap
	farjp FinishBattleAnim ; battle colours, then a frame

.overworld
; Back to the party menu
	ld a, [wCurPartyMon]
	push af
	xor a
	ld [wPartyMenuActionText], a
	farcall LoadPartyMenuGFX
	farcall InitPartyMenuWithCancel
	farcall InitPartyMenuGFX
	farcall WritePartyMenuTilemap
	pop af
	ld [wCurPartyMon], a
	call WaitBGMap
	call SetDefaultBGPAndOBP
	call SpeechTextbox
	jmp DelayFrame

LearnedMoveText:
	text_far _LearnedMoveText
	text_end

StopLearningMoveText:
	text_far _StopLearningMoveText
	text_end

AskForgetMoveText:
	text_far _AskForgetMoveText
	text_end

Text_1_2_and_Poof:
	text_far Text_MoveForgetCount ; 1, 2 and…
	text_asm
	push de
	ld de, SFX_SWITCH_POKEMON
	call PlaySFX
	pop de
	ld hl, .MoveForgotText
	ret

.MoveForgotText:
	text_far _MoveForgotText
	text_end
