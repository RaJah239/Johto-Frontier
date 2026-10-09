; BattleTransitionJumptable.Jumptable indexes
DEF BATTLETRANSITION_CAVE             EQU $01
DEF BATTLETRANSITION_CAVE_STRONGER    EQU $09
DEF BATTLETRANSITION_NO_CAVE          EQU $10
DEF BATTLETRANSITION_NO_CAVE_STRONGER EQU $18
DEF BATTLETRANSITION_FINISH           EQU $20
DEF BATTLETRANSITION_END              EQU $80

DEF BATTLETRANSITION_SQUARE EQU "8" ; $fe
DEF BATTLETRANSITION_BLACK  EQU "9" ; $ff

DoBattleTransition:
	call .InitGFX
	ldh a, [rBGP]
	ld [wBGP], a
	ldh a, [rOBP0]
	ld [wOBP0], a
	ldh a, [rOBP1]
	ld [wOBP1], a
	call DelayFrame
	ld hl, hVBlank
	ld a, [hl]
	push af
	vc_hook Reduce_battle_transition_flashing
	ld [hl], $1

.loop
	ld a, [wJumptableIndex]
	bit 7, a ; BATTLETRANSITION_END?
	jr nz, .done
	call BattleTransitionJumptable
	call BattleTransitionDelayFrame
	jr .loop

.done
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a

	ld hl, wBGPals1
	ld bc, 8 palettes
	xor a
	call ByteFill

	pop af
	ldh [rSVBK], a

	ld a, %11111111
	ld [wBGP], a
	call DmgToCgbBGPals
	call DelayFrame
	ld a, RETI_INSTRUCTION
	ld [hFunctionInstruction], a
	xor a
	ldh [hLCDCPointer], a
	ldh [hLYOverrideStart], a
	ldh [hLYOverrideEnd], a
	ldh [hSCY], a

	ld a, $1 ; unnecessary bankswitch?
	ldh [rSVBK], a
	pop af
	vc_hook Stop_reducing_battle_transition_flashing
	ldh [hVBlank], a
	jmp DelayFrame

.InitGFX:
	ld a, [wLinkMode]
	cp LINK_MOBILE
	jr z, .mobile
	farcall ReanchorBGMap_NoOAMUpdate
	call UpdateSprites
	call DelayFrame
	call .NonMobile_LoadPokeballTiles
	call BattleStart_CopyTilemapAtOnce
	jr .resume

.mobile
	call LoadTrainerBattlePokeballTiles

.resume
	ld a, SCREEN_HEIGHT_PX
	ldh [hWY], a
	call DelayFrame
	xor a
	ldh [hBGMapMode], a
	ld hl, wJumptableIndex
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld a, BALL_POCKET
	ld [wLastPocket], a
	jmp WipeLYOverrides

.NonMobile_LoadPokeballTiles:
	call LoadTrainerBattlePokeballTiles
	hlbgcoord 0, 0
	jr ConvertTrainerBattlePokeballTilesTo2bpp

LoadTrainerBattlePokeballTiles:
; Load the tiles used in the Pokeball Graphic that fills the screen
; at the start of every Trainer battle.
	ld de, TrainerBattlePokeballTiles
	ld hl, vTiles0 tile BATTLETRANSITION_SQUARE
	ld b, BANK(TrainerBattlePokeballTiles)
	ld c, 2
	call Request2bpp

	ldh a, [rVBK]
	push af
	ld a, $1
	ldh [rVBK], a

	ld de, TrainerBattlePokeballTiles
	ld hl, vTiles3 tile BATTLETRANSITION_SQUARE
	ld b, BANK(TrainerBattlePokeballTiles)
	ld c, 2
	call Request2bpp

	pop af
	ldh [rVBK], a
	ret

ConvertTrainerBattlePokeballTilesTo2bpp:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDecompressScratch)
	ldh [rSVBK], a
	push hl
	ld hl, wDecompressScratch
	ld bc, $28 tiles

.loop
	ld [hl], -1
	inc hl
	dec bc
	ld a, c
	or b
	jr nz, .loop

	pop hl
	ld de, wDecompressScratch
	ld b, BANK(@)
	ld c, $28
	call Request2bpp
	pop af
	ldh [rSVBK], a
	ret

TrainerBattlePokeballTiles:
INCBIN "gfx/overworld/trainer_battle_pokeball_tiles.2bpp"

BattleTransitionDelayFrame:
; "Battle Speed: Double" runs one extra state-machine tick before the
; next real VBlank, so the screen transition finishes in about half the
; time. Only states that merely advance an animation counter get the
; extra tick; setup and hand-off states keep one tick per frame so their
; staged VRAM work is not dropped.
	call CheckIfDoubleBattleSpeed
	jr z, .delay
	call BattleTransition_ShouldRunExtraTick
	jr z, .delay
	call BattleTransitionJumptable
.delay
	jmp DelayFrame

BattleTransition_ShouldRunExtraTick:
; Return z unless [wJumptableIndex] names a state that is safe to run
; twice per frame: the three Flash steps and the wavy/speckle outros.
; Everything else ($01-$02 setup, $06/$0e/$15/$1d scene hand-offs, the
; other outros, and $20 finish) has to keep its normal cadence.
	ld a, [wJumptableIndex]
	bit 7, a ; BATTLETRANSITION_END?
	jr nz, .no

	cp BATTLETRANSITION_CAVE + 2
	jr c, .check_cave_sine
	cp BATTLETRANSITION_CAVE + 5
	jr c, .yes

