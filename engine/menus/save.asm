SaveMenu:
	call LoadStandardMenuHeader
	farcall DisplaySaveInfoOnSave
	call SpeechTextbox
	call UpdateSprites
	farcall SaveMenu_CopyTilemapAtOnce
	call AskOverwriteSaveFile
	jr c, .refused
	call PauseGameLogic
	call SavedTheGame
	call ResumeGameLogic
	call ExitMenu
	jmp ReturnToMapFromSubmenu

.refused
	call ExitMenu
	call GSReloadPalettes
	farcall SaveMenu_CopyTilemapAtOnce
	scf
	ret

QuickSaveGame::
; Quick-save triggered by holding Start in the overworld
; asks before overwriting a different player's save file
	; never save while linked
	ld a, [wLinkMode]
	and a
	ret nz

	call AskOverwriteSaveFile
	ret c ; the player refused the overwrite
	call PauseGameLogic
	call SavedTheGame
	jr ResumeGameLogic

SaveAfterLinkTrade:
	call PauseGameLogic
	farcall StageRTCTimeForSave
	farcall BackupMysteryGift
	call SavePokemonData
	call SaveChecksum
	call SaveBackupPokemonData
	call SaveBackupChecksum
	farcall BackupPartyMonMail
	farcall SaveRTC
	; fallthrough

ResumeGameLogic:
	xor a ; FALSE
	ld [wGameLogicPaused], a
	ret

Link_SaveGame:
	call AskOverwriteSaveFile
	ret c
ForceGameSave:
	call PauseGameLogic
	call SavedTheGame
	call ResumeGameLogic
	and a
	ret

PauseGameLogic:
	ld a, TRUE
	ld [wGameLogicPaused], a
	ret

AddHallOfFameEntry:
	ld a, BANK(sHallOfFame)
	call OpenSRAM
	ld hl, sHallOfFame + HOF_LENGTH * (NUM_HOF_TEAMS - 1) - 1
	ld de, sHallOfFame + HOF_LENGTH * NUM_HOF_TEAMS - 1
	ld bc, HOF_LENGTH * (NUM_HOF_TEAMS - 1)
.loop
	ld a, [hld]
	ld [de], a
	dec de
	dec bc
	ld a, c
	or b
	jr nz, .loop
	ld hl, wHallOfFamePokemonList
	ld de, sHallOfFame
	ld bc, wHallOfFamePokemonListEnd - wHallOfFamePokemonList + 1
	call CopyBytes
	call CloseSRAM
; This vc_hook causes the Virtual Console to set [sGSBallFlag] and [sGSBallFlagBackup]
; to GS_BALL_AVAILABLE, which enables you to get the GS Ball, take it to Kurt, and
; encounter Celebi. It assumes that sGSBallFlag and sGSBallFlagBackup are at their
; original addresses.
	vc_hook Enable_GS_Ball_mobile_event
	vc_assert BANK(sGSBallFlag) == $1 && sGSBallFlag == $be3c, \
		"sGSBallFlag is no longer located at 01:be3c."
	vc_assert BANK(sGSBallFlagBackup) == $1 && sGSBallFlagBackup == $be44, \
		"sGSBallFlagBackup is no longer located at 01:be44."
	vc_assert GS_BALL_AVAILABLE == $b, \
		"GS_BALL_AVAILABLE is no longer equal to $b."
	ret

AskOverwriteSaveFile:
	ld a, [wSaveFileExists]
	and a
	jr z, .erase
	call CompareLoadedAndSavedPlayerID
	ret z ; pretend the player answered "Yes", but without asking

	ld hl, AnotherSaveFileText
	call SaveTheGame_yesorno
	jr z, .refused

	ld hl, AreYouReallyReallySureText
	call SaveTheGame_yesorno
	jr z, .refused

	ld hl, ThisCantBeUndoneText
	call SaveTheGame_yesorno
	jr z, .refused

.erase
	call ErasePreviousSave
	and a
	ret

.refused
	scf
	ret

SaveTheGame_yesorno:
	ld b, BANK(AnotherSaveFileText)
	call MapTextbox
	call LoadMenuTextbox
	lb bc, 0, 7
	call NoYesBox
	ld a, [wMenuCursorY]
	dec a
	call CloseWindow
	push af
	call GSReloadPalettes
	pop af
	and a
	ret

