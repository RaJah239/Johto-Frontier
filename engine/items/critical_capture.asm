CheckCriticalCapture::
; Polished Crystal's Pokédex-based trigger, adapted to the held Catch Charm.
; Carry selects a critical throw, whose success uses one shake check.
	ld hl, wPokedexCaught
	ld b, wEndPokedexCaught - wPokedexCaught
	call CountSetBits
	ld hl, .caught_limits
	ld d, 0
.count
	cp [hl]
	jr c, .got_multiplier
	jr z, .got_multiplier
	inc d
	inc hl
	jr .count
.got_multiplier
	ld a, d
	and a
	ret z

; Chance = final catch rate * multiplier / 12 (or / 6 with Catch Charm).
; The multipliers 0..5 represent Polished Crystal's 0..2.5 factors.
	xor a
	ldh [hMultiplicand], a
	ldh [hMultiplicand + 1], a
	ld a, [wFinalCatchRate]
	ldh [hMultiplicand + 2], a
	ld a, d
	ldh [hMultiplier], a
	call Multiply
	ld a, [wBattleMonItem]
	cp CATCH_CHARM
	ld a, 12
	jr nz, .divide
	ld a, 6
.divide
	ldh [hDivisor], a
	ld b, 4
	call Divide
	ldh a, [hQuotient + 3]
	ld c, a
	call Random
	cp c
	ret

.caught_limits
	db 30, 100, 150, 200, 250, 255

CriticalCaptureRoll::
; A critical capture only has to pass one of Polished Crystal's shake
; checks. Return carry on capture; final catch rate 255 always succeeds.
	ld a, [wFinalCatchRate]
	and a
	ret z
	inc a
	jr z, .guaranteed
	dec a
	ld b, a
	ld hl, .WobbleProbabilities
.find
	ld a, [hli]
	cp b
	jr z, .check
	jr nc, .previous
	inc hl
	jr .find
.previous
	dec hl
	dec hl
.check
	ld b, [hl]
	call Random
	cp b
	ret
.guaranteed
	scf
	ret

.WobbleProbabilities
INCLUDE "data/battle/critical_capture_wobble_probabilities.asm"
