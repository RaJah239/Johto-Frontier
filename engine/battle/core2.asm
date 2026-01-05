InitBackPic:
	farcall GetTrainerBackpic
	;call CopyBackpic
	; fallthrough

CopyBackpic:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDecompressScratch)
	ldh [rSVBK], a
	ld hl, vTiles0
	ld de, vTiles2 tile $31
	ldh a, [hROMBank]
	ld b, a
	ld c, 7 * 7
	call Get2bpp
	pop af
	ldh [rSVBK], a
	call .LoadTrainerBackpicAsOAM
	ld a, $31
	ldh [hGraphicStartTile], a
	hlcoord 2, 6
	lb bc, 6, 6
	predef_jump PlaceGraphic

.LoadTrainerBackpicAsOAM:
	ld hl, wShadowOAMSprite00
	xor a
	ldh [hMapObjectIndex], a
	ld b, 6
	ld e, (SCREEN_WIDTH + 1) * TILE_WIDTH
.outer_loop
	ld c, 3
	ld d, 8 * TILE_WIDTH
.inner_loop
	ld [hl], d ; y
	inc hl
	ld [hl], e ; x
	inc hl
	ldh a, [hMapObjectIndex]
	ld [hli], a ; tile id
	inc a
	ldh [hMapObjectIndex], a
	ld a, PAL_BATTLE_OB_PLAYER
	ld [hli], a ; attributes
	ld a, d
	add 1 * TILE_WIDTH
	ld d, a
	dec c
	jr nz, .inner_loop
	ldh a, [hMapObjectIndex]
	add $3
	ldh [hMapObjectIndex], a
	ld a, e
	add 1 * TILE_WIDTH
	ld e, a
	dec b
	jr nz, .outer_loop
	ret

ExitBattle:
	farcall UpdatePartyStats
	call .HandleEndOfBattle
	farcall CleanUpBattleRAM
	ret

.HandleEndOfBattle:
	ld a, [wLinkMode]
	and a
	jr z, .not_linked
	farcall ShowLinkBattleParticipantsAfterEnd
	ld c, 150
	call DelayFrames
	farcall DisplayLinkBattleResult
	ret

.not_linked
	ld a, [wBattleResult]
	and $f
	ret nz
	xor a
	ld [wForceEvolution], a
	predef EvolveAfterBattle
	farcall GivePokerusAndConvertBerries
	ret

GetTrainerBackpic:
; Load the player character's backpic (6x6) into VRAM starting from vTiles2 tile $31.

; Special exception for Dude.
	ld b, BANK(DudeBackpic)
	ld hl, DudeBackpic
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	jr z, .Decompress

; What gender are we?
	ld a, [wPlayerSpriteSetupFlags]
	bit PLAYERSPRITESETUP_FEMALE_TO_MALE_F, a
	jr nz, .Chris
	ld a, [wPlayerGender]
	bit PLAYERGENDER_FEMALE_F, a
	jr z, .Chris

; It's a girl.
	farcall GetKrisBackpic
	ret

.Chris:
; It's a boy.
	ld b, BANK(ChrisBackpic)
	ld hl, ChrisBackpic

.Decompress:
	ld de, vTiles2 tile $31
	ld c, 7 * 7
	predef DecompressGet2bpp
	ret

CheckAmuletCoin:
	ld a, [wBattleMonItem]
	ld b, a
	farcall GetItemHeldEffect
	ld a, b
	cp HELD_AMULET_COIN
	ret nz
	ld a, 1
	ld [wAmuletCoin], a
	ret

GetTeamHighestLevel:
	ld a, [wPartyCount]
	ld b, a
	ld hl, wPartyMon1Level
	ld a, [hl]
	dec b
	jr z, .SetLevel
	ld de, PARTYMON_STRUCT_LENGTH
	ld c, a

.LoopPartyLevel
	add hl, de
	ld a, [hl]
	cp c
	jr c, .continue
	ld c, a
.continue
	dec b
	jr nz, .LoopPartyLevel
	ld a, c
.SetLevel
	ld [wTeamHighestLevel], a
	ret

WriteDownOldStatsForGainCalculation::
	inc hl ; Max HP.
	inc hl ; Max HP + 1.
	inc hl ; Atk high byte (big-endian).
	ld a, [hli]
	ld [wTempMonLevelUpStatGain + 0], a ; Atk.
	inc hl

	ld a, [hli]
	ld [wTempMonLevelUpStatGain + 1], a ; Def.
	inc hl

	ld a, [hli]
	ld [wTempMonLevelUpStatGain + 4], a ; Speed.
	inc hl

	ld a, [hli]
	ld [wTempMonLevelUpStatGain + 2], a ; Special atk.
	inc hl

	ld a, [hl]
	ld [wTempMonLevelUpStatGain + 3], a ; Special def.
	ret

_LinkBattleSendReceiveAction:
	call .StageForSend
	ld [wLinkBattleSentAction], a
	vc_hook Wireless_start_exchange
	farcall PlaceWaitingText
	jr .LinkBattle_SendReceiveAction

.StageForSend:
	ld a, [wBattlePlayerAction]
	and a ; BATTLEPLAYERACTION_USEMOVE?
	jr nz, .switch
	ld a, [wCurPlayerMove]
	ld b, BATTLEACTION_STRUGGLE
	cp STRUGGLE
	jr z, .struggle
	ld b, BATTLEACTION_SKIPTURN
	cp $ff
	jr z, .struggle
	ld a, [wCurMoveNum]
	jr .use_move

.switch
	ld a, [wCurPartyMon]
	add BATTLEACTION_SWITCH1
	jr .use_move

.struggle
	ld a, b

.use_move
	and $0f
	ret

.LinkBattle_SendReceiveAction:
	ld a, [wLinkBattleSentAction]
	ld [wPlayerLinkAction], a
	ld a, $ff
	ld [wOtherPlayerLinkAction], a
.waiting
	call LinkTransfer
	call DelayFrame
	ld a, [wOtherPlayerLinkAction]
	inc a
	jr z, .waiting

	vc_hook Wireless_end_exchange
	vc_patch Wireless_net_delay_3
if DEF(_CRYSTAL11_VC)
	ld b, 26
else
	ld b, 10
endc
	vc_patch_end
.receive
	call DelayFrame
	call LinkTransfer
	dec b
	jr nz, .receive

	vc_hook Wireless_start_send_zero_bytes
	vc_patch Wireless_net_delay_4
if DEF(_CRYSTAL11_VC)
	ld b, 26
else
	ld b, 10
endc
	vc_patch_end
.acknowledge
	call DelayFrame
	call LinkDataReceived
	dec b
	jr nz, .acknowledge

	vc_hook Wireless_end_send_zero_bytes
	ld a, [wOtherPlayerLinkAction]
	ld [wBattleAction], a
	ret

ShouldIgniteFlameOrb:
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	and a
	jr nz, .no

	ldh a, [hBattleTurn]
	and a
	jr z, .playerTurn
	ld a, [wEnemyMonType1]
	ld b, a
	ld a, [wEnemyMonType2]
	ld c, a
	ld a, [wEnemyMonSpecies]
	jr .checkDetails
.playerTurn
	ld a, [wBattleMonType1]
	ld b, a
	ld a, [wBattleMonType2]
	ld c, a
	ld a, [wBattleMonSpecies]
.checkDetails
	cp MEGANIUM
	jr z, .no
	cp SYLVEON
	jr z, .no
	cp MEW
	jr z, .no
	ld a, b
	cp FIRE
	jr z, .no
	ld a, c
	cp FIRE
	jr z, .no
.yes
	scf
	ret
.no
	xor a
	ret

XAccuracy:
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVar
	bit SUBSTATUS_X_ACCURACY, a
	ret

ThunderRain:
; Return z if the current move always hits in rain, and it is raining.
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_THUNDER
	ret nz

	ld a, [wBattleWeather]
	cp WEATHER_RAIN
	ret

BlizzardHail:
; Return z if the current mova always hits in hail, and it is hailing
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_BLIZZARD
	ret nz
	
	ld a, [wBattleWeather]
	cp WEATHER_HAIL
	ret

FlyDigMovesMiss:
; Check for moves that can hit underground/flying opponents.
; Return z if the current move can hit the opponent.
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	ret z
	bit SUBSTATUS_FLYING, a
	jr z, .DigMoves
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp GUST
	ret z
	cp WHIRLWIND
	ret z
	cp THUNDER
	ret z
	cp HURRICANE
	ret z
	ret

.DigMoves:
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp EARTHQUAKE
	ret

HurricaneRain:
; Return z if the current move always hits in rain, and it is raining.
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_HURRICANE
	ret nz

	ld a, [wBattleWeather]
	cp WEATHER_RAIN
	ret

DreamEaterMiss:
; Return z if we're trying to eat the dream of
; a monster that isn't sleeping.
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_DREAM_EATER
	ret nz
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVar
	and SLP_MASK
	ret

ProtectMiss:
; Return nz if the opponent is protected.
	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVar
	bit SUBSTATUS_PROTECT, a
	ret z
	ld c, 40
	call DelayFrames
; 'protecting itself!'
	ld hl, ProtectingItselfText
	call StdBattleTextbox
	ld c, 40
	call DelayFrames
	ld a, 1
	and a
	ret

ToxicPoison:
; Return z if the used move is Toxic, and the user is Poison type.
; Which means Toxic should always hit.
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_TOXIC
	ret nz

	ld hl, wBattleMonType1
	ldh a, [hBattleTurn]
	and a
	jr z, .cur_mon_own_type_found
	ld hl, wEnemyMonType1
.cur_mon_own_type_found
	ld a, [hli]
	cp POISON
	ret z

	ld a, [hl]
	cp POISON
	ret

; used by trainer SELF to set DVS in bc
SetUpSelfDVs:
    ld a, [wOtherTrainerClass]
    cp CAL
    jr nz, .notSelf
    ld a, [wCurPartyMon]
	ld hl, wOTPartyMon1DVs
	call GetPartyLocation
	ld b, [hl]
	inc hl
	ld c, [hl]
.notSelf
    ret

