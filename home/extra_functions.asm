; Used in most mandatory long texts, returns the result of the 'bit' operation,
; which determines if the dialogue option is set to Normal (z=0) or Minimum (z=1)
CheckDialogueMode::
	ld a, [wOptions2]
	bit MINIMAL_DIALOGUE, a
	ret

CheckStatusText::
	ld a, [wOptions3]
	bit STATUS_TEXT, a
	ret

CheckIntrosOutros::
	ld a, [wOptions4]
	bit INTRO_OUTROS, a
	ret

CheckNicknaming::
	ld a, [wOptions4]
	bit NICKNAMING, a
	ret

GetCurrentMon::
	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonHP
	ld a, [wBattleMonSpecies]
	ret z
	ld hl, wEnemyMonHP
	ld a, [wEnemyMonSpecies]
	ret

GetOpposingMon::
    ldh a, [hBattleTurn]
	and a
	ld a, [wBattleMonSpecies]
	ret nz
	ld a, [wEnemyMonSpecies]
    ret

; This converts values out of 256 into a value
; out of 100. It achieves this by multiplying
; the value by 100 and dividing it by 256.
ConvertPercentages::

	; Overwrite the "hl" register.
	ld l, a
	ld h, 0
	push af

	; Multiplies the value of the "hl" register by 3.
	add hl, hl
	add a, l
	ld l, a
	adc h
	sub l
	ld h, a

	; Multiplies the value of the "hl" register
	; by 8. The value of the "hl" register
	; is now 24 times its original value.
	add hl, hl
	add hl, hl
	add hl, hl

	; Add the original value of the "hl" value to itself,
	; making it 25 times its original value.
	pop af
	add a, l
	ld l, a
	adc h
	sbc l
	ld h, a

	; Multiply the value of the "hl" register by
	; 4, making it 100 times its original value.
	add hl, hl
	add hl, hl

	; Set the "l" register to 0.5, otherwise the rounded
	; value may be lower than expected. Round the
	; high byte to nearest and drop the low byte.
	ld l, 0.5
	sla l
	sbc a
	and 1
	add a, h
	ret

StackJumpTable::
	pop hl
	push de
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	pop de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

ShowDefensiveAbilityBanner::
; Popup b:de over the target's HUD. Carry if Neutralizing Gas suppresses
; the ability (its popup shows instead).
	ldh a, [hBattleTurn]
	xor 1
	ld c, a
	; b = bank of text
	; de = text pointer
	farcall ShowAbilityPopup
	ret c
	ld a, [wOptions4]
	bit ABILITY_BANNERS, a
	ret z ; (nc)
	ld c, 30
	call DelayFrames
	and a
	ret

; =================================
; === Ability: Neutralizing Gas ===
; =================================
; (engine/abilities/neutralizing_gas.asm)

IsSideSuppressed::
; Carry if side a's (0: player, 1: enemy) mon has its ability suppressed by
; the other mon's Neutralizing Gas (while that mon is still standing).
; Preserves a, bc, de, hl.
	push hl
	push bc
	ld c, a
	ld a, [wBattleMode]
	and a
	jr z, .no
	ld a, [wNeutralizingGas]
	ld b, a
	ld a, c
	and a
	jr nz, .enemy
	bit 0, b
	jr z, .no
	ld hl, wEnemyMonHP
	jr .check_hp
.enemy
	bit 1, b
	jr z, .no
	ld hl, wBattleMonHP
.check_hp
	ld a, [hli]
	or [hl]
	jr z, .no
	ld a, c
	scf
	jr .done
.no
	ld a, c
	and a
.done
	pop bc
	pop hl
	ret

IsSpeciesSuppressed::
; Carry if species a is the mon out on a side whose ability is suppressed by
; Neutralizing Gas. Preserves a, bc, de, hl.
	push bc
	ld c, a
	ld a, [wBattleMonSpecies]
	cp c
	ld a, 0
	jr z, .side
	ld a, [wEnemyMonSpecies]
	cp c
	jr nz, .no
	ld a, 1
.side
	call IsSideSuppressed
	ld a, c
	pop bc
	ret
.no
	ld a, c
	and a
	pop bc
	ret

IsInAbilityList::
; IsInByteArray for an ability's species list: no match for a mon whose
; ability Neutralizing Gas suppresses.
	call IsSpeciesSuppressed
	jmp nc, IsInByteArray
	and a
	ret

IsInAbilityListNG::
; IsInAbilityList where the ability would act right now: if it's in list hl
; but suppressed, Neutralizing Gas's popup shows (over the other side).
	call IsSpeciesSuppressed
	jmp nc, IsInByteArray
	push hl
	push de
	push bc
	call IsInByteArray
	jr nc, .done
	; the suppressed mon's side: its popup is swapped for Neutralizing Gas's
	ld c, a
	ld a, [wBattleMonSpecies]
	cp c
	ld c, 0
	jr z, .got_side
	inc c
.got_side
	ld b, BANK(NeutralizingGasPopupText)
	ld de, NeutralizingGasPopupText
	farcall ShowAbilityPopup
.done
	pop bc
	pop de
	pop hl
	and a
	ret
