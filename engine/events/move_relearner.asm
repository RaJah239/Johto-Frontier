MoveRelearner:
	; Loads and prints the "MoveReminderIntroText" text and places
	; the player's current money at the top right corner of the
	; screen. Then prompts the player to select "YES" or "NO".
	; Relative jump to the ".cancel" local jump
	; if the player selected "NO" and continue
	; if the player selected "YES".
	ld hl, MoveReminderIntroText
	call PrintText
	farcall PlaceMoneyTopRight
	call YesNoBox
	jr c, .cancel

	; Calls the "CheckCostAgainstPlayerMoney" label. Relative jump
	; to the ".not_enough_money" local jump if the player does
	; not have enough money and continue if they do.
	call CheckCostAgainstPlayerMoney
	jr c, .not_enough_money

	; Loads and prints the "MoveReminderWhichMonText" text.
	ld hl, MoveReminderWhichMonText
	call PrintText
; This code falls through into the ".loop_party_menu" local jump.

; This is where the party menu loop begins.
; Loads the party menu to select a Pokémon. Relative jump
; to the ".cancel" local jump if the player leaves
; the party menu without selecting anything.
.loop_party_menu
	farcall SelectMonFromParty
	jr c, .cancel

	; Checks if the current selection is an egg. Relative jump to
	; the ".is_an_egg" local jump if so and continue if not.
	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .is_an_egg

	; Checks if the current selection is not a Pokémon. Relative jump to
	; the ".not_a_pokemon" local jump if so and continue if not.
	; Prevents continuing if glitched Pokémon are selected.
	call IsAPokemon
	jr c, .not_a_pokemon

	; Checks for any moves that can be learned. Relative
	; jump to the ".no_moves_to_learn" local jump if
	; there are none and continue if there are.
	call GetRemindableMoves
	jr z, .no_moves_to_learn

	; Loads and prints the "MoveReminderWhichMoveText" text.
	ld hl, MoveReminderWhichMoveText
	call PrintText
; This code falls through into the ".loop_move_menu" local jump.

; This is where the move menu loop begins.

; Generates the Move Reminder's menu. Relative jump to the
; ".loop_party_menu" local jump if the player leaves
; the menu and continue if they do not.
.loop_move_menu
	call ChooseMoveToLearn
	jr c, .loop_party_menu

	; If the player selects a move, load the move's name and copy
	; it for later. This is used for displaying the move's
	; name in some of the text boxes while learning a move.
	ld a, [wMenuSelection]
	ld [wNamedObjectIndex], a
	call GetMoveName
	call CopyName1

; Begins the process of learning a move.

	; The "LearnMove" label sets the value of the "b" register to "1"
	; when a move is successfully learned and sets it to "0" if
	; cancelled at any point in the move learning process.
	predef LearnMove

	; Relative jump to the ".move_learned" local jump if
	; a move has been learned and continue if not.
	ld a, b
	dec a
	jr z, .move_learned
; This code falls through into the ".recheck_for_moves" local jump.

; Rechecks for any moves that can be learned. Relative
; jump to the ".no_moves_to_learn" local jump if
; there are none and relative jump to the
; ".loop_move_menu" local jump if there are.
.recheck_for_moves
	call GetRemindableMoves
	jr z, .no_moves_to_learn
	jr .loop_move_menu

; Loads and prints the "MoveReminderCancelText" text.
; This ends the dialogue.
.cancel
	ld hl, MoveReminderCancelText
	jp PrintText

; Loads and prints the "MoveReminderEggText" text and then waits for
; the player to press a button for the text to progress. Then
; relative jump to the ".loop_party_menu" local jump.
.is_an_egg
	ld hl, MoveReminderEggText
	call PrintText
	jr .loop_party_menu

; Loads and prints the "MoveReminderNotaMonText" text and then waits
; for the player to press a button for the text to progress. Then
; relative jump to the ".loop_party_menu" local jump.
.not_a_pokemon
	ld hl, MoveReminderNotaMonText
	call PrintText
	jr .loop_party_menu