GetWeatherImage:
	ld a, [wBattleWeather]
	ld de, ClearWeatherImage
	lb bc, PAL_BATTLE_OB_BLUE, 4
	cp WEATHER_NONE
	jr z, .done
	ld de, RainWeatherImage
	lb bc, PAL_BATTLE_OB_BLUE, 4
	dec a
	jr z, .done
	ld de, SunWeatherImage
	ld b, PAL_BATTLE_OB_YELLOW
	dec a
	jr z, .done
	ld de, SandstormWeatherImage
	ld b, PAL_BATTLE_OB_BROWN
	dec a
	jr z, .done
	ld de, HailWeatherImage
	ld b, PAL_BATTLE_OB_BLUE
	dec a
	ret nz
	
.done
	push bc
	ld b, BANK(WeatherImages) ; c = 4
	ld hl, vTiles0
	call Request2bpp
	pop bc
	ld hl, wShadowOAMSprite00
	ld de, .WeatherImageOAMData
.loop
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	ld a, c
	ld [hli], a
	ld a, b
	ld [hli], a
	jr nz, .loop
	ret

.WeatherImageOAMData
; positions are backwards since
; we load them in reverse order
	db $88, $1c ; y/x - bottom right
	db $88, $14 ; y/x - bottom left
	db $80, $1c ; y/x - top right
	db $80, $14 ; y/x - top left

FieldWeather:
	; is weather already set up
	ld a, [wBattleWeather]
	cp WEATHER_NONE
	jr nz, .doWeather

	; set weather and count to 255 turns
	ld a, 255
	ld [wWeatherCount], a
	ld a, [wFieldWeather]
	ld [wBattleWeather], a
.doWeather
	cp WEATHER_RAIN
	jr z, .rain
	cp WEATHER_SUN
	jr z, .sun
	cp WEATHER_SANDSTORM
	jr z, .sand
	cp WEATHER_HAIL
	ret nz

.hail
	ld de, ANIM_IN_HAIL
	farcall Call_PlayBattleAnim
	ld hl, ItStartedToHailText
	jmp StdBattleTextbox

.sand
	ld de, ANIM_IN_SANDSTORM
	farcall Call_PlayBattleAnim
	ld hl, SandstormBrewedText
	jmp StdBattleTextbox

.rain
	ld de, RAIN_DANCE
	farcall Call_PlayBattleAnim
	ld hl, DownpourText
	jmp StdBattleTextbox

.sun
	ld de, SUNNY_DAY
	farcall Call_PlayBattleAnim
	ld hl, SunsRaysIntensifiedText
	jmp StdBattleTextbox

GetTimeOfDayImage:
	; wipes out text before TimeOfDayImage
	; mixes with text for split second
	ld hl, BattleText_Null
	call StdBattleTextbox

	ld a, [wTimeOfDay]
	cp MORN_F
	jr z, .MornImage

	cp DAY_F
	jr z, .DayImage
	
	cp EVE_F
	jr z, .EveImage
	jr .NightImage

.MornImage:
 	ld de, MorningTimeImage
 	lb bc, PAL_BATTLE_OB_BLUE, 4
 	jr .done

.DayImage:
 	ld de, DayTimeImage
 	lb bc, PAL_BATTLE_OB_YELLOW, 4
 	jr .done	

 .EveImage:
 	ld de, EveningTimeImage
 	lb bc, PAL_BATTLE_OB_RED, 4
 	jr .done

 .NightImage:
 	ld de, NightTimeImage
 	lb bc, PAL_BATTLE_OB_GRAY, 4

.done
	push bc
	ld b, BANK(TimeOfDayImages) ; c = 4
	ld hl, vTiles0
	call Request2bpp
	pop bc
	ld hl, wShadowOAMSprite00
	ld de, .TimeOfDayImageOAMData
.loop
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	ld a, c
	ld [hli], a
	ld a, b
	ld [hli], a
	jr nz, .loop
	ret

.TimeOfDayImageOAMData
; positions are backwards since
; we load them in reverse order
	db $88, $1c ; y/x - bottom right
	db $88, $14 ; y/x - bottom left
	db $80, $1c ; y/x - top right
	db $80, $14 ; y/x - top left

TypeChart:
	push hl
	push de
	push bc
	xor a
	ld [wTypeChartInBattle], a
	call UpdateChartPageText
	call BugTypeChart
	call WaitButtonChartInfoBox
	jmp PopBCDEHL

; ========================
; Update text for each page
; ========================
UpdateChartPageText:
	hlcoord 4, 17
	ld a, [wTypeChartInBattle]

	cp 1
	jr z, .page_2
	cp 2
	jr z, .page_3
	cp 3
	jr z, .page_4
	cp 4
	jr z, .page_5
	cp 5
	jr z, .page_6
	cp 6
	jr z, .page_7
	cp 7
	jmp z, .page_8
	cp 8
	jmp z, .page_9
	cp 9
	jmp z, .page_10
	cp 10
	jmp z, .page_11
	cp 11
	jmp z, .page_12
	cp 12
	jmp z, .page_13
	cp 13
	jmp z, .page_14
	cp 14
	jmp z, .page_15
	cp 15
	jmp z, .page_16
	cp 16
	jmp z, .page_17
	cp 17
	jmp z, .page_18
; Default: page 1
	ld de, TypeChartMainText.page1
	call PlaceString
	ld de, TypeChartMainText.page1_content
	jmp .done

.page_2
	ld de, TypeChartMainText.page2
	call PlaceString
	ld de, TypeChartMainText.page2_content
	jmp .done

.page_3
	ld de, TypeChartMainText.page3
	call PlaceString
	ld de, TypeChartMainText.page3_content
	jmp .done

.page_4
	ld de, TypeChartMainText.page4
	call PlaceString
	ld de, TypeChartMainText.page4_content
	jmp .done

.page_5
	ld de, TypeChartMainText.page5
	call PlaceString
	ld de, TypeChartMainText.page5_content
	jmp .done

.page_6
	ld de, TypeChartMainText.page6
	call PlaceString
	ld de, TypeChartMainText.page6_content
	jmp .done

.page_7
	ld de, TypeChartMainText.page7
	call PlaceString
	ld de, TypeChartMainText.page7_content
	jr .done

.page_8
	ld de, TypeChartMainText.page8
	call PlaceString
	ld de, TypeChartMainText.page8_content
	jr .done

.page_9
	ld de, TypeChartMainText.page9
	call PlaceString
	ld de, TypeChartMainText.page9_content
	jr .done

.page_10
	ld de, TypeChartMainText.page10
	call PlaceString
	ld de, TypeChartMainText.page10_content
	jr .done

.page_11
	ld de, TypeChartMainText.page11
	call PlaceString
	ld de, TypeChartMainText.page11_content
	jr .done

.page_12
	ld de, TypeChartMainText.page12
	call PlaceString
	ld de, TypeChartMainText.page12_content
	jr .done

.page_13
	ld de, TypeChartMainText.page13
	call PlaceString
	ld de, TypeChartMainText.page13_content
	jr .done

.page_14
	ld de, TypeChartMainText.page14
	call PlaceString
	ld de, TypeChartMainText.page14_content
	jr .done

.page_15
	ld de, TypeChartMainText.page15
	call PlaceString
	ld de, TypeChartMainText.page15_content
	jr .done

.page_16
	ld de, TypeChartMainText.page16
	call PlaceString
	ld de, TypeChartMainText.page16_content
	jr .done

.page_17
	ld de, TypeChartMainText.page17
	call PlaceString
	ld de, TypeChartMainText.page17_content
	jr .done

.page_18
	ld de, TypeChartMainText.page18
	call PlaceString
	ld de, TypeChartMainText.page18_content
.done
	hlcoord 4, 16
	jmp PlaceString

TypeChartMainText:
.page1:
	db "◀ Page 01/18 ▶@"
.page1_content:
	db "   Bug Type   @"

.page2:
	db "◀ Page 02/18 ▶@"
.page2_content:
	db "  Dark Type   @"

.page3:
	db "◀ Page 03/18 ▶@"
.page3_content:
	db "  Dragon Type @"

.page4:
	db "◀ Page 04/18 ▶@"
.page4_content:
	db " Electric Type@"

.page5:
	db "◀ Page 05/18 ▶@"
.page5_content:
	db "  Fairy Type  @"

.page6:
	db "◀ Page 06/18 ▶@"
.page6_content:
	db " Fighting Type@"

.page7:
	db "◀ Page 07/18 ▶@"
.page7_content:
	db "  Fire Type   @"

.page8:
	db "◀ Page 08/18 ▶@"
.page8_content:
	db "  Flying Type @"

.page9:
	db "◀ Page 09/18 ▶@"
.page9_content:
	db "  Ghost Type  @"

.page10:
	db "◀ Page 10/18 ▶@"
.page10_content:
	db "  Grass Type  @"

.page11:
	db "◀ Page 11/18 ▶@"
.page11_content:
	db "  Ground Type @"

.page12:
	db "◀ Page 12/18 ▶@"
.page12_content:
	db "   Ice Type   @"

.page13:
	db "◀ Page 13/18 ▶@"
.page13_content:
	db "  Normal Type @"

.page14:
	db "◀ Page 14/18 ▶@"
.page14_content:
	db "  Poison Type @"

.page15:
	db "◀ Page 15/18 ▶@"
.page15_content:
	db " Psychic Type @"

.page16:
	db "◀ Page 16/18 ▶@"
.page16_content:
	db "  Rock Type   @"

.page17:
	db "◀ Page 17/18 ▶@"
.page17_content:
	db "  Steel Type  @"

.page18:
	db "◀ Page 18/18 ▶@"
.page18_content:
	db "  Water Type  @"

WaitButtonChartInfoBox:
	ldh a, [hOAMUpdate]
	push af
	ld a, 1
	ldh [hOAMUpdate], a
	call WaitBGMap
	call JoyWaitAorBorDPADChartInfo
	pop af
	ldh [hOAMUpdate], a
	ret

JoyWaitAorBorDPADChartInfo:
.loop
	call DelayFrame
	call GetJoypad
	ldh a, [hJoyPressed]
	and A_BUTTON | B_BUTTON
	ret nz
	ldh a, [hJoyPressed]
	and D_RIGHT
	call nz, ChartBoxRightPress
	ldh a, [hJoyPressed]
	and D_LEFT
	call nz, ChartBoxLeftPress
	call UpdateTimeAndPals
	jr .loop