.check_cave_sine
	cp BATTLETRANSITION_CAVE + 7
	jr z, .yes

	cp BATTLETRANSITION_CAVE_STRONGER + 2
	jr c, .check_no_cave
	cp BATTLETRANSITION_CAVE_STRONGER + 5
	jr c, .yes

.check_no_cave
	cp BATTLETRANSITION_NO_CAVE + 2
	jr c, .check_stronger_no_cave
	cp BATTLETRANSITION_NO_CAVE + 5
	jr c, .yes

.check_stronger_no_cave
	cp BATTLETRANSITION_NO_CAVE_STRONGER + 2
	jr c, .check_speckle
	cp BATTLETRANSITION_NO_CAVE_STRONGER + 5
	jr c, .yes

.check_speckle
	cp BATTLETRANSITION_NO_CAVE_STRONGER + 7
	jr z, .yes

.no
	xor a
	ret

.yes
	ld a, 1
	and a
	ret

BattleTransitionJumptable:
	jumptable .Jumptable, wJumptableIndex

.Jumptable:
	dw StartTrainerBattle_DetermineWhichAnimation ; 00

	; BATTLETRANSITION_CAVE
	dw StartTrainerBattle_LoadPokeBallGraphics ; 01
	dw StartTrainerBattle_SetUpBGMap ; 02
	dw StartTrainerBattle_Flash ; 03
	dw StartTrainerBattle_Flash ; 04
	dw StartTrainerBattle_Flash ; 05
	dw StartTrainerBattle_NextScene ; 06
	dw StartTrainerBattle_SetUpForWavyOutro ; 07
	dw StartTrainerBattle_SineWave ; 08

	; BATTLETRANSITION_CAVE_STRONGER
	dw StartTrainerBattle_LoadPokeBallGraphics ; 09
	dw StartTrainerBattle_SetUpBGMap ; 0a
	dw StartTrainerBattle_Flash ; 0b
	dw StartTrainerBattle_Flash ; 0c
	dw StartTrainerBattle_Flash ; 0d
	dw StartTrainerBattle_NextScene ; 0e
	; There is no setup for this one
	dw StartTrainerBattle_ZoomToBlack ; 0f

	; BATTLETRANSITION_NO_CAVE
	dw StartTrainerBattle_LoadPokeBallGraphics ; 10
	dw StartTrainerBattle_SetUpBGMap ; 11
	dw StartTrainerBattle_Flash ; 12
	dw StartTrainerBattle_Flash ; 13
	dw StartTrainerBattle_Flash ; 14
	dw StartTrainerBattle_NextScene ; 15
	dw StartTrainerBattle_SetUpForSpinOutro ; 16
	dw StartTrainerBattle_SpinToBlack ; 17

	; BATTLETRANSITION_NO_CAVE_STRONGER
	dw StartTrainerBattle_LoadPokeBallGraphics ; 18
	dw StartTrainerBattle_SetUpBGMap ; 19
	dw StartTrainerBattle_Flash ; 1a
	dw StartTrainerBattle_Flash ; 1b
	dw StartTrainerBattle_Flash ; 1c
	dw StartTrainerBattle_NextScene ; 1d
	dw StartTrainerBattle_SetUpForRandomScatterOutro ; 1e
	dw StartTrainerBattle_SpeckleToBlack ; 1f

	; BATTLETRANSITION_FINISH
	dw StartTrainerBattle_Finish ; 20

; transition animations
	const_def
	const TRANS_CAVE
	const TRANS_CAVE_STRONGER
	const TRANS_NO_CAVE
	const TRANS_NO_CAVE_STRONGER

; transition animation bits
DEF TRANS_STRONGER_F EQU 0 ; bit set in TRANS_CAVE_STRONGER and TRANS_NO_CAVE_STRONGER
DEF TRANS_NO_CAVE_F  EQU 1 ; bit set in TRANS_NO_CAVE and TRANS_NO_CAVE_STRONGER

StartTrainerBattle_DetermineWhichAnimation:
; The screen flashes a different number of times depending on the level of
; your lead Pokemon relative to the opponent's.
	ld a, [wOtherTrainerClass]
 	and a
 	jr z, .wild
 	farcall SetTrainerBattleLevel
 
 .wild
 	ld b, PARTY_LENGTH
 	ld hl, wPartyMon1HP
 	ld de, PARTYMON_STRUCT_LENGTH - 1
 
 .loop
 	ld a, [hli]
 	or [hl]
 	jr nz, .okay
 	add hl, de
 	dec b
 	jr nz, .loop
 
 .okay
 	ld de, MON_LEVEL - MON_HP - 1
 	add hl, de
	ld de, 0
	ld a, [hl]
	add 3
	ld hl, wCurPartyLevel
	cp [hl]
	jr nc, .not_stronger
	set TRANS_STRONGER_F, e
.not_stronger
	ld a, [wEnvironment]
	cp CAVE
	jr z, .cave
	cp ENVIRONMENT_5
	jr z, .cave
	cp DUNGEON
	jr z, .cave
	set TRANS_NO_CAVE_F, e
.cave
	ld hl, .StartingPoints
	add hl, de
	ld a, [hl]
	ld [wJumptableIndex], a
	ret

