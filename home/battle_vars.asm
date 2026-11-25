GetBattleVar::
	push hl
	call GetBattleVarAddr
	pop hl
	ret

GetBattleVarAddr::
; hl = the address of battle variable a (BATTLE_VARS_*) for whoever's turn
; it is, and a = its value. Preserves bc and de.
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl ; 4 bytes per variable
; The enemy's turn uses the second address. This lets battle variable calls
; be side-neutral.
	ldh a, [hBattleTurn]
	and a
	jr z, .got_turn
	inc hl
	inc hl
.got_turn
	ld a, LOW(BattleVarAddresses)
	add l
	ld l, a
	ld a, HIGH(BattleVarAddresses)
	adc h
	ld h, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hl]
	ret

BattleVarAddresses:
; entries correspond to BATTLE_VARS_* constants
	table_width 4, BattleVarAddresses
	;  on the player's turn         on the enemy's turn
	dw wPlayerSubStatus1,          wEnemySubStatus1          ; SUBSTATUS1
	dw wPlayerSubStatus2,          wEnemySubStatus2          ; SUBSTATUS2
	dw wPlayerSubStatus3,          wEnemySubStatus3          ; SUBSTATUS3
	dw wPlayerSubStatus4,          wEnemySubStatus4          ; SUBSTATUS4
	dw wPlayerSubStatus5,          wEnemySubStatus5          ; SUBSTATUS5
	dw wEnemySubStatus1,           wPlayerSubStatus1         ; SUBSTATUS1_OPP
	dw wEnemySubStatus2,           wPlayerSubStatus2         ; SUBSTATUS2_OPP
	dw wEnemySubStatus3,           wPlayerSubStatus3         ; SUBSTATUS3_OPP
	dw wEnemySubStatus4,           wPlayerSubStatus4         ; SUBSTATUS4_OPP
	dw wEnemySubStatus5,           wPlayerSubStatus5         ; SUBSTATUS5_OPP
	dw wBattleMonStatus,           wEnemyMonStatus           ; STATUS
	dw wEnemyMonStatus,            wBattleMonStatus          ; STATUS_OPP
	dw wPlayerMoveStructAnimation, wEnemyMoveStructAnimation ; MOVE_ANIM
	dw wPlayerMoveStructEffect,    wEnemyMoveStructEffect    ; MOVE_EFFECT
	dw wPlayerMoveStructPower,     wEnemyMoveStructPower     ; MOVE_POWER
	dw wPlayerMoveStructType,      wEnemyMoveStructType      ; MOVE_TYPE
	dw wCurPlayerMove,             wCurEnemyMove             ; MOVE
	dw wLastPlayerCounterMove,     wLastEnemyCounterMove     ; LAST_COUNTER_MOVE
	dw wLastEnemyCounterMove,      wLastPlayerCounterMove    ; LAST_COUNTER_MOVE_OPP
	dw wLastPlayerMove,            wLastEnemyMove            ; LAST_MOVE
	dw wLastEnemyMove,             wLastPlayerMove           ; LAST_MOVE_OPP
	assert_table_length NUM_BATTLE_VARS
