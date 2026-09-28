Random::
; A save-backed deterministic pseudorandom number generator.

; The 32-bit state lives in hRandomState (HRAM) and is stored in
; the save file as sRandomState when saving (see engine/menus/
; save.asm), then read back when loading. Reloading a save resumes
; the exact sequence the game had when it was saved, so replaying
; the same actions from the same save reproduces the same results:
; save->reload rerolling no longer gets a fresh roll for free.

; A zero state means "not seeded yet" (a fresh boot, or a save file
; from before this feature existed). It is seeded once from the
; divider, the current scanline and the frame counter, which vary
; with boot and entry timing on real hardware.

; Every call refreshes hRandomAdd and hRandomSub; callers that
; sample them after `call Random` keep working unchanged.

; This leaves a with the value in hRandomSub.

	push bc
	push de
	push hl

	; if the state is zero, seed it first
	ld a, [hRandomState]
	ld b, a
	ld a, [hRandomState + 1]
	or b
	ld b, a
	ld a, [hRandomState + 2]
	or b
	ld b, a
	ld a, [hRandomState + 3]
	or b
	jp z, .reseed

.step
	; xorshift32: x ^= x << 13; x ^= x >> 17; x ^= x << 5
	; (Marsaglia's triple; full period, zero is a fixed point)
	ld a, [hRandomState]
	ld b, a
	ld a, [hRandomState + 1]
	ld c, a
	ld a, [hRandomState + 2]
	ld d, a
	ld a, [hRandomState + 3]
	ld e, a

	; x ^= x << 13
	; l = (b >> 3) | (c << 5)
	ld a, b
	srl a
	srl a
	srl a
	ld l, a
	ld a, c
	sla a
	sla a
	sla a
	sla a
	sla a
	or l
	ld l, a
	; h = (c >> 3) | (d << 5)
	ld a, c
	srl a
	srl a
	srl a
	ld h, a
	ld a, d
	sla a
	sla a
	sla a
	sla a
	sla a
	or h
	ld h, a
	; apply: e ^= h, d ^= l, c ^= (b << 5)
	ld a, e
	xor h
	ld e, a
	ld a, d
	xor l
	ld d, a
	ld a, b
	sla a
	sla a
	sla a
	sla a
	sla a
	ld h, a
	ld a, c
	xor h
	ld c, a

	; x ^= x >> 17
	; h = (d >> 1) | ((e & 1) << 7)
	ld a, e
	rrca
	and $80
	ld h, a
	ld a, d
	srl a
	or h
	ld h, a
	ld a, b
	xor h
	ld b, a
	; h = e >> 1
	ld a, e
	srl a
	ld h, a
	ld a, c
	xor h
	ld c, a

	; x ^= x << 5, high byte to low byte so that each lower
	; neighbour is still its pre-transform value
	; e ^= (e << 5) | (d >> 3)
	ld a, e
	sla a
	sla a
	sla a
	sla a
	sla a
	ld h, a
	ld a, d
	srl a
	srl a
	srl a
	or h
	ld h, a
	ld a, e
	xor h
	ld e, a
	; d ^= (d << 5) | (c >> 3)
	ld a, d
	sla a
	sla a
	sla a
	sla a
	sla a
	ld h, a
	ld a, c
	srl a
	srl a
	srl a
	or h
	ld h, a
	ld a, d
	xor h
	ld d, a
	; c ^= (c << 5) | (b >> 3)
	ld a, c
	sla a
	sla a
	sla a
	sla a
	sla a
	ld h, a
	ld a, b
	srl a
	srl a
	srl a
	or h
	ld h, a
	ld a, c
	xor h
	ld c, a
	; b ^= b << 5
	ld a, b
	sla a
	sla a
	sla a
	sla a
	sla a
	ld h, a
	ld a, b
	xor h
	ld b, a

	; write the state back
	ld a, b
	ld [hRandomState], a
	ld a, c
	ld [hRandomState + 1], a
	ld a, d
	ld [hRandomState + 2], a
	ld a, e
	ld [hRandomState + 3], a

	; refresh the sampled bytes
	ld a, [hRandomState + 3]
	ldh [hRandomAdd], a
	ld a, [hRandomState + 2]
	ldh [hRandomSub], a

	pop hl
	pop de
	pop bc
	ret

.reseed
	ldh a, [rDIV]
	ld [hRandomState], a
	ldh a, [rLY]
	ld [hRandomState + 1], a
	ldh a, [hVBlankCounter]
	ld [hRandomState + 2], a
	; spin past a divider tick so the two samples differ
	ld b, 64
.spin
	dec b
	jr nz, .spin
	ldh a, [rDIV]
	ld [hRandomState + 3], a
	; never leave the state zero (0 is a fixed point of xorshift)
	ld a, [hRandomState]
	and a
	jp nz, .step
	ld a, 1
	ld [hRandomState], a
	jp .step

BattleRandom::
; _BattleRandom lives in another bank.

; It handles all RNG calls in the battle engine, allowing
; link battles to remain in sync using a shared PRNG.

	ldh a, [hROMBank]
	push af
	ld a, BANK(_BattleRandom)
	rst Bankswitch

	call _BattleRandom

	ld [wPredefHL + 1], a
	pop af
	rst Bankswitch
	ld a, [wPredefHL + 1]
	ret

RandomRange::
; Return a random number between 0 and a (non-inclusive).

	push bc
	ld c, a

	; b = $100 % c
	xor a
	sub c
.mod
	sub c
	jr nc, .mod
	add c
	ld b, a

	; Get a random number
	; from 0 to $ff - b.
	push bc
.loop
	call Random
	ldh a, [hRandomAdd]
	ld c, a
	add b
	jr c, .loop
	ld a, c
	pop bc

	call SimpleDivide

	pop bc
	ret