.StartingPoints:
; entries correspond to TRANS_* constants
	db BATTLETRANSITION_CAVE
	db BATTLETRANSITION_CAVE_STRONGER
	db BATTLETRANSITION_NO_CAVE
	db BATTLETRANSITION_NO_CAVE_STRONGER

StartTrainerBattle_Finish:
	call ClearSprites
	ld a, BATTLETRANSITION_END
	ld [wJumptableIndex], a
	ret

StartTrainerBattle_NextScene:
	ld hl, wJumptableIndex
	inc [hl]
	ret

StartTrainerBattle_SetUpBGMap:
	call StartTrainerBattle_NextScene
	xor a
	ld [wBattleTransitionCounter], a
	ldh [hBGMapMode], a
	ret

StartTrainerBattle_Flash:
	call .DoFlashAnimation
	ret nc
	jr StartTrainerBattle_NextScene

.DoFlashAnimation:
	ld a, [wTimeOfDayPalset]
	cp DARKNESS_PALSET
	jr z, .done
	ld hl, wBattleTransitionCounter
	ld a, [hl]
	inc [hl]
	srl a
	ld e, a
	ld d, 0
	ld hl, .pals
	add hl, de
	ld a, [hl]
	cp %00000001
	jr z, .done
	ld [wBGP], a
	call DmgToCgbBGPals
	and a
	ret

.done
	xor a
	ld [wBattleTransitionCounter], a
	scf
	ret

.pals:
	dc 3, 3, 2, 1
	dc 3, 3, 3, 2
	dc 3, 3, 3, 3
	dc 3, 3, 3, 2
	dc 3, 3, 2, 1
	dc 3, 2, 1, 0
	dc 2, 1, 0, 0
	dc 1, 0, 0, 0
	dc 0, 0, 0, 0
	dc 1, 0, 0, 0
	dc 2, 1, 0, 0
	dc 3, 2, 1, 0
	dc 0, 0, 0, 1

StartTrainerBattle_SetUpForWavyOutro:
	vc_hook Stop_reducing_battle_transition_flashing_WavyOutro
	farcall RespawnPlayerAndOpponent
	ld a, BANK(wLYOverrides)
	ldh [rSVBK], a
	call StartTrainerBattle_NextScene

	ld a, JP_INSTRUCTION
	ld [hFunctionInstruction], a
	ld a, LOW(rSCX)
	ldh [hLCDCPointer], a
	xor a
	ldh [hLYOverrideStart], a
	ld a, $90
	ldh [hLYOverrideEnd], a
	xor a
	ld [wBattleTransitionCounter], a
	ld [wBattleTransitionSineWaveOffset], a
	ret

StartTrainerBattle_SineWave:
	ld a, [wBattleTransitionCounter]
	cp $60
	jr nc, .end
	jr .DoSineWave

.end
	ld a, BATTLETRANSITION_FINISH
	ld [wJumptableIndex], a
	ret

.DoSineWave:
	ld hl, wBattleTransitionSineWaveOffset
	ld a, [hl]
	inc [hl]
	ld hl, wBattleTransitionCounter
	ld d, [hl]
	add [hl]
	ld [hl], a
	ld a, wLYOverridesEnd - wLYOverrides
	ld bc, wLYOverrides
	ld e, 0

.loop
	push af
	push de
	ld a, e
	call StartTrainerBattle_DrawSineWave
	ld [bc], a
	inc bc
	pop de
	ld a, e
	add 2
	ld e, a
	pop af
	dec a
	jr nz, .loop
	ret

StartTrainerBattle_SetUpForSpinOutro:
	vc_hook Stop_reducing_battle_transition_flashing_SpinOutro
	farcall RespawnPlayerAndOpponent
	ld a, BANK(wLYOverrides)
	ldh [rSVBK], a
	call StartTrainerBattle_NextScene
	xor a
	ld [wBattleTransitionCounter], a
	ret

StartTrainerBattle_SpinToBlack:
	xor a
	ldh [hBGMapMode], a
	ld a, [wBattleTransitionCounter]
	ld e, a
	ld d, 0
	ld hl, .spin_quadrants
rept 5
	add hl, de
endr
	ld a, [hli]
	cp -1
	jr z, .end
	ld [wBattleTransitionSineWaveOffset], a
	call .load
	ld a, 1
	ldh [hBGMapMode], a
	call DelayFrame
	call DelayFrame
	ld hl, wBattleTransitionCounter
	inc [hl]
	ret

.end
	ld a, 1
	ldh [hBGMapMode], a
	call DelayFrame
	call DelayFrame
	call DelayFrame
	xor a
	ldh [hBGMapMode], a
	ld a, BATTLETRANSITION_FINISH
	ld [wJumptableIndex], a
	ret

; quadrants
	const_def
	const UPPER_LEFT
	const UPPER_RIGHT
	const LOWER_LEFT
	const LOWER_RIGHT

; quadrant bits
DEF RIGHT_QUADRANT_F EQU 0 ; bit set in UPPER_RIGHT and LOWER_RIGHT
DEF LOWER_QUADRANT_F EQU 1 ; bit set in LOWER_LEFT and LOWER_RIGHT

.spin_quadrants:
MACRO spin_quadrant
	db \1
	dw \2
	dwcoord \3, \4
