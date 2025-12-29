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
	ret nc

;.flash_step
	call ClearFailures
	ld [wNumHits], a
	jr FlashStepBoost	

.moxie
	call ClearFailures
	ld [wNumHits], a
	jr MoxieBoost

.ignis
	call ClearFailures
	ld [wNumHits], a
	jr IgnisBoost

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

INCLUDE "data/abilities/ability_mons/moxie_mons.asm"
INCLUDE "data/abilities/ability_mons/ignis_mons.asm"
INCLUDE "data/abilities/ability_mons/flash_step_mons.asm"

PlayBoostAnimation:
	; fast battles skip this animation
	call CheckIfFastBattlesIsOn
	ret nz

	ld de, FOCUS_ENERGY
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
