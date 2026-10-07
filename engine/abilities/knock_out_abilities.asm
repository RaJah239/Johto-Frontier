; ===============================================================
; === Ability: Moxie, Ignis, Flash Step, Blood Lust & Renewal ===
; ===============================================================
KOBoost:
	push bc
	call GetCurrentMon
	ld b, a
	ld a, [hli]
	and a
	jr nz, .cont
	ld a, [hl]
	and a
	jr nz, .cont
	pop bc
	ret

.cont
	ld a, b
	pop bc
	ld hl, MoxiePokemon
	call IsInByteArray
	jr c, .moxie

	call GetCurrentMon
	ld hl, IgnisPokemon
	call IsInByteArray
	jmp c, .ignis

	call GetCurrentMon
	ld hl, FlashStepPokemon
	call IsInByteArray
	jr c, .flash_step

	call GetCurrentMon
	ld hl, LifeDrainPokemon
	call IsInByteArray
	jmp c, .life_drain

	call GetCurrentMon
	ld hl, RenewalPokemon
	call IsInByteArray
	jmp c, .renewal

	call GetCurrentMon
	ld hl, BloodlustPokemon
	call IsInByteArray
	jmp c, .bloodlust
	ret

.flash_step
	; don't boost if at level 3 or higher
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerSpdLevel]
	jr z, .got_flash_step_level
	ld a, [wEnemySpdLevel]
.got_flash_step_level
	cp BASE_STAT_LEVEL + 3
	ret nc

	call ClearFailures
	ld [wNumHits], a
	ShowEntryOrKOAbilityPopup FlashStepText
	farcall BattleCommand_SpeedUp
	farjp BattleCommand_StatUpMessage

.moxie
	; don't boost if at level 3 or higher
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerAtkLevel]
	jr z, .got_moxie_level
	ld a, [wEnemyAtkLevel]
.got_moxie_level
	cp BASE_STAT_LEVEL + 3
	ret nc

	call ClearFailures
	ld [wNumHits], a
	ShowEntryOrKOAbilityPopup MoxieText
	farcall BattleCommand_AttackUp
	farjp BattleCommand_StatUpMessage

.ignis
	; don't boost if at level 3 or higher
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerSAtkLevel]
	jr z, .got_ignis_level
	ld a, [wEnemySAtkLevel]
.got_ignis_level
	cp BASE_STAT_LEVEL + 3
	ret nc

	call ClearFailures
	ld [wNumHits], a
	ShowEntryOrKOAbilityPopup IgnisText
	farcall BattleCommand_SpecialAttackUp
	farjp BattleCommand_StatUpMessage

.bloodlust
	; don't boost if attack is at level 3 or higher
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerAtkLevel]
	jr z, .got_atk_level
	ld a, [wEnemyAtkLevel]
.got_atk_level
	cp BASE_STAT_LEVEL + 3
	jr nc, .sp_atk_boost

	call ClearFailures
	ld [wNumHits], a
	ShowEntryOrKOAbilityPopup BloodLustText
	farcall BattleCommand_AttackUp
	farcall BattleCommand_StatUpMessage
.sp_atk_boost
	; don't boost if special attack is at level 3 or higher
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerSAtkLevel]
	jr z, .got_sp_atk_level
	ld a, [wEnemySAtkLevel]
.got_sp_atk_level
	cp BASE_STAT_LEVEL + 3
	ret nc

	call ClearFailures
	ld [wNumHits], a
	ShowEntryOrKOAbilityPopup BloodLustText
	farcall BattleCommand_SpecialAttackUp
	farjp BattleCommand_StatUpMessage

.life_drain
	call ClearFailures
	ld [wNumHits], a

; ==================
; === Check Turn ===
; ==================
	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy_turn_life_drain

; =====================
; === Player's Turn ===
; =====================

.enemy_turn_life_drain
	ld hl, wBattleMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, wEnemyMonHP

.got_hp
; Don't restore if we're already at max HP
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	cp b
	jr nz, .restore
	ld a, [hl]
	cp c
	ret z

.restore
	ShowEntryOrKOAbilityPopup LifeDrainText
	farcall GetEighthMaxHP
	farcall SwitchTurnCore
	farjp RestoreHP

.renewal
	call ClearFailures
	ld [wNumHits], a
; ==================
; === Check Turn ===
; ==================
	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy_turn_renewal

; =====================
; === Player's Turn ===
; =====================
.enemy_turn_renewal
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	and a
	ret z
	xor a
	ld [hl], a
	ShowEntryOrKOAbilityPopup RenewalText
	farjp CalcPokemonStats

FlashStepText: db "Flash Step@"
MoxieText:     db "Moxie@"
IgnisText:     db "Ignis@"
BloodLustText: db "Blood Lust@"
LifeDrainText: db "Life Drain@"
RenewalText:   db "Renewal@"

INCLUDE "data/abilities/moxie_mons.asm"
INCLUDE "data/abilities/ignis_mons.asm"
INCLUDE "data/abilities/flash_step_mons.asm"
INCLUDE "data/abilities/bloodlust_mons.asm"
INCLUDE "data/abilities/life_drain_mons.asm"
INCLUDE "data/abilities/renewal_mons.asm"

; fail-safe should anything go awry
; and prevent stat ups when a pokemon has zero hp
ClearFailures:
	xor a
	ld [wFailedMessage], a
	ld [wEffectFailed], a
	ld [wAttackMissed], a
	ret
