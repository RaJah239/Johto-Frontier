Special::
; Run script special de.
	ld hl, SpecialsPointers
	add hl, de
	add hl, de
	add hl, de
	ld b, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, b
	rst FarCall
	ret

INCLUDE "data/events/special_pointers.asm"

GameCornerPrizeMonCheckDex:
	ld a, [wScriptVar]
	dec a
	call CheckCaughtMon
	ret nz
	ld a, [wScriptVar]
	dec a
	call SetSeenAndCaughtMon
	call FadeToMenu
	ld a, [wScriptVar]
	ld [wNamedObjectIndex], a
	farcall NewPokedexEntry
	jmp ExitAllMenus

SetMonAsSeen:
	ld a, [wScriptVar]
	dec a
	jmp SetSeenMon

FindPartyMonThatSpecies:
	ld a, [wScriptVar]
	ld b, a
	farcall _FindPartyMonThatSpecies
	jr z, FoundNone
	jr FoundOne

FindPartyMonThatSpeciesYourTrainerID:
	ld a, [wScriptVar]
	ld b, a
	farcall _FindPartyMonThatSpeciesYourTrainerID
	jr z, FoundNone
	; fallthrough

FoundOne:
	ld a, TRUE
	ld [wScriptVar], a
	ret

FoundNone:
	xor a
	ld [wScriptVar], a
	ret

NameRival:
	ld b, NAME_RIVAL
	ld de, wRivalName
	farcall _NamingScreen
	ld hl, wRivalName
	ld de, .DefaultName
	jmp InitName

.DefaultName:
	db "Silver@"

NameRater:
	farjp _NameRater

OverworldTownMap:
	call FadeToMenu
	farcall _TownMap
	jmp ExitAllMenus

ViewUnown:
	call FadeToMenu
	farcall _ViewUnown
	jmp ExitAllMenus

DisplayLinkRecord:
	call FadeToMenu
	farcall _DisplayLinkRecord
	jmp ExitAllMenus

PlayersHousePC:
	xor a
	ld [wScriptVar], a
	farcall _PlayersHousePC
	ld a, c
	ld [wScriptVar], a
	ret

BugContestJudging:
	farcall _BugContestJudging
	ld a, b
	ld [wScriptVar], a
	ret

MapRadio:
	ld a, [wScriptVar]
	ld e, a
	farjp PlayRadio

UnownPuzzle:
	call FadeToMenu
	farcall _UnownPuzzle
	ld a, [wSolvedUnownPuzzle]
	ld [wScriptVar], a
	jmp ExitAllMenus

SlotMachine:
	call CheckCoinsAndCoinCase
	ret c
	ld a, BANK(_SlotMachine)
	ld hl, _SlotMachine
	jr StartGameCornerGame

_VoltorbFlip:
	call CheckCoinsAndCoinCase
	ret c
	ld a, BANK(VoltorbFlip)
	ld hl, VoltorbFlip
	jr StartGameCornerGame

CardFlip:
	call CheckCoinsAndCoinCase
	ret c
	ld a, BANK(_CardFlip)
	ld hl, _CardFlip
	jr StartGameCornerGame

GetPartyCountWithoutEggs::
	push hl
	push de

	ld a, [wPartyCount]
	ld e, a ; E will be the return value.

	ld a, [wPartyCount]
	ld d, a
	xor a
	ld hl, wPartySpecies

.loop
	cp d
	jr nc, .end_loop

	push af
	ld a, [hl]
	cp EGG
	jr nz, .go_on

	dec e

.go_on
	pop af
	
	inc a
	inc hl
	jr .loop

.end_loop
	ld a, e
	ld [wScriptVar], a

	pop de
	pop hl
	ret

MemoryGame:
	call CheckCoinsAndCoinCase
	ret c
	ld a, BANK(_MemoryGame)
	ld hl, _MemoryGame
	jr StartGameCornerGame

StartGameCornerGame:
	call FarQueueScript
	call FadeToMenu
	ld hl, wQueuedScriptBank
	ld a, [hli]
	push af
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	rst FarCall
	jmp ExitAllMenus