; ========================
; Left button navigation
; ========================
ChartBoxLeftPress:
	; play switching pockets SFX	
	ld de, SFX_SWITCH_POCKETS
	call PlaySFX

	ld a, [wTypeChartInBattle]
	and a
	jr z, .jump_to_page_18
	cp 1
	jr z, .jump_to_page_1
	cp 2
	jr z, .jump_to_page_2
	cp 3
	jr z, .jump_to_page_3
	cp 4
	jr z, .jump_to_page_4
	cp 5
	jr z, .jump_to_page_5
	cp 6
	jr z, .jump_to_page_6
	cp 7
	jr z, .jump_to_page_7
	cp 8
	jr z, .jump_to_page_8
	cp 9
	jr z, .jump_to_page_9
	cp 10
	jmp z, .jump_to_page_10
	cp 11
	jmp z, .jump_to_page_11
	cp 12
	jmp z, .jump_to_page_12
	cp 13
	jmp z, .jump_to_page_13
	cp 14
	jmp z, .jump_to_page_14
	cp 15
	jmp z, .jump_to_page_15
	cp 16
	jmp z, .jump_to_page_16
	cp 17
	jmp z, .jump_to_page_17
	cp 18
	ret nz
.jump_to_page_18:
	call DecreaseTypeChartPage
	call UpdateChartPageText
	jmp WaterTypeChart

.jump_to_page_1
	call DecreaseTypeChartPage
	call UpdateChartPageText
	jmp BugTypeChart

.jump_to_page_2
	call DecreaseTypeChartPage
	call UpdateChartPageText
	jmp DarkTypeChart

.jump_to_page_3
	call DecreaseTypeChartPage
	call UpdateChartPageText
	jmp DragonTypeChart

.jump_to_page_4
	call DecreaseTypeChartPage
	call UpdateChartPageText
	jmp ElectricTypeChart

.jump_to_page_5
	call DecreaseTypeChartPage
	call UpdateChartPageText
	jmp FairyTypeChart

.jump_to_page_6
	call DecreaseTypeChartPage
	call UpdateChartPageText
	jmp FightingTypeChart

.jump_to_page_7
	call DecreaseTypeChartPage
	call UpdateChartPageText
	jmp FireTypeChart

.jump_to_page_8
	call DecreaseTypeChartPage
	call UpdateChartPageText
	jmp FlyingTypeChart

.jump_to_page_9
	call DecreaseTypeChartPage
	call UpdateChartPageText
	jmp GhostTypeChart

.jump_to_page_10
	call DecreaseTypeChartPage
	call UpdateChartPageText
	jmp GrassTypeChart

.jump_to_page_11
	call DecreaseTypeChartPage
	call UpdateChartPageText
	jmp GroundTypeChart

.jump_to_page_12
	call DecreaseTypeChartPage
	call UpdateChartPageText
	jmp IceTypeChart

.jump_to_page_13
	call DecreaseTypeChartPage
	call UpdateChartPageText
	jmp NormalTypeChart

.jump_to_page_14
	call DecreaseTypeChartPage
	call UpdateChartPageText
	jmp PoisonTypeChart

.jump_to_page_15
	call DecreaseTypeChartPage
	call UpdateChartPageText
	jmp PsychicTypeChart

.jump_to_page_16
	call DecreaseTypeChartPage
	call UpdateChartPageText
	jmp RockTypeChart

.jump_to_page_17
	call DecreaseTypeChartPage
	call UpdateChartPageText
	jmp SteelTypeChart

; ========================
; Right button navigation
; ========================
ChartBoxRightPress:
	; play switching pockets SFX	
	ld de, SFX_SWITCH_POCKETS
	call PlaySFX

	ld a, [wTypeChartInBattle]
	and a
	jr z, .jump_to_page_2
	cp 1
	jr z, .jump_to_page_3
	cp 2
	jr z, .jump_to_page_4
	cp 3
	jr z, .jump_to_page_5
	cp 4
	jr z, .jump_to_page_6
	cp 5
	jr z, .jump_to_page_7
	cp 6
	jr z, .jump_to_page_8
	cp 7
	jr z, .jump_to_page_9
	cp 8
	jr z, .jump_to_page_10
	cp 9
	jmp z, .jump_to_page_11
	cp 10
	jmp z, .jump_to_page_12
	cp 11
	jmp z, .jump_to_page_13
	cp 12
	jmp z, .jump_to_page_14
	cp 13
	jmp z, .jump_to_page_15
	cp 14
	jmp z, .jump_to_page_16
	cp 15
	jmp z, .jump_to_page_17
	cp 16
	jmp z, .jump_to_page_18
	cp 17
	ret nz
.jump_to_page_1:
	call IncreaseTypeChartPage
	call UpdateChartPageText
	jmp BugTypeChart

.jump_to_page_2
	call IncreaseTypeChartPage
	call UpdateChartPageText
	jmp DarkTypeChart

.jump_to_page_3
	call IncreaseTypeChartPage
	call UpdateChartPageText
	jmp DragonTypeChart

.jump_to_page_4
	call IncreaseTypeChartPage
	call UpdateChartPageText
	jmp ElectricTypeChart

.jump_to_page_5
	call IncreaseTypeChartPage
	call UpdateChartPageText
	jmp FairyTypeChart

.jump_to_page_6
	call IncreaseTypeChartPage
	call UpdateChartPageText
	jmp FightingTypeChart

.jump_to_page_7
	call IncreaseTypeChartPage
	call UpdateChartPageText
	jmp FireTypeChart

.jump_to_page_8
	call IncreaseTypeChartPage
	call UpdateChartPageText
	jmp FlyingTypeChart

.jump_to_page_9
	call IncreaseTypeChartPage
	call UpdateChartPageText
	jmp GhostTypeChart

.jump_to_page_10
	call IncreaseTypeChartPage
	call UpdateChartPageText
	jmp GrassTypeChart

.jump_to_page_11
	call IncreaseTypeChartPage
	call UpdateChartPageText
	jmp GroundTypeChart

.jump_to_page_12
	call IncreaseTypeChartPage
	call UpdateChartPageText
	jmp IceTypeChart

.jump_to_page_13
	call IncreaseTypeChartPage
	call UpdateChartPageText
	jmp NormalTypeChart

.jump_to_page_14
	call IncreaseTypeChartPage
	call UpdateChartPageText
	jmp PoisonTypeChart

.jump_to_page_15
	call IncreaseTypeChartPage
	call UpdateChartPageText
	jmp PsychicTypeChart

.jump_to_page_16
	call IncreaseTypeChartPage
	call UpdateChartPageText
	jmp RockTypeChart

.jump_to_page_17
	call IncreaseTypeChartPage
	call UpdateChartPageText
	jmp SteelTypeChart

.jump_to_page_18
	call IncreaseTypeChartPage
	call UpdateChartPageText
	jmp WaterTypeChart
	
; ========================
; Page counter functions
; ========================
IncreaseTypeChartPage:
	ld a, [wTypeChartInBattle]
	inc a
	cp 18                     ; Pages 0 to 18 (inclusive)
	jr c, .store
	xor a                    ; Wrap to page 0
.store
	ld [wTypeChartInBattle], a
	ret

DecreaseTypeChartPage:
	ld a, [wTypeChartInBattle]
	or a
	jr nz, .dec
	ld a, 18                 ; Wrap to last page
.dec
	dec a
	ld [wTypeChartInBattle], a
	ret

BugTypeChart:
	hlcoord 0, 0
	lb bc, 14, 18
	call Textbox

	ld de, .TypeString
	hlcoord 1, 1
	call PlaceString

	ld de, .AttackerString
	hlcoord 1, 3
	call PlaceString

	ld de, .AttackerStringHalfDamage1
	hlcoord 1, 4
	call PlaceString

	ld de, .AttackerStringHalfDamage2
	hlcoord 1, 5
	call PlaceString

	ld de, .AttackerStringDoubleDamage1
	hlcoord 1, 6
	call PlaceString

	ld de, .AttackerStringDoubleDamage2
	hlcoord 1, 7
	call PlaceString

	ld de, .DefenderString
	hlcoord 1, 9
	call PlaceString

	ld de, .DefenderStringHalfDamage
	hlcoord 1, 10
	call PlaceString

	ld de, .DefenderStringDoubleDamage
	hlcoord 1, 11
	jmp PlaceString

.TypeString:
	db "Bug Type@"
.AttackerString:
	db "Attacker:@"
.AttackerStringHalfDamage1:
	db "<half>× Steel/Poison/@"
.AttackerStringHalfDamage2:
	db "   Fly/Fire@"
.AttackerStringDoubleDamage1:
	db "2× Grass/Dark/@"
.AttackerStringDoubleDamage2:
	db "   Fairy/Psychic@"

.DefenderString:
	db "Defender:@"
.DefenderStringHalfDamage:
	db "<half>× Grass/Ground@"
.DefenderStringDoubleDamage:
	db "2× Fire/Rock/Fly@"

DarkTypeChart:
	hlcoord 0, 0
	lb bc, 14, 18
	call Textbox

	ld de, .TypeString
	hlcoord 1, 1
	call PlaceString

	ld de, .AttackerString
	hlcoord 1, 3
	call PlaceString

	ld de, .AttackerStringHalfDamage1
	hlcoord 1, 4
	call PlaceString

	ld de, .AttackerStringHalfDamage2
	hlcoord 1, 5
	call PlaceString

	ld de, .AttackerStringDoubleDamage
	hlcoord 1, 6
	call PlaceString

	ld de, .DefenderString
	hlcoord 1, 8
	call PlaceString

	ld de, .DefenderStringZeroDamage
	hlcoord 1, 9
	call PlaceString

	ld de, .DefenderStringHalfDamage
	hlcoord 1, 10
	call PlaceString

	ld de, .DefenderStringDoubleDamage
	hlcoord 1, 11
	jmp PlaceString

.TypeString:
	db "Dark Type@"
.AttackerString:
	db "Attacker:@"
.AttackerStringHalfDamage1:
	db "<half>× Dark/Fairy/@"
