CatchTutorial::
	ld a, [wBattleType]
	dec a
	ld c, a
	ld hl, .dw
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.dw
	dw .DudeTutorial
	dw .DudeTutorial
	dw .DudeTutorial

.DudeTutorial:
; Back up your name to your Mom's name.
	ld hl, wPlayerName
	ld de, wMomsName
	ld bc, NAME_LENGTH
	call CopyBytes
; Copy Dude's name to your name
	ld hl, .Dude
	ld de, wPlayerName
	ld bc, NAME_LENGTH
	call CopyBytes

	call .LoadDudeData

	xor a
	ldh [hJoyDown], a
	ldh [hJoyPressed], a
	ld a, [wOptions]
	push af
	and ~TEXT_DELAY_MASK
	add TEXT_DELAY_NONE
	ld [wOptions], a
	ld hl, .AutoInput
	ld a, BANK(.AutoInput)
	call StartAutoInput
	callfar StartBattle
	call StopAutoInput
	pop af

	ld [wOptions], a
	ld hl, wMomsName
	ld de, wPlayerName
	ld bc, NAME_LENGTH
	call CopyBytes
	ret

.LoadDudeData:
	ld hl, wDudeNumItems
	ld de, .DudeItems
	call .CopyDudeData

	ld hl, wDudeNumFruits
	ld [hl], 0
	inc hl
	ld [hl], -1

	ld hl, wDudeNumKeyItems
	ld [hl], 0
	inc hl
	ld [hl], -1

	ld hl, wDudeNumBalls
	ld de, .DudeBalls
	; fallthrough

.CopyDudeData:
	ld a, [de]
	inc de
	ld [hli], a
	cp -1
	jr nz, .CopyDudeData
	ret

.Dude:
	db "Dude@"

.DudeItems:
	db 4, SACRED_ASH, 99,  CRYSTAL, 99, HYPER_EV_UP, 99, RARE_CANDY, 99, -1
.DudeBalls:
	db 3, POKE_BALL, 1, MASTER_BALL, 99, SHINY_BALL, 99, -1

.AutoInput:
	db NO_INPUT, $ff ; end
