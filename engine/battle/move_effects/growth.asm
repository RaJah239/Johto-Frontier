BattleCommand_Growth:
; growth

	ld bc, wPlayerStatLevels
	ld a, [hBattleTurn]
	and a
	jr z, .go
	ld bc, wEnemyStatLevels

.go
; Sharply raise stats in sunny weather.
	ld a, [wBattleWeather]
	cp WEATHER_SUN
	jr z, .trysharplyraise

.tryraise
; If no stats can be increased, don't.

; Attack
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr c, .raise

; Special Attack
	inc bc
	inc bc
	inc bc
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr nc, .cantraise

.raise
; Raise Attack and Special Attack.
	ld a, $1
	ld [wBattleAnimParam], a
	farcall AnimateCurrentMove
	farcall BattleCommand_AttackUp
	farcall BattleCommand_StatUpMessage
	farcall ResetMiss
	farcall BattleCommand_SpecialAttackUp
	farjp BattleCommand_StatUpMessage

.trysharplyraise
; If no stats can be increased, don't.

; Attack
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr c, .sharplyraise

; Special Attack
	inc bc
	inc bc
	inc bc
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr nc, .cantraise

.sharplyraise
; Sharply raise Attack and Special Attack.
	ld a, $1
	ld [wBattleAnimParam], a
	farcall AnimateCurrentMove
	farcall BattleCommand_AttackUp2
	farcall BattleCommand_StatUpMessage
	farcall ResetMiss
	farcall BattleCommand_SpecialAttackUp2
	farjp BattleCommand_StatUpMessage


.cantraise
; Can't raise either stat.
	ld b, ABILITY + 1
	farcall GetStatName
	farcall AnimateFailedMove
	ld hl, WontRiseAnymoreText
	jmp StdBattleTextbox