.AttackerStringHalfDamage2:
	db "   Fight@"
.AttackerStringDoubleDamage:
	db "2× Ghost/Psychic@"

.DefenderString:
	db "Defender:@"
.DefenderStringZeroDamage:
	db "0× Psychic@"
.DefenderStringHalfDamage:
	db "<half>× Ghost/Dark@"
.DefenderStringDoubleDamage:
	db "2× Bug/Fairy/Fight@"


DragonTypeChart:
	hlcoord 0, 0
	lb bc, 14, 18
	call Textbox

	ld de, .TypeString
	hlcoord 1, 1
	call PlaceString

	ld de, .AttackerString
	hlcoord 1, 3
	call PlaceString

	ld de, .AttackerStringZeroDamage
	hlcoord 1, 4
	call PlaceString

	ld de, .AttackerStringHalfDamage
	hlcoord 1, 5
	call PlaceString

	ld de, .AttackerStringDoubleDamage
	hlcoord 1, 6
	call PlaceString

	ld de, .DefenderString
	hlcoord 1, 8
	call PlaceString

	ld de, .DefenderStringHalfDamage1
	hlcoord 1, 9
	call PlaceString

	ld de, .DefenderStringHalfDamage2
	hlcoord 1, 10
	call PlaceString

	ld de, .DefenderStringDoubleDamage1
	hlcoord 1, 11
	call PlaceString

	ld de, .DefenderStringDoubleDamage2
	hlcoord 1, 12
	jmp PlaceString

.TypeString:
	db "Dragon Type@"
.AttackerString:
	db "Attacker:@"
.AttackerStringZeroDamage:
	db "0× Fairy@"
.AttackerStringHalfDamage:
	db "<half>× Steel@"
.AttackerStringDoubleDamage:
	db "2× Dragon@"

.DefenderString:
	db "Defender:@"
.DefenderStringHalfDamage1:
	db "<half>× Fire/Electric/@"
.DefenderStringHalfDamage2:
	db "   Water/Grass@"
.DefenderStringDoubleDamage1:
	db "2× Ice/Fiary/@"
.DefenderStringDoubleDamage2:
	db "   Dragon@"

ElectricTypeChart:
	hlcoord 0, 0
	lb bc, 14, 18
	call Textbox

	ld de, .TypeString
	hlcoord 1, 1
	call PlaceString

	ld de, .AttackerString
	hlcoord 1, 3
	call PlaceString

	ld de, .AttackerStringZeroDamage
	hlcoord 1, 4
	call PlaceString

	ld de, .AttackerStringHalfDamage1
	hlcoord 1, 5
	call PlaceString

	ld de, .AttackerStringHalfDamage2
	hlcoord 1, 6
	call PlaceString

	ld de, .AttackerStringDoubleDamage
	hlcoord 1, 7
	call PlaceString

	ld de, .DefenderString
	hlcoord 1, 9
	call PlaceString

	ld de, .DefenderStringHalfDamage1
	hlcoord 1, 10
	call PlaceString

	ld de, .DefenderStringHalfDamage2
	hlcoord 1, 11
	call PlaceString

	ld de, .DefenderStringDoubleDamage
	hlcoord 1, 12
	jmp PlaceString

.TypeString:
	db "Electric Type@"
.AttackerString:
	db "Attacker:@"
.AttackerStringHalfDamage1:
	db "<half>× Grass/Dragon/@"
.AttackerStringHalfDamage2:
	db "   Electric@"
.AttackerStringZeroDamage:
	db "0× Ground@"
.AttackerStringDoubleDamage:
	db "2× Water/Flying@"

.DefenderString:
	db "Defender:@"
.DefenderStringHalfDamage1:
	db "<half>× Flying/Steel/@"
.DefenderStringHalfDamage2:
	db "   Electric@"
.DefenderStringDoubleDamage:
	db "2× Ground@"

FairyTypeChart:
	hlcoord 0, 0
	lb bc, 14, 18
	call Textbox

	ld de, .TypeString
	hlcoord 1, 1
	call PlaceString

	ld de, .AttackerString
	hlcoord 1, 3
	call PlaceString

	ld de, .AttackerStringHalfDamage1
	hlcoord 1, 4
	call PlaceString

	ld de, .AttackerStringHalfDamage2
	hlcoord 1, 5
	call PlaceString

	ld de, .AttackerStringDoubleDamage1
	hlcoord 1, 6
	call PlaceString

	ld de, .AttackerStringDoubleDamage2
	hlcoord 1, 7
	call PlaceString

	ld de, .DefenderString
	hlcoord 1, 9
	call PlaceString

	ld de, .DefenderStringZeroDamage
	hlcoord 1, 10
	call PlaceString

	ld de, .DefenderStringHalfDamage
	hlcoord 1, 11
	call PlaceString

	ld de, .DefenderStringDoubleDamage1
	hlcoord 1, 12
	call PlaceString

	ld de, .DefenderStringDoubleDamage2
	hlcoord 1, 13
	call PlaceString
	jmp PlaceString

.TypeString:
	db "Fairy Type@"
.AttackerString:
	db "Attacker:@"
.AttackerStringHalfDamage1:
	db "<half>× Poison/Steel/@"
.AttackerStringHalfDamage2:
	db "   Bug@"
.AttackerStringDoubleDamage1:
	db "2× Dark/Dragon/@"
.AttackerStringDoubleDamage2:
	db "   Fight@"

.DefenderString:
	db "Defender:@"
.DefenderStringZeroDamage:
	db "0× Dragon@"
.DefenderStringHalfDamage:
	db "<half>× Fight/Dark@"
.DefenderStringDoubleDamage1:
	db "2× Poison/Steel/@"
.DefenderStringDoubleDamage2:
	db "   Bug@"

FightingTypeChart:
	hlcoord 0, 0
	lb bc, 14, 18
	call Textbox

	ld de, .TypeString
	hlcoord 1, 1
	call PlaceString

	ld de, .AttackerString
	hlcoord 1, 3
	call PlaceString

	ld de, .AttackerStringZeroDamage
	hlcoord 1, 4
	call PlaceString

	ld de, .AttackerStringHalfDamage1
	hlcoord 1, 5
	call PlaceString

	ld de, .AttackerStringHalfDamage2
	hlcoord 1, 6
	call PlaceString

	ld de, .AttackerStringDoubleDamage1
	hlcoord 1, 7
	call PlaceString

	ld de, .AttackerStringDoubleDamage2
	hlcoord 1, 8
	call PlaceString

	ld de, .DefenderString
	hlcoord 1, 10
	call PlaceString

	ld de, .DefenderStringHalfDamage
	hlcoord 1, 11
	call PlaceString

	ld de, .DefenderStringDoubleDamage1
	hlcoord 1, 12
	call PlaceString

	ld de, .DefenderStringDoubleDamage2
	hlcoord 1, 13
	jmp PlaceString

.TypeString:
	db "Fighting Type@"
.AttackerString:
	db "Attacker:@"
.AttackerStringZeroDamage:
	db "0× Ghost@"
.AttackerStringHalfDamage1:
	db "<half>× Poison/Psychic/@"
.AttackerStringHalfDamage2:
	db "   Flying/Fairy@"
.AttackerStringDoubleDamage1:
	db "2× Ice/Rock/Dark/@"
.AttackerStringDoubleDamage2:
	db "   Normal/Steel@"

.DefenderString:
	db "Defender:@"
.DefenderStringHalfDamage:
	db "<half>× Rock/Dark@"
.DefenderStringDoubleDamage1:
	db "2× Fly/Psychic/@"
.DefenderStringDoubleDamage2:
	db "   Fairy@"

FireTypeChart:
	hlcoord 0, 0
	lb bc, 14, 18
	call Textbox

	ld de, .TypeString
	hlcoord 1, 1
	call PlaceString

	ld de, .AttackerString
	hlcoord 1, 3
	call PlaceString

	ld de, .AttackerStringHalfDamage1
	hlcoord 1, 4
	call PlaceString

	ld de, .AttackerStringHalfDamage2
	hlcoord 1, 5
	call PlaceString

	ld de, .AttackerStringDoubleDamage1
	hlcoord 1, 6
	call PlaceString

	ld de, .AttackerStringDoubleDamage2
	hlcoord 1, 7
	call PlaceString

	ld de, .DefenderString
	hlcoord 1, 9
	call PlaceString

	ld de, .DefenderStringHalfDamage1
	hlcoord 1, 10
	call PlaceString

	ld de, .DefenderStringHalfDamage2
	hlcoord 1, 11
	call PlaceString

	ld de, .DefenderStringDoubleDamage1
	hlcoord 1, 12
	call PlaceString

	ld de, .DefenderStringDoubleDamage2
	hlcoord 1, 13
	jmp PlaceString

.TypeString:
	db "Fire Type@"
.AttackerString:
	db "Attacker:@"
.AttackerStringHalfDamage1:
	db "<half>× Water/Fire/@"
.AttackerStringHalfDamage2:
	db "   Dragon/Rock@"
.AttackerStringDoubleDamage1:
	db "2× Grass/Ice/Bug/@"
.AttackerStringDoubleDamage2:
	db "   Steel@"

.DefenderString:
	db "Defender:@"
.DefenderStringHalfDamage1:
	db "<half>× Grass/Steel/@"
.DefenderStringHalfDamage2:
	db "   Fire/Ice/Bug@"
.DefenderStringDoubleDamage1:
	db "2× Water/Rock/@"
.DefenderStringDoubleDamage2:
	db "   Ground@"

FlyingTypeChart:
	hlcoord 0, 0
	lb bc, 14, 18
	call Textbox

	ld de, .TypeString
	hlcoord 1, 1
	call PlaceString

	ld de, .AttackerString
	hlcoord 1, 3
	call PlaceString

	ld de, .AttackerStringHalfDamage1
	hlcoord 1, 4
	call PlaceString

	ld de, .AttackerStringHalfDamage2
	hlcoord 1, 5
	call PlaceString

	ld de, .AttackerStringDoubleDamage1
	hlcoord 1, 6
	call PlaceString

	ld de, .AttackerStringDoubleDamage2
	hlcoord 1, 7
	call PlaceString

	ld de, .DefenderString
	hlcoord 1, 9
	call PlaceString

	ld de, .DefenderStringZeroDamage
	hlcoord 1, 10
	call PlaceString

	ld de, .DefenderStringHalfDamage1
	hlcoord 1, 11
	call PlaceString

	ld de, .DefenderStringHalfDamage2
	hlcoord 1, 12
	call PlaceString

	ld de, .DefenderStringDoubleDamage1
	hlcoord 1, 13
	call PlaceString

	ld de, .DefenderStringDoubleDamage2
	hlcoord 1, 14
	jmp PlaceString