ENDM
	spin_quadrant UPPER_LEFT,  .wedge1,  1,  6
	spin_quadrant UPPER_LEFT,  .wedge2,  0,  3
	spin_quadrant UPPER_LEFT,  .wedge3,  1,  0
	spin_quadrant UPPER_LEFT,  .wedge4,  5,  0
	spin_quadrant UPPER_LEFT,  .wedge5,  9,  0
	spin_quadrant UPPER_RIGHT, .wedge5, 10,  0
	spin_quadrant UPPER_RIGHT, .wedge4, 14,  0
	spin_quadrant UPPER_RIGHT, .wedge3, 18,  0
	spin_quadrant UPPER_RIGHT, .wedge2, 19,  3
	spin_quadrant UPPER_RIGHT, .wedge1, 18,  6
	spin_quadrant LOWER_RIGHT, .wedge1, 18, 11
	spin_quadrant LOWER_RIGHT, .wedge2, 19, 14
	spin_quadrant LOWER_RIGHT, .wedge3, 18, 17
	spin_quadrant LOWER_RIGHT, .wedge4, 14, 17
	spin_quadrant LOWER_RIGHT, .wedge5, 10, 17
	spin_quadrant LOWER_LEFT,  .wedge5,  9, 17
	spin_quadrant LOWER_LEFT,  .wedge4,  5, 17
	spin_quadrant LOWER_LEFT,  .wedge3,  1, 17
	spin_quadrant LOWER_LEFT,  .wedge2,  0, 14
	spin_quadrant LOWER_LEFT,  .wedge1,  1, 11
	db -1

.load:
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
.loop
	push hl
	ld a, [de]
	ld c, a
	inc de
.loop1
	ld [hl], BATTLETRANSITION_BLACK
	ld a, [wBattleTransitionSineWaveOffset]
	bit RIGHT_QUADRANT_F, a
	jr z, .leftside
	inc hl
	jr .okay1
.leftside
	dec hl
.okay1
	dec c
	jr nz, .loop1
	pop hl
	ld a, [wBattleTransitionSineWaveOffset]
	bit LOWER_QUADRANT_F, a
	ld bc, SCREEN_WIDTH
	jr z, .upper
	ld bc, -SCREEN_WIDTH
.upper
	add hl, bc
	ld a, [de]
	inc de
	cp -1
	ret z
	and a
	jr z, .loop
	ld c, a
.loop2
	ld a, [wBattleTransitionSineWaveOffset]
	bit RIGHT_QUADRANT_F, a
	jr z, .leftside2
	dec hl
	jr .okay2
.leftside2
	inc hl
.okay2
	dec c
	jr nz, .loop2
	jr .loop

.wedge1: db 2, 3, 5, 4, 9, -1
.wedge2: db 1, 1, 2, 2, 4, 2, 4, 2, 3, -1
.wedge3: db 2, 1, 3, 1, 4, 1, 4, 1, 4, 1, 3, 1, 2, 1, 1, 1, 1, -1
.wedge4: db 4, 1, 4, 0, 3, 1, 3, 0, 2, 1, 2, 0, 1, -1
.wedge5: db 4, 0, 3, 0, 3, 0, 2, 0, 2, 0, 1, 0, 1, 0, 1, -1

StartTrainerBattle_SetUpForRandomScatterOutro:
	vc_hook Stop_reducing_battle_transition_flashing_ScatterOutro
	farcall RespawnPlayerAndOpponent
	ld a, BANK(wLYOverrides)
	ldh [rSVBK], a
	call StartTrainerBattle_NextScene
	ld a, $10
	ld [wBattleTransitionCounter], a
	ld a, 1
	ldh [hBGMapMode], a
	ret

StartTrainerBattle_SpeckleToBlack:
	ld hl, wBattleTransitionCounter
	ld a, [hl]
	and a
	jr z, .done
	dec [hl]
	ld c, $c
.loop
	push bc
	call .BlackOutRandomTile
	pop bc
	dec c
	jr nz, .loop
	ret

.done
	ld a, $1
	ldh [hBGMapMode], a
	call DelayFrame
	call DelayFrame
	call DelayFrame
	xor a
	ldh [hBGMapMode], a
	ld a, BATTLETRANSITION_FINISH
	ld [wJumptableIndex], a
	ret

.BlackOutRandomTile:
.y_loop
	call Random
	cp SCREEN_HEIGHT
	jr nc, .y_loop
	ld b, a

.x_loop
	call Random
	cp SCREEN_WIDTH
	jr nc, .x_loop
	ld c, a

	hlcoord 0, -1
	ld de, SCREEN_WIDTH
	inc b

.row_loop
	add hl, de
	dec b
	jr nz, .row_loop
	add hl, bc

; If the tile has already been blacked out,
; sample a new tile
	ld a, [hl]
	cp BATTLETRANSITION_BLACK
	jr z, .y_loop
	ld [hl], BATTLETRANSITION_BLACK
	ret

StartTrainerBattle_LoadPokeBallGraphics:
	ld a, [wOtherTrainerClass]
	and a
	jmp z, .nextscene ; don't need to be here if wild

	xor a
	ldh [hBGMapMode], a

	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	inc b
	inc c
	jr .enter_loop_midway

.pal_loop
; set all pals to 7
	ld a, [hl]
	or PAL_BG_TEXT
	ld [hli], a
