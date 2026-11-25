_SwitchPartyMons:
	ld a, [wSwitchMon]
	dec a
	ld [wSwitchMonFrom], a
	ld b, a
	ld a, [wMenuCursorY]
	dec a
	ld [wSwitchMonTo], a
	cp b
	ret z
	call .SwapMonAndMail
	ld a, [wSwitchMonFrom]
	call .ClearSprite
	ld a, [wSwitchMonTo]
	; fallthrough

.ClearSprite:
	push af
	hlcoord 0, 1
	ld bc, 2 * SCREEN_WIDTH
	call AddNTimes
	ld bc, 2 * SCREEN_WIDTH
	ld a, " "
	call ByteFill
	pop af
	ld hl, wShadowOAMSprite00
	ld bc, 4 * SPRITEOAMSTRUCT_LENGTH
	call AddNTimes
	ld de, SPRITEOAMSTRUCT_LENGTH
	ld c, 4
.gfx_loop
	ld [hl], SCREEN_WIDTH_PX ; y (off-screen)
	add hl, de
	dec c
	jr nz, .gfx_loop
	ld de, SFX_SWITCH_POKEMON
	jmp WaitPlaySFX

.SwapMonAndMail:
; Swap the two slots' species, party struct, nickname, OT and mail.
	push hl
	push de
	push bc
	ld a, [wSwitchMonFrom]
	inc a
	ld c, a
	ld a, [wSwitchMonTo]
	inc a
	ld e, a
	farcall SwapPartyMons ; 1-indexed c and e
	jmp PopBCDEHL
