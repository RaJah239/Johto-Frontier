FieldMoveJumptableReset:
	xor a
	ld hl, wFieldMoveData
	ld bc, wFieldMoveDataEnd - wFieldMoveData
	call ByteFill
	ret

FieldMoveJumptable:
	ld a, [wFieldMoveJumptableIndex]
	rst JumpTable
	ld [wFieldMoveJumptableIndex], a
	bit 7, a
	jr nz, .okay
	and a
	ret

.okay
	and $7f
	scf
	ret

GetPartyNickname:
; write wCurPartyMon nickname to wStringBuffer1-3
	ld hl, wPartyMonNicknames
	ld a, BOXMON
	ld [wMonType], a
	ld a, [wCurPartyMon]
	call GetNickname
	call CopyName1
; copy text from wStringBuffer2 to wStringBuffer3
	ld de, wStringBuffer2
	ld hl, wStringBuffer3
	call CopyName2
	ret

CheckEngineFlag:
; Check engine flag de
; Return carry if flag is not set
	ld b, CHECK_FLAG
	farcall EngineFlagAction
	ld a, c
	and a
	jr nz, .isset
	scf
	ret
.isset
	xor a
	ret

CheckBadge:
; Check engine flag a (ENGINE_ZEPHYRBADGE thru ENGINE_EARTHBADGE)
; Display "Badge required" text and return carry if the badge is not owned
	call CheckEngineFlag
	ret nc
	ld hl, .BadgeRequiredText
	call MenuTextboxBackup ; push text to queue
	scf
	ret

.BadgeRequiredText:
	text_far _BadgeRequiredText
	text_end

CheckPartyMove:
; Check if a monster in your party has move d.

	ld e, 0
	xor a
	ld [wCurPartyMon], a
.loop
	ld c, e
	ld b, 0
	ld hl, wPartySpecies
	add hl, bc
	ld a, [hl]
	and a
	jr z, .no
	cp -1
	jr z, .no
	cp EGG
	jr z, .next

	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1Moves
	ld a, e
	call AddNTimes
	ld b, NUM_MOVES
.check
	ld a, [hli]
	cp d
	jr z, .yes
	dec b
	jr nz, .check

.next
	inc e
	jr .loop

.yes
	ld a, e
	ld [wCurPartyMon], a ; which mon has the move
	xor a
	ret
.no
	scf
	ret

CheckPartyCanLearnMove:
; CHECK IF MONSTER IN PARTY CAN LEARN MOVE D
	ld e, 0
	xor a
	ld [wCurPartyMon], a
.loop
	ld c, e
	ld b, 0
	ld hl, wPartySpecies
	add hl, bc
	ld a, [hl]
	and a
	jr z, .no
	cp -1
	jr z, .no
	cp EGG
	jr z, .next

	ld [wCurPartySpecies], a
	ld a, d
; Check the TM/HM/Move Tutor list
	ld [wPutativeTMHMMove], a
	push de
	farcall CanLearnTMHMMove
	pop de
.check
	ld a, c
	and a
	jr nz, .yes
; Check the Pokemon's Level-Up Learnset
	ld b,b
	ld a, d
	push de
	call OW_CheckLvlUpMoves
	pop de
	jr nc, .yes
; done checking

.next
	inc e
	jr .loop

.yes
	ld a, e
	; which mon can learn the move
	ld [wCurPartyMon], a
	xor a
	ret
.no
	ld a, 1
	ret

OW_CheckLvlUpMoves:
; move looking for in a
	ld d, a
	ld a, [wCurPartySpecies]
	dec a
	ld b, 0
	ld c, a
	ld hl, EvosAttacksPointers
	add hl, bc
	add hl, bc
	ld a, BANK(EvosAttacksPointers)
	ld b, a
	call GetFarWord
	ld a, b
	call GetFarByte
	inc hl
	and a
	jr z, .find_move ; no evolutions
	dec hl ; does have evolution(s)
	call OW_SkipEvolutions
.find_move
	call OW_GetNextEvoAttackByte
	and a
	jr z, .notfound ; end of mon's lvl up learnset
	call OW_GetNextEvoAttackByte
	cp d
	jr z, .found
	jr .find_move
.found
	xor a
	ret ; move is in lvl up learnset
.notfound
	scf ; move isnt in lvl up learnset
	ret

OW_SkipEvolutions:
; Receives a pointer to the evos and attacks, and skips to the attacks.
	ld a, b
	call GetFarByte
	inc hl
	and a
	ret z
	cp EVOLVE_STAT
	jr nz, .no_extra_skip
	inc hl
.no_extra_skip
	inc hl
	inc hl
	jr OW_SkipEvolutions

OW_GetNextEvoAttackByte:
	ld a, BANK(EvosAttacksPointers)
	call GetFarByte
	inc hl
	ret

FieldMovePokepicScript:
	readmem wOverworldMoveSpecies
	reanchormap
	pokepic 0
	cry 0
	waitsfx
	closepokepic
	refreshmap
	end

FieldMoveFailed:
	ld hl, .CantUseItemText
	call MenuTextboxBackup
	ret

.CantUseItemText:
	text_far _CantUseItemText
	text_end

CutFunction:
	call FieldMoveJumptableReset
.loop
	ld hl, .Jumptable
	call FieldMoveJumptable
	jr nc, .loop
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.Jumptable:
	dw .CheckAble
	dw .DoCut
	dw .FailCut

.CheckAble:
	call CheckMapForSomethingToCut
	jr c, .nothingtocut
	ld a, $1
	ret

.nothingtocut
	ld a, $2
	ret

.DoCut:
	ld hl, Script_CutFromMenu
	call QueueScript
	ld a, $81
	ret

.FailCut:
	ld hl, CutNothingText
	call MenuTextboxBackup
	ld a, $80
	ret