.enter_loop_midway
	dec c
	jr nz, .pal_loop
	dec b
	jr nz, .pal_loop

	call .loadpokeballgfx
	hlcoord 2, 1

	ld b, SCREEN_WIDTH - 4
.tile_loop
	push hl
	ld c, 2
.row_loop
	push hl
	ld a, [de]
	inc de
.col_loop
; Loading is done bit by bit
	and a
	jr z, .done
	add a
	jr nc, .no_load
	ld [hl], BATTLETRANSITION_SQUARE
.no_load
	inc hl
	jr .col_loop

.done
	pop hl
	push bc
	ld bc, (SCREEN_WIDTH - 4) / 2
	add hl, bc
	pop bc
	dec c
	jr nz, .row_loop

	pop hl
	push bc
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .tile_loop

	ldh a, [hCGB]
	and a
	jr nz, .cgb
	ld a, 1
	ldh [hBGMapMode], a
	call DelayFrame
	call DelayFrame
	jr .nextscene

.cgb
	ld hl, .rocketpals
	ld a, [wOtherTrainerClass]
	cp GRUNTM
	jr z, .load_rocket_pals
	cp GRUNTF
	jr z, .load_rocket_pals
	cp EXECUTIVEM
	jr z, .load_rocket_pals
	cp EXECUTIVEF
	jr z, .load_rocket_pals
	cp PROTON
	jr z, .load_rocket_pals
	cp PETREL
	jr z, .load_rocket_pals
	cp ARIANA
	jr z, .load_rocket_pals
	cp ARCHER
	jr z, .load_rocket_pals
	cp GIOVANNI
	jr z, .load_rocket_pals
	ld hl, .pals
.load_rocket_pals
	ld a, [wTimeOfDayPalset]
	cp DARKNESS_PALSET
	jr nz, .not_dark
	ld hl, .darkpals
.not_dark
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	call .copypals
	push hl
	ld de, wBGPals1 palette PAL_BG_TEXT
	ld bc, 1 palettes
	call CopyBytes
	pop hl
	ld de, wBGPals2 palette PAL_BG_TEXT
	ld bc, 1 palettes
	call CopyBytes
	pop af
	ldh [rSVBK], a
	farcall ClearSavedObjPals
	farcall CheckForUsedObjPals
	farcall _UpdateSprites
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	call DelayFrame
	call BattleStart_CopyTilemapAtOnce

.nextscene
	call StartTrainerBattle_NextScene
	ret

; todo: verify the following (dyn pal)
.copypals
	ld de, wBGPals1 palette PAL_BG_TEXT
	call .copy
	ld de, wBGPals2 palette PAL_BG_TEXT
	call .copy
	ld de, wOBPals1 palette PAL_OW_TREE
	call .copy
	ld de, wOBPals2 palette PAL_OW_TREE
	call .copy
	ld de, wOBPals1 palette PAL_OW_ROCK
	call .copy
	ld de, wOBPals2 palette PAL_OW_ROCK

.copy
	push hl
	ld bc, 1 palettes
	call CopyBytes
	pop hl
	ret

.pals:
INCLUDE "gfx/overworld/trainer_battle.pal"

.darkpals:
INCLUDE "gfx/overworld/trainer_battle_dark.pal"

.rocketpals:
INCLUDE "gfx/overworld/rocket_battle.pal"

.loadpokeballgfx:
	ld de, TeamRocketTransition
	ld a, [wOtherTrainerClass]
	cp GRUNTM
	ret z
	cp GRUNTF
	ret z
	cp EXECUTIVEM
	ret z
	cp EXECUTIVEF
	ret z
	cp PROTON
	ret z
	cp PETREL
	ret z
	cp ARIANA
	ret z
	cp ARCHER
	ret z
	cp GIOVANNI
	ret z

	; gym leaders
	ld de, BugsyTransition
    cp BUGSY 
    ret z
    ld de, WhitneyTransition
    cp WHITNEY
    ret z  
    ld de, FalknerTransition
    cp FALKNER 
    ret z 
    ld de, MortyTransition
    cp MORTY 
    ret z 
    ld de, ChuckTransition
    cp CHUCK 
    ret z 
    ld de, JasmineTransition
    cp JASMINE 
    ret z  
    ld de, PryceTransition
    cp PRYCE 
    ret z 
    ld de, ClairTransition
    cp CLAIR 
    ret z
    ld de, BrockTransition 
    cp BROCK 
    ret z
    ld de, BlaineTransition
    cp BLAINE 
    ret z
    ld de, BlueTransition
    cp BLUE 
    ret z
	ld de, LtSurgeTransition
	cp LT_SURGE
	ret z
    ld de, MistyTransition
    cp MISTY 
    ret z
    ld de, ErikaTransition
    cp ERIKA 
    ret z
    ld de, SabrinaTransition
    cp SABRINA 
    ret z 
    ld de, JanineTransition
    cp JANINE 
    ret z   	

	; elite 4
	ld de, Elite4Transition
    cp KOGA
	ret z
    cp BRUNO
	ret z
    cp KAREN
	ret z
    cp WILL
	ret z

   ; champions
    ld de, ChampionTransition
    cp CHAMPION
	ret z
	cp RED
	ret z
	cp POKEMON_PROF
	ret z
	cp INSAF
	ret z
	cp GREEN
	ret z
	ld de, PokeBallTransition
	ret