.TypeString:
	db "Flying Type@"
.AttackerString:
	db "Attacker:@"
.AttackerStringHalfDamage1:
	db "<half>× Steel, Rock &@"
.AttackerStringHalfDamage2:
	db "   Electric@"
.AttackerStringDoubleDamage1:
	db "2× Grass, Bug &@"
.AttackerStringDoubleDamage2:
	db "   Fighting@"

.DefenderString:
	db "Defender:@"
.DefenderStringZeroDamage:
	db "0× Ground@"
.DefenderStringHalfDamage1:
	db "<half>× Grass, Bug &@"
.DefenderStringHalfDamage2:
	db "   Fighting@"
.DefenderStringDoubleDamage1:
	db "2× Electric/Ice/@"
.DefenderStringDoubleDamage2:
	db "   Rock@"

GhostTypeChart:
	hlcoord 0, 0
	lb bc, 14, 18
	call Textbox

	ld de, .TypeString
	hlcoord 1, 1
	call PlaceString

	ld de, .AttackerString
	hlcoord 1, 3
	call PlaceString

	ld de, .AttackerStringZeroDamage
	hlcoord 1, 4
	call PlaceString

	ld de, .AttackerStringHalfDamage
	hlcoord 1, 5
	call PlaceString

	ld de, .AttackerStringDoubleDamage
	hlcoord 1, 6
	call PlaceString

	ld de, .DefenderString
	hlcoord 1, 8
	call PlaceString

	ld de, .DefenderStringZeroDamage
	hlcoord 1, 9
	call PlaceString

	ld de, .DefenderStringHalfDamage
	hlcoord 1, 10
	call PlaceString

	ld de, .DefenderStringDoubleDamage
	hlcoord 1, 11
	jmp PlaceString

.TypeString:
	db "Ghost Type@"
.AttackerString:
	db "Attacker:@"
.AttackerStringZeroDamage:
	db "0× Normal @"
.AttackerStringHalfDamage:
	db "<half>× Dark@"
.AttackerStringDoubleDamage:
	db "2× Psychic/Ghost@"

.DefenderString:
	db "Defender:@"
.DefenderStringZeroDamage:
	db "0× Normal/Fight@"
.DefenderStringHalfDamage:
	db "<half>× Poison/Psychic@"
.DefenderStringDoubleDamage:
	db "2× Ghost/Dark@"

GrassTypeChart:
	hlcoord 0, 0
	lb bc, 14, 18
	call Textbox

	ld de, .TypeString
	hlcoord 1, 1
	call PlaceString

	ld de, .AttackerString
	hlcoord 1, 3
	call PlaceString

	ld de, .AttackerStringHalfDamage1
	hlcoord 1, 4
	call PlaceString

	ld de, .AttackerStringHalfDamage2
	hlcoord 1, 5
	call PlaceString

	ld de, .AttackerStringHalfDamage3
	hlcoord 1, 6
	call PlaceString

	ld de, .AttackerStringDoubleDamage1
	hlcoord 1, 7
	call PlaceString

	ld de, .AttackerStringDoubleDamage2
	hlcoord 1, 8
	call PlaceString

	ld de, .DefenderString
	hlcoord 1, 10
	call PlaceString

	ld de, .DefenderStringHalfDamage1
	hlcoord 1, 11
	call PlaceString

	ld de, .DefenderStringHalfDamage2
	hlcoord 1, 12
	call PlaceString

	ld de, .DefenderStringDoubleDamage1
	hlcoord 1, 13
	call PlaceString

	ld de, .DefenderStringDoubleDamage2
	hlcoord 1, 14
	jmp PlaceString

.TypeString:
	db "Grass Type@"
.AttackerString:
	db "Attacker:@"
.AttackerStringHalfDamage1:
	db "<half>× Grass/Poison/@"
.AttackerStringHalfDamage2:
	db "   Fire/Bug/Fly/@"
.AttackerStringHalfDamage3:
	db "   Dragon/Steel@"
.AttackerStringDoubleDamage1:
	db "2× Water/Ground/@"
.AttackerStringDoubleDamage2:
	db "   Rock@"

.DefenderString:
	db "Defender:@"
.DefenderStringHalfDamage1:
	db "<half>× Water/Electric/@"
.DefenderStringHalfDamage2:
	db "   Grass/Ground@"
.DefenderStringDoubleDamage1:
	db "2× Flying/Poison/@"
.DefenderStringDoubleDamage2:
	db "   Bug/Fire/Ice@"

GroundTypeChart:
	hlcoord 0, 0
	lb bc, 14, 18
	call Textbox

	ld de, .TypeString
	hlcoord 1, 1
	call PlaceString

	ld de, .AttackerString
	hlcoord 1, 3
	call PlaceString

	ld de, .AttackerStringHalfDamage
	hlcoord 1, 4
	call PlaceString

	ld de, .AttackerStringZeroDamage
	hlcoord 1, 5
	call PlaceString

	ld de, .AttackerStringDoubleDamage1
	hlcoord 1, 6
	call PlaceString

	ld de, .AttackerStringDoubleDamage2
	hlcoord 1, 7
	call PlaceString

	ld de, .AttackerStringDoubleDamage3
	hlcoord 1, 8
	call PlaceString

	ld de, .DefenderString
	hlcoord 1, 10
	call PlaceString

	ld de, .DefenderStringZeroDamage
	hlcoord 1, 11
	call PlaceString

	ld de, .DefenderStringHalfDamage
	hlcoord 1, 12
	call PlaceString

	ld de, .DefenderStringDoubleDamage
	hlcoord 1, 13
	jmp PlaceString

.TypeString:
	db "Ground Type@"
.AttackerString:
	db "Attacker:@"
.AttackerStringHalfDamage:
	db "<half>× Grass/Bug@"
.AttackerStringZeroDamage:
	db "0× Flying@"
.AttackerStringDoubleDamage1:
	db "2× Electric/Steel/@"
.AttackerStringDoubleDamage2:
	db "   Poison/Fire/@"
.AttackerStringDoubleDamage3:
	db "   Rock@"

.DefenderString:
	db "Defender:@"
.DefenderStringZeroDamage:
	db "0× Electric@"
.DefenderStringHalfDamage:
	db "<half>× Poison & Rock@"
.DefenderStringDoubleDamage:
	db "2× Water/Grass/Ice@"

IceTypeChart:
	hlcoord 0, 0
	lb bc, 14, 18
	call Textbox

	ld de, .TypeString
	hlcoord 1, 1
	call PlaceString

	ld de, .AttackerString
	hlcoord 1, 3
	call PlaceString

	ld de, .AttackerStringHalfDamage1
	hlcoord 1, 4
	call PlaceString

	ld de, .AttackerStringHalfDamage2
	hlcoord 1, 5
	call PlaceString

	ld de, .AttackerStringDoubleDamage1
	hlcoord 1, 6
	call PlaceString

	ld de, .AttackerStringDoubleDamage2
	hlcoord 1, 7
	call PlaceString

	ld de, .DefenderString
	hlcoord 1, 9
	call PlaceString

	ld de, .DefenderStringHalfDamage1
	hlcoord 1, 10
	call PlaceString

	ld de, .DefenderStringHalfDamage2
	hlcoord 1, 11
	call PlaceString

	ld de, .DefenderStringDoubleDamage1
	hlcoord 1, 12
	call PlaceString

	ld de, .DefenderStringDoubleDamage2
	hlcoord 1, 13
	jmp PlaceString

.TypeString:
	db "Ice Type@"
.AttackerString:
	db "Attacker:@"
.AttackerStringHalfDamage1:
	db "<half>× Fire/Water/Ice@"
.AttackerStringHalfDamage2:
	db "   Steel@"
.AttackerStringDoubleDamage1:
	db "2× Grass, Ground@"
.AttackerStringDoubleDamage2:
	db "   Flying & Dragon@"

.DefenderString:
	db "Defender:@"
.DefenderStringHalfDamage1:
	db "<half>× Ice/Water/@"
.DefenderStringHalfDamage2:
	db "   Electric@"
.DefenderStringDoubleDamage1:
	db "2× Fire/Fight/@"
.DefenderStringDoubleDamage2:
	db "   Steel/Rock@"

NormalTypeChart:
	hlcoord 0, 0
	lb bc, 14, 18
	call Textbox

	ld de, .TypeString
	hlcoord 1, 1
	call PlaceString

	ld de, .AttackerString
	hlcoord 1, 3
	call PlaceString

	ld de, .AttackerStringZeroDamage
	hlcoord 1, 4
	call PlaceString

	ld de, .AttackerStringHalfDamage
	hlcoord 1, 5
	call PlaceString

	ld de, .DefenderString
	hlcoord 1, 7
	call PlaceString

	ld de, .DefenderStringZeroDamage
	hlcoord 1, 8
	call PlaceString

	ld de, .DefenderStringDoubleDamage
	hlcoord 1, 9
	jmp PlaceString

.TypeString:
	db "Normal Type@"
.AttackerString:
	db "Attacker:@"
.AttackerStringZeroDamage:
	db "0× Ghost@"
.AttackerStringHalfDamage:
	db "<half>× Rock/Steel@"

.DefenderString:
	db "Defender:@"
.DefenderStringZeroDamage:
	db "0× Ghost@"
.DefenderStringDoubleDamage:
	db "2× Poison/Fight@"