UseCutText:
	text_far _UseCutText
	text_end

CutNothingText:
	text_far _CutNothingText
	text_end

CheckMapForSomethingToCut:
	; Does the collision data of the facing tile permit cutting?
	call GetFacingTileCoord
	ld c, a
	push de
	farcall CheckCutCollision
	pop de
	jr nc, .fail
	; Get the location of the current block in wOverworldMapBlocks.
	call GetBlockLocation
	ld c, [hl]
	; See if that block contains something that can be cut.
	push hl
	ld hl, CutTreeBlockPointers
	call CheckOverworldTileArrays
	pop hl
	jr nc, .fail
	; Save the Cut field move data
	ld a, l
	ld [wCutWhirlpoolOverworldBlockAddr], a
	ld a, h
	ld [wCutWhirlpoolOverworldBlockAddr + 1], a
	ld a, b
	ld [wCutWhirlpoolReplacementBlock], a
	ld a, c
	ld [wCutWhirlpoolAnimationType], a
	xor a
	ret

.fail
	scf
	ret

Script_CutFromMenu:
	refreshmap
	special UpdateTimePals

Script_Cut:
	isfieldactionssettoquick
	iftrue .skip
	writetext UseCutText
	refreshmap
	pokepic SCYTHER
	cry SCYTHER
	waitsfx
	closepokepic
.skip
	refreshmap
	callasm CutDownTreeOrGrass
	closetext
	end

CutDownTreeOrGrass:
	farcall CopyBGGreenToOBPal7
	ld hl, wCutWhirlpoolOverworldBlockAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wCutWhirlpoolReplacementBlock]
	ld [hl], a
	xor a
	ldh [hBGMapMode], a
	call LoadOverworldTilemapAndAttrmapPals
	call UpdateSprites
	call DelayFrame
	ld a, [wCutWhirlpoolAnimationType]
	ld e, a
	farcall OWCutAnimation
	call BufferScreen
	call GetMovementPermissions
	call UpdateSprites
	call DelayFrame
	call LoadStandardFont
	ret

CheckOverworldTileArrays:
	; Input: c contains the tile you're facing
	; Output: Replacement tile in b and effect on wild encounters in c, plus carry set.
	;         Carry is not set if the facing tile cannot be replaced, or if the tileset
	;         does not contain a tile you can replace.

	; Dictionary lookup for pointer to tile replacement table
	push bc
	ld a, [wMapTileset]
	ld de, 3
	call IsInArray
	pop bc
	jr nc, .nope
	; Load the pointer
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	; Look up the tile you're facing
	ld de, 3
	ld a, c
	call IsInArray
	jr nc, .nope
	; Load the replacement to b
	inc hl
	ld b, [hl]
	; Load the animation type parameter to c
	inc hl
	ld c, [hl]
	scf
	ret

.nope
	xor a
	ret

INCLUDE "data/collision/field_move_blocks.asm"

TryFlashOW::
	ld a, [wTimeOfDayPalset]
	cp DARKNESS_PALSET
	jr nz, .quit

	; check if we own the the mareep call
	ld a, MAREEP_CALL
	ld [wCurItem], a
	ld hl, wNumItems
	call CheckItem
	jr nc, .quit

.yes
	ld a, BANK(Script_UseFlash)
	ld hl, Script_UseFlash
	jmp CallScript

.quit
	xor a
	ret

FlashFunction:
	call .CheckUseFlash
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.CheckUseFlash:
	push hl
	farcall SpecialAerodactylChamber
	pop hl
	jr c, .useflash
	ld a, [wTimeOfDayPalset]
	cp DARKNESS_PALSET
	jr nz, .notadarkcave
.useflash
	call UseFlash
	ld a, $81
	ret

.notadarkcave
	call FieldMoveFailed
	ld a, $80
	ret

UseFlash:
	ld hl, Script_UseFlash
	jmp QueueScript

Script_UseFlash:
	reanchormap
	isfieldactionssettoquick
	iftrue .skip
	special UpdateTimePals
	reanchormap
	pokepic MAREEP
	cry MAREEP
	waitsfx
	closepokepic
	reanchormap
	writetext UseFlashTextScript
	closetext
.skip
	callasm BlindingFlash
	closetext
	end

UseFlashTextScript:
	text_far _MareepLit
	text_asm
	call WaitSFX
	ld de, SFX_FLASH
	call PlaySFX
	call WaitSFX
	ld hl, .BlankText
	ret

.BlankText:
	text_end

SurfFunction:
	call FieldMoveJumptableReset
.loop
	ld hl, .Jumptable
	call FieldMoveJumptable
	jr nc, .loop
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.Jumptable:
	dw .TrySurf
	dw .DoSurf
	dw .FailSurf
	dw .AlreadySurfing

.TrySurf:
if DEF(_DEBUG)
else
	ld de, ENGINE_FOGBADGE
	call CheckBadge
	jr c, .nofogbadge
endc
	ld hl, wBikeFlags
	bit BIKEFLAGS_ALWAYS_ON_BIKE_F, [hl]
	jr nz, .cannotsurf
	ld a, [wPlayerState]
	cp PLAYER_SURF
	jr z, .alreadyfail
	cp PLAYER_SURF_PIKA
	jr z, .alreadyfail
	call GetFacingTileCoord
	call GetTilePermission
	cp WATER_TILE
	jr nz, .cannotsurf
	call CheckDirection
	jr c, .cannotsurf
	farcall CheckFacingObject
	jr c, .cannotsurf
	ld a, $1
	ret
.nofogbadge
	ld a, $80
	ret
.alreadyfail
	ld a, $3
	ret
.cannotsurf
	ld a, $2
	ret

