EggMaster:
    farcall PlaceMoneyTopRight
    call YesNoBox
    jr c, .cancel

    ; Calls the "CalculateCostAgainstPlayerMoney" label. Relative jump
    ; to the ".not_enough_money" local jump if the player does
    ; not have enough money and continue if they do.
    call CalculateCostAgainstPlayerMoney
    jr c, .not_enough_money

    ld hl, EggReminderWhichMonText
    call PrintText
.loop_party_menu
    farcall SelectMonFromParty
    jr c, .cancel
    ld a, [wCurPartySpecies]
    cp EGG
    jr z, .is_an_egg
    call IsAPokemon
    jr c, .cancel
    call GetRemindableEggMoves
    jr z, .no_moves_to_learn
    ld hl, EggReminderWhichMoveText
    call PrintText

.loop_move_menu
    call ChooseEggMoveToLearn
    jr c, .loop_party_menu
    ld a, [wMenuSelection]
    ld [wNamedObjectIndex], a
    call GetMoveName
    call CopyName1
    predef LearnMove
    ld a, b
    dec a
    jr z, .move_learned

.recheck_for_moves
    call GetRemindableEggMoves
    jr z, .no_moves_to_learn
    jr .loop_move_menu

.cancel
    ld hl, EggReminderCancelText
    jmp PrintText

.is_an_egg
    ld hl, EggReminderEggText
    call PrintText
    jr .loop_party_menu

.no_moves_to_learn
    ld hl, EggReminderNoMovesText
    call PrintText
    jr .loop_party_menu

; Loads and prints the "EggReminderNotEnoughMoneyText" text.
; This will end the dialogue.
.not_enough_money
    ld hl, EggReminderNotEnoughMoneyText
    jmp PrintText

.move_learned
    call ReturnToMapWithSpeechTextbox
    ld hl, EggReminderMoveLearnedText
    call PrintText
 
; This code falls through into the ".pay_for_move" local jump.

; Places the player's current money at the top right corner of
; the screen, retrieves the amount of money defined in the
; "EggMoveCost" label, removes the defined amount of money from
; the player, plays the "SFX_TRANSACTION" sound effect and
; finally prints the "EggReminderPaymentReceivedText" text.
.pay_for_move
    farcall PlaceMoneyTopRight
    ld hl, EggMoveCost
    ld de, hMoneyTemp
    ld bc, 3
    call CopyBytes
    call ApplyTilemap
    call PromptButton
    call WaitSFX
    ld bc, hMoneyTemp
    ld de, wMoney
    farcall TakeMoney
    farcall PlaceMoneyTopRight
    ld de, SFX_TRANSACTION
    call PlaySFX
    call WaitSFX
    ld hl, EggReminderPaymentReceivedText
    call PrintText
    ret

    call CalculateCostAgainstPlayerMoney
    jr c, .not_enough_money
 
    jr .recheck_for_moves

; Compares the value of "EggMoveCost" to
; the amount of money the player has.
CalculateCostAgainstPlayerMoney:
    ld hl, EggMoveCost
    ld de, hMoneyTemp
    ld bc, 3
    call CopyBytes
    ld bc, hMoneyTemp
    ld de, wMoney
    farcall CompareMoney
    ret

; The cost for learning a move.
EggMoveCost:
    dt 500000

GetRemindableEggMoves:
    ld hl, wd002
    xor a
    ld [hli], a
    ld [hl], $ff
    ld a, MON_SPECIES
    call GetPartyParamLocation
    ld a, [hl]
    ld [wCurPartySpecies], a
    push af
    ld b, 0
    ld de, wd002 + 1
    ld a, [wCurPartySpecies]
    dec a
    push bc
    ld c, a
    ld hl, EggMovePointers
    add hl, bc
    add hl, bc
    ld a, BANK(EggMovePointers)
    call GetFarWord

.loop_moves
    ld a, BANK("Egg Moves")
    call GetFarByte
    inc hl
    cp -1
    jr z, .done
    ld c, a
    call CheckAlreadyInList
    jr c, .loop_moves
    call CheckPokemonAlreadyKnowsMove
    jr c, .loop_moves
    ld a, c
    ld [de], a
    inc de
    ld a, $ff
    ld [de], a
    pop bc
    inc b
    push bc
    jr .loop_moves

.done
    pop bc
    pop af
    ld [wCurPartySpecies], a
    ld a, b
    ld [wd002], a
    and a
    ret

CheckAlreadyInMoveList:
    push hl
    ld hl, wd002 + 1

.loop
    ld a, [hli]
    inc a
    jr z, .nope
    dec a
    cp c
    jr nz, .loop
    pop hl
    scf
    ret

.nope
    pop hl
    and a
    ret

CheckPokemonAlreadyKnowsEggMove:
    push hl
    push bc
    ld a, MON_MOVES
    call GetPartyParamLocation
    ld b, 4

.loop
    ld a, [hli]
    cp c
    jr z, .yes
    dec b
    jr nz, .loop
    pop bc
    pop hl
    and a
    ret

.yes
    pop bc
    pop hl
    scf
    ret

; This is the text that displays if the player
; does not have enough money to learn a move.
EggReminderNotEnoughMoneyText:
    text "Hm… You don't have"
    line "enough money."

    para "Please come back"
    line "when you do."
    done

EggReminderWhichMonText:
    text "Which #MON"
    line "needs tutoring?"
    prompt

EggReminderWhichMoveText:
    text "Which move should"
    line "it learn, then?"
    prompt

EggReminderCancelText:
    text "Do visit again."
    done

EggReminderEggText:
    text "EGGS needs to be"
    line "hatched first."
    prompt

EggReminderNoMovesText:
    text "Hmm… this #MON"
    line "has no EGG MOVES."
    prompt

EggReminderMoveLearnedText:
    text "Done! Your #MON"
    line "learned the move."
    done

EggReminderPaymentReceivedText:
    text "Pleasure doing"
    line "business!"

    para "Come again, any-"
    line "time!"
    done