PokeBallTransition:
; 16x16 overlay of a Poke Ball
pusho
opt b.X ; . = 0, X = 1
	bigdw %......XXXX......
	bigdw %....XXXXXXXX....
	bigdw %..XXXX....XXXX..
	bigdw %..XX........XX..
	bigdw %.XX..........XX.
	bigdw %.XX...XXXX...XX.
	bigdw %XX...XX..XX...XX
	bigdw %XXXXXX....XXXXXX
	bigdw %XXXXXX....XXXXXX
	bigdw %XX...XX..XX...XX
	bigdw %.XX...XXXX...XX.
	bigdw %.XX..........XX.
	bigdw %..XX........XX..
	bigdw %..XXXX....XXXX..
	bigdw %....XXXXXXXX....
	bigdw %......XXXX......
popo

FalknerTransition:
pusho
opt b.X ; . = 0, X = 0
	bigdw %....XXXXXXXX....
	bigdw %..XX........XX..
	bigdw %XX..XXX..XXX..XX
	bigdw %X.XXX.X..X.XXX.X
	bigdw %X.X.X.X..X.X.X.X
	bigdw %X.X.X.XXXX.X.X.X
	bigdw %X.X.X.X..X.X.X.X
	bigdw %X.X.X.X..X.X.X.X
	bigdw %X.X.X.X..X.X.X.X
	bigdw %X.X.X.X..X.X.X.X
	bigdw %X.X.X.X..X.X.X.X
	bigdw %X.X.XXX..XXX.X.X
	bigdw %X.X.X......X.X.X
	bigdw %X.XXX......XXX.X
	bigdw %X.X..........X.X
	bigdw %XXX..........XXX
popo

BugsyTransition:
pusho
opt b.X ; . = 0, X = 0
	bigdw %......XXXX......
	bigdw %....XXXXXXXX....
	bigdw %..XXXXXXXXXXXX..
	bigdw %..X..........X..
	bigdw %.X.....XX.....X.
	bigdw %.X....XXXX....X.
	bigdw %X.....XXXX.....X
	bigdw %X......XX......X
	bigdw %X...XX....XX...X
	bigdw %X..XXXX..XXXX..X
	bigdw %.X.XXXX..XXXX.X.
	bigdw %.X..XX....XX..X.
	bigdw %..X..........X..
	bigdw %..XX........XX..
	bigdw %....XX....XX....
	bigdw %......XXXX......
popo

WhitneyTransition:
pusho
opt b.X ; . = 0, X = 0
	bigdw %.......XX.......
	bigdw %......X.XX......
	bigdw %.....X...XX.....
	bigdw %....X.....XX....
	bigdw %...X.......XX...
	bigdw %..X.........XX..
	bigdw %.X...........XX.
	bigdw %X.............XX
	bigdw %X.............XX
	bigdw %.X...........XX.
	bigdw %..X.........XX..
	bigdw %...X.......XX...
	bigdw %....X.....XX....
	bigdw %.....X...XX.....
	bigdw %......XXXX......
	bigdw %.......XX.......
popo

MortyTransition:
pusho
opt b.X ; . = 0, X = 0
	bigdw %.....XXXXXX.....
	bigdw %...XX......XX...
	bigdw %..X..........X..
	bigdw %.X....X..X....X.
	bigdw %.X...XX..XX...X.
	bigdw %X...XXX..XXX..XX
	bigdw %X.............XX
	bigdw %X.............XX
	bigdw %.X...........XX.
	bigdw %.X...........XX.
	bigdw %..X.........XX..
	bigdw %...X.....XXXX...
	bigdw %....X....XXX....
	bigdw %.....XX...X.....
	bigdw %.......XX..X....
	bigdw %.........XXXX...
popo

ChuckTransition:
pusho
opt b.X ; . = 0, X = 0
	bigdw %....XXXXXXXX....
	bigdw %.XXXX..X...XXXX.
	bigdw %.X..X..X...X..X.
	bigdw %.X..X..X...X..X.
	bigdw %XX..X..X...X..XX
	bigdw %X...X..X...X...X
	bigdw %X...X..X...X...X
	bigdw %X...X..X...X...X
	bigdw %XXXXXXXXXX.X...X
	bigdw %X........X.X...X
	bigdw %X........XXXXXXX
	bigdw %XXXXXXXXXX....XX
	bigdw %.X............X.
	bigdw %.X............X.
	bigdw %.XXXX.......XXX.
	bigdw %....XXXXXXXX....
popo

JasmineTransition:
pusho
opt b.X ; . = 0, X = 0
	bigdw %.....XXXXXX.....
	bigdw %....XXXXXXXX....
	bigdw %...XX..X.XXXX...
	bigdw %..XX..X.XXX..X..
	bigdw %.XX..X.XXX....X.
	bigdw %XX..X.XXX....X.X
	bigdw %XX.X.XXX....X..X
	bigdw %XX.XXX.....X.X.X
	bigdw %X.XXX.....X.XX.X
	bigdw %XXXX.....X.XX..X
	bigdw %XXX.....X.XX...X
	bigdw %.XX....X.XX...X.
	bigdw %..X...X.XX...X..
	bigdw %...X.X.XX...X...
	bigdw %....X......X....
	bigdw %.....XXXXXX.....
popo