PoisonTypeChart:
	hlcoord 0, 0
	lb bc, 14, 18
	call Textbox

	ld de, .TypeString
	hlcoord 1, 1
	call PlaceString

	ld de, .AttackerString
	hlcoord 1, 3
	call PlaceString

	ld de, .AttackerStringHalfDamage1
	hlcoord 1, 4
	call PlaceString

	ld de, .AttackerStringHalfDamage2
	hlcoord 1, 5
	call PlaceString

	ld de, .AttackerStringZeroDamage
	hlcoord 1, 6
	call PlaceString

	ld de, .AttackerStringDoubleDamage1
	hlcoord 1, 7
	call PlaceString

	ld de, .AttackerStringDoubleDamage2
	hlcoord 1, 8
	call PlaceString


	ld de, .DefenderString
	hlcoord 1, 10
	call PlaceString

	ld de, .DefenderStringZeroDamage
	hlcoord 1, 11
	call PlaceString

	ld de, .DefenderStringHalfoDamage1
	hlcoord 1, 12
	call PlaceString

	ld de, .DefenderStringHalfoDamage2
	hlcoord 1, 13
	call PlaceString

	ld de, .DefenderStringDoubleDamage
	hlcoord 1, 14
	jmp PlaceString

.TypeString:
	db "Poison Type@"
.AttackerString:
	db "Attacker:@"
.AttackerStringHalfDamage1:
	db "<half>× Poison/Ground/@"
.AttackerStringHalfDamage2:
	db "   Rock@"
.AttackerStringZeroDamage:
	db "0× Steel@"
.AttackerStringDoubleDamage1:
	db "2× Grass/Fairy/@"
.AttackerStringDoubleDamage2:
	db "   Normal@"

.DefenderString:
	db "Defender:@"
.DefenderStringZeroDamage:
	db "0× Steel@"
.DefenderStringHalfoDamage1:
	db "<half>× Grass/Poison/@"
.DefenderStringHalfoDamage2:
	db "   Bug/Fighting@"
.DefenderStringDoubleDamage:
	db "2× Ground/Psychic@"

PsychicTypeChart:
	hlcoord 0, 0
	lb bc, 14, 18
	call Textbox

	ld de, .TypeString
	hlcoord 1, 1
	call PlaceString

	ld de, .AttackerString
	hlcoord 1, 3
	call PlaceString

	ld de, .AttackerStringZeroDamage
	hlcoord 1, 4
	call PlaceString

	ld de, .AttackerStringHalfDamage1
	hlcoord 1, 5
	call PlaceString

	ld de, .AttackerStringHalfDamage2
	hlcoord 1, 6
	call PlaceString

	ld de, .AttackerStringDoubleDamage
	hlcoord 1, 7
	call PlaceString

	ld de, .DefenderString
	hlcoord 1, 9
	call PlaceString

	ld de, .DefenderStringHalfDamage
	hlcoord 1, 10
	call PlaceString

	ld de, .DefenderStringDoubleDamage
	hlcoord 1, 11
	jmp PlaceString

.TypeString:
	db "Psychic Type@"
.AttackerString:
	db "Attacker:@"
.AttackerStringZeroDamage:
	db "0× Dark@"
.AttackerStringHalfDamage1:
	db "<half>× Ghost/Steel/@"
.AttackerStringHalfDamage2:
	db "   Psychic@"
.AttackerStringDoubleDamage:
	db "2× Poison/Fight@"

.DefenderString:
	db "Defender:@"
.DefenderStringHalfDamage:
	db "<half>× Psychic/Fight@"
.DefenderStringDoubleDamage:
	db "2× Bug/Dark/Ghost@"

RockTypeChart:
	hlcoord 0, 0
	lb bc, 14, 18
	call Textbox

	ld de, .TypeString
	hlcoord 1, 1
	call PlaceString

	ld de, .AttackerString
	hlcoord 1, 3
	call PlaceString

	ld de, .AttackerStringHalfDamage1
	hlcoord 1, 4
	call PlaceString

	ld de, .AttackerStringHalfDamage2
	hlcoord 1, 5
	call PlaceString

	ld de, .AttackerStringDoubleDamage1
	hlcoord 1, 6
	call PlaceString

	ld de, .AttackerStringDoubleDamage2
	hlcoord 1, 7
	call PlaceString

	ld de, .DefenderString
	hlcoord 1, 9
	call PlaceString

	ld de, .DefenderStringHalfDamage1
	hlcoord 1, 10
	call PlaceString

	ld de, .DefenderStringHalfDamage2
	hlcoord 1, 11
	call PlaceString

	ld de, .DefenderStringDoubleDamage1
	hlcoord 1, 12
	call PlaceString

	ld de, .DefenderStringDoubleDamage2
	hlcoord 1, 13
	call PlaceString

	ld de, .DefenderStringDoubleDamage3
	hlcoord 1, 14
	jmp PlaceString

.TypeString:
	db "Rock Type@"
.AttackerString:
	db "Attacker:@"
.AttackerStringHalfDamage1:
	db "<half>× Ground/Steel/@"
.AttackerStringHalfDamage2:
	db "   Fight@"
.AttackerStringDoubleDamage1:
	db "2× Fire/Fly/Ice/@"
.AttackerStringDoubleDamage2:
	db "   Bug@"

.DefenderString:
	db "Defender:@"
.DefenderStringHalfDamage1:
	db "<half>× Normal/Fly/@"
.DefenderStringHalfDamage2:
	db "   Fire/Poison@"
.DefenderStringDoubleDamage1:
	db "2× Water/Grass/@"
.DefenderStringDoubleDamage2:
	db "   Steel/Ground/@"
.DefenderStringDoubleDamage3:
	db "   Fight@"

SteelTypeChart:
	hlcoord 0, 0
	lb bc, 14, 18
	call Textbox

	ld de, .TypeString
	hlcoord 1, 1
	call PlaceString

	ld de, .AttackerString
	hlcoord 1, 2
	call PlaceString

	ld de, .AttackerStringHalfDamage1
	hlcoord 1, 3
	call PlaceString

	ld de, .AttackerStringHalfDamage2
	hlcoord 1, 4
	call PlaceString

	ld de, .AttackerStringDoubleDamage
	hlcoord 1, 5
	call PlaceString

	ld de, .DefenderString
	hlcoord 1, 7
	call PlaceString

	ld de, .DefenderStringZeroDamage
	hlcoord 1, 8
	call PlaceString

	ld de, .DefenderStringHalfDamage1
	hlcoord 1, 9
	call PlaceString

	ld de, .DefenderStringHalfDamage2
	hlcoord 1, 10
	call PlaceString

	ld de, .DefenderStringHalfDamage3
	hlcoord 1, 11
	call PlaceString

	ld de, .DefenderStringHalfDamage4
	hlcoord 1, 12
	call PlaceString

	ld de, .DefenderStringDoubleDamage1
	hlcoord 1, 13
	call PlaceString

	ld de, .DefenderStringDoubleDamage2
	hlcoord 1, 14
	jmp PlaceString

.TypeString:
	db "Steel Type@"
.AttackerString:
	db "Attacker:@"
.AttackerStringHalfDamage1:
	db "<half>× Fire/Electric/@"
.AttackerStringHalfDamage2:
	db "   Steel/Water@"
.AttackerStringDoubleDamage:
	db "2× Ice/Fairy/Rock@"

.DefenderString:
	db "Defender:@"
.DefenderStringZeroDamage:
	db "0× Poison@"
.DefenderStringHalfDamage1:
	db "<half>× Normal/Psychic/@"
.DefenderStringHalfDamage2:
	db "   Ice/Bug,/Steel/@"
.DefenderStringHalfDamage3:
	db "   Rock/Grass/Fly/@"
.DefenderStringHalfDamage4:
	db "   Dragon/Fairy@"
.DefenderStringDoubleDamage1:
	db "2× Fire/Fight/@"
.DefenderStringDoubleDamage2:
	db "   Ground@"

WaterTypeChart:
	hlcoord 0, 0
	lb bc, 14, 18
	call Textbox

	ld de, .TypeString
	hlcoord 1, 1
	call PlaceString

	ld de, .AttackerString
	hlcoord 1, 3
	call PlaceString

	ld de, .AttackerStringHalfDamage1
	hlcoord 1, 4
	call PlaceString

	ld de, .AttackerStringHalfDamage2
	hlcoord 1, 5
	call PlaceString

	ld de, .AttackerStringDoubleDamage1
	hlcoord 1, 6
	call PlaceString

	ld de, .AttackerStringDoubleDamage2
	hlcoord 1, 7
	call PlaceString

	ld de, .DefenderString
	hlcoord 1, 9
	call PlaceString

	ld de, .DefenderStringHalfDamage1
	hlcoord 1, 10
	call PlaceString

	ld de, .DefenderStringHalfDamage2
	hlcoord 1, 11
	call PlaceString

	ld de, .DefenderStringDoubleDamage
	hlcoord 1, 12
	jmp PlaceString

.TypeString:
	db "Water Type@"
.AttackerString:
	db "Attacker:@"
.AttackerStringHalfDamage1:
	db "<half>× Water/Grass/@"
.AttackerStringHalfDamage2:
	db "   Dragon/Ice@"
.AttackerStringDoubleDamage1:
	db "2× Fire/Ground/@"
.AttackerStringDoubleDamage2:
	db "   Rock@"

.DefenderString:
	db "Defender:@"
.DefenderStringHalfDamage1:
	db "<half>× Fire/Steel/Ice/@"
.DefenderStringHalfDamage2:
	db "   Water@"
.DefenderStringDoubleDamage:
	db "2× Grass/Electric@"

TrainerBattleInfo::
	push hl
	push de
	push bc
	xor a
	ld [wTrainerInfoPage], a
	call UpdatePageText
	call StatsInfoBox
	call WaitButtonInfoTrainer
	jmp PopBCDEHL
	
StatChangesInfoBox:
	hlcoord 0, 0
	ld b, 14
	ld c, 8
	call Textbox
	ld b, 14
	ld c, 8
	hlcoord 10, 0
	call Textbox
	
	hlcoord 1, 0
	ld de, MainText.player
	call PlaceString
	ld de, StatTexts.attack
	ld b, 1
	ld c, 2
	ld hl, wPlayerStatLevels
	call StatChangesInfoBoxLoop
	
	hlcoord 11, 0
	ld de, MainText.enemy
	call PlaceString
	ld de, StatTexts.attack
	ld b, 11
	ld c, 2
	ld hl, wEnemyStatLevels
	; fallthrough
	