CheckCoinsAndCoinCase:
	ld hl, wCoins
	ld a, [hli]
	or [hl]
	jr z, .no_coins
	ld a, COIN_CASE
	ld [wCurItem], a
	ld hl, wNumItems
	call CheckItem
	jr nc, .no_coin_case
	and a
	ret

.no_coins
	ld hl, .NoCoinsText
	jr .print

.no_coin_case
	ld hl, .NoCoinCaseText

.print
	call PrintText
	scf
	ret

.NoCoinsText:
	text_far _NoCoinsText
	text_end

.NoCoinCaseText:
	text_far _NoCoinCaseText
	text_end

ScriptReturnCarry:
	jr c, .carry
	xor a
	ld [wScriptVar], a
	ret
.carry
	ld a, 1
	ld [wScriptVar], a
	ret

ActivateFishingSwarm:
	ld a, [wScriptVar]
	ld [wFishingSwarmFlag], a
	jr SetSwarmFlag

StoreSwarmMapIndices::
	ld a, d
	ld [wSwarmMapGroup], a
	ld a, e
	ld [wSwarmMapNumber], a

SetSwarmFlag:
	ld hl, wDailyFlags1
	set DAILYFLAGS1_SWARM_F, [hl]
	ret

CheckSwarmFlag::
	ld hl, wDailyFlags1
	bit DAILYFLAGS1_SWARM_F, [hl]
	jr z, .clear_swarm
	xor a
	ld [wScriptVar], a
	ret

.clear_swarm
	ld a, 1
	ld [wScriptVar], a
	xor a
	ld [wFishingSwarmFlag], a
	ld [wSwarmMapGroup], a
	ld [wSwarmMapNumber], a
	ret

CheckPokerus:
; Check if a monster in your party has Pokerus
	farcall _CheckPokerus
	jr ScriptReturnCarry

PlayCurMonCry:
	ld a, [wCurPartySpecies]
	jmp PlayMonCry

FadeOutMusic:
	xor a ; MUSIC_NONE
	ld [wMusicFadeID], a
	ld [wMusicFadeID + 1], a
	ld a, $2
	ld [wMusicFade], a
	ret

Diploma:
	call FadeToMenu
	farcall _Diploma
	jmp ExitAllMenus

PartyKeeperShowTeam:
; open the party menu to look over team
; returns once they back out of the menu
	farjp StartMenu_Pokemon

BackupPartyHeldItems:
	ld hl, wPartyMon1Item
	ld de, wPartyMonItemBackup
	ld c, PARTY_LENGTH
.loop
	push bc
	ld a, [hl]
	ld [de], a
	inc de
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	dec c
	jr nz, .loop
	ret

RestorePartyHeldItems:
	ld hl, wPartyMon1Item
	ld de, wPartyMonItemBackup
	ld c, PARTY_LENGTH
.loop
	push bc
	ld a, [de]
	ld [hl], a
	inc de
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	dec c
	jr nz, .loop
	ret

TradebackNPC:
	farjp TradebackKid

PlayerGivesAwayAnEggForAdoption:
	farcall SelectMonFromParty
	jr c, .done
	
	ld a, [wCurPartySpecies]
	cp EGG
	jr nz, .not_an_egg

	ld [wMonType], a ; PARTYMON
	ld [wPokemonWithdrawDepositParameter], a ; REMOVE_PARTY
	callfar AdoptMonFromParty
	jr .done

.not_an_egg:
	; here we set an event to tell the Day Care Granddaughter that this is not an Egg
	ld de, EVENT_DAY_CARE_GRANDDAUGHTER_THIS_IS_NOT_AN_EGG
	ld b, SET_FLAG
	call EventFlagAction

.done:
	ret

if DEF(_DEBUG)
SetAllUnownCaught:
	ld b, NUM_UNOWN
	ld hl, wUnownDex
	ld c, 1
.loop
	ld a, c
	ld [hli], a
	inc c
	dec b
	jr nz, .loop
	ret

FillPokedex:
	ld a, UNOWN_A
	ld [wFirstUnownSeen], a
	ld a, CYNDAQUIL
	ld [wScriptVar], a
.loop
	ld a, [wScriptVar]
	dec a
	call SetSeenAndCaughtMon
	ld a, [wScriptVar]
	inc a
	cp EGG
	ret z
	ld [wScriptVar], a
	jr .loop

endc