CompareLoadedAndSavedPlayerID:
	ld a, BANK(sPlayerData)
	call OpenSRAM
	ld hl, sPlayerData + (wPlayerID - wPlayerData)
	ld a, [hli]
	ld c, [hl]
	ld b, a
	call CloseSRAM
	ld a, [wPlayerID]
	cp b
	ret nz
	ld a, [wPlayerID + 1]
	cp c
	ret

SavedTheGame:
	call SaveGameData
	; copy the original text speed setting to the stack
	ld a, [wOptions]
	push af
	; set text speed to fast
	ld a, TEXT_DELAY_FAST
	ld [wOptions], a
	; <PLAYER> saved the game!
	ld hl, SavedTheGameText
	call PrintText
	; restore the original text speed setting
	pop af
	ld [wOptions], a
	ld de, SFX_SAVE
	call WaitPlaySFX
	jmp WaitSFX

SaveGameData:
	ld a, TRUE
	ld [wSaveFileExists], a
	farcall StageRTCTimeForSave
	call ValidateSave
	call SaveOptions
	call SavePlayerData
	call SavePokemonData
	ld a, BANK(sBattleTowerChallengeState)
	call OpenSRAM
	ld a, [sBattleTowerChallengeState]
	cp BATTLETOWER_RECEIVED_REWARD
	jr nz, .ok
	xor a
	ld [sBattleTowerChallengeState], a
.ok
	call CloseSRAM

	; At this point, there is no longer any harm in setting this. We can't set
	; it earlier, because it might confuse the load routine into using bad
	; box/mail data, and we can't set it later because we need to set it
	; before our main save copy is valid.
	ld a, 1
	call SetSavePhase

	call SaveChecksum
	call WriteBackupSave
	farcall SaveRTC
	jmp CloseSRAM ; just in case

WriteBackupSave:
; Runs after saving the main copy. Writes the "pseudo-WRAM" copies of storage
; and mail, then creates the backup save. This process is automatically run
; on game load if we have a valid main save but not a backup save.
	; Save storage, mail, mobile event and mystery gift to backup
	farcall BackupPartyMonMail
	farcall BackupMysteryGift
	call SaveStorageSystem

	; Save the backup copy of game data.
	call ValidateBackupSave
	call SaveBackupOptions
	call SaveBackupPlayerData
	call SaveBackupPokemonData
	call SaveBackupChecksum

	; Finished saving.
	xor a
	call SetSavePhase
	jmp CloseSRAM

LoadStorageSystem:
; Copy backup storage system to active.
	ld hl, sBackupNewBox1
	ld de, sNewBox1
	call CopyStorageSystem

	; Initialize allocation information.
	farjp FlushStorageSystem

SaveStorageSystem:
; Copy active storage system to backup.
	ld hl, sNewBox1
	ld de, sBackupNewBox1
	; fallthrough

CopyStorageSystem:
	ld a, BANK(sNewBox1)
	call OpenSRAM
	ld bc, sNewBoxEnd - sNewBox1
	call CopyBytes
	jmp CloseSRAM

EraseLinkBattleStats:
	ld a, BANK(sLinkBattleStats)
	call OpenSRAM
	ld hl, sLinkBattleStats
	ld bc, sLinkBattleStatsEnd - sLinkBattleStats
	xor a
	call ByteFill
	jmp CloseSRAM

EraseMysteryGift:
	ld a, BANK(sBackupMysteryGiftItem)
	call OpenSRAM
	ld hl, sBackupMysteryGiftItem
	ld bc, sBackupMysteryGiftItemEnd - sBackupMysteryGiftItem
	xor a
	call ByteFill
	jmp CloseSRAM

EraseHallOfFame:
	ld a, BANK(sHallOfFame)
	call OpenSRAM
	ld hl, sHallOfFame
	ld bc, sHallOfFameEnd - sHallOfFame
	xor a
	call ByteFill
	jmp CloseSRAM

EraseBattleTowerStatus:
	ld a, BANK(sBattleTowerChallengeState)
	call OpenSRAM
	xor a
	ld [sBattleTowerChallengeState], a
	jmp CloseSRAM

HallOfFame_InitSaveIfNeeded:
	ld a, [wSavedAtLeastOnce]
	and a
	ret nz
	; fallthrough

ErasePreviousSave:
	call EraseHallOfFame
	call EraseLinkBattleStats
	call EraseMysteryGift
	call SaveData
	call EraseBattleTowerStatus
	ld a, BANK(sStackTop)
	call OpenSRAM
	xor a
	ld [sStackTop + 0], a
	ld [sStackTop + 1], a
	call CloseSRAM
	ld a, $1
	ld [wSavedAtLeastOnce], a
	ret

