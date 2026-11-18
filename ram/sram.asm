SECTION "Scratch", SRAM

UNION
sScratch:: ds $60 tiles

NEXTU
sEnemyFrontpicTileCount:: db
	ds 15 ; 16-byte aligned, so Get2bpp can copy the pic with GDMA
sPaddedEnemyFrontpic:: ds 7 * 7 tiles

NEXTU
; grid Pokedex: the picture's first tile column, for its sprites (past
; sPaddedEnemyFrontpic and the question mark pic at sScratch; 16-byte aligned)
	ds $330
sDexGridPicSprite:: ds 8 tiles
sDexGridLabel:: ds 4 tiles ; a type label being drawn on the grid
ENDU

SECTION "SRAM Bank 0", SRAM

sPartyMail::
; sPartyMon1Mail - sPartyMon6Mail
for n, 1, PARTY_LENGTH + 1
sPartyMon{d:n}Mail:: mailmsg sPartyMon{d:n}Mail
endr

sPartyMailBackup::
; sPartyMon1MailBackup - sPartyMon6MailBackup
for n, 1, PARTY_LENGTH + 1
sPartyMon{d:n}MailBackup:: mailmsg sPartyMon{d:n}MailBackup
endr

sMailboxCount:: db
sMailboxes::
; sMailbox1 - sMailbox10
for n, 1, MAILBOX_CAPACITY + 1
sMailbox{d:n}:: mailmsg sMailbox{d:n}
endr

sMailboxCountBackup:: db
sMailboxesBackup::
; sMailbox1Backup - sMailbox10Backup
for n, 1, MAILBOX_CAPACITY + 1
sMailbox{d:n}Backup:: mailmsg sMailbox{d:n}Backup
endr

	ds 78
	ds $30

sRTCStatusFlags:: db
	ds 9


SECTION "GG Bag Stash Backup", SRAM

; Grand Gauntlet dungeon bag stash for the backup slot (see sGGBagStash).
sBackupGGBagStash:: ds GG_BAG_STASH_LENGTH

SECTION "Backup Save", SRAM

sBackupOptions:: ds wOptionsEnd - wOptions

sBackupCheckValue1:: db ; loaded with SAVE_CHECK_VALUE_1, used to check save corruption

sBackupGameData::
sBackupPlayerData::  ds wPlayerDataEnd - wPlayerData
sBackupCurMapData::  ds wCurMapDataEnd - wCurMapData
sBackupPokemonData:: ds wPokemonDataEnd - wPokemonData
sBackupGameDataEnd::

; Save-backed PRNG state for the backup slot (see Random in
; home/random.asm). Kept at the front of the padding so no save
; field moves and the checksum range is unchanged.
sBackupRandomState:: ds 4

sBackupMonPalOverrides::
sBackupMonPalOverrideCount:: db
sBackupMonPalOverrideCheck:: db
sBackupMonPalOverrideEntries:: ds MAX_MON_PAL_OVERRIDES * MON_PAL_OVERRIDE_SIZE

; Bag pocket / cursor positions for the backup slot (see sBagCursors).
sBackupBagCursors::
sBackupBagCursorCheck:: db
sBackupBagCursorData:: ds BAG_CURSORS_LENGTH

	ds $186 - (2 + MAX_MON_PAL_OVERRIDES * MON_PAL_OVERRIDE_SIZE) - (1 + BAG_CURSORS_LENGTH)

sBackupChecksum:: dw

sBackupCheckValue2:: db ; loaded with SAVE_CHECK_VALUE_2, used to check save corruption

sStackTop:: dw

SECTION "Save", SRAM

sOptions:: ds wOptionsEnd - wOptions

sCheckValue1:: db ; loaded with SAVE_CHECK_VALUE_1, used to check save corruption

sGameData::
sPlayerData::  ds wPlayerDataEnd - wPlayerData
sCurMapData::  ds wCurMapDataEnd - wCurMapData
sPokemonData:: ds wPokemonDataEnd - wPokemonData
sGameDataEnd::

; Save-backed PRNG state (see Random in home/random.asm). It lives
; at the front of the padding after the checksummed region so that
; adding it does not move any save field; a save file from before
; this feature leaves it zero, which Random treats as "not seeded
; yet" and reseeds from the divider.
sRandomState:: ds 4

