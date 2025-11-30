BattleCommand_ToxicSpikes:
; toxic spikes

	ld hl, wEnemyScreens
	ldh a, [hBattleTurn]
	and a
	jr z, .got_screens
	ld hl, wPlayerScreens
.got_screens

; Fails if toxic spikes are already down!

	bit SCREENS_TOXIC_SPIKES, [hl]
	jr nz, .failed

	set SCREENS_TOXIC_SPIKES, [hl]

	farcall AnimateCurrentMove
	ld hl, ToxicSpikesText
	jmp StdBattleTextbox

.failed
	farjp FailMove