ValidateSave:
	ld a, BANK(sCheckValue1) ; aka BANK(sCheckValue2)
	call OpenSRAM
	ld a, SAVE_CHECK_VALUE_1
	ld [sCheckValue1], a
	ld a, SAVE_CHECK_VALUE_2
	ld [sCheckValue2], a
	jmp CloseSRAM

SaveOptions:
	ld a, BANK(sOptions)
	call OpenSRAM
	ld hl, wOptions
	ld de, sOptions
	ld bc, wOptionsEnd - wOptions
	call CopyBytes
	ld a, [wOptions]
	and ~(1 << NO_TEXT_SCROLL)
	ld [sOptions], a
	jmp CloseSRAM

SavePlayerData:
	ld a, BANK(sPlayerData)
	call OpenSRAM
	ld hl, wPlayerData
	ld de, sPlayerData
	ld bc, wPlayerDataEnd - wPlayerData
	call CopyBytes
	ld hl, wCurMapData
	ld de, sCurMapData
	ld bc, wCurMapDataEnd - wCurMapData
	call CopyBytes
	; commit the session stash to the saved slot (SRAM bank 0)
	call CloseSRAM
	ld a, BANK(sMartSessionBagData)
	call OpenSRAM
	ld hl, sMartSavedBagData
	call SaveStashedBagToSRAM
	jmp CloseSRAM

SavePokemonData:
	ld a, BANK(sPokemonData)
	call OpenSRAM
	ld hl, wPokemonData
	ld de, sPokemonData
	ld bc, wPokemonDataEnd - wPokemonData
	call CopyBytes
	jmp CloseSRAM

SaveChecksum:
	ld hl, sGameData
	ld bc, sGameDataEnd - sGameData
	ld a, BANK(sGameData)
	call OpenSRAM
	call Checksum
	ld a, e
	ld [sChecksum + 0], a
	ld a, d
	ld [sChecksum + 1], a
	jmp CloseSRAM

ValidateBackupSave:
	ld a, BANK(sBackupCheckValue1) ; aka BANK(sBackupCheckValue2)
	call OpenSRAM
	ld a, SAVE_CHECK_VALUE_1
	ld [sBackupCheckValue1], a
	ld a, SAVE_CHECK_VALUE_2
	ld [sBackupCheckValue2], a
	jmp CloseSRAM

SaveBackupOptions:
	ld a, BANK(sBackupOptions)
	call OpenSRAM
	ld hl, wOptions
	ld de, sBackupOptions
	ld bc, wOptionsEnd - wOptions
	call CopyBytes
	jmp CloseSRAM

SaveBackupPlayerData:
	ld a, BANK(sBackupPlayerData)
	call OpenSRAM
	ld hl, wPlayerData
	ld de, sBackupPlayerData
	ld bc, wPlayerDataEnd - wPlayerData
	call CopyBytes
	ld hl, wCurMapData
	ld de, sBackupCurMapData
	ld bc, wCurMapDataEnd - wCurMapData
	call CopyBytes
	; commit the session stash to the backup-saved slot (SRAM bank 0,
	; the same bank this routine already has open)
	ld hl, sMartBackupSavedBagData
	call SaveStashedBagToSRAM
	jmp CloseSRAM

SaveBackupPokemonData:
	ld a, BANK(sBackupPokemonData)
	call OpenSRAM
	ld hl, wPokemonData
	ld de, sBackupPokemonData
	ld bc, wPokemonDataEnd - wPokemonData
	call CopyBytes
	jmp CloseSRAM

SaveBackupChecksum:
	ld hl, sBackupGameData
	ld bc, sBackupGameDataEnd - sBackupGameData
	ld a, BANK(sBackupGameData)
	call OpenSRAM
	call Checksum
	ld a, e
	ld [sBackupChecksum + 0], a
	ld a, d
	ld [sBackupChecksum + 1], a
	jmp CloseSRAM

WasMidSaveAborted:
; Returns z if the system was reset mid-saving.
	ld a, BANK(sWritingBackup)
	call OpenSRAM
	ld a, [sWritingBackup]
	dec a
	jmp CloseSRAM

SetSavePhase:
; set current save phase: 1 (saving), 0 (not saving).
	push af
	ld a, BANK(sWritingBackup)
	call OpenSRAM
	pop af
	ld [sWritingBackup], a
	jmp CloseSRAM