.DoSurf:
	call GetSurfType
	ld [wSurfingPlayerState], a
	call GetPartyNickname
	ld hl, SurfFromMenuScript
	call QueueScript
	ld a, $81
	ret

.FailSurf:
	ld hl, CantSurfText
	call MenuTextboxBackup
	ld a, $80
	ret

.AlreadySurfing:
	ld hl, AlreadySurfingText
	call MenuTextboxBackup
	ld a, $80
	ret

SurfFromMenuScript:
	special UpdateTimePals

UsedSurfScript:
	reanchormap
	checkevent EVENT_PIKA_SURF
	iftrue .PikaSurfs
	pokepic LANTURN
	cry LANTURN
	sjump .continue

.PikaSurfs:
	pokepic PIKACHU
	cry PIKACHU
.continue:
	waitsfx
	closepokepic
	refreshmap
	writetext UsedSurfText ; "used SURF!"
	waitbutton
	closetext
	; fallthrough

AutoSurfScript:
	readmem wSurfingPlayerState
	writevar VAR_MOVEMENT

	special UpdatePlayerSprite
	special PlayMapMusic
	special SurfStartStep
	end

UsedSurfText:
	text_far _UsedSurfText
	text_end

CantSurfText:
	text_far _CantSurfText
	text_end

AlreadySurfingText:
	text_far _AlreadySurfingText
	text_end

GetSurfType:
; Surfing on Pikachu uses an alternate sprite.
; This is done by using a separate movement type.
; If the current surfing Pokémon is Pikachu, return
; PLAYER_SURF_PIKA and set EVENT_PIKA_SURF.
; Otherwise, return PLAYER_SURF.

	ld a, [wCurPartyMon]
	ld e, a
	ld d, 0
	ld hl, wPartySpecies
	add hl, de

	ld a, [hl]
	cp PIKACHU
	jr nz, .not_pikachu

	; Pikachu is our surfer
	ld de, EVENT_PIKA_SURF
	ld b, SET_FLAG
	call EventFlagAction

	ld a, PLAYER_SURF_PIKA
	ret

.not_pikachu
	ld a, PLAYER_SURF
	ret

CheckDirection:
; Return carry if a tile permission prevents you
; from moving in the direction you're facing.

; Get player direction
	ld a, [wPlayerDirection]
	and %00001100 ; bits 2 and 3 contain direction
	rrca
	rrca
	ld e, a
	ld d, 0
	ld hl, .Directions
	add hl, de

; Can you walk in this direction?
	ld a, [wTilePermissions]
	and [hl]
	jr nz, .quit
	xor a
	ret

.quit
	scf
	ret

.Directions:
	db FACE_DOWN
	db FACE_UP
	db FACE_LEFT
	db FACE_RIGHT

TrySurfOW::
; Checking a tile in the overworld.
; Return carry if fail is allowed.

; Don't ask to surf if already fail.

	; Pikachu is not our surfer
	ld de, EVENT_PIKA_SURF
	ld b, RESET_FLAG
	call EventFlagAction

	ld a, [wPlayerState]
	cp PLAYER_SURF_PIKA
	jr z, .quit
	cp PLAYER_SURF
	jr z, .quit

; Must be facing water.
	ld a, [wFacingTileID]
	call GetTilePermission
	cp WATER_TILE
	jr nz, .quit

; Check tile permissions.
	call CheckDirection
	jr c, .quit
if DEF(_DEBUG)
else
	ld de, ENGINE_FOGBADGE
	call CheckEngineFlag
	jr c, .quit
endc
	ld hl, wBikeFlags
	bit BIKEFLAGS_ALWAYS_ON_BIKE_F, [hl]
	jr nz, .quit

	ld d, SURF
	call CheckPartyMove
	jr c, .check_mon_move

	call GetSurfType
	ld [wSurfingPlayerState], a
	jr .finish

.check_mon_move
	ld a, LANTURN_CALL
	ld [wCurItem], a
	ld hl, wNumItems
	call CheckItem
	jr nc, .quit

	ld a, PLAYER_SURF
	ld [wSurfingPlayerState], a

.finish
	ld a, BANK(AskSurfScript)
	ld hl, AskSurfScript
	call CallScript
	scf
	ret

.quit
	xor a
	ret

AskSurfScript:
	isfieldactionssettoquick
	iftrue AutoSurfScript
	opentext
	checkevent EVENT_PIKA_SURF
	iftrue .AskPikaSurf
	writetext AskSurfText
	sjump .YesOrNoSurf

.AskPikaSurf:
	writetext AskPikaSurfText
.YesOrNoSurf:
	yesorno
	iftrue UsedSurfScript
	closetext
	end

AskSurfText:
	text_far _AskSurfText
	text_end

AskPikaSurfText:
	text_far _AskPikaSurfText
	text_end

FlyFunction:
	call FieldMoveJumptableReset
.loop
	ld hl, .Jumptable
	call FieldMoveJumptable
	jr nc, .loop
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.Jumptable:
	dw .TryFly
	dw .DoFly
	dw .FailFly

.TryFly:
	call GetMapEnvironment
	call CheckOutdoorMap
	jr z, .outdoors
	jr .indoors

.outdoors
	xor a
	ldh [hMapAnims], a
	call LoadStandardMenuHeader
	call ClearSprites
	farcall _FlyMap
	ld a, e
	cp -1
	jr z, .illegal
	cp NUM_SPAWNS
	jr nc, .illegal

	ld [wDefaultSpawnpoint], a
	call CloseWindow
	ld a, $1
	ret

.indoors
	ld a, $2
	ret

.illegal
	call CloseWindow
	call WaitBGMap
	ld a, $80
	ret

.DoFly:
	ld hl, .FlyScript
	call QueueScript
	ld a, $81
	ret

.FailFly:
	call FieldMoveFailed
	ld a, $82
	ret