StatChangesInfoBoxLoop:
	push hl
	call CoordsBCtoHL
	ld a, c
	cp 16
	jr nc, .finish
	push bc
	call PlaceString
	pop bc
	ld a, b
	add 6				; b = 7 or 17
	ld b, a
	pop hl
	call PrintStatChangeValue
	inc hl				; hl = StatLevel + 1
	inc de				; de gets increased to the end of the string in PlaceString, so increase it 1 more for the next string
	ld a, b
	sub 6
	ld b, a
	inc c
	inc c
	jr StatChangesInfoBoxLoop
.finish
	pop hl
	ret

PrintStatChangeValue: ; Input is hl (either wPlayerStatX or wEnemyStatX) and bc (coords to place text)
	push de
	push hl
	push bc
	ld de, wStringBuffer4
	ld a, TX_START
	ld [de], a
	inc de
	ld a, [hl]  	; Stat
	ld c, a
	cp 7			; 7 = no changes
	jr c, .lowered
	jr z, .same
	ld a, "▲"
	ld [de], a
	inc de
	ld a, c
	sub 7			; a = a - 7
	jr .insert
.same
	ld a, "▲"
	ld [de], a
	inc de
	xor a
	jr .insert
.lowered
	ld a, "▼"
	ld [de], a
	inc de
	ld a, 7
	sub c
.insert
	add "0"
	ld [de], a
	ld a, TX_END
	inc de
	ld [de], a		; Terminate string
	inc de
	ld [de], a		; Terminate string
	ld hl, wStringBuffer4
	pop bc
	push bc
	push hl
	call CoordsBCtoHL
	ld b, h
	ld c, l
	pop hl
	call PrintTextboxTextAt
	pop bc
	pop hl
	pop de
	ret

StatsInfoBox:
	hlcoord 0, 0
	ld b, 14
	ld c, 8
	call Textbox
	ld b, 14
	ld c, 8
	hlcoord 10, 0
	call Textbox

	hlcoord 1, 0
	ld de, MainText.player
	call PlaceString
	ld de, StatTexts
	ld b, 1
	ld c, 2
	ld hl, wBattleMonMaxHP
	call StatsInfoBoxLoop
	
	hlcoord 11, 0
	ld de, MainText.enemy
	call PlaceString
	ld de, StatTexts
	ld b, 11
	ld c, 2
	ld hl, wEnemyMonMaxHP
	jp StatsInfoBoxLoop

FoeAbilityPageInfoBox:
	hlcoord 0, 0
	ld b, 14
	ld c, 18
	call Textbox
	ld b, 14
	ld c, 18

	hlcoord 0, 0
	ld b, 2
	ld c, 18
	call Textbox

	farcall DisplayFoeNameAndAbility

	ld de, .FoeString
	hlcoord 1, 1
	call PlaceString

	ld de, .AbilitiesString
	hlcoord 1, 5
	jp PlaceString

.FoeString:
	db "Foe:@"
.AbilitiesString:
	db "Ability Info:@"

StatsInfoBoxLoop:
	push hl
	call CoordsBCtoHL
	ld a, c
	cp 14
	jr nc, .finish
	push bc
	call PlaceString
	pop bc
	ld a, b
	add 4				; b = 6 or 16
	ld b, a
	pop hl
	push de
	ld d, h
	ld e, l
	push hl
	call CoordsBCtoHL
	push bc
	lb bc, 2, 4
	call PrintNum
	pop bc
	pop hl
	pop de
	inc hl
	inc hl
	inc de				; de gets increased to the end of the string in PlaceString, so increase it 1 more for the next string
	ld a, b
	sub 4
	ld b, a
	inc c
	inc c
	jr StatsInfoBoxLoop
.finish
	pop hl
	ret

FieldStatusPagesLayout:
	hlcoord 0, 0
	ld b, 2
	ld c, 18
	call Textbox
	ld b, 10
	ld c, 8
	hlcoord 0, 4
	call Textbox
	ld b, 10
	ld c, 8
	hlcoord 10, 4
	call Textbox
.weather
	hlcoord 6, 0
	ld de, FieldTexts.weather
	call PlaceString
	ld a, [wBattleWeather]
	cp WEATHER_HAIL
	ld de, FieldTexts.hail
	jr z, .done
	cp WEATHER_SUN
	ld de, FieldTexts.sun
	jr z, .done
	cp WEATHER_RAIN
	ld de, FieldTexts.rain
	jr z, .done
	cp WEATHER_SANDSTORM
	ld de, FieldTexts.sand
	jr z, .done
	ld de, FieldTexts.none
.done
	hlcoord 1, 1
	call PlaceString
	ld a, [wBattleWeather]
	cp WEATHER_NONE
	jr z, .skip_weather_turns
	ld de, wStringBuffer5
	ld a, [wWeatherCount]
	cp 10
	ld de, FieldTexts.infinite
	jr nc, .not_1_turn
	ld a, [wWeatherCount]
	add "0"
	ld [de], a
	ld a, TX_END
	inc de
	ld [de], a
	ld de, wStringBuffer5
	hlcoord 1, 2
	call PlaceString
	ld a, [wWeatherCount]
	cp 1
	ld de, FieldTexts.turnsleft
	jr nz, .not_1_turn
	ld de, FieldTexts.turnleft
.not_1_turn
	hlcoord 2, 2
	call PlaceString
.skip_weather_turns
	hlcoord 1, 4
	ld de, MainText.player
	call PlaceString	
	hlcoord 11, 4
	ld de, MainText.enemy
	call PlaceString
	lb bc, 1, 5
	ret

FieldInfoBox1:
	call FieldStatusPagesLayout

; spikes
	lb bc, 1, 5
	ld de, FieldTexts.spikes
	call FieldInfoBox1Spikes

; toxic spikes
	lb bc, 1, 6
	ld de, FieldTexts.toxicspikes
	call FieldInfoBox1ToxicSpikes

; sticky web
	lb bc, 1, 7
	ld de, FieldTexts.stickyweb
	call FieldInfoBox1StickyWeb

; stealth rock
	lb bc, 1, 8
	ld de, FieldTexts.stealthrock
	call FieldInfoBox1StealthRock

; toxic
.player_toxic
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_TOXIC, a
	jr z, .enemy_toxic
	lb bc, 1, 9
	ld de, wPlayerToxicCount
	call FieldInfoBox1Toxic
.enemy_toxic
	ld a, [wEnemySubStatus5]
	bit SUBSTATUS_TOXIC, a
	jr z, .handle_reflect
	lb bc, 11, 9
	ld de, wEnemyToxicCount
	call FieldInfoBox1Toxic

.handle_reflect
; reflect
	lb bc, 1, 11
	call FieldInfoBox1Reflect
; light screen
	lb bc, 1, 13
	jp FieldInfoBox1LScreen

FieldInfoBox2:
	call FieldStatusPagesLayout

; trick room
	lb bc, 1, 5
	call FieldInfoBox2TrickRoom

; safeguard
	lb bc, 1, 7
	call FieldInfoBox2Safeguard

; confused
	ld de, FieldTexts.confused
	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_CONFUSED, a
	jr z, .enemy_confuse
	lb bc, 1, 9
	call FieldInfoBoxStatus
.enemy_confuse
	ld a, [wEnemySubStatus3]
	bit SUBSTATUS_CONFUSED, a
	jr z, .player_encore
	lb bc, 11, 9
	call FieldInfoBoxStatus

; encored
.player_encore
	ld de, FieldTexts.encored
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_ENCORED, a
	jr z, .enemy_encore
	lb bc, 1, 10
	call FieldInfoBoxStatus
.enemy_encore
	ld a, [wEnemySubStatus5]
	bit SUBSTATUS_ENCORED, a
	jr z, .player_disable
	lb bc, 11, 10
	call FieldInfoBoxStatus

; disabled
.player_disable
	ld de, FieldTexts.disabled
	ld a, [wDisabledMove]
	and a
	jr z, .enemy_disable
	lb bc, 1, 11
	call FieldInfoBoxStatus
.enemy_disable
	ld a, [wEnemyDisabledMove]
	and a
	jr z, .player_taunt
	lb bc, 11, 11
	call FieldInfoBoxStatus

; taunt
.player_taunt
    ld de, FieldTexts.taunt
    ld a, [wPlayerTauntCount]
    and a
    jr z, .enemy_taunt
    lb bc, 1, 12
    call FieldInfoBoxStatus
.enemy_taunt
    ld a, [wEnemyTauntCount]
    and a
    ret z
    lb bc, 11, 12
    jp FieldInfoBoxStatus

FieldInfoBox1Reflect: ; input: bc -> coords
	ld hl, wPlayerScreens
	ld de, wPlayerReflectCount
	bit 4, [hl]
	jr z, .enemy
	ld hl, FieldTexts.reflect
	push bc
	call FieldInfoBoxPlaceElement
	pop bc
.enemy
	ld hl, wEnemyScreens
	ld de, wEnemyReflectCount
	bit 4, [hl]
	ret z
	ld a, b
	add 10
	ld b, a
	ld hl, FieldTexts.reflect
	jp FieldInfoBoxPlaceElement
	
FieldInfoBox1LScreen: ; input: bc -> coords
	ld hl, wPlayerScreens
	ld de, wPlayerLightScreenCount
	bit 3, [hl]
	jr z, .enemy
	ld hl, FieldTexts.lightscreen
	push bc
	call FieldInfoBoxPlaceElement
	pop bc
.enemy
	ld hl, wEnemyScreens
	ld de, wEnemyLightScreenCount
	bit 3, [hl]
	ret z
	ld a, b
	add 10
	ld b, a
	ld hl, FieldTexts.lightscreen
	jp FieldInfoBoxPlaceElement

FieldInfoBox1Spikes: ; input: bc -> coords
	ld hl, wPlayerScreens
	bit 0, [hl]
	jr z, .enemy
	push de
	call CoordsBCtoHL
	push bc
	call PlaceString
	pop bc
	pop de
.enemy
	ld hl, wEnemyScreens
	bit 0, [hl]
	ret z
	ld a, b
	add 10
	ld b, a
	call CoordsBCtoHL
	jp PlaceString