TryLoadSaveFile:
	call VerifyChecksum
	jr nz, .backup
	call LoadPlayerData
	call LoadPokemonData
	; If a mid-save was aborted but main save data is good, finish it.
	call WasMidSaveAborted
	call z, WriteBackupSave
	farcall RestorePartyMonMail
	farcall RestoreMysteryGift
	call LoadStorageSystem

	; Just in case
	call WriteBackupSave
	and a
	ret

.backup
	call VerifyBackupChecksum
	jr nz, .corrupt
	call LoadBackupPlayerData
	call LoadBackupPokemonData
	farcall RestorePartyMonMail
	farcall RestoreMysteryGift
	call LoadStorageSystem
	call SaveGameData
	and a
	ret

.corrupt
	ld a, [wOptions]
	push af
	set NO_TEXT_SCROLL, a
	ld [wOptions], a
	ld hl, SaveFileCorruptedText
	call PrintText
	pop af
	ld [wOptions], a
	scf
	ret

TryLoadSaveData:
	xor a ; FALSE
	ld [wSaveFileExists], a
	call CheckPrimarySaveFile
	ld a, [wSaveFileExists]
	and a
	jr z, .backup

	ld a, BANK(sPlayerData)
	call OpenSRAM
	ld hl, sPlayerData + wStartDay - wPlayerData
	ld de, wStartDay
	ld bc, 8
	call CopyBytes
	ld hl, sPlayerData + wStatusFlags - wPlayerData
	ld de, wStatusFlags
	ld a, [hl]
	ld [de], a
	jmp CloseSRAM

.backup
	call CheckBackupSaveFile
	ld a, [wSaveFileExists]
	and a
	jr z, .corrupt

	ld a, BANK(sBackupPlayerData)
	call OpenSRAM
	ld hl, sBackupPlayerData + wStartDay - wPlayerData
	ld de, wStartDay
	ld bc, 8
	call CopyBytes
	ld hl, sBackupPlayerData + wStatusFlags - wPlayerData
	ld de, wStatusFlags
	ld a, [hl]
	ld [de], a
	jmp CloseSRAM

.corrupt
	ld hl, DefaultOptions
	ld de, wOptions
	ld bc, wOptionsEnd - wOptions
	call CopyBytes
	jmp ClearClock

INCLUDE "data/default_options.asm"

CheckPrimarySaveFile:
	ld a, BANK(sCheckValue1) ; aka BANK(sCheckValue2)
	call OpenSRAM
	ld a, [sCheckValue1]
	cp SAVE_CHECK_VALUE_1
	jr nz, .nope
	ld a, [sCheckValue2]
	cp SAVE_CHECK_VALUE_2
	jr nz, .nope
	ld hl, sOptions
	ld de, wOptions
	ld bc, wOptionsEnd - wOptions
	call CopyBytes
	call CloseSRAM
	ld a, TRUE
	ld [wSaveFileExists], a
.nope
	jmp CloseSRAM

CheckBackupSaveFile:
	ld a, BANK(sBackupCheckValue1) ; aka BANK(sBackupCheckValue2)
	call OpenSRAM
	ld a, [sBackupCheckValue1]
	cp SAVE_CHECK_VALUE_1
	jr nz, .nope
	ld a, [sBackupCheckValue2]
	cp SAVE_CHECK_VALUE_2
	jr nz, .nope
	ld hl, sBackupOptions
	ld de, wOptions
	ld bc, wOptionsEnd - wOptions
	call CopyBytes
	ld a, $2
	ld [wSaveFileExists], a
.nope
	jmp CloseSRAM

LoadPlayerData:
	ld a, BANK(sPlayerData)
	call OpenSRAM
	ld hl, sPlayerData
	ld de, wPlayerData
	ld bc, wPlayerDataEnd - wPlayerData
	call CopyBytes
	ld hl, sCurMapData
	ld de, wCurMapData
	ld bc, wCurMapDataEnd - wCurMapData
	call CopyBytes
	; restore the session stash from the saved slot (SRAM bank 0)
	call CloseSRAM
	ld a, BANK(sMartSessionBagData)
	call OpenSRAM
	ld hl, sMartSavedBagData
	call LoadStashedBagFromSRAM
	call CloseSRAM
	ld a, BANK(sBattleTowerChallengeState)
	call OpenSRAM
	ld a, [sBattleTowerChallengeState]
	cp BATTLETOWER_RECEIVED_REWARD
	jr nz, .not_4
	ld a, BATTLETOWER_WON_CHALLENGE
	ld [sBattleTowerChallengeState], a