.FlyScript:
	isfieldactionssettoquick
	iftrue .skip
	refreshmap
	callasm HideSprites
	callasm ClearSavedObjPals
	callasm PrepareOverworldMove
	scall FieldMovePokepicScript
	callasm CopyBGGreenToOBPal7
	special UpdateTimePals
	callasm FlyFromAnim
.skip:
	farscall Script_AbortBugContest
	special WarpToSpawnPoint
	callasm SkipUpdateMapSprites
	loadvar VAR_MOVEMENT, PLAYER_NORMAL
	newloadmap MAPSETUP_FLY
	callasm CopyBGGreenToOBPal7
	callasm FlyToAnim
	special WaitSFX
	callasm .ReturnFromFly
	end

.ReturnFromFly:
	farcall RespawnPlayer
	farcall ClearSavedObjPals
	farcall CheckForUsedObjPals
	call DelayFrame
	call UpdatePlayerSprite
	farcall LoadOverworldFont
	ret

WaterfallFunction:
	call .TryWaterfall
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.TryWaterfall:
	call CheckMapCanWaterfall
	jr c, .failed
	ld hl, Script_WaterfallFromMenu
	call QueueScript
	ld a, $81
	ret

.failed
	call FieldMoveFailed
	ld a, $80
	ret

CheckMapCanWaterfall:
	ld a, [wPlayerDirection]
	and $c
	cp FACE_UP
	jr nz, .failed
	ld a, [wTileUp]
	call CheckWaterfallTile
	jr nz, .failed
	xor a
	ret

.failed
	scf
	ret

Script_WaterfallFromMenu:
	refreshmap
	special UpdateTimePals

Script_UsedWaterfall:
	reanchormap
	pokepic MILOTIC
	cry MILOTIC
	waitsfx
	closepokepic
	refreshmap
	farwritetext _UseWaterfallText
	waitbutton
	closetext
	; fallthrough

Script_AutoWaterfall:
	waitsfx
	playsound SFX_BUBBLEBEAM
.loop
	applymovement PLAYER, .WaterfallStep
	callasm .CheckContinueWaterfall
	iffalse .loop
	end

.CheckContinueWaterfall:
	xor a
	ld [wScriptVar], a
	ld a, [wPlayerTileCollision]
	call CheckWaterfallTile
	ret z
	farcall StubbedTrainerRankings_Waterfall
	ld a, $1
	ld [wScriptVar], a
	ret

.WaterfallStep:
	turn_waterfall UP
	step_end

TryWaterfallOW::
	ld a, MILOTIC_CALL
	ld [wCurItem], a
	ld hl, wNumItems
	call CheckItem
	jr nc, .failed

	call CheckMapCanWaterfall
	jr c, .failed
	ld a, BANK(Script_AskWaterfall)
	ld hl, Script_AskWaterfall
	call CallScript
	scf
	ret

.failed
	ld a, BANK(Script_CantDoWaterfall)
	ld hl, Script_CantDoWaterfall
	call CallScript
	scf
	ret

Script_CantDoWaterfall:
	jumptext .HugeWaterfallText

.HugeWaterfallText:
	text_far _HugeWaterfallText
	text_end

Script_AskWaterfall:
	isfieldactionssettoquick
	iftrue Script_AutoWaterfall
	opentext
	writetext .AskWaterfallText
	yesorno
	iftrue Script_UsedWaterfall
	closetext
	end

.AskWaterfallText:
	text_far _AskWaterfallText
	text_end

EscapeRopeFunction:
	call FieldMoveJumptableReset
	ld a, $1
	jr EscapeRopeOrDig

DigFunction:
	call FieldMoveJumptableReset
	ld a, $2

EscapeRopeOrDig:
	ld [wEscapeRopeOrDigType], a
.loop
	ld hl, .DigTable
	call FieldMoveJumptable
	jr nc, .loop
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.DigTable:
	dw .CheckCanDig
	dw .DoDig
	dw .FailDig

.CheckCanDig:
	call GetMapEnvironment
	cp CAVE
	jr z, .incave
	cp DUNGEON
	jr z, .incave
.fail
	ld a, $2
	ret

.incave
	ld hl, wDigWarpNumber
	ld a, [hli]
	and a
	jr z, .fail
	ld a, [hli]
	and a
	jr z, .fail
	ld a, [hl]
	and a
	jr z, .fail
	ld a, $1
	ret

.DoDig:
	ld hl, wDigWarpNumber
	ld de, wNextWarp
	ld bc, 3
	call CopyBytes
	call GetPartyNickname
	ld a, [wEscapeRopeOrDigType]
	cp $2
	jr nz, .escaperope
	ld hl, .UsedDigScript
	call QueueScript
	ld a, $81
	ret

.escaperope
	farcall SpecialLileepChamber
	ld hl, .UsedEscapeRopeScript
	call QueueScript
	ld a, $81
	ret

.FailDig:
	ld a, [wEscapeRopeOrDigType]
	cp $2
	jr nz, .failescaperope
	ld hl, .CantUseDigText
	call MenuTextbox
	call WaitPressAorB_BlinkCursor
	call CloseWindow

.failescaperope
	ld a, $80
	ret

.UseDigText:
	text_far _UseDigText
	text_end

.UseEscapeRopeText:
	text_far _UseEscapeRopeText
	text_end

.CantUseDigText:
	text_far _CantUseDigText
	text_end

.UsedEscapeRopeScript:
	isfieldactionssettoquick
	iftrue .skip
	refreshmap
	special UpdateTimePals
	writetext .UseEscapeRopeText
	sjump .UsedDigOrEscapeRopeScript

.UsedDigScript:
	isfieldactionssettoquick
	iftrue .skip
	refreshmap
	special UpdateTimePals
	callasm PrepareOverworldMove
	scall FieldMovePokepicScript
	writetext .UseDigText

.UsedDigOrEscapeRopeScript:
	waitbutton
	closetext
.skip
	playsound SFX_WARP_TO
	applymovement PLAYER, .DigOut
	farscall Script_AbortBugContest
	special WarpToSpawnPoint
	loadvar VAR_MOVEMENT, PLAYER_NORMAL
	newloadmap MAPSETUP_DOOR
	playsound SFX_WARP_FROM
	applymovement PLAYER, .DigReturn
	end

.DigOut:
	step_dig 32
	hide_object
	step_end

.DigReturn:
	show_object
	return_dig 32
	step_end

TeleportFunction:
	call FieldMoveJumptableReset
.loop
	ld hl, .Jumptable
	call FieldMoveJumptable
	jr nc, .loop
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.Jumptable:
	dw .TryTeleport
	dw .DoTeleport
	dw .FailTeleport

.TryTeleport:
	ld a, [wLastSpawnMapGroup]
	ld d, a
	ld a, [wLastSpawnMapNumber]
	ld e, a
	farcall IsSpawnPoint
	jr nc, .nope
	ld a, c
	ld [wDefaultSpawnpoint], a
	ld a, $1
	ret

.nope
	ld a, $2
	ret

.DoTeleport:
	call GetPartyNickname
	ld hl, .TeleportScript
	call QueueScript
	ld a, $81
	ret

.FailTeleport:
	ld hl, .CantUseTeleportText
	call MenuTextboxBackup
	ld a, $80
	ret

.TeleportReturnText:
	text_far _TeleportReturnText
	text_end

.CantUseTeleportText:
	text_far _CantUseTeleportText
	text_end

.TeleportScript:
	isfieldactionssettoquick
	iftrue .skip
	refreshmap
	special UpdateTimePals
	callasm PrepareOverworldMove
	scall FieldMovePokepicScript
	writetext .TeleportReturnText
	pause 16
	refreshmap
	closetext
	playsound SFX_WARP_TO
.skip
	applymovement PLAYER, .TeleportFrom
	farscall Script_AbortBugContest
	special WarpToSpawnPoint
	loadvar VAR_MOVEMENT, PLAYER_NORMAL
	newloadmap MAPSETUP_TELEPORT
	playsound SFX_WARP_FROM
	applymovement PLAYER, .TeleportTo
	end

.TeleportFrom:
	teleport_from
	step_end

.TeleportTo:
	teleport_to
	step_end

StrengthFunction:
	call .TryStrength
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.TryStrength:
	ld hl, Script_StrengthFromMenu
	call QueueScript
	ld a, $81
	ret

SetStrengthFlag:
	ld hl, wBikeFlags
	set BIKEFLAGS_STRENGTH_ACTIVE_F, [hl]
PrepareOverworldMove:
	ld a, [wCurPartyMon]
	ld e, a
	ld d, 0
	ld hl, wPartySpecies
	add hl, de
	ld a, [hl]
	ld [wOverworldMoveSpecies], a
	call GetPartyNickname
	ret

Script_StrengthFromMenu:
	refreshmap
	special UpdateTimePals

Script_UsedStrength:
	callasm SetStrengthFlag
	isfieldactionssettoquick
	iftrue .skip
	writetext .UseStrengthText
	waitbutton
	reanchormap
	pokepic DONPHAN
	cry DONPHAN
	waitsfx
	closepokepic
	refreshmap
	writetext .MoveBoulderText
	closetext
	end

.skip:
	reanchormap
	closetext
	end

.UseStrengthText:
	text_far _UseStrengthText
	text_end

.MoveBoulderText:
	text_far _MoveBoulderText
	text_end

AskStrengthScript:
	callasm TryStrengthOW
	iffalse .AskStrength
	ifequal $1, .DontMeetRequirements
	sjump .AlreadyUsedStrength

.DontMeetRequirements:
	jumptext BouldersMayMoveText

.AlreadyUsedStrength:
	jumptext BouldersMoveText

.AskStrength:
	isfieldactionssettoquick
	iftrue .skip
	opentext
	writetext AskStrengthText
	yesorno
	iftrue Script_UsedStrength
	closetext
	end

.skip:
	sjump Script_UsedStrength

AskStrengthText:
	text_far _AskStrengthText
	text_end

BouldersMoveText:
	text_far _BouldersMoveText
	text_end

BouldersMayMoveText:
	text_far _BouldersMayMoveText
	text_end

TryStrengthOW:
	ld a, DONPHAN_CALL
	ld [wCurItem], a
	ld hl, wNumItems
	call CheckItem
	jr nc, .nope

	ld hl, wBikeFlags
	bit BIKEFLAGS_STRENGTH_ACTIVE_F, [hl]
	jr z, .already_using

	ld a, 2
	jr .done

.nope
	ld a, 1
	jr .done

.already_using
	xor a

.done
	ld [wScriptVar], a
	ret

WhirlpoolFunction:
	call FieldMoveJumptableReset
.loop
	ld hl, .Jumptable
	call FieldMoveJumptable
	jr nc, .loop
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.Jumptable:
	dw .TryWhirlpool
	dw .DoWhirlpool
	dw .FailWhirlpool

.TryWhirlpool:
	call TryWhirlpoolMenu
	jr c, .failed
	ld a, $1
	ret

.failed
	ld a, $2
	ret

.DoWhirlpool:
	ld hl, Script_WhirlpoolFromMenu
	call QueueScript
	ld a, $81
	ret

.FailWhirlpool:
	call FieldMoveFailed
	ld a, $80
	ret

UseWhirlpoolText:
	text_far _UseWhirlpoolText
	text_end

TryWhirlpoolMenu:
	call GetFacingTileCoord
	ld c, a
	push de
	call CheckWhirlpoolTile
	pop de
	jr c, .failed
	call GetBlockLocation
	ld c, [hl]
	push hl
	ld hl, WhirlpoolBlockPointers
	call CheckOverworldTileArrays
	pop hl
	jr nc, .failed
	; Save the Whirlpool field move data
	ld a, l
	ld [wCutWhirlpoolOverworldBlockAddr], a
	ld a, h
	ld [wCutWhirlpoolOverworldBlockAddr + 1], a
	ld a, b
	ld [wCutWhirlpoolReplacementBlock], a
	ld a, c
	ld [wCutWhirlpoolAnimationType], a
	xor a
	ret

.failed
	scf
	ret

Script_WhirlpoolFromMenu:
	refreshmap
	special UpdateTimePals

Script_UsedWhirlpool:
	reanchormap
	pokepic KINGDRA
	cry KINGDRA
	waitsfx
	closepokepic
	refreshmap
	writetext UseWhirlpoolText
	closetext
	; fallthrough

Script_AutoWhirlpool:
	waitsfx
	playsound SFX_2_BOOPS
	checkcode VAR_FACING
	if_equal UP, .Up
	if_equal DOWN, .Down
	if_equal RIGHT, .Right
	applymovement PLAYER, .LeftMovementData
	end

.Up:
	applymovement PLAYER, .UpMovementData
	end

.Right:
	applymovement PLAYER, .RightMovementData
	end

.Down:
	applymovement PLAYER, .DownMovementData
	end

.UpMovementData:
	slow_step_up
	slow_step_up
	step_end

.RightMovementData:
	slow_step_right
	slow_step_right
	step_end

.DownMovementData:
	slow_step_down
	slow_step_down
	step_end

.LeftMovementData:
	slow_step_left
	slow_step_left
	step_end

TryWhirlpoolOW::
	ld a, KINGDRA_CALL
	ld [wCurItem], a
	ld hl, wNumItems
	call CheckItem
	jr nc, .failed

	call TryWhirlpoolMenu
	jr c, .failed
	ld a, BANK(Script_AskWhirlpoolOW)
	ld hl, Script_AskWhirlpoolOW
	call CallScript
	scf
	ret

.failed
	ld a, BANK(Script_MightyWhirlpool)
	ld hl, Script_MightyWhirlpool
	call CallScript
	scf
	ret

Script_MightyWhirlpool:
	jumptext .MayPassWhirlpoolText

.MayPassWhirlpoolText:
	text_far _MayPassWhirlpoolText
	text_end

Script_AskWhirlpoolOW:
	isfieldactionssettoquick
	iftrue Script_AutoWhirlpool
	opentext
	writetext AskWhirlpoolText
	yesorno
	iftrue Script_UsedWhirlpool
	closetext
	end

AskWhirlpoolText:
	text_far _AskWhirlpoolText
	text_end

HeadbuttFunction:
	call TryHeadbuttFromMenu
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

TryHeadbuttFromMenu:
	call GetFacingTileCoord
	call CheckHeadbuttTreeTile
	jr nz, .no_tree

	ld hl, HeadbuttFromMenuScript
	call QueueScript
	ld a, $81
	ret

.no_tree
	call FieldMoveFailed
	ld a, $80
	ret

UseHeadbuttText:
	text_far _UseHeadbuttText
	text_end

HeadbuttFromMenuScript:
	refreshmap
	special UpdateTimePals

HeadbuttScript:
	callasm PrepareOverworldMove
	writetext UseHeadbuttText
	scall FieldMovePokepicScript
	; fallthrough

AutoHeadbuttScript:
	reanchormap
	callasm ShakeHeadbuttTree

	callasm TreeMonEncounter
	iffalse .no_battle
	closetext
	randomwildmon
	startbattle
	reloadmapafterbattle
.no_battle
	callasm HeadbuttItemEncounter
	iffalse .no_item
	opentext
	verbosegiveitem ITEM_FROM_MEM
	closetext
.no_item
	end

TryHeadbuttOW::
; Step 1
	ld d, HEADBUTT
	call CheckPartyMove
	jr nc, .can_use

; Step 2
	ld a, TM_HEADBUTT
	ld [wCurItem], a
	ld hl, wNumItems
	call CheckItem
	jr z, .no

; Step 3
	ld d, HEADBUTT
	call CheckPartyCanLearnMove
    and a
	jr z, .can_use ; cannot learn headbutt
.no
	xor a
	ret
.can_use
	ld a, BANK(AskHeadbuttScript)
	ld hl, AskHeadbuttScript
	call CallScript
	scf
	ret

AskHeadbuttScript:
	isfieldactionssettoquick
	iftrue AutoHeadbuttScript
	opentext
	writetext AskHeadbuttText
	yesorno
	iftrue HeadbuttScript
	closetext
	end

AskHeadbuttText:
	text_far _AskHeadbuttText
	text_end

RockSmashFunction:
	call TryRockSmashFromMenu
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

TryRockSmashFromMenu:
	call GetFacingObject
	jr c, .no_rock
	ld a, d
	cp SPRITEMOVEDATA_SMASHABLE_ROCK
	jr nz, .no_rock

	ld hl, RockSmashFromMenuScript
	call QueueScript
	ld a, $81
	ret

.no_rock
	call FieldMoveFailed
	ld a, $80
	ret

GetFacingObject:
	farcall CheckFacingObject
	jr nc, .fail

	ldh a, [hObjectStructIndex]
	call GetObjectStruct
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	ldh [hLastTalked], a
	call GetMapObject
	ld hl, MAPOBJECT_MOVEMENT
	add hl, bc
	ld a, [hl]
	ld d, a
	and a
	ret

.fail
	scf
	ret

RockSmashFromMenuScript:
	refreshmap
	special UpdateTimePals

RockSmashScript:
	callasm PrepareOverworldMove
	farwritetext _UseRockSmashText
	scall FieldMovePokepicScript
	closetext
	; fallthrough

AutoRockSmashScript:
	waitsfx
	playsound SFX_STRENGTH
	earthquake 84
	applymovementlasttalked MovementData_RockSmash
	disappear LAST_TALKED

	callasm RockMonEncounter
	readmem wTempWildMonSpecies
	iffalse .no_battle
	randomwildmon
	startbattle
	reloadmapafterbattle
.no_battle
	callasm RockItemEncounter
	iffalse .no_item
	opentext
	verbosegiveitem ITEM_FROM_MEM
	closetext
.no_item
	end

MovementData_RockSmash:
	rock_smash 10
	step_end

AskRockSmashScript:
	callasm HasRockSmash
	ifequal 1, .no

	isfieldactionssettoquick
	iftrue AutoRockSmashScript
	opentext
	writetext AskRockSmashText
	yesorno
	iftrue RockSmashScript
	endtext

.no
	jumptext MaySmashText

MaySmashText:
	text_far _MaySmashText
	text_end

AskRockSmashText:
	text_far _AskRockSmashText
	text_end

HasRockSmash:
; Step 1
	ld d, BRICK_BREAK
	call CheckPartyMove
	jr nc, .yes

; Step 2
	ld a, TM_BRICK_BREAK
	ld [wCurItem], a
	ld hl, wNumItems
	call CheckItem
	jr z, .no

; Step 3
	ld d, BRICK_BREAK
	call CheckPartyCanLearnMove
       and a
	jr z, .yes
.no
	ld a, 1
	jr .done
.yes
	xor a
	jr .done
.done
	ld [wScriptVar], a
	ret

FishFunction:
	ld a, e
	push af
	call FieldMoveJumptableReset
	pop af
	ld [wFishingRodUsed], a
.loop
	ld hl, .FishTable
	call FieldMoveJumptable
	jr nc, .loop
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.FishTable:
	dw .TryFish
	dw .FishNoBite
	dw .FishGotSomething
	dw .FailFish
	dw .FishNoFish

.TryFish:
	ld a, [wPlayerState]
	cp PLAYER_SURF_PIKA
	jr z, .fail
	call GetFacingTileCoord
	call GetTilePermission
	cp WATER_TILE
	jr nz, .fail
 	farcall CheckFacingObject
 	jr nc, .facingwater
.fail
	ld a, $3
	ret

.facingwater
	call GetFishingGroup
	and a
	jr nz, .goodtofish
	ld a, $4
	ret

.goodtofish
	ld d, a
	ld a, [wFishingRodUsed]
	ld e, a
	farcall Fish
	ld a, d
	and a
	jr z, .nonibble
	ld [wTempWildMonSpecies], a
	ld a, e
	ld [wCurPartyLevel], a
	ld a, BATTLETYPE_FISH
	ld [wBattleType], a
	ld a, $2
	ret

.nonibble
	ld a, $1
	ret

.FailFish:
	ld a, $80
	ret

.FishGotSomething:
	ld a, $1
	ld [wFishingResult], a
	ld hl, Script_GotABite
	call QueueScript
	ld a, $81
	ret

.FishNoBite:
	ld a, $2
	ld [wFishingResult], a
	ld hl, Script_NotEvenANibble
	call QueueScript
	ld a, $81
	ret

.FishNoFish:
	ld a, $0
	ld [wFishingResult], a
	ld hl, Script_NotEvenANibble2
	call QueueScript
	ld a, $81
	ret

Script_NotEvenANibble:
	scall Script_FishCastRod
	callasm FishingtItemEncounter
	iffalse .no_item
	opentext
	verbosegiveitem ITEM_FROM_MEM
	closetext
	end
.no_item
	isfieldactionssettoquick
	iftrue .skip1
	writetext RodNothingText
.skip1
	sjump Script_NotEvenANibble_FallThrough

Script_NotEvenANibble2:
	scall Script_FishCastRod
	callasm FishingtItemEncounter
	iffalse .no_item
	opentext
	verbosegiveitem ITEM_FROM_MEM
	closetext
	end
.no_item
	isfieldactionssettoquick
	iftrue .skip2
	writetext RodNothingText
.skip2
	; fallthrough

Script_NotEvenANibble_FallThrough:
	loademote EMOTE_SHADOW
	callasm PutTheRodAway
	closetext
	end

Script_GotABite:
	scall Script_FishCastRod
	callasm Fishing_CheckFacingUp
	iffalse .NotFacingUp
	applymovement PLAYER, .Movement_FacingUp
	sjump .FightTheHookedPokemon

.NotFacingUp:
	applymovement PLAYER, .Movement_NotFacingUp

.FightTheHookedPokemon:
	pause 20
	applymovement PLAYER, .Movement_RestoreRod

	isfieldactionssettoquick
	iftrue .skip
	writetext RodBiteText
.skip
	callasm PutTheRodAway
	closetext
	randomwildmon
	startbattle
	reloadmapafterbattle
	callasm FishingtItemEncounter
	iffalse .no_item
	opentext
	verbosegiveitem ITEM_FROM_MEM
	closetext
.no_item
	end

.Movement_NotFacingUp:
	fish_got_bite
	fish_got_bite
	fish_got_bite
	fish_got_bite
	show_emote
	step_end

.Movement_FacingUp:
	fish_got_bite
	fish_got_bite
	fish_got_bite
	fish_got_bite
	step_sleep 1
	show_emote
	step_end

.Movement_RestoreRod:
	hide_emote
	fish_cast_rod
	step_end

Fishing_CheckFacingUp:
	ld a, [wPlayerDirection]
	and $c
	cp OW_UP
	ld a, $1
	jr z, .up
	xor a

.up
	ld [wScriptVar], a
	ret

Script_FishCastRod:
	refreshmap
	loadmem hBGMapMode, $0
	special UpdateTimePals
	loademote EMOTE_ROD
	callasm LoadFishingGFX
	loademote EMOTE_SHOCK
	applymovement PLAYER, MovementData_CastRod
	pause 10 ; wait time after casting rod
	end

MovementData_CastRod:
	fish_cast_rod
	step_end

PutTheRodAway:
	xor a
	ldh [hBGMapMode], a
	ld a, $1
	ld [wPlayerAction], a
	call UpdateSprites
	call UpdatePlayerSprite
	ret

RodBiteText:
	text_far _RodBiteText
	text_end

RodNothingText:
	text_far _RodNothingText
	text_end

BikeFunction:
	call .TryBike
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.TryBike:
	call .CheckEnvironment
	jr c, .CannotUseBike
	ld a, [wPlayerState]
	cp PLAYER_NORMAL
	jr z, .GetOnBike
	cp PLAYER_BIKE
	jr z, .GetOffBike
	jr .CannotUseBike

.GetOnBike:
	ld hl, Script_GetOnBike
	ld de, Script_GetOnBike_Register
	call .CheckIfRegistered
	call QueueScript
	xor a
	ld [wMusicFade], a
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	call MaxVolume
	ld de, MUSIC_BICYCLE
	ld a, e
	ld [wMapMusic], a
	call PlayMusic
	ld a, $1
	ret

.GetOffBike:
	ld hl, wBikeFlags
	bit BIKEFLAGS_ALWAYS_ON_BIKE_F, [hl]
	jr nz, .CantGetOffBike
	ld hl, Script_GetOffBike
	ld de, Script_GetOffBike_Register
	call .CheckIfRegistered
	ld a, BANK(Script_GetOffBike)
	jr .done

.CantGetOffBike:
	ld hl, Script_CantGetOffBike
	jr .done

.CannotUseBike:
	ld a, $0
	ret

.done
	call QueueScript
	ld a, $1
	ret

.CheckIfRegistered:
	ld a, [wUsingItemWithSelect]
	and a
	ret z
	ld h, d
	ld l, e
	ret

.CheckEnvironment:
	call GetMapEnvironment
	call CheckOutdoorMap
	jr z, .ok
	cp CAVE
	jr z, .ok
	cp GATE
	jr z, .ok
	jr .nope

.ok
	call GetPlayerTilePermission
	and $f ; lo nybble only
	jr nz, .nope ; not FLOOR_TILE
	xor a
	ret

.nope
	scf
	ret

Script_GetOnBike:
	refreshmap
	special UpdateTimePals
	loadvar VAR_MOVEMENT, PLAYER_BIKE
	isfieldactionssettoquick
	iftrue .skip
	writetext GotOnBikeText
	waitbutton
.skip
	closetext
	special UpdatePlayerSprite
	end

Script_GetOnBike_Register:
	loadvar VAR_MOVEMENT, PLAYER_BIKE
	closetext
	special UpdatePlayerSprite
	end

Script_GetOffBike:
	refreshmap
	special UpdateTimePals
	loadvar VAR_MOVEMENT, PLAYER_NORMAL
	isfieldactionssettoquick
	iftrue .skip
	writetext GotOffBikeText
	waitbutton
.skip
	; fallthrough

FinishGettingOffBike:
	closetext
	special UpdatePlayerSprite
	special PlayMapMusic
	end

Script_GetOffBike_Register:
	loadvar VAR_MOVEMENT, PLAYER_NORMAL
	sjump FinishGettingOffBike

Script_CantGetOffBike:
	writetext .CantGetOffBikeText
	waitbutton
	closetext
	end

.CantGetOffBikeText:
	text_far _CantGetOffBikeText
	text_end

GotOnBikeText:
	text_far _GotOnBikeText
	text_end

GotOffBikeText:
	text_far _GotOffBikeText
	text_end

TryCutOW::
	ld a, SCYTHER_CALL
	ld [wCurItem], a
	ld hl, wNumItems
	call CheckItem
	jr nc, .cant_cut

	ld a, BANK(AskCutScript)
	ld hl, AskCutScript
	call CallScript
	scf
	ret

.cant_cut
	ld a, BANK(CantCutScript)
	ld hl, CantCutScript
	call CallScript
	scf
	ret

AskCutScript:
	opentext
	isfieldactionssettoquick
	iftrue .skip
	sjump .regularscript

.skip:
	writetext SycterUsedCut
	promptbutton
	sjump .next
.regularscript:
	writetext AskCutText
	yesorno
	iffalse .declined
.next:
	callasm .CheckMap
	iftrue Script_Cut
.declined
	closetext
	end

.CheckMap:
	xor a
	ld [wScriptVar], a
	call CheckMapForSomethingToCut
	ret c
	ld a, TRUE
	ld [wScriptVar], a
	ret

AskCutText:
	text_far _AskCutText
	text_end

SycterUsedCut:
	text_far _SycterUsedCutText
	text_end

CantCutScript:
	jumptext CanCutText

CanCutText:
	text_far _CanCutText
	text_end

NomadSigilFunction:
	call .NomadSigilFunction
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.NomadSigilFunction:
	ld a, [wNomadSigil]
	xor 1
	ld [wNomadSigil], a
	and a
	ld hl, NomadSigilOn
	jr nz, .done
	ld hl, NomadSigilOff

.done
	call PrintText
	ld hl, Script_ReloadMap
	call QueueScript
	ld a, TRUE
	ret

Script_ReloadMap:
	warp NONE, 0, 0
	end

NomadSigilOn:
	text_far _NomadSigilOn
	text_end

NomadSigilOff:
	text_far _NomadSigilOff
	text_end
