BattleCommand_KingsShield:
    call BattleCommand_Protect
    ret c
    ldh a, [hBattleTurn]
    and a
    ld a, [wPlayerSDefLevel]
    jr z, .go
    ld a, [wEnemySDefLevel]
.go
    cp BASE_STAT_LEVEL + 2
    ret nc
    farcall BattleCommand_DefenseUp2
    farcall BattleCommand_SpecialDefenseUp2
    ld hl, DefenseModeText
    jmp StdBattleTextbox