PryceTransition:
pusho
opt b.X ; . = 0, X = 0
	bigdw %.......XX.......
	bigdw %.....XX..XX.....
	bigdw %...XX...X..XX...
	bigdw %.XX..XX.X....XX.
	bigdw %X...X...XXX.X..X
	bigdw %X.X...X.X.XXX..X
	bigdw %X.XXX...XXX....X
	bigdw %X.X.XXX.X...X..X
	bigdw %X.X.X...XXX.X..X
	bigdw %X.X...X.X.XXX..X
	bigdw %X.X..XX.X..XX..X
	bigdw %X..XX...XXX....X
	bigdw %.XX..XX.X....XX.
	bigdw %...XX...X..XX...
	bigdw %.....XX..XX.....
	bigdw %.......XX.......
popo

ClairTransition:
pusho
opt b.X ; . = 0, X = 0
	bigdw %..XXXXXXXXXXXX..
	bigdw %..X..X....X..X..
	bigdw %.XX..X....X..XX.
	bigdw %X..XX......XX..X
	bigdw %X..............X
	bigdw %X...X......X...X
	bigdw %X...XX....XX...X
	bigdw %X....XX..XX....X
	bigdw %X..............X
	bigdw %.XXX........XXX.
	bigdw %..XXXX....XXXX..
	bigdw %...XX.X..X.XX...
	bigdw %....X.X..X.X....
	bigdw %....XX....XX....
	bigdw %.....X....X.....
	bigdw %......XXXX......
popo

BrockTransition:
pusho 
opt b.X ; . = 0, X = 0
    bigdw %................
	bigdw %................
	bigdw %......XXXX......
	bigdw %.....X....X.....
	bigdw %....X......X....
	bigdw %...X........X...
	bigdw %..X...XXXX...X..
	bigdw %.X...X....X...X.
	bigdw %.X...X....X...X.
	bigdw %.X...X....X...X.
	bigdw %.X...X....X...X.
	bigdw %..X...XXXX...X..
	bigdw %...X........X...
	bigdw %....X......X....
	bigdw %.....X....X.....
	bigdw %......XXXX......
popo

BlaineTransition:
pusho 
opt b.X ; . = 0, X = 0
    bigdw %................
    bigdw %.......X........
	bigdw %......X.X.......
	bigdw %..X...X.X...X...
	bigdw %.X.X.X...X.X.X..
	bigdw %.X..XX...XX..X..
	bigdw %.X...........X..
	bigdw %.X.....X.....X..
	bigdw %..X....X....X...
	bigdw %..X...X.X...X...
	bigdw %.X...X...X...X..
	bigdw %.X...X...X...X..
	bigdw %..X...XXX...X...
	bigdw %...X.......X....
	bigdw %....XX...XX.....
	bigdw %......XXX.......
popo

BlueTransition:
pusho 
opt b.X ; . = 0, X = 0
    bigdw %................
	bigdw %................
	bigdw %....XXXXX.......
	bigdw %...X..X..X......
	bigdw %..X.XXXXXX......
	bigdw %..X.XXXXXXX.....
	bigdw %..XXXXXXXX.X....
	bigdw %..X.XXXXXXXX....
	bigdw %..X.XXXXX..XX...
	bigdw %...XXXXX.X.X.X..
	bigdw %.....X.X..X..X..
	bigdw %......XXXX.X.X..
	bigdw %........X...XX..
	bigdw %.........XXXX.X.
	bigdw %.............X.X
	bigdw %..............XX
popo

LtSurgeTransition:
pusho 
opt b.X ; . = 0, X = 0
    bigdw %........X.......
	bigdw %.......X.X......
	bigdw %......X...X.....
	bigdw %...XXXX...XXX...
	bigdw %...X..XXXX..X...
	bigdw %..XX.X....X.X...
	bigdw %.X..X......XXX..
	bigdw %X...X......X..X.
	bigdw %.X..X......X...X
	bigdw %..XXX......X..X.
	bigdw %...X.X....X.XX..
	bigdw %...X..XXXX..X...
	bigdw %...XXX...XXXX...
	bigdw %.....X...X......
	bigdw %......X.X.......
	bigdw %.......X........
popo

MistyTransition:
pusho
opt b.X ; . = 0, X = 0
    bigdw %................
	bigdw %................
	bigdw %.......X........
	bigdw %......X.X.......
	bigdw %......X.X.......
	bigdw %.....X...X......
	bigdw %.....X...X......
	bigdw %....X.....X.....
	bigdw %...X.......X....
	bigdw %...X...X...X....
	bigdw %..X...X.X...X...
	bigdw %..X..X...X..X...
	bigdw %..X...X.X...X...
	bigdw %...X...X...X....
	bigdw %....XX...XX.....
	bigdw %......XXX.......
popo

ErikaTransition:
pusho
opt b.X ; . = 0, X = 0
    bigdw %.......XX.......
	bigdw %......X..X......
	bigdw %...XXX....XXX...
	bigdw %..X...X..X...X..
	bigdw %..X....XX....X..
	bigdw %..X....XX....X..
	bigdw %.X.X..X..X..X.X.
	bigdw %X...XX.XX.XX...X
	bigdw %X...XX.XX.XX...X
	bigdw %.X.X..X..X..X.X.
	bigdw %..X....XX....X..
	bigdw %..X....XX....X..
	bigdw %..X...X..X...X..
	bigdw %...XXX....XXX...
	bigdw %......X..X......
	bigdw %.......XX.......