; Loads and prints the "MoveReminderNoMovesText" text and then waits
; for the player to press a button for the text to progress. Then
; relative jump to the ".loop_party_menu" local jump.
.no_moves_to_learn
	ld hl, MoveReminderNoMovesText
	call PrintText
	jr .loop_party_menu

; Loads and prints the "MoveReminderNotEnoughMoneyText" text.
; This will end the dialogue.
.not_enough_money
	ld hl, MoveReminderNotEnoughMoneyText
	jp PrintText

; Exits the menu and goes back to the map with a
; speech text box open and then loads and prints
; the "MoveReminderMoveLearnedText" text.

.move_learned
	call ReturnToMapWithSpeechTextbox
	ld hl, MoveReminderMoveLearnedText
	call PrintText
; This code falls through into the ".pay_for_move" local jump.

; Places the player's current money at the top right corner of
; the screen, retrieves the amount of money defined in the
; "MoveCost" label, removes the defined amount of money from
; the player, plays the "SFX_TRANSACTION" sound effect and
; finally prints the "MoveReminderPaymentReceivedText" text.
.pay_for_move
	farcall PlaceMoneyTopRight
	ld hl, MoveCost
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
	ld hl, MoveReminderPaymentReceivedText
	call PrintText

	; Calls the "CheckCostAgainstPlayerMoney" label. Relative
	; jump to the ".not_enough_money" local jump if the
	; player does not have enough money and relative jump
	; to the ".recheck_for_moves" local jump if they do.
	call CheckCostAgainstPlayerMoney
	jr c, .not_enough_money
	jr .recheck_for_moves

; Compares the value of "MoveCost" to
; the amount of money the player has.
CheckCostAgainstPlayerMoney:
	ld hl, MoveCost
	ld de, hMoneyTemp
	ld bc, 3
	call CopyBytes
	ld bc, hMoneyTemp
	ld de, wMoney
	farcall CompareMoney
	ret

; The cost for learning a move.
MoveCost:
	dt 9800

; Checks for moves that can be learned and returns
; a zero flag if there are none.
GetRemindableMoves:

	; The "wd002" wram label is being used to store
	; the moves for placement in the move list.
	ld hl, wd002
	xor a
	ld [hli], a
	ld [hl], $ff

	; Retrieves and stores the species of
	; the currently selected Pokémon.
	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld a, [hl]
	ld [wCurPartySpecies], a

	; Retrieves and stores the level of the
	; currently selected Pokémon.
	push af
	ld a, MON_LEVEL
	call GetPartyParamLocation
	ld a, [hl]
	ld [wCurPartyLevel], a

	; The "b" register will contain the number of
	; moves in the move list and "wd002 + 1"
	; is where the move list begins.
	ld b, 0
	ld de, wd002 + 1

	; Retrieves the currently selected Pokémon's evolution
	; and attack address from the "EvosAttacksPointers"
	; table that is located in another bank. This is the
	; list of evolutions and learnset of every Pokémon.
	ld a, [wCurPartySpecies]
	dec a
	push bc
	ld c, a
	ld hl, EvosAttacksPointers
	add hl, bc
	add hl, bc
	ld a, BANK(EvosAttacksPointers)
	call GetFarWord

; Skips the evolution data to start at the learnset for the
; currently selected Pokémon in the "EvosAttacksPointers"
; table. This is "db 0 ; no more evolutions".
.skip_evos
	ld a, BANK("Evolutions and Attacks")
	call GetFarByte
	inc hl
	and a
	jr nz, .skip_evos

; Loops through the move list until it reaches
; the end of the "EvosAttacksPointers" table
; for the currently selected Pokémon. This is
; "db 0 ; no more level-up moves".

; It then compares the currently selected Pokémon's
; level with the level the move is learned at and
; if the Pokémon's level is higher, it will
; attempt to add the move to the move list.
.loop_moves
	ld a, BANK("Evolutions and Attacks")
	call GetFarByte
	inc hl
	and a
	jr z, .done
	ld c, a
	ld a, [wCurPartyLevel]
	cp c
	ld a, BANK("Evolutions and Attacks")
	call GetFarByte
	inc hl
	jr c, .loop_moves

	; Checks if the move is already in the
	; move list or already learned by the
	; Pokémon. If both are false, then the
	; move will be added to the move list.
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

; Adds all the possible moves the currently
; selected Pokémon can learn into "wd002".
; Which is the move list.
.done
	pop bc
	pop af
	ld [wCurPartySpecies], a
	ld a, b
	ld [wd002], a
	and a
	ret

; Checks if there is a move already placed
; in the move list. This prevents
; duplicate entries in the move list.
CheckAlreadyInList:
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

; Checks if a Pokémon already knows a move. This
; prevents the player teaching the currently
; selected Pokémon a move it already knows.
CheckPokemonAlreadyKnowsMove:
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

; The shared move-details menu renderer now lives in
; "engine/events/move_details_menu.asm" and consumes the
; move list stored in "wd002".
; This is the text that displays when the player
; first talks to the move reminder.
MoveReminderIntroText:
	text "Hi, I'm the Move"
	line "Reminder!"

	para "For ¥9,800 I can"
	line "make #MON"
	cont "remember a move."

	para "Are you"
	line "interested?"
	done

; This is the text that displays just
; before the party menu opens.
MoveReminderWhichMonText:
	text "Which #MON?"
	prompt

; This is the text that displays after
; a Pokémon has been selected.
MoveReminderWhichMoveText:
	text "Which move should"
	line "it remember, then?"
	prompt

; This is the text that displays just before
; the player ends the dialogue
; with the move reminder.
MoveReminderCancelText:
	text "Come visit me"
	line "again."
	done

; This is the text that displays if the player
; selects an egg in the party menu.
MoveReminderEggText:
	text "An EGG can't learn"
	line "any moves!"
	prompt

; This is the text that displays if the player
; selects an entry in the party menu that
; is neither a Pokémon or an egg.
MoveReminderNotaMonText:
	text "What is that!?"

	para "I'm sorry, but I"
	line "can only teach"
	cont "moves to #MON!"
	prompt

; This is the text that displays if the player
; selects a Pokémon in the party menu that
; has no moves that can be learned.
MoveReminderNoMovesText:
	text "There are no moves"
	line "for this #MON"
	cont "to learn."
	prompt

; This is the text that displays if the player
; does not have enough money to learn a move.
MoveReminderNotEnoughMoneyText:
	text "Hm… You don't have"
	line "enough money."

	para "Please come back"
	line "when you do."
	done

; This is the text that displays after a
; Pokémon successfully learns a move.
MoveReminderMoveLearnedText:
	text "Done! Your #MON"
	line "remembered the"
	cont "move."
	done

; This is the text that displays after the
; Move Reminder accepts payment.
MoveReminderPaymentReceivedText:
	text "Pleasure doing"
	line "business with"
	cont "you!"
	prompt

PrintMoveRelearnerText:
	ld e, a
	ld d, 0
	ld hl, .TextPointers
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	ret
.TextPointers
	dw .Intro
	dw .WhichMon
	dw .WhichMove
	dw .ComeAgain
	dw .Egg
	dw .NotMon
	dw .NotEnoughMoney
	dw .NoMovesToLearn

.Intro
	text "Hello! I am the"
	line "MOVE RELEARNER."

	para "I know every"
	line "move that each"
	cont "#MON can learn."

	para "For just ¥5000, I"
	line "can share that"

	para "knowledge with"
	line "you. How about it?"
	done
.WhichMon
	text "Very well! Which"
	line "#MON should"
	cont "remember a move?"
	done
.WhichMove
	text "Which move should"
	line "it remember?"
	done
.ComeAgain
	text "Thanks! Come see"
	line "me again, if you"
	para "want me to teach"
	line "your #MON!"
	done
.Egg
	text "An EGG can't learn"
	line "any moves."
	done
.NotMon
	text "That's not"
	line "a #MON!"
	done
.NotEnoughMoney
	text "I'm sorry, but"
	line "you don't have"
	cont "enough money."
	done
.NoMovesToLearn
	text "This #MON can't"
	line "learn any moves"
	cont "from me."
	done

