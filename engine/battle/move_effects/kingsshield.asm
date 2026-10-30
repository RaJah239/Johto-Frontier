BattleCommand_KingsShield:
    farcall BattleCommand_Protect
    ret c
    ldh a, [hBattleTurn]
    and a
    ld a, [wPlayerSDefLevel]
    jr z, .go
    ld a, [wEnemySDefLevel]
.go
    cp BASE_STAT_LEVEL + 2
    ret nc
    call BattleCommand_DefenseUp2
    call BattleCommand_SpecialDefenseUp2
    ld hl, DefenseModeText
    jp StdBattleTextbox