popo

SabrinaTransition:
pusho
opt b.X ; . = 0, X = 0
    bigdw %................
	bigdw %................
	bigdw %................
	bigdw %......XXX.......
	bigdw %....XX...XX.....
	bigdw %...X.......X....
	bigdw %..X...XXX...X...
	bigdw %..X..X...X..X...
	bigdw %.X..X.....X..X..
	bigdw %.X..X.....X..X..
	bigdw %.X..X.....X..X..
	bigdw %..X..X...X..X...
	bigdw %..X...XXX...X...
	bigdw %...X.......X....
	bigdw %....XX...XX.....
	bigdw %......XXX.......
popo

JanineTransition:
pusho
opt b.X ; . = 0, X = 0
    bigdw %................
	bigdw %................
	bigdw %....XX....XX....
	bigdw %...X..X..X..X...
	bigdw %..X....XX....X..
	bigdw %..X.....X....X..
	bigdw %.X......X.....X.
	bigdw %.X......X.....X.
	bigdw %.X......X.....X.
	bigdw %..X.....X....X..
	bigdw %..X.....X....X..
	bigdw %...X....X...X...
	bigdw %....X...X..X....
	bigdw %.....X..X.X.....
	bigdw %......X.XX......
	bigdw %.......XX.......
popo

TeamRocketTransition:
pusho
opt b.X ; . = 0, X = 1
	bigdw %XXXXXXXXXXXX....
	bigdw %XXXXXXXXXXXXXX..
	bigdw %XXXXXXXXXXXXXXX.
	bigdw %XXXXXXXXXXXXXXX.
	bigdw %XXXXX.....XXXXXX
	bigdw %XXXXX......XXXXX
	bigdw %XXXXX.....XXXXXX
	bigdw %XXXXXXXXXXXXXXX.
	bigdw %XXXXXXXXXXXXXXX.
	bigdw %XXXXXXXXXXXXXX..
	bigdw %XXXXXXXXXXXXX...
	bigdw %XXXXX....XXXXX..
	bigdw %XXXXX....XXXXX..
	bigdw %XXXXX.....XXXXX.
	bigdw %XXXXX......XXXXX
	bigdw %XXXXX......XXXXX
popo

Elite4Transition:
pusho
opt b.X ; . = 0, X = 1
	bigdw %................
	bigdw %........XXX.....
	bigdw %......XXX.......
	bigdw %......XXX.......
	bigdw %....XXX.........
	bigdw %....XXX.........
	bigdw %..XXX...........
	bigdw %..XXX...........
	bigdw %XXX...XXXX......
	bigdw %XXX...XXXX......
	bigdw %XXXXXXXXXXXXXXXX
	bigdw %XXXXXXXXXXXXXXXX
	bigdw %......XXXX......
	bigdw %......XXXX......
	bigdw %......XXXX......
	bigdw %................
popo

ChampionTransition:
pusho
opt b.X ; . = 0, X = 1
	bigdw %................
	bigdw %................
	bigdw %X......XX......X
	bigdw %XX....XXXX....XX
	bigdw %XX....XXXX....XX
	bigdw %XXX..XX..XX..XXX
	bigdw %XXX..XX..XX..XXX
	bigdw %X.XXXX....XXXX.X
	bigdw %XX............XX
	bigdw %XX............XX
	bigdw %XX............XX
	bigdw %XX............XX
	bigdw %XXXXXXXXXXXXXXXX
	bigdw %XXXXXXXXXXXXXXXX
	bigdw %................
	bigdw %................
popo

WipeLYOverrides:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wLYOverrides)
	ldh [rSVBK], a

	ld hl, wLYOverrides
	call .wipe
	ld hl, wLYOverridesBackup
	call .wipe

	pop af
	ldh [rSVBK], a
	ret

.wipe
	xor a
	ld c, SCREEN_HEIGHT_PX
.loop
	ld [hli], a
	dec c
	jr nz, .loop
	ret

StartTrainerBattle_DrawSineWave:
	calc_sine_wave

StartTrainerBattle_ZoomToBlack:
	vc_hook Stop_reducing_battle_transition_flashing_ZoomToBlack
	farcall RespawnPlayerAndOpponent
	ld de, .boxes

.loop
	ld a, [de]
	cp -1
	jr z, .done
	inc de
	ld c, a
	ld a, [de]
	inc de
	ld b, a
	ld a, [de]
	inc de
	ld l, a
	ld a, [de]
	inc de
	ld h, a
	xor a
	ldh [hBGMapMode], a
	call .Copy
	call WaitBGMap
	jr .loop

.done
	ld a, BATTLETRANSITION_FINISH
	ld [wJumptableIndex], a
	ret

.boxes
MACRO zoombox
; width, height, start y, start x
	db \1, \2
	dwcoord \3, \4
ENDM
	zoombox  4,  2,  8, 8
	zoombox  6,  4,  7, 7
	zoombox  8,  6,  6, 6
	zoombox 10,  8,  5, 5
	zoombox 12, 10,  4, 4
	zoombox 14, 12,  3, 3
	zoombox 16, 14,  2, 2
	zoombox 18, 16,  1, 1
	zoombox 20, 18,  0, 0
	db -1

.Copy:
	ld a, BATTLETRANSITION_BLACK
.row
	push bc
	push hl
.col
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret
