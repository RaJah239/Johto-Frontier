RunMapSetupScript::
	ldh a, [hMapEntryMethod]
	and $f
	dec a
	ld c, a
	ld b, 0
	ld hl, MapSetupScripts
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jmp ReadMapSetupScript

INCLUDE "data/maps/setup_scripts.asm"

ReadMapSetupScript:
.loop
	ld a, [hli]
	cp -1 ; end?
	ret z

	push hl

	ld c, a
	ld b, 0
	ld hl, MapSetupCommands
	add hl, bc
	add hl, bc
	add hl, bc

	; bank
	ld b, [hl]
	inc hl

	; address
	ld a, [hli]
	ld h, [hl]
	ld l, a

	; Bit 7 of the bank indicates a parameter.
	; This is left unused.
	bit 7, b
	jr z, .go

	pop de
	ld a, [de]
	ld c, a
	inc de
	push de

.go
	ld a, b
	and $7f
	rst FarCall

	pop hl
	jr .loop

INCLUDE "data/maps/setup_script_pointers.asm"

EnableTextAcceleration:
	xor a
	ld [wDisableTextAcceleration], a
	ret

ActivateMapAnims:
	ld a, TRUE
	ldh [hMapAnims], a
	ret

SuspendMapAnims:
	xor a ; FALSE
	ldh [hMapAnims], a
	ret

LoadMapObjects:
	call HandleAutoBicycle
	ld a, MAPCALLBACK_OBJECTS
	call RunMapCallback
	farcall LoadObjectMasks
	farcall InitializeVisibleSprites
	; Map callbacks can override the default weather.
	newfarcall SetCurrentWeather
	newfarcall SelectWeatherObjPalette
	farjp LoadWeatherGraphics

; the weather is re-rolled each time you reach a new outdoor
; map, so it stays the same when entering and leaving
; buildings within a map.
HandleMapDefaultWeather:
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call GetMapEnvironment
	cp ROUTE
	jr z, .outdoor
	cp TOWN
	jr z, .outdoor
; buildings are clear; the outdoor weather is remembered for
; when you head back outside.
	ld a, WEATHER_NONE
	jr .done

.outdoor
; re-roll only when this is a different outdoor map than the
; last one, so the weather is stable across a building visit.
	ld a, [wMapGroup]
	ld hl, wLastWeatherMapGroup
	cp [hl]
	jr nz, .roll
	ld a, [wMapNumber]
	ld hl, wLastWeatherMapNumber
	cp [hl]
	jr z, .same_map
.roll
	ld a, [wMapGroup]
	ld [wLastWeatherMapGroup], a
	ld a, [wMapNumber]
	ld [wLastWeatherMapNumber], a
; outdoor maps: 35% rain, 35% sun, 30% clear.
	call Random
	cp 35 percent ; 35% for rain
	jr c, .rain
	cp 70 percent ; 35% for sun
	jr c, .sun
.none ; 30% no weather
	ld a, WEATHER_NONE
	jr .save_group

.rain
	ld a, WEATHER_RAIN
	jr .save_group

.sun
	ld a, WEATHER_SUN
.save_group
	ld [wGroupWeather], a
.same_map
; Apply the map's weather; sun becomes clear at night.
	ld a, [wGroupWeather]
	cp WEATHER_SUN
	jr nz, .done
; Sun becomes clear weather at night.
	ld a, [wTimeOfDay]
	cp NITE_F
	jr z, .clear
	ld a, WEATHER_SUN
	jr .done

.clear
	ld a, WEATHER_NONE
.done
	ld [wFieldWeather], a
	ret

HandleAutoBicycle:
	; check if Auto Bicycle is turned on
	ld a, [wOptions2]
	bit AUTO_BICYCLE, a
	ret z

	; check if we own the Bicycle
	ld a, BICYCLE
	ld [wCurItem], a
	ld hl, wNumItems
	call CheckItem
	ret nc

	; don't use the bike on water tiles
	; ensure we aren't on a water tile like between
	; newbark town and route 27
	; or between route 40, 41 and cianwood city
	call IsOnWaterTile
	ret c

	; get on the bike in every environment except indoors
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call GetMapEnvironment
	cp ROUTE
	jr z, .HopOnBike
	cp TOWN
	jr z, .HopOnBike
	cp CAVE
	jr z, .HopOnBike
	cp GATE
	jr z, .HopOnBike
	cp DUNGEON
	jr z, .HopOnBike
	ret nc