.not_4
	jmp CloseSRAM

LoadPokemonData:
	ld a, BANK(sPokemonData)
	call OpenSRAM
	ld hl, sPokemonData
	ld de, wPokemonData
	ld bc, wPokemonDataEnd - wPokemonData
	call CopyBytes
	jmp CloseSRAM

SaveStashedBagToSRAM:
; hl = address of a stash struct in SRAM (saved or backup-saved);
; SRAM bank 0 must be open. Copies the session stash there, writing
; the check values last so a partial write is never mistaken for
; valid data.
	ld d, h
	ld e, l
	ld hl, sMartSessionBagData
	ld bc, sMartSessionBagDataEnd - sMartSessionBagData
	call CopyBytes ; de now points at the check values
	ld a, SAVE_CHECK_VALUE_1
	ld [de], a
	inc de
	ld a, SAVE_CHECK_VALUE_2
	ld [de], a
	ret

LoadStashedBagFromSRAM:
; hl = address of a stash struct in SRAM (saved or backup-saved);
; SRAM bank 0 must be open. Copies it into the session stash, or
; resets the session stash if the check values are invalid (a save
; file from before the mart bag existed: the field bag is simply
; live, and the mart bag starts empty).
	ld d, h
	ld e, l
	ld bc, sMartSavedBagDataEnd - sMartSavedBagData
	add hl, bc ; hl -> the check values
	ld a, [hli]
	cp SAVE_CHECK_VALUE_1
	jr nz, .reset
	ld a, [hl]
	cp SAVE_CHECK_VALUE_2
	jr nz, .reset
	ld h, d
	ld l, e
	ld de, sMartSessionBagData
	ld bc, sMartSessionBagDataEnd - sMartSessionBagData
	call CopyBytes
	; the session stash needs valid check values too, or the next map
	; transition would treat it as uninitialized and empty it
	ld a, SAVE_CHECK_VALUE_1
	ld [sMartSessionBagCheck1], a
	ld a, SAVE_CHECK_VALUE_2
	ld [sMartSessionBagCheck2], a
	ret
.reset
	call ResetMartSessionStash
	ret

ResetMartStash::
; Starting a new game: forget the previous session's stash, so the
; old game's stashed bag cannot leak into this one. The saved slots
; are left alone; they belong to save files that still exist on the
; cartridge, and the first save overwrites them anyway.
	ld a, BANK(sMartSessionBagData)
	call OpenSRAM
	call ResetMartSessionStash
	jmp CloseSRAM

ResetMartSessionStash::
; Rebuild the session stash as a pristine empty mart bag: zeroed
; counts and data, valid check values, and the -1 terminator in the
; first slot of every list pocket, exactly as ResetWRAM's .InitList
; leaves the live bag on a fresh game. Without those terminators the
; pack draws garbage rows instead of Cancel, and PutItemInPocket's
; scan for -1 runs off the end of the pocket and deposits the item
; wherever the first stray -1 sits. SRAM bank 0 must be open.
	ld hl, sMartSessionBagData
	ld bc, sMartSessionBagDataEnd - sMartSessionBagData
	xor a
	call ByteFill
	ld a, SAVE_CHECK_VALUE_1
	ld [sMartSessionBagCheck1], a
	ld a, SAVE_CHECK_VALUE_2
	ld [sMartSessionBagCheck2], a
	ld hl, sMartSessionBag
	jmp WriteMartBagSentinels

WriteMartBagSentinels:
; hl = a bag in the wTMsHMs-to-wNumPCItems layout, just zeroed.
; Give each list pocket the -1 terminator in its first item slot;
; the flat TM/HM array needs none, like .InitList.
	ld a, -1
	push hl
	ld de, wItems - wTMsHMs
	add hl, de
	ld [hl], a
	ld de, wKeyItems - wItems
	add hl, de
	ld [hl], a
	ld de, wBalls - wKeyItems
	add hl, de
	ld [hl], a
	ld de, wFruits - wBalls
	add hl, de
	ld [hl], a
	ld de, wBattles - wFruits
	add hl, de
	ld [hl], a
	pop hl
	ret

SanitizeMartBag::
; Whichever side holds the mart bag, per the active flag, must have
; intact terminators; a bag missing one predates them (a save from
; the buggy build), so rebuild it as empty. The field bag is never
; touched. SRAM bank 0 must be open.
	ld a, [sMartSessionBagActive]
	and a
	ld hl, wTMsHMs ; active: the live bag is the mart bag
	jr nz, .got_base
	ld hl, sMartSessionBag ; inactive: the stash holds it
.got_base
	push hl
	ld de, wNumItems - wTMsHMs
	call .checkQuantity
	jr nz, .corrupt
	ld de, wNumBalls - wTMsHMs
	call .checkQuantity
	jr nz, .corrupt
	ld de, wNumFruits - wTMsHMs
	call .checkQuantity
	jr nz, .corrupt
	ld de, wNumBattles - wTMsHMs
	call .checkQuantity
	jr nz, .corrupt
	ld de, wNumKeyItems - wTMsHMs
	call .checkNormal
	jr nz, .corrupt
	pop hl
	ret

.checkQuantity:
; de = the pocket's count byte offset. Returns z if the terminator
; sits where it belongs: quantity format is two bytes per entry.
	push hl
	add hl, de
	ld a, [hl] ; count
	add a      ; 2 * count (max 32 per pocket, so no overflow)
	ld c, a
	ld b, 0
	inc hl     ; -> first item slot
	add hl, bc
	ld a, [hl]
	cp -1
	pop hl
	ret

.checkNormal:
; de = the pocket's count byte offset; key items are one byte each.
	push hl
	add hl, de
	ld a, [hl]
	ld c, a
	ld b, 0
	inc hl
	add hl, bc
	ld a, [hl]
	cp -1
	pop hl
	ret

.corrupt
	pop hl
	push hl
	ld bc, wNumPCItems - wTMsHMs
	xor a
	call ByteFill
	pop hl
	jmp WriteMartBagSentinels

VerifyChecksum:
	ld hl, sGameData
	ld bc, sGameDataEnd - sGameData
	ld a, BANK(sGameData)
	call OpenSRAM
	call Checksum
	ld a, [sChecksum + 0]
	cp e
	jr nz, .fail
	ld a, [sChecksum + 1]
	cp d
.fail
	push af
	call CloseSRAM
	pop af
	ret

LoadBackupPlayerData:
	ld a, BANK(sBackupPlayerData)
	call OpenSRAM
	ld hl, sBackupPlayerData
	ld de, wPlayerData
	ld bc, wPlayerDataEnd - wPlayerData
	call CopyBytes
	ld hl, sBackupCurMapData
	ld de, wCurMapData
	ld bc, wCurMapDataEnd - wCurMapData
	call CopyBytes
	ld hl, sMartBackupSavedBagData
	call LoadStashedBagFromSRAM
	jmp CloseSRAM

LoadBackupPokemonData:
	ld a, BANK(sBackupPokemonData)
	call OpenSRAM
	ld hl, sBackupPokemonData
	ld de, wPokemonData
	ld bc, wPokemonDataEnd - wPokemonData
	call CopyBytes
	jmp CloseSRAM

VerifyBackupChecksum:
	ld hl, sBackupGameData
	ld bc, sBackupGameDataEnd - sBackupGameData
	ld a, BANK(sBackupGameData)
	call OpenSRAM
	call Checksum
	ld a, [sBackupChecksum + 0]
	cp e
	jr nz, .fail
	ld a, [sBackupChecksum + 1]
	cp d
.fail
	push af
	call CloseSRAM
	pop af
	ret

SaveData:
	; the process of erasing the save from a previous game file
	ld a, BANK(sCrystalData)
	call OpenSRAM
	ld hl, wCrystalData
	ld de, sCrystalData
	ld bc, wCrystalDataEnd - wCrystalData
	call CopyBytes
	jmp CloseSRAM

_LoadData:
	ld a, BANK(sCrystalData)
	call OpenSRAM
	ld hl, sCrystalData
	ld de, wCrystalData
	ld bc, wCrystalDataEnd - wCrystalData
	call CopyBytes
	jmp CloseSRAM

Checksum:
	ld de, 0
.loop
	ld a, [hli]
	add e
	ld e, a
	ld a, 0
	adc d
	ld d, a
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

SavedTheGameText:
	text_far _SavedTheGameText
	text_end

AnotherSaveFileText:
	text_far _AnotherSaveFileText
	text_end

AreYouReallyReallySureText:
	text_far _AreYouReallyReallySureText
	text_end

ThisCantBeUndoneText:
	text_far _ThisCantBeUndoneText
	text_end

SaveFileCorruptedText:
	text_far _SaveFileCorruptedText
	text_end
