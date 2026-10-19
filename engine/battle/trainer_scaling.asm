; Trainer Party Evolution Check
; Checks if a trainer's Pokemon should evolve based on its scaled level
; and evolves it before adding it to the party.
; Also checks for Everstone/Light Ball to prevent evolution.

; CheckAndEvolveTrainerMon
; Input: de = trainer data pointer (just after the species byte)
;        wCurPartyLevel = scaled level
;        wCurPartySpecies = base species
;        wOtherTrainerType = trainer type flags
; Output: wCurPartySpecies = evolved species (if evolved)
;         carry flag set if evolution blocked (Everstone/Light Ball)
; Preserves: hl, de, bc
; Note: the pointer is passed in de because `farcall` loads hl with the
;       target address before jumping, destroying the caller's hl.
CheckAndEvolveTrainerMon:
	push hl
	push de
	push bc
	push af

	; hl = trainer data pointer.
	ld h, d
	ld l, e

	; Skip the nickname, if this trainer's Pokemon have one.
	ld a, [wOtherTrainerType]
	bit TRAINERTYPE_NICKNAME_F, a
	jr z, .skip_dvs
.skip_nickname
	ld a, [wTrainerGroupBank]
	call GetFarByte
	inc hl
	cp "@"
	jr nz, .skip_nickname

	; Skip the DVs, if present (2 bytes).
.skip_dvs
	ld a, [wOtherTrainerType]
	bit TRAINERTYPE_DVS_F, a
	jr z, .skip_evs
	inc hl
	inc hl

	; Skip the EVs, if present (NUM_STATS bytes).
.skip_evs
	ld a, [wOtherTrainerType]
	bit TRAINERTYPE_EVS_F, a
	jr z, .check_item
	rept NUM_STATS
		inc hl
	endr

	; Check for Everstone/Light Ball to block evolution.
.check_item
	ld a, [wOtherTrainerType]
	bit TRAINERTYPE_ITEM_F, a
	jr z, .check_evolution

	; Read the item and check for Everstone/Light Ball.
	ld a, [wTrainerGroupBank]
	call GetFarByte
	inc hl
	cp EVERSTONE
	jr z, .blocked
	cp LIGHT_BALL
	jr z, .blocked

.check_evolution
	; Save the base species.
	ld a, [wCurPartySpecies]
	ld b, a

	; Look up the evolution threshold.
	ld hl, EvoThresholds
.check_loop
	ld a, [hli]      ; base species
	cp $FF
	jr z, .no_evo
	cp b
	jr z, .found
	inc hl           ; skip the threshold
	inc hl           ; skip the evolved species
	jr .check_loop

.found
	ld a, [hli]      ; evolution threshold level
	ld e, a
	ld a, [hl]       ; evolved species
	ld d, a

	; Compare the scaled level with the threshold.
	ld a, [wCurPartyLevel]
	cp e
	jr c, .no_evo    ; not high enough level

	; Evolution triggered!
	ld a, d
	ld [wCurPartySpecies], a
	jr .not_blocked

.no_evo
	ld a, b
	ld [wCurPartySpecies], a

.not_blocked
	pop af
	pop bc
	pop de
	pop hl
	and a           ; clear carry: no block
	ret

.blocked
	pop af
	pop bc
	pop de
	pop hl
	scf             ; carry set: evolution blocked by an item
	ret

INCLUDE "data/trainer_scaling/evo_thresholds.asm"