.HopOnBike
	push bc
	ld a, PLAYER_BIKE
	ld [wPlayerState], a
	call UpdatePlayerSprite ; UpdateSprites
	pop bc
	ret

IsOnWaterTile::
	ld a, [wPlayerTileCollision]
	and $f0
	cp HI_NYBBLE_CURRENT
	jr z, .water
	cp HI_NYBBLE_WALK
	jr z, .not_water
	cp HI_NYBBLE_WALK_ALT
	jr z, .not_water
	cp HI_NYBBLE_WARPS
	jr z, .not_water
.water
	scf         ; set carry flag = TRUE (on water)
	ret
.not_water
	xor a
	ret         ; carry clear = FALSE (not on water)

ResetPlayerObjectAction:
	ld hl, wPlayerSpriteSetupFlags
	set PLAYERSPRITESETUP_RESET_ACTION_F, [hl]
	ret

SkipUpdateMapSprites:
	ld hl, wPlayerSpriteSetupFlags
	set PLAYERSPRITESETUP_SKIP_RELOAD_GFX_F, [hl]
	ret

CheckUpdatePlayerSprite:
	call .CheckForcedBiking
	jmp c, UpdatePlayerSprite
	call .CheckSurfing
	jmp c, UpdatePlayerSprite
	call .ResetSurfingOrBikingState
	jmp c, UpdatePlayerSprite
	ret

.CheckForcedBiking:
	and a
	ld hl, wBikeFlags
	bit BIKEFLAGS_ALWAYS_ON_BIKE_F, [hl]
	ret z
	ld a, PLAYER_BIKE
	ld [wPlayerState], a
	scf
	ret

.ResetSurfingOrBikingState:
	ld a, [wPlayerState]
	cp PLAYER_NORMAL
	jr z, .nope
	cp PLAYER_SKATE
	jr z, .nope
	cp PLAYER_SURF
	jr z, .surfing
	cp PLAYER_SURF_PIKA
	jr z, .surfing
	call GetMapEnvironment
	cp INDOOR
	jr z, .no_biking
	cp ENVIRONMENT_5
	jr z, .no_biking
	cp DUNGEON
	jr z, .no_biking
	jr .nope
.no_biking
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	jr nz, .nope
.surfing
	ld a, PLAYER_NORMAL
	ld [wPlayerState], a
	scf
	ret

.nope
	and a
	ret

.CheckSurfing:
	call CheckOnWater
	jr nz, .nope2
	ld a, [wPlayerState]
	cp PLAYER_SURF
	jr z, .is_surfing
	cp PLAYER_SURF_PIKA
	jr z, .is_surfing
	ld a, PLAYER_SURF
	ld [wPlayerState], a
.is_surfing
	scf
	ret

.nope2
	and a
	ret

FadeOutMapMusic:
	ld a, 6
	jmp SkipMusic

ApplyMapPalettes:
	farjp _UpdateTimePals

FadeMapMusicAndPalettes:
	xor a
	ld [wMusicFadeID], a
	ld [wMusicFadeID + 1], a
	ld a, $4
	ld [wMusicFade], a
	farjp FadeOutPalettes

ForceMapMusic:
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	jr nz, .notbiking
	call MinVolume
	ld a, $88
	ld [wMusicFade], a
.notbiking
	jmp TryRestartMapMusic

DecompressMetatiles:
; Decompress the current tileset's metatile and attribute tables into WRAM,
; so _LoadOverworldTilemap can draw the screen directly from them.
; Both tables only depend on the tileset, so they are decompressed once:
; entering a map that uses the tileset already in WRAM (route to route, or
; reloading after a battle) skips this work, which keeps connections seamless.
	ldh a, [hDecompressedTileset]
	ld hl, wMapTileset
	cp [hl]
	ret z

	ld a, [hl]
	ldh [hDecompressedTileset], a
	ld hl, wTilesetBlocksBank
	ld c, BANK(wDecompressedMetatiles)
	ld de, wDecompressedMetatiles
	call .Decompress

	ld hl, wTilesetAttributesBank
	ld c, BANK(wDecompressedAttributes)
	ld de, wDecompressedAttributes

.Decompress:
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [rSVBK]
	push af
	ld a, c
	ld [rSVBK], a
	ld a, b
	ld bc, $1000
	call FarDecompress
	pop af
	ld [rSVBK], a
	ret