FieldInfoBox1ToxicSpikes: ; input: bc -> coords
	ld hl, wPlayerScreens
	bit 6, [hl]
	jr z, .enemy
	push de
	call CoordsBCtoHL
	push bc
	call PlaceString
	pop bc
	pop de
.enemy
	ld hl, wEnemyScreens
	bit 6, [hl]
	ret z
	ld a, b
	add 10
	ld b, a
	call CoordsBCtoHL
	jp PlaceString

FieldInfoBox1StickyWeb: ; input: bc -> coords
	ld hl, wPlayerScreens
	bit 7, [hl]
	jr z, .enemy
	push de
	call CoordsBCtoHL
	push bc
	call PlaceString
	pop bc
	pop de
.enemy
	ld hl, wEnemyScreens
	bit 7, [hl]
	ret z
	ld a, b
	add 10
	ld b, a
	call CoordsBCtoHL
	jp PlaceString

FieldInfoBox1StealthRock: ; input: bc -> coords
	ld hl, wPlayerScreens
	bit 5, [hl]
	jr z, .enemy
	push de
	call CoordsBCtoHL
	push bc
	call PlaceString
	pop bc
	pop de
.enemy
	ld hl, wEnemyScreens
	bit 5, [hl]
	ret z
	ld a, b
	add 10
	ld b, a
	call CoordsBCtoHL
	jp PlaceString

FieldInfoBox2TrickRoom: ; input: bc -> coords
	ld de, wTrickRoomCount
	ld a, [de]
    and a
	ret z
	ld hl, FieldTexts.trickroom
	push bc
	call FieldInfoBoxPlaceElement
	pop bc
.enemy
	ld a, b
	add 10
	ld b, a
	ld de, wTrickRoomCount
	ld hl, FieldTexts.trickroom
	jp FieldInfoBoxPlaceElement

FieldInfoBox2Safeguard:
	ld hl, wPlayerScreens
	ld de, wPlayerSafeguardCount
	bit 2, [hl]
	jr z, .enemy
	ld hl, FieldTexts.safeguard
	push bc
	call FieldInfoBoxPlaceElement
	pop bc
.enemy
	ld hl, wEnemyScreens
	ld de, wEnemySafeguardCount
	bit 2, [hl]
	ret z
	ld a, b
	add 10
	ld b, a
	ld hl, FieldTexts.safeguard
	jp FieldInfoBoxPlaceElement

FieldInfoBoxStatus: ; input: bc -> coords, de -> text
	push de
	call CoordsBCtoHL
	call PlaceString
	pop de
	ret
	
FieldInfoBox1Toxic: ; input: bc -> coords , de -> count
	ld hl, FieldTexts.toxic
	push hl
	push bc
	call FieldInfoBoxPlaceElement
	pop bc
	pop hl
	ret
	
FieldInfoBoxPlaceElement: ; input: bc -> coords, hl -> Field text, de -> Count
	push de
	ld d, h
	ld e, l
	call CoordsBCtoHL
	push bc
	call PlaceString
	pop bc
	inc c
	call CoordsBCtoHL
	pop de
	push de
	ld a, [de]
	ld de, wStringBuffer5
	add "0"
	ld [de], a
	ld a, TX_END
	inc de
	ld [de], a
	dec de
	push bc
	call PlaceString
	pop bc
	pop de
	ld a, [de]
	cp 1
	ld de, FieldTexts.turns
	jr nz, .not_1_turn
	ld de, FieldTexts.turn
.not_1_turn
	inc b
	call CoordsBCtoHL
	jp PlaceString

MainText:
.page1:
	db "◀ Page 1/5 ▶@"
.page1_content:
	db " Stat Changes @"

.page2:
	db "◀ Page 2/5 ▶@"
.page2_content:
	db " Actual Stats @"

.page3:
	db "◀ Page 3/5 ▶@"
.page3_content:
	db "Field/Status 1@"

.page4:
	db "◀ Page 4/5 ▶@"
.page4_content:
	db "Field/Status 2@"

.page5:
	db "◀ Page 5/5 ▶@"
.page5_content:
	db "   Ability    @"

.player:
	db " Player @"
	
.enemy:
	db " Enemy @"

StatTexts:
.health:
	db "HP:  @"

.attack:
	db "Atk: @"

.defense:
	db "Def: @"

.speed:
	db "Spe: @"
	
.sattack:
	db "SAtk:@"
	
.sdefense:
	db "SDef:@"
	
.accuracy:
	db "Acc: @"
	
.evasiveness:
	db "Eva:@"

FieldTexts:
.weather:
	db " Weather@"
	
.none:
	db "Normal@"
	
.sun:
	db "Sunny@"

.rain:
	db "Raining@"
	
.sand:
	db "Sandstorm@"
	
.hail:
	db "Hail@"
	
.spikes:
	db "Spikes@"

.toxicspikes:
	db "T.Spikes@"

.stickyweb:
	db "S.Web@"

.stealthrock:
	db "S.Rock@"

.toxic:
	db "Toxic@"

.reflect:
	db "Reflect@"
	
.lightscreen:
	db "L.Screen@"

.trickroom:
	db "T.Room@"

.safeguard:
	db "S.Guard@"

.confused:
	db "Confused@"
	
.encored:
	db "Encored@"
	
.disabled:
	db "Disabled@"

.taunt:
	db "Taunt@"

.turnsleft:
	db " turns left@"

.turnleft:
	db " turn left@"

.infinite:
	db "@"
	
.turns:
	db " turns@"

.turn:
	db " turn@"

JoyWaitAorBorDPADInfoTrainer:
.loop
	call DelayFrame
	call GetJoypad
	ldh a, [hJoyPressed]
	and A_BUTTON | B_BUTTON
	ret nz
	ldh a, [hJoyPressed]
	and D_RIGHT
	call nz, InfoBoxRightPress
	ldh a, [hJoyPressed]
	and D_LEFT
	call nz, InfoBoxLeftPress
	call UpdateTimeAndPals
	jr .loop

WaitButtonInfoTrainer:
	ldh a, [hOAMUpdate]
	push af
	ld a, 1
	ldh [hOAMUpdate], a
	call WaitBGMap
	call JoyWaitAorBorDPADInfoTrainer
	pop af
	ldh [hOAMUpdate], a
	ret
	
; ========================
; Left button navigation
; ========================
InfoBoxLeftPress:
	; play switching pockets SFX	
	ld de, SFX_SWITCH_POCKETS
	call PlaySFX

	ld a, [wTrainerInfoPage]
	and a
	jr z, .jump_to_page_5
	cp 1
	jr z, .jump_to_page_1
	cp 2
	jr z, .jump_to_page_2
	cp 3
	jr z, .jump_to_page_3
	cp 4
	ret nz
.jump_to_page_4
	call DecreasePage
	call UpdatePageText
	jp FieldInfoBox2

.jump_to_page_1
	call DecreasePage
	call UpdatePageText
	jp StatsInfoBox

.jump_to_page_2
	call DecreasePage
	call UpdatePageText
	jp StatChangesInfoBox

.jump_to_page_3
	call DecreasePage
	call UpdatePageText
	jp FieldInfoBox1

.jump_to_page_5
	call DecreasePage
	call UpdatePageText
	jp FoeAbilityPageInfoBox

; ========================
; Right button navigation
; ========================
InfoBoxRightPress:
	; play switching pockets SFX	
	ld de, SFX_SWITCH_POCKETS
	call PlaySFX

	ld a, [wTrainerInfoPage]
	and a
	jr z, .jump_to_page_2
	cp 1
	jr z, .jump_to_page_3
	cp 2
	jr z, .jump_to_page_4
	cp 3
	jr z, .jump_to_page_5
	call IncreasePage
	call UpdatePageText
	jp StatsInfoBox

.jump_to_page_5
	call IncreasePage
	call UpdatePageText
	jp FoeAbilityPageInfoBox

.jump_to_page_1
	call IncreasePage
	call UpdatePageText
	jp StatsInfoBox

.jump_to_page_2
	call IncreasePage
	call UpdatePageText
	jp StatChangesInfoBox

.jump_to_page_3
	call IncreasePage
	call UpdatePageText
	jp FieldInfoBox1

.jump_to_page_4
	call IncreasePage
	call UpdatePageText
	jp FieldInfoBox2

; ========================
; Page counter functions
; ========================
IncreasePage:
	ld a, [wTrainerInfoPage]
	inc a
	cp 5                     ; Pages 0..5 (inclusive)
	jr c, .store
	xor a                    ; Wrap to page 0
.store
	ld [wTrainerInfoPage], a
	ret

DecreasePage:
	ld a, [wTrainerInfoPage]
	or a
	jr nz, .dec
	ld a, 5                  ; Wrap to last page
.dec
	dec a
	ld [wTrainerInfoPage], a
	ret

; ========================
; Update text for each page
; ========================
UpdatePageText:
	hlcoord 4, 17
	ld a, [wTrainerInfoPage]

	cp 1
	jr z, .page_2
	cp 2
	jr z, .page_3
	cp 3
	jr z, .page_4
	cp 4
	jr z, .page_5

; Default: page 0
	ld de, MainText.page1
	call PlaceString
	ld de, MainText.page1_content
	jr .done

.page_2
	ld de, MainText.page2
	call PlaceString
	ld de, MainText.page2_content
	jr .done

.page_3
	ld de, MainText.page3
	call PlaceString
	ld de, MainText.page3_content
	jr .done

.page_4
	ld de, MainText.page4
	call PlaceString
	ld de, MainText.page4_content
	jr .done

.page_5
	ld de, MainText.page5
	call PlaceString
	ld de, MainText.page5_content
.done
	hlcoord 4, 16
	jp PlaceString

CoordsBCtoHL:
	ld hl, wTilemap
	ld a, c
	push bc
	ld c, SCREEN_WIDTH
	call HLMultiply
	pop bc
	ld a, b
	add l
	ld l, a
	ret nc
	inc h
	ret

HLMultiply:
; Returns hl + a * c
	and a
	ret z
	
	push bc
	ld b, a
	xor a
.loop
	add c
	jr nc, .nocarry
	inc h
.nocarry
	dec b
	jr nz, .loop
	ld c, a
	add hl, bc
	pop bc
	ret