; Per-species palette overrides (see the palette editor NPC). Written
; with sMonPalOverrideCheck = SAVE_CHECK_VALUE_1 when valid; an older
; save leaves garbage here, which the check value rejects.
sMonPalOverrides::
sMonPalOverrideCount:: db
sMonPalOverrideCheck:: db
sMonPalOverrideEntries:: ds MAX_MON_PAL_OVERRIDES * MON_PAL_OVERRIDE_SIZE

; Bag pocket / cursor positions (wBagCursors - wBagCursorsEnd, BAG_CURSORS_LENGTH bytes): the last
; open pocket and each pocket's cursor and scroll position, so the bag
; reopens where it was left. Written with sBagCursorCheck =
; SAVE_CHECK_VALUE_1; an older save leaves garbage here, which the check
; value rejects.
sBagCursors::
sBagCursorCheck:: db
sBagCursorData:: ds BAG_CURSORS_LENGTH

	ds $186 - (2 + MAX_MON_PAL_OVERRIDES * MON_PAL_OVERRIDE_SIZE) - (1 + BAG_CURSORS_LENGTH)

sChecksum:: dw

sCheckValue2:: db ; loaded with SAVE_CHECK_VALUE_2, used to check save corruption


SECTION "Box Metadata", SRAM

for n, 1, NUM_BOXES + 1
sNewBox{d:n}:: newbox sNewBox{d:n}
endr
sNewBoxEnd::

for n, 1, NUM_BOXES + 1
sBackupNewBox{d:n}:: newbox sBackupNewBox{d:n}
endr
sBackupNewBoxEnd::

sWritingBackup:: db ; 1 if we're saving, anything else if not.

	ds $ff


SECTION "Link Battle Data", SRAM

sLinkBattleStats::
sLinkBattleWins::   dw
sLinkBattleLosses:: dw
sLinkBattleDraws::  dw

sLinkBattleRecord::
; sLinkBattleRecord1 - sLinkBattleRecord5
for n, 1, NUM_LINK_BATTLE_RECORDS + 1
sLinkBattleRecord{d:n}:: link_battle_record sLinkBattleRecord{d:n}
endr
sLinkBattleStatsEnd::


SECTION "SRAM Hall of Fame", SRAM

sHallOfFame::
; sHallOfFame1 - sHallOfFame30
for n, 1, NUM_HOF_TEAMS + 1
sHallOfFame{d:n}:: hall_of_fame sHallOfFame{d:n}
endr
sHallOfFameEnd::


SECTION "SRAM Crystal Data", SRAM

sGSBallFlag:: db

sCrystalData:: ds wCrystalDataEnd - wCrystalData

sGSBallFlagBackup:: db


SECTION "SRAM Battle Tower", SRAM

; Battle Tower data must be in SRAM because you can save and leave between battles
sBattleTowerChallengeState::
; 0: normal
; 2: battle tower
	db

sNrOfBeatenBattleTowerTrainers:: db
sBTChoiceOfLevelGroup:: db
; Battle Tower trainers are saved here, so nobody appears more than once
sBTTrainers:: ds BATTLETOWER_STREAK_LENGTH
sBattleTowerSaveFileFlags:: db
sBattleTowerReward:: db

sBTMonOfTrainers::
; team of previous trainer
; sBTMonPrevTrainer1 - sBTMonPrevTrainer3
for n, 1, BATTLETOWER_PARTY_LENGTH + 1
sBTMonPrevTrainer{d:n}:: db
endr
; team of preprevious trainer
; sBTMonPrevPrevTrainer1 - sBTMonPrevPrevTrainer3
for n, 1, BATTLETOWER_PARTY_LENGTH + 1
sBTMonPrevPrevTrainer{d:n}:: db
endr


SECTION "PokeDB Bank 1", SRAM

sNewBoxMons1:: pokedb sNewBoxMons1, MONDB_ENTRIES


SECTION "PokeDB Bank 2", SRAM

sNewBoxMons2:: pokedb sNewBoxMons2, MONDB_ENTRIES


SECTION "GG Bag Stash Save", SRAM

; The player's own bag while a Grand Gauntlet run is on (copy of
; wGGBagStash, written with the rest of the save). Its first byte is
; SAVE_CHECK_VALUE_1 only while a bag is stashed.
sGGBagStash:: ds GG_BAG_STASH_LENGTH
