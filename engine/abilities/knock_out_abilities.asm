; ==========================================
; === Ability: Moxie, Ignis & Flash Step ===
; ==========================================
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
	jr c, .ignis

	call GetCurrentMon
	ld hl, FlashStepPokemon
	call IsInByteArray
	jr c, .flash_step

	call GetCurrentMon
	ld hl, BattleFeastPokemon
	call IsInByteArray
	jr c, .battle_feast

	call GetCurrentMon
	ld hl, RenewalPokemon
	call IsInByteArray
	jmp c, .renewal
	ret

.flash_step
	; don't boost if at level 2 or higher
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerSpdLevel]
	jr z, .got_flash_step_level
	ld a, [wEnemySpdLevel]
.got_flash_step_level
	cp BASE_STAT_LEVEL + 2
	ret nc

	call ClearFailures
	ld [wNumHits], a
	jmp FlashStepBoost	

.moxie
	; don't boost if at level 2 or higher
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerAtkLevel]
	jr z, .got_moxie_level
	ld a, [wEnemyAtkLevel]
.got_moxie_level
	cp BASE_STAT_LEVEL + 2
	ret nc

	call ClearFailures
	ld [wNumHits], a
	jmp MoxieBoost

.ignis
	; don't boost if at level 2 or higher
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerSAtkLevel]
	jr z, .got_ignis_level
	ld a, [wEnemySAtkLevel]
.got_ignis_level
	cp BASE_STAT_LEVEL + 2
	ret nc

	call ClearFailures
	ld [wNumHits], a
	jr IgnisBoost

.battle_feast
	call ClearFailures
	ld [wNumHits], a

; ==================
; === Check Turn ===
; ==================
	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy_turn_battle_feast

; =====================
; === Player's Turn ===
; =====================

.enemy_turn_battle_feast
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
	farcall GetEighthMaxHP
	farcall SwitchTurnCore
	farcall RestoreHP

	call CheckIfFastBattlesIsOn
	ret nz
	ld hl, BattleText_BattleFeastText
	jmp StdBattleTextbox

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
	farcall SwitchTurnCore
	farcall ItemRecoveryAnim
	farcall SwitchTurnCore
	ld hl, RenewalText
	call BattleTextbox
	farjp CalcPokemonStats

MoxieBoost:
	call PlayBoostAnimation
	farcall BattleCommand_AttackUp
    ld hl, MoxieText
    jmp BattleTextbox

IgnisBoost:
	call PlayBoostAnimation
	farcall BattleCommand_SpecialAttackUp
    ld hl, IgnisText
    jmp BattleTextbox

FlashStepBoost:
	call PlayBoostAnimation
	farcall BattleCommand_SpeedUp
    ld hl, FlashStepText
    jmp BattleTextbox

MoxieText:
	text "<USER>'s"
	line "Moxie activated!"

	para "<USER>'s"
	line "Attack went up!"
	prompt

IgnisText:
	text "<USER>'s"
	line "Ignis activated!"

	para "<USER>'s"
	line "Sp.Attack went up!"
	prompt

FlashStepText:
	text "<USER>'s"
	line "Flash Step"
	cont "activated!"

	para "<USER>'s"
	line "Speed went up!"
	prompt

RenewalText:
	text "<USER>'s"
	line "Renewal activated!"

	para "<USER>"
	line "became healthy!"
	prompt

INCLUDE "data/abilities/moxie_mons.asm"
INCLUDE "data/abilities/ignis_mons.asm"
INCLUDE "data/abilities/flash_step_mons.asm"
INCLUDE "data/abilities/battle_feast_mons.asm"
INCLUDE "data/abilities/renewal_mons.asm"

PlayBoostAnimation:
	ld a, [wOptions]
	bit BATTLE_SCENE, a
	jr nz, .skipAnim

	ld de, ANIM_STAT_UP
	call ShouldPlayAnimQuestionMark
	jr c, .skipAnim

	farcall Call_PlayBattleAnim
	scf
	ret

.skipAnim
	xor a
	ret

; skip boost animation in wild battles
ShouldPlayAnimQuestionMark:
	ld a, [wBattleMode]
	bit WILD_BATTLE, a
	jr nz, .no

.yes
	scf
	ret

.no
	xor a
	ret

; fail-safe should anything go awry
; and prevent stat ups when a pokemon has zero hp
ClearFailures:
	xor a
	ld [wFailedMessage], a
	ld [wEffectFailed], a
	ld [wAttackMissed], a
	ret
