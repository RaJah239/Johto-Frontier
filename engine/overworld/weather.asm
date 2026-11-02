; Overworld rain, snow/hail, and sandstorm particles
; Weather uses free OAM entries from the end so map objects keep priority.

UpdateOverworldWeatherFrame::
	call DoOverworldWeather
	call SunShimmerFrame
	jp WeatherFadeStep

DoOverworldWeather::
; Preserves bc, de, and hl
	push hl
	push de
	push bc

	call GetActiveOverworldWeather
	ld b, a
	ld a, [wOverworldWeatherCooldown]
	or b
	jr z, .done ; no weather and nothing left falling
	call ClearReservedWeatherSprites

	ld hl, wWeatherFlags
	bit WEATHER_PAUSED_F, [hl]
	jr nz, .done

	; Run weather at 30 fps.
	ld a, [wOverworldWeatherTimer]
	and 1
	jr z, .done

	; Starting a step redraws the map, and that plus a weather tick in the
	; same frame doesn't fit: the walk stutters. When the next frame will
	; probably start a step (the player just finished one, or is standing
	; with the d-pad held), skip this frame without advancing the timer so
	; the tick runs on the next frame instead. Never skip twice in a row,
	; or the weather would freeze while walking into a wall.
	bit WEATHER_SKIPPED_FRAME_F, [hl]
	res WEATHER_SKIPPED_FRAME_F, [hl]
	jr nz, .no_skip
	ld a, [wPlayerStepFlags]
	bit PLAYERSTEP_STOP_F, a
	jr nz, .skip
	and a
	jr nz, .no_skip
	ldh a, [hJoyDown]
	and D_PAD
	jr z, .no_skip
.skip
	set WEATHER_SKIPPED_FRAME_F, [hl]
	jr .skip_frame

.no_skip
	ld a, [wWeatherPalSlot]
	cp NUM_OVERWORLD_OBJ_PALETTES
	jr nc, .no_palette

	call EnsureWeatherObjectPalette

	ld a, [wOverworldWeatherCooldown]
	and a
	jr nz, .on_cooldown

	call GetOverworldWeatherType
	ld hl, .SpawnAndFall
	call JumpTable
	jr .done

.on_cooldown
	; Let the old particles finish falling.
	dec a
	ld [wOverworldWeatherCooldown], a
	jr z, .cooldown_over
	ld a, [wPreviousFieldWeather]
	call TranslateFieldWeatherToOverworld
	ld hl, .FallOnly
	call JumpTable
	jr .done

.cooldown_over
	call ClearWeatherSprites
	ld a, [wFieldWeather]
	ld [wPreviousFieldWeather], a
	call LoadWeatherGraphics
	call EnsureWeatherObjectPalette
	jr .done

.no_palette
	; The allocator already cleared the old particles.
	ld a, [wFieldWeather]
	ld [wPreviousFieldWeather], a
	xor a
	ld [wOverworldWeatherCooldown], a

.done
	ld hl, wOverworldWeatherTimer
	inc [hl]
.skip_frame
	pop bc
	pop de
	pop hl
	ret

.SpawnAndFall:
	table_width 2
	dw DoNothing
	dw DoOverworldRain
	dw DoOverworldSnow
	dw DoOverworldSandstorm
	assert_table_length NUM_OVERWORLD_WEATHER_TYPES

.FallOnly:
	table_width 2
	dw DoNothing
	dw DoRainFall
	dw DoSnowFall
	dw DoSandFall
	assert_table_length NUM_OVERWORLD_WEATHER_TYPES

GetActiveOverworldWeather:
; Use the previous weather during cooldown.
	ld a, [wOverworldWeatherCooldown]
	and a
	ld a, [wPreviousFieldWeather]
	jp nz, TranslateFieldWeatherToOverworld
	; fallthrough

GetOverworldWeatherType::
	ld a, [wFieldWeather]
	; fallthrough

TranslateFieldWeatherToOverworld:
	cp WEATHER_HAIL + 1
	jr nc, .none
	push hl
	push de
	ld e, a
	ld d, 0
	ld hl, .FieldWeatherTypes
	add hl, de
	ld a, [hl]
	pop de
	pop hl
	and a
	ret
.none
	xor a
	ret

.FieldWeatherTypes:
	table_width 1
	db OVERWORLD_WEATHER_NONE      ; WEATHER_NONE
	db OVERWORLD_WEATHER_RAIN      ; WEATHER_RAIN
	db OVERWORLD_WEATHER_NONE      ; WEATHER_SUN
	db OVERWORLD_WEATHER_SANDSTORM ; WEATHER_SANDSTORM
	db OVERWORLD_WEATHER_SNOW      ; WEATHER_HAIL
	assert_table_length WEATHER_HAIL + 1

GetWeatherTint::
	ld a, [wFieldWeather]
	cp WEATHER_HAIL + 1
	jr nc, .none
	push hl
	push de
	ld e, a
	ld d, 0
	ld hl, .FieldWeatherTints
	add hl, de
	ld a, [hl]
	pop de
	pop hl
	and a
	ret
.none
	xor a
	ret

.FieldWeatherTints:
	table_width 1
	db WEATHER_TINT_NONE      ; WEATHER_NONE
	db WEATHER_TINT_RAIN      ; WEATHER_RAIN
	db WEATHER_TINT_SUN       ; WEATHER_SUN
	db WEATHER_TINT_SANDSTORM ; WEATHER_SANDSTORM
	db WEATHER_TINT_SNOW      ; WEATHER_HAIL
	assert_table_length WEATHER_HAIL + 1

; Map setup

SetCurrentWeather::
	ld a, [wPreviousFieldWeather]
	ld b, a
	ld a, [wFieldWeather]
	cp b
	ret z ; same weather continues across the map change

	ld a, b
	call TranslateFieldWeatherToOverworld
	jr z, .start_now
	ld a, OVERWORLD_WEATHER_COOLDOWN
	ld [wOverworldWeatherCooldown], a
	ret

.start_now
	ld a, [wFieldWeather]
	ld [wPreviousFieldWeather], a
	xor a
	ld [wOverworldWeatherCooldown], a
	call LoadWeatherGraphics
	jp EnsureWeatherObjectPalette

ClearWeather::
	call GetActiveOverworldWeather
	jr z, .no_particles
	call ClearWeatherSprites
.no_particles
	xor a
	ld [wWeatherFlags], a
	ld [wOverworldWeatherTimer], a
	ld [wOverworldWeatherCooldown], a
	ld [wWeatherFadeSteps], a
	ld [wWeatherFadeFrame], a
	ld [wPreviousFieldWeather], a
	ld [wPalTintWeather], a
	ld [wPrevPalTintWeather], a
	ld a, WEATHER_PAL_SLOT_NONE
	ld [wWeatherPalSlot], a
	ret

SetWeatherPaletteSlot::
; a = physical OBJ palette, or WEATHER_PAL_SLOT_NONE
	push bc
	cp NUM_OVERWORLD_OBJ_PALETTES
	jr c, .valid
	ld a, WEATHER_PAL_SLOT_NONE
.valid
	ld b, a
	ld a, [wWeatherPalSlot]
	cp b
	jr z, .done
	call ClearWeatherSprites
	ld a, b
	ld [wWeatherPalSlot], a
.done
	pop bc
	ret

SelectWeatherObjPalette::
; Pick a physical OBJ palette slot for the weather particles that no
; object is using. CheckForUsedObjPals reserves the slot afterwards,
; so the dynamic allocator will never hand it to an object.
	push bc
	push de
	push hl
	call GetActiveOverworldWeather
	jr nz, .active

.no_particles
	ld a, WEATHER_PAL_SLOT_NONE
	jr .select

.active
	; Keep the current slot across connections when possible.
	ld a, [wWeatherPalSlot]
	cp NUM_OVERWORLD_OBJ_PALETTES
	jr c, .select

	; Otherwise take the first slot no object is using.
	ld a, [wUsedObjectPals]
	cpl ; free slots now have set bits
	and a
	jr z, .no_free_slot
	ld b, -1
.find_free_slot
	inc b
	rrca
	jr nc, .find_free_slot
	ld a, b
	jr .select

.no_free_slot
	; Every slot is in use; run without particles for now.
	ld a, WEATHER_PAL_SLOT_NONE

.select
	call SetWeatherPaletteSlot
	pop hl
	pop de
	pop bc
	ret

ClearReservedWeatherSprites:
; Clear weather from OAM reserved by another field effect.
	ld a, [wStateFlags]
	bit LAST_12_SPRITE_OAM_STRUCTS_RESERVED_F, a
	ret z
	push hl
	push bc
	ld hl, wShadowOAM + (OAM_COUNT - 12) * OBJ_SIZE
	ld b, 12
.loop
	call IsWeatherSprite
	jr nz, .next
	push bc
	ld b, OBJ_SIZE
	xor a
.clear
	ld [hli], a
	dec b
	jr nz, .clear
	pop bc
	ld a, l
	sub OBJ_SIZE
	ld l, a
.next
	ld a, l
	add OBJ_SIZE
	ld l, a
	dec b
	jr nz, .loop
	pop bc
	pop hl
	ret

ClearWeatherSprites::
	push hl
	push bc
	ld hl, wShadowOAM
	ld b, NUM_SPRITE_OAM_STRUCTS
.loop
	call IsWeatherSprite
	jr nz, .next
	push bc
	ld b, SPRITEOAMSTRUCT_LENGTH
	xor a
.clear
	ld [hli], a
	dec b
	jr nz, .clear
	pop bc
	ld a, l
	sub SPRITEOAMSTRUCT_LENGTH
	ld l, a
.next
	ld a, l
	add SPRITEOAMSTRUCT_LENGTH
	ld l, a
	dec b
	jr nz, .loop
	pop bc
	pop hl
	ret

PauseWeather::
	ld hl, wWeatherFlags
	set WEATHER_PAUSED_F, [hl]
	call ClearWeatherSprites
	jp CancelWeatherFade

ResumeWeather::
	ld hl, wWeatherFlags
	res WEATHER_PAUSED_F, [hl]
	ret

PrepareWeatherForFullScreen::
	call ClearWeatherSprites
	jp CancelWeatherFade

LoadWeatherGraphics::
; Load the active particle tiles into VRAM bank 0.
	call GetActiveOverworldWeather
	and a
	ret z
	push hl
	push de
	push bc
	ld c, a
	ld b, 0
	ld hl, WeatherGraphics - 3
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld c, [hl]
	ld b, BANK(RainGFX)
	ld hl, vTiles0 tile OVERWORLD_WEATHER_TILE
	ldh a, [rVBK]
	push af
	xor a
	ldh [rVBK], a
	call Get2bpp
	pop af
	ldh [rVBK], a
	pop bc
	pop de
	pop hl
	ret

MACRO weather_gfx
	dw \1
	db \2
ENDM

WeatherGraphics:
	table_width 3
	weather_gfx RainGFX, 2
	weather_gfx SnowGFX, 1
	weather_gfx SandGFX, 1
	assert_table_length NUM_OVERWORLD_WEATHER_TYPES - 1

GetWeatherObjectPalettePointer:
; a: OVERWORLD_WEATHER_*; returns hl
	dec a
	add a
	add a ; four times of day per weather
	ld b, a
	ld a, [wTimeOfDayPal]
	maskbits NUM_DAYTIMES
	add b
	add a
	add a
	add a ; one eight-byte CGB palette
	ld c, a
	ld b, 0
	ld hl, WeatherObjectPalettes
	add hl, bc
	ret

LoadWeatherObjectPalette::
	push af
	push bc
	push de
	push hl
	call GetActiveOverworldWeather
	jr z, .done
	ld c, a
	ld a, [wWeatherPalSlot]
	cp NUM_OVERWORLD_OBJ_PALETTES
	jr nc, .done
	push af
	ld a, c
	call GetWeatherObjectPalettePointer
	pop af
	add a
	add a
	add a
	add LOW(wOBPals1)
	ld e, a
	adc HIGH(wOBPals1)
	sub e
	ld d, a
	ldh a, [rSVBK]
	push af
	ld a, BANK(wOBPals1)
	ldh [rSVBK], a
	ld bc, 1 palettes
	call CopyBytes
	pop af
	ldh [rSVBK], a
.done
	pop hl
	pop de
	pop bc
	pop af
	ret

EnsureWeatherObjectPalette:
; Restore the particle palette after an object palette reload.
	call LoadWeatherObjectPalette
	call GetActiveOverworldWeather
	ret z
	ld a, [wWeatherFlags]
	bit WEATHER_FADE_ACTIVE_F, a
	ret nz
	ld a, [wWeatherPalSlot]
	cp NUM_OVERWORLD_OBJ_PALETTES
	ret nc
	push hl
	push de
	push bc
	add a
	add a
	add a
	ld c, a
	ld b, 0
	ld hl, wOBPals1
	add hl, bc
	ld de, wOBPals2
	ld a, e
	add c
	ld e, a
	jr nc, .bank
	inc d
.bank
	ldh a, [rSVBK]
	push af
	ld a, BANK(wOBPals1)
	ldh [rSVBK], a
	push hl
	push de
	ld b, PAL_SIZE
.compare_loop
	ld a, [de]
	cp [hl]
	jr nz, .copy
	inc de
	inc hl
	dec b
	jr nz, .compare_loop
	pop de
	pop hl
	jr .restore_bank
.copy
	pop de
	pop hl
	ld bc, 1 palettes
	call CopyBytes
	ld a, TRUE
	ldh [hCGBPalUpdate], a
.restore_bank
	pop af
	ldh [rSVBK], a
	pop bc
	pop de
	pop hl
	ret

WeatherObjectPalettes:
	table_width PAL_SIZE
	assert NUM_DAYTIMES == 4
; rain
	RGB 28, 31, 16, 21, 21, 31, 16, 22, 31, 00, 00, 00 ; morn
	RGB 27, 31, 27, 21, 21, 31, 16, 22, 31, 00, 00, 00 ; day
	RGB 15, 14, 24, 16, 14, 19, 16, 16, 31, 00, 00, 00 ; nite
	RGB 31, 21, 14, 16, 14, 19, 16, 16, 31, 00, 00, 00 ; eve
; snow/hail
	RGB 28, 31, 16, 31, 31, 31, 31, 31, 31, 00, 00, 00 ; morn
	RGB 27, 31, 27, 31, 31, 31, 31, 31, 31, 00, 00, 00 ; day
	RGB 15, 14, 24, 24, 24, 31, 24, 24, 31, 00, 00, 00 ; nite
	RGB 31, 21, 14, 31, 31, 31, 31, 31, 31, 00, 00, 00 ; eve
; sandstorm
	RGB 28, 31, 16, 22, 19, 09, 11, 05, 00, 15, 09, 02 ; morn
	RGB 27, 31, 27, 22, 19, 09, 11, 05, 00, 15, 09, 02 ; day
	RGB 15, 14, 24, 16, 14, 10, 08, 04, 05, 10, 09, 09 ; nite
	RGB 31, 21, 14, 22, 19, 09, 11, 05, 00, 15, 09, 02 ; eve
	assert_table_length (NUM_OVERWORLD_WEATHER_TYPES - 1) * NUM_DAYTIMES

; OAM helpers

FillUnusedOAMPreservingWeather::
; Hide unused OAM without clearing weather particles.
	ld a, [wStateFlags]
	bit LAST_12_SPRITE_OAM_STRUCTS_RESERVED_F, a
	ld b, OAM_SIZE
	jr z, .got_boundary
	ld b, (OAM_COUNT - 12) * OBJ_SIZE
.got_boundary
	ldh a, [hUsedSpriteIndex]
	cp b
	ret nc
	ld l, a
	ld c, (OAM_COUNT - MAX_OVERWORLD_WEATHER_PARTICLES) * OBJ_SIZE
	ld a, b
	cp OAM_SIZE
	jr z, .got_start
	ld c, (OAM_COUNT - 12 - MAX_OVERWORLD_WEATHER_PARTICLES) * OBJ_SIZE
.got_start
	ld h, HIGH(wShadowOAM)
	ld de, OBJ_SIZE
.loop
	ld a, l
	cp c
	jr c, .hide
	call IsWeatherSprite
	jr z, .next
.hide
	ld [hl], OAM_YCOORD_HIDDEN
.next
	add hl, de
	ld a, b
	cp l
	jr nz, .loop
	; Keep the old OAM cleanup routine's return value in c.
	ld c, OAM_YCOORD_HIDDEN
	ret

IsWeatherSprite::
; hl = OAM entry; return z for a visible weather particle
	push bc
	ld a, [hl]
	and a
	jr z, .no
	cp OAM_YCOORD_HIDDEN
	jr nc, .no
	inc l
	inc l
	ld a, [hli]
	cp OVERWORLD_WEATHER_TILE
	jr z, .tile_ok
	cp OVERWORLD_RAIN_SPLASH_TILE
	jr nz, .no_back3
.tile_ok
	ld c, [hl]
	dec l
	dec l
	dec l
	ld a, [wWeatherPalSlot]
	cp c
	pop bc
	ret
.no_back3
	dec l
	dec l
	dec l
.no
	or 1 ; nz
	pop bc
	ret

ScanForEmptyOAM:
; Search backwards for free OAM. Returns carry if none is available.
	ldh a, [hUsedSpriteIndex]
	ld c, a
	ld a, [wStateFlags]
	bit LAST_12_SPRITE_OAM_STRUCTS_RESERVED_F, a
	ld l, OAM_SIZE - SPRITEOAMSTRUCT_LENGTH
	ld b, (OAM_COUNT - MAX_OVERWORLD_WEATHER_PARTICLES) * OBJ_SIZE
	jr z, .got_end
	ld l, (OAM_COUNT - 12) * OBJ_SIZE - SPRITEOAMSTRUCT_LENGTH
	ld b, (OAM_COUNT - 12 - MAX_OVERWORLD_WEATHER_PARTICLES) * OBJ_SIZE
.got_end
	ld a, c
	cp b
	jr nc, .got_start
	ld c, b
.got_start
	ld h, HIGH(wShadowOAM)
.loop
	ld a, l
	cp c
	jr c, .none
	ld a, [hl]
	and a
	ret z
	cp OAM_YCOORD_HIDDEN
	jr c, .used
	and a
	ret
.used
	ld a, l
	sub SPRITEOAMSTRUCT_LENGTH
	ld l, a
	jr nc, .loop
.none
	scf
	ret

SetWeatherParticle:
; hl = tile byte, a = tile ID
	ld [hli], a
	ld a, [wWeatherPalSlot]
	ld [hl], a
	ret

GetPlayerStepY:
; Ignore camera movement from screen shake.
	ld a, [wWeatherFlags]
	bit WEATHER_IGNORE_PLAYER_Y_F, a
	ld a, 0
	ret nz
	ld a, [wPlayerStepVectorY]
	ret

IsEvenSpriteIndex:
	ld a, e
	rra
	rra
	and 1
	ret

Despawn:
; de = OAM entry
	ld h, d
	ld l, e
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ret

ForEachWeatherSprite:
; Call hl for each particle. de points to its OAM entry.
	ld de, wShadowOAM + (OAM_COUNT - MAX_OVERWORLD_WEATHER_PARTICLES) * OBJ_SIZE
	ld b, MAX_OVERWORLD_WEATHER_PARTICLES
	ld a, [wStateFlags]
	bit LAST_12_SPRITE_OAM_STRUCTS_RESERVED_F, a
	jr z, .loop
	ld de, wShadowOAM + (OAM_COUNT - 12 - MAX_OVERWORLD_WEATHER_PARTICLES) * OBJ_SIZE
.loop
	; skip empty and hidden slots without the full check
	ld a, [de]
	and a
	jr z, .next
	cp OAM_YCOORD_HIDDEN
	jr nc, .next
	push hl
	push bc
	ld h, d
	ld l, e
	call IsWeatherSprite
	pop bc
	pop hl
	jr nz, .next
	push hl
	push bc
	push de
	call _hl_
	pop de
	pop bc
	pop hl
.next
	ld a, e
	add SPRITEOAMSTRUCT_LENGTH
	ld e, a
	dec b
	jr nz, .loop
	ret

; Rain

DoOverworldRain:
rept 3
	call ScanForEmptyOAM
	jr c, .done_spawning
	call SpawnRainDrop
endr

.done_spawning
	; fallthrough
DoRainFall:
	ld hl, .Update
	call ForEachWeatherSprite

	; Splashes last four weather ticks.
	ld a, [wOverworldWeatherTimer]
	and %1110
	ret nz
	ld hl, .HideSplash
	jp ForEachWeatherSprite

.HideSplash:
	ld hl, SPRITEOAMSTRUCT_TILE_ID
	add hl, de
	ld a, [hl]
	cp RAINSPLASH_TILE
	ret nz
	jp Despawn

.Update:
	ld hl, SPRITEOAMSTRUCT_TILE_ID
	add hl, de
	ld a, [hl]
	cp RAINSPLASH_TILE
	jr z, .update_splash

	; 5% chance to splash.
	call WeatherRandom
	cp 5 percent
	jr nc, .fall
	ld [hl], RAINSPLASH_TILE
	ret

.fall
	; Offset movement so particles stay in place relative to the map.
	call GetPlayerStepY
	add a
	add a
	ld c, a
	ld a, [de]
	sub c
	ld c, a
	call IsEvenSpriteIndex
	add a
	add c
	add 8 ; minimum fall speed
	cp OAM_YCOORD_HIDDEN
	jp nc, Despawn
	ld [de], a

	ld a, [wPlayerStepVectorX]
	add a
	add a
	ld c, a
	ld h, d
	ld l, e
	inc l
	ld a, [hl]
	sub c
	ld c, a
	call IsEvenSpriteIndex
	add a
	ld b, a
	ld a, c
	sub b
	jp c, Despawn
	sub 4 ; minimum leftward drift
	jp c, Despawn
	ld [hl], a
	ret

.update_splash
	; Splashes only follow the camera.
	call GetPlayerStepY
	add a
	ld c, a
	ld a, [de]
	sub c
	cp OAM_YCOORD_HIDDEN
	jp nc, Despawn
	ld [de], a
	ld a, [wPlayerStepVectorX]
	add a
	ld c, a
	ld h, d
	ld l, e
	inc l
	ld a, [hl]
	sub c
	ld [hl], a
	ret

SpawnRainDrop:
; hl = free OAM entry
	; Enter from the top or right edge.
	call WeatherRandom
	and 1
	jr z, .from_right
	ld [hl], 1 ; y (just above the screen)
	inc l
	ld a, SCREEN_WIDTH_PX + 7
	call WeatherRandomRange
	add TILE_WIDTH
	ld [hli], a
	jr .finish
.from_right
	ld a, OAM_YCOORD_HIDDEN - 1
	call WeatherRandomRange
	inc a
	ld [hli], a
	ld [hl], SCREEN_WIDTH_PX + TILE_WIDTH
	inc l
.finish
	ld a, RAINDROP_TILE
	jp SetWeatherParticle

; Snow

DoOverworldSnow:
rept 2
	call ScanForEmptyOAM
	jr c, .done_spawning
	call SpawnSnowFlake
endr

.done_spawning
	; fallthrough
DoSnowFall:
	ld hl, .Update
	jp ForEachWeatherSprite

.Update:
	; Occasionally melt.
	call WeatherRandom
	cp 1 percent
	jr nc, .ok
	call WeatherRandom
	cp 10 percent
	jp c, Despawn
.ok
	call GetPlayerStepY
	add a
	ld c, a
	ld a, [de]
	sub c
	ld c, a
	call IsEvenSpriteIndex
	add c
	add 2 ; minimum fall speed
	cp OAM_YCOORD_HIDDEN
	jp nc, Despawn
	ld [de], a

	; Wiggle left half the time.
	ld a, [wPlayerStepVectorX]
	add a
	ld c, a
	call WeatherRandom
	and 1
	jr nz, .no_wiggle
	inc c
.no_wiggle
	ld h, d
	ld l, e
	inc l
	ld a, [hl]
	sub c ; c is negative while walking left, so ignore the carry
	jp z, Despawn ; reached the left edge
	cp SCREEN_WIDTH_PX + 2 * TILE_WIDTH
	jp nc, Despawn ; off the right edge, or wrapped past the left edge
	ld [hl], a
	ret

SpawnSnowFlake:
; hl = free OAM entry
	; 40% chance to spawn.
	call WeatherRandom
	cp 40 percent
	ret nc
	; Enter from the right one-quarter of the time.
	call WeatherRandom
	and %11
	jr z, .from_right
	ld [hl], 1
	inc l
	ld a, SCREEN_WIDTH_PX + 7
	call WeatherRandomRange
	add TILE_WIDTH
	ld [hli], a
	jr .finish
.from_right
	ld a, OAM_YCOORD_HIDDEN - 1
	call WeatherRandomRange
	inc a
	ld [hli], a
	ld [hl], SCREEN_WIDTH_PX + TILE_WIDTH
	inc l
.finish
	ld a, SNOWFLAKE_TILE
	jp SetWeatherParticle

; Sandstorm

DoOverworldSandstorm:
rept 3
	call ScanForEmptyOAM
	jr c, .done_spawning
	call SpawnSandDrop
endr

.done_spawning
	; fallthrough
DoSandFall:
	ld hl, .Update
	jp ForEachWeatherSprite

.Update:
	; 5% chance to vanish.
	call WeatherRandom
	cp 5 percent
	jp c, Despawn

	; Blow up and left.
	call GetPlayerStepY
	add a
	add a
	ld c, a
	ld a, [de]
	sub c
	ld c, a
	call IsEvenSpriteIndex
	add a
	add c
	sub 4 ; minimum rise speed
	jp c, Despawn
	cp OAM_YCOORD_HIDDEN
	jp nc, Despawn
	and a
	jp z, Despawn
	ld [de], a

	ld a, [wPlayerStepVectorX]
	add a
	add a
	ld c, a
	ld h, d
	ld l, e
	inc l
	ld a, [hl]
	sub c
	ld c, a
	call IsEvenSpriteIndex
	add a
	ld b, a
	ld a, c
	sub b
	jp c, Despawn
	sub 12 ; minimum leftward speed
	jp c, Despawn
	ld [hl], a
	ret

SpawnSandDrop:
; hl = free OAM entry
	; Enter from the bottom or right edge.
	call WeatherRandom
	and 1
	jr z, .from_right
	ld [hl], SCREEN_HEIGHT_PX + TILE_WIDTH
	inc l
	ld a, SCREEN_WIDTH_PX + 7
	call WeatherRandomRange
	add TILE_WIDTH
	ld [hli], a
	jr .finish
.from_right
	ld a, OAM_YCOORD_HIDDEN - 1
	call WeatherRandomRange
	inc a
	ld [hli], a
	ld [hl], SCREEN_WIDTH_PX + TILE_WIDTH
	inc l
.finish
	ld a, SANDSTORM_TILE
	jp SetWeatherParticle

; Weather tint
; Each channel becomes min(31, (channel * multiplier + 8) / 16 + add).

ApplyMapWeatherPalettes::
; Leave the text palette unchanged.
	push af
	push bc
	push de
	push hl
	ld hl, wBGPals1
	ld c, PAL_BG_TEXT
	call ApplyWeatherTint
	ld hl, wOBPals1
	ld c, NUM_OVERWORLD_OBJ_PALETTES
	call ApplyWeatherTint
	call LoadWeatherObjectPalette
	pop hl
	pop de
	pop bc
	pop af
	ret

ApplyWeatherTint::
; hl = first palette, c = number of palettes
; Tints each color through precomputed per-channel tables (WeatherTintTables):
; this runs for every color of 15 palettes whenever map palettes are
; rebuilt (e.g. crossing into a connected map), so it has to be quick.
	push af
	push bc
	push de
	push hl
	ldh a, [rSVBK]
	push af

	ld a, BANK(wFieldWeather)
	ldh [rSVBK], a
	call GetWeatherTint
	jp z, .done
	; Table rows are 128 bytes (96 used), 128-byte aligned, so a row's address
	; is d = HIGH(WeatherTintTables) + row / 2, e = (row & 1) * $80, and
	; any entry in the row is just h = d, l = e | offset (no carry).
	dec a
	add a
	add a ; * NUM_DAYTIMES
	ld b, a
	ld a, [wTimeOfDayPal]
	maskbits NUM_DAYTIMES
	add b ; row
	srl a
	ld e, 0
	rr e ; (row & 1) * $80
	add HIGH(WeatherTintTables)
	ld d, a

	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld a, c
	add a
	add a ; 4 colors per palette
	ldh [hProduct + 2], a
.color_loop
	ld a, [hli]
	ld b, a ; b = low byte: gggrrrrr
	ld a, [hld]
	ld c, a ; c = high byte: 0bbbbbgg
	push hl
	ld h, d

	; red
	ld a, b
	and %11111
	or e
	ld l, a
	ld a, [hl]
	ldh [hProduct], a

	; green
	ld a, c
	and %11
	add a
	add a
	add a
	ld l, a
	ld a, b
	swap a
	rrca
	and %111
	or l
	add 32
	or e
	ld l, a
	ld a, [hl]
	ldh [hProduct + 1], a

	; blue
	ld a, c
	rrca
	rrca
	and %11111
	add 64
	or e
	ld l, a
	ld a, [hl]

	; high byte: 0bbbbbgg
	add a
	add a
	ld c, a
	ldh a, [hProduct + 1]
	ld b, a
	rrca
	rrca
	rrca
	and %11
	or c
	ld c, a
	; low byte: gggrrrrr
	ld a, b
	and %111
	swap a
	add a
	ld b, a
	ldh a, [hProduct]
	or b

	pop hl
	ld [hli], a
	ld a, c
	ld [hli], a
	ldh a, [hProduct + 2]
	dec a
	ldh [hProduct + 2], a
	jr nz, .color_loop

.done
	pop af
	ldh [rSVBK], a
	pop hl
	pop de
	pop bc
	pop af
	ret

; For each weather tint and time of day: three 32-byte tables (red, green,
; blue) holding min(31, (channel * multiplier + 8) / 16 + add).
MACRO tint_channel_table ; multiplier, add
	FOR v, 32
		DEF tinted = ((v * (\1) + 8) >> 4) + (\2)
		IF tinted > 31
			DEF tinted = 31
		ENDC
		db tinted
	ENDR
ENDM

; red mult, red add, green mult, green add, blue mult, blue add
MACRO weather_tint
	tint_channel_table \1, \2
	tint_channel_table \3, \4
	tint_channel_table \5, \6
	ds 32 ; pad each row to 128 bytes (see ApplyWeatherTint)
ENDM


; Map connection fade

; Sunny overworld shimmer (ported from sour): while the sun is out, the BG
; palettes (all but the text palette) gently brighten and dim in a
; 30-frame pulse. Every 3 frames the brightness moves one step:
; up 1, 2, 3, 4, 5 then down 4, 3, 2, 1, 0. Step n adds SunShimmerDeltas
; (red, green/blue) to each color, clamped at 31. The displayed palettes
; (wBGPals2) are rebuilt from the untouched map palettes (wBGPals1), a
; third of them per frame, so nothing drifts and the work is spread out.

DEF SUN_SHIMMER_STEP_FRAMES EQU 3
DEF SUN_SHIMMER_STEPS       EQU 10
DEF SUN_SHIMMER_FRAMES      EQU SUN_SHIMMER_STEP_FRAMES * SUN_SHIMMER_STEPS
DEF SUN_SHIMMER_SKIPPED_F   EQU 7
assert SUN_SHIMMER_FRAMES < 1 << SUN_SHIMMER_SKIPPED_F
assert BANK(wSunShimmerWaterActive) == BANK(wBGPals1)
assert BANK(wBGPals2) == BANK(wBGPals1)

SunShimmerFrame:
	ld a, [wFieldWeather]
	cp WEATHER_SUN
	jr nz, .off
	ldh a, [hCGB]
	and a
	ret z
	; leave the palettes alone while they're being faded or a script runs
	; (a script may have faded the screen out)
	ld a, [wWeatherFlags]
	and (1 << WEATHER_PAUSED_F) | (1 << WEATHER_FADE_ACTIVE_F)
	ret nz
	ld a, [wScriptRunning]
	and a
	ret nz

	; Like the weather particles: if a step will probably start next frame
	; (the map redraw is expensive), wait a frame. Never twice in a row.
	ld hl, wSunShimmerTimer
	bit SUN_SHIMMER_SKIPPED_F, [hl]
	res SUN_SHIMMER_SKIPPED_F, [hl]
	jr nz, .run
	ld a, [wPlayerStepFlags]
	bit PLAYERSTEP_STOP_F, a
	jr nz, .skip
	and a
	jr nz, .run
	ldh a, [hJoyDown]
	and D_PAD
	jr z, .run
.skip
	set SUN_SHIMMER_SKIPPED_F, [hl]
	ret

.run
	; step = timer / 3, part = timer % 3
	ld a, [hl]
	ld b, 0
.div
	cp SUN_SHIMMER_STEP_FRAMES
	jr c, .got_part
	sub SUN_SHIMMER_STEP_FRAMES
	inc b
	jr .div
.got_part
	ld c, a
	; level = step + 1 for steps 0-4, 9 - step for steps 5-9
	ld a, b
	cp SUN_SHIMMER_STEPS / 2
	jr nc, .going_down
	inc a
	jr .got_level
.going_down
	ld a, SUN_SHIMMER_STEPS - 1
	sub b
.got_level
	ld d, a
	call SunShimmerPart

	ld hl, wSunShimmerTimer
	inc [hl]
	ld a, [hl]
	cp SUN_SHIMMER_FRAMES
	ret c
	xor a
	ld [hl], a
	ret

.off
	xor a
	ld [wSunShimmerTimer], a
	ld a, [wSunShimmerLevel]
	and a
	ret z
	xor a
	ld [wSunShimmerLevel], a
	; fallthrough

SunShimmerStopWater::
; The water animation goes back to the plain map colors.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wSunShimmerWaterActive)
	ldh [rSVBK], a
	xor a
	ld [wSunShimmerWaterActive], a
	pop af
	ldh [rSVBK], a
	ret

SunShimmerResetWater::
; Called when the map palettes are (re)loaded: the new map may not
; animate its water, and its colors are different.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wWaterPalColor)
	ldh [rSVBK], a
	ld a, -1
	ld [wWaterPalColor], a
	xor a
	ld [wSunShimmerWaterActive], a
	pop af
	ldh [rSVBK], a
	ret

SunShimmerPart:
; c = part (0-2), d = brightness level (0-5)
; Part 0 rebuilds BG palettes 0-2, part 1 palettes 3-4 (with the water
; colors), part 2 palettes 5-6 and then uploads them.
	ld a, d
	add a
	add LOW(SunShimmerDeltas)
	ld l, a
	adc HIGH(SunShimmerDeltas)
	sub l
	ld h, a
	ld a, [hli]
	ld b, a ; red delta
	ld a, [hl]
	ld e, a ; green / blue delta

	; the level the water animation and the next part 0 see once this
	; pass is shown (WRAM bank 1, so before switching banks)
	ld a, c
	cp 2
	jr nz, .not_last_part
	ld a, d
	ld [wSunShimmerLevel], a
.not_last_part

	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a

	ld a, c
	and a
	jr z, .part0
	dec a
	jr z, .part1

	; part 2: palettes 5-6, then show the result
	ld a, 5
	ld c, 2
	call .Rebuild
	jr .upload

.part0
	xor a
	ld c, 3
	call .Rebuild
	jr .done

.part1
	ld a, 3
	ld c, 2
	call .Rebuild
	call .WaterColors
	jr .done

.upload
	ld a, TRUE
	ldh [hCGBPalUpdate], a
.done
	pop af
	ldh [rSVBK], a
	ret

.Rebuild:
; Copy c palettes starting at palette a from wBGPals1 to wBGPals2 and
; brighten them by b (red) / e (green and blue).
	push de
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl ; * PAL_SIZE
	push hl
	ld de, wBGPals1
	add hl, de
	pop de
	push hl
	ld hl, wBGPals2
	add hl, de
	ld d, h
	ld e, l
	pop hl
	ld a, c
	add a
	add a
	add a
	push bc
	ld c, a
	ld b, 0
	push de
	call CopyBytes
	pop hl ; first rebuilt color in wBGPals2
	pop bc
	pop de
	ld a, c
	add a
	add a ; colors
	ld c, a
.color
	call SunShimmerColor
	dec c
	jr nz, .color
	ret

.WaterColors:
; Shimmered copies of the water palette's colors 0-2 for the water
; animation, and the color it is currently showing as wBGPals2's color 0.
	push de
	ld hl, wBGPals1 palette PAL_BG_WATER
	ld de, wSunShimmerWaterColors
	push bc
	ld bc, 3 * PAL_COLOR_SIZE
	call CopyBytes
	pop bc
	pop de
	ld hl, wSunShimmerWaterColors
	ld c, 3
.water
	call SunShimmerColor
	dec c
	jr nz, .water
	ld a, TRUE
	ld [wSunShimmerWaterActive], a

	ld a, [wWaterPalColor]
	cp 3
	ret nc ; the water isn't animated
	add a
	add LOW(wSunShimmerWaterColors)
	ld l, a
	adc HIGH(wSunShimmerWaterColors)
	sub l
	ld h, a
	ld de, wBGPals2 palette PAL_BG_WATER
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ret

SunShimmerColor:
; Brighten the RGB555 color at hl: red + b, green and blue + e, each
; capped at 31. hl advances to the next color. Clobbers a, d.
	; red
	ld a, [hl]
	and %00011111
	add b
	cp 32
	jr c, .red_ok
	ld a, 31
.red_ok
	ld d, a
	; green: %gggRRRRR %0BBBBBGG -> %000GGggg
	ld a, [hli]
	and %11100000
	push bc
	ld c, a
	ld a, [hl]
	and %00000011
	or c
	rlca
	rlca
	rlca
	add e
	cp 32
	jr c, .green_ok
	ld a, 31
.green_ok
	ld c, a
	; blue
	ld a, [hl]
	and %01111100
	rrca
	rrca
	add e
	cp 32
	jr c, .blue_ok
	ld a, 31
.blue_ok
	; high byte %0BBBBBGG
	rlca
	rlca
	ld b, a
	ld a, c
	rrca
	rrca
	rrca ; %gggxxxGG
	ld c, a
	and %00000011
	or b
	ld [hld], a
	; low byte %gggRRRRR
	ld a, c
	and %11100000
	or d
	ld [hli], a
	inc hl
	pop bc
	ret

SunShimmerDeltas:
; red, green and blue added at each brightness level
	db 0, 0
	db 1, 1
	db 2, 1
	db 3, 2
	db 4, 2
	db 5, 3

SaveWeatherFadeSource::
; Save the displayed palettes before loading the connected map.
	push af
	push bc
	push de
	push hl
	call GetWeatherTint
	ld [wPrevPalTintWeather], a
	ld [wPalTintWeather], a
	xor a
	ld [wWeatherFadeSteps], a
	ld [wWeatherFadeFrame], a
	ld hl, wWeatherFlags
	res WEATHER_FADE_ACTIVE_F, [hl]
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals2)
	ldh [rSVBK], a
	ld hl, wBGPals2
	ld de, wWeatherFadeStartPalettes
	ld bc, WEATHER_FADE_BUFFER_SIZE
	call CopyBytes
	pop af
	ldh [rSVBK], a
	pop hl
	pop de
	pop bc
	pop af
	ret

RecordMapPalsWeather::
	call GetWeatherTint
	ld [wPalTintWeather], a
	ret

MapConnWeatherFade::
	call RecordMapPalsWeather
	ld a, [wPrevPalTintWeather]
	ld b, a
	ld a, [wPalTintWeather]
	cp b
	jr nz, .fade
	call CancelWeatherFade
	farjp _UpdateTimePals

.fade
	ld a, WEATHER_FADE_STEPS
	ld [wWeatherFadeSteps], a
	xor a
	ld [wWeatherFadeFrame], a
	ld hl, wWeatherFlags
	set WEATHER_FADE_ACTIVE_F, [hl]
	; Apply the connected map's OBJ palettes immediately so map sprites
	; load at once instead of fading in. Only the BG palettes are lerped;
	; the fade's OBJ quarters (c = 2,3) are skipped in WeatherFadeStep.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wOBPals2)
	ldh [rSVBK], a
	ld hl, wOBPals1
	ld de, wOBPals2
	ld bc, 8 palettes
	call CopyBytes
	pop af
	ldh [rSVBK], a
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	ret

CancelWeatherFade::
	xor a
	ld [wWeatherFadeSteps], a
	ld [wWeatherFadeFrame], a
	ld hl, wWeatherFlags
	res WEATHER_FADE_ACTIVE_F, [hl]
	ret

WeatherFadeStep::
; Update four palettes per frame.
	ld a, [wWeatherFlags]
	bit WEATHER_PAUSED_F, a
	ret nz
	bit WEATHER_FADE_ACTIVE_F, a
	ret z
	ld a, [wWeatherFadeSteps]
	and a
	jp z, .cancel
	push hl
	push de
	push bc
	ld b, a ; steps left (WEATHER_FADE_STEPS .. 1)

	ld a, [wWeatherFadeFrame]
	ld c, a
	inc a
	and %11
	ld [wWeatherFadeFrame], a
	; The fade covers wBGPals2's eight BG palettes in two 32-byte
	; quarters (c = 0,1). OBJ quarters (c = 2,3) are skipped: OBJ
	; palettes are applied instantly when the fade starts.
	ld a, c
	swap a
	add a ; * 4 palettes (32 bytes)
	add LOW(wBGPals2)
	ld l, a
	adc HIGH(wBGPals2)
	sub l
	ld h, a
	ld a, c
	cp %11 ; last quarter of the step?
	push af
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals2)
	ldh [rSVBK], a

	ld a, c
	cp 2 ; OBJ quarters are applied instantly, not faded
	jp nc, .stepped

	ld a, b
	dec a
	jp z, .last_step
	push hl
	ld a, WEATHER_FADE_STEPS
	sub b
	ld c, a
	ld b, 0
	ld hl, WeatherFadeProgress
	add hl, bc
	ld a, [hl]
	ldh [hWeatherFadeProgress], a
	pop hl

	ld c, 4 * NUM_PAL_COLORS
.color_loop
	push bc
	push hl
	ld bc, wWeatherFadeStartPalettes - wBGPals2
	add hl, bc
	ld a, [hli]
	ld e, a ; start low:  gggrrrrr
	ld d, [hl] ; start high: 0bbbbbgg
	pop hl
	push hl
	ld bc, wBGPals1 - wBGPals2
	add hl, bc
	ld a, [hli]
	ld c, a ; target low
	ld b, [hl] ; target high
	cp e
	jr nz, .lerp
	ld a, b
	cp d
	jp z, .store
.lerp

	; red
	ld a, c
	and %11111
	ld l, a
	ld a, e
	and %11111
	call LerpChannel
	push af

	; green
	ld a, b
	and %11
	add a
	add a
	add a
	ld l, a
	ld a, c
	swap a
	rrca
	and %111
	or l
	ld l, a
	ld a, d
	and %11
	add a
	add a
	add a
	ld h, a
	ld a, e
	swap a
	rrca
	and %111
	or h
	call LerpChannel
	push af

	; blue
	ld a, b
	rrca
	rrca
	and %11111
	ld l, a
	ld a, d
	rrca
	rrca
	and %11111
	call LerpChannel

	; repack
	add a
	add a
	ld d, a
	pop af ; green
	ld e, a
	rrca
	rrca
	rrca
	and %11
	or d
	ld d, a
	ld a, e
	and %111
	swap a
	add a
	ld e, a
	pop af ; red
	or e
	ld e, a

.store
	pop hl
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	pop bc
	dec c
	jp nz, .color_loop
	jr .stepped

.last_step
	; Copy the target exactly on the final step.
	ld d, h
	ld e, l
	ld bc, wBGPals1 - wBGPals2
	add hl, bc
	ld bc, 4 palettes
	call CopyBytes

.stepped
	pop af
	ldh [rSVBK], a
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	pop af
	jr nz, .done ; the rest of this step happens in the next frames
	ld hl, wWeatherFadeSteps
	dec [hl]
	jr nz, .done
	ld hl, wWeatherFlags
	res WEATHER_FADE_ACTIVE_F, [hl]
.done
	pop bc
	pop de
	pop hl
	ret

.cancel
	push hl
	ld hl, wWeatherFlags
	res WEATHER_FADE_ACTIVE_F, [hl]
	pop hl
	ret

WeatherFadeProgress:
for k, 1, WEATHER_FADE_STEPS
	db k * 256 / WEATHER_FADE_STEPS
endr
WeatherFadeProgressEnd:
	assert WeatherFadeProgressEnd - WeatherFadeProgress == WEATHER_FADE_STEPS - 1

LerpChannel:
; a = start channel, l = target channel
	cp l
	ret z
	ld h, a
	jr c, .up
	sub l
	call .Scale
	ld l, a
	ld a, h
	sub l
	ret
.up
	ld a, l
	sub h
	call .Scale
	add h
	ret

.Scale:
; a = (a * progress + 128) / 256
	push hl
	push de
	push bc
	ld c, a
	ldh a, [hWeatherFadeProgress]
	ld e, a
	ld d, 0
	ld hl, 128
.bits
	srl c
	jr nc, .no_add
	add hl, de
.no_add
	sla e
	rl d
	ld a, c
	and a
	jr nz, .bits
	ld a, h
	pop bc
	pop de
	pop hl
	ret



WeatherRandom:
; Cheap 16-bit xorshift (7, 9, 8) for weather particles: a few instructions
; instead of the save-backed Random, which up to 16 particles call several
; times per weather tick. Returns a. Preserves bc, de and hl.
	push hl
	ldh a, [hWeatherRandom]
	ld l, a
	ldh a, [hWeatherRandom + 1]
	ld h, a
	or l
	jr nz, .seeded
	ldh a, [rDIV]
	or 1
	ld l, a
.seeded
	ld a, h
	rra
	ld a, l
	rra
	xor h
	ld h, a
	ld a, l
	rra
	ld a, h
	rra
	xor l
	ld l, a
	xor h
	ld h, a
	ldh [hWeatherRandom + 1], a
	ld a, l
	ldh [hWeatherRandom], a
	xor h
	pop hl
	ret

WeatherRandomRange:
; Return a random number from 0 to a - 1 (a > 0). Preserves bc, de and hl.
	push bc
	ld c, a
	call WeatherRandom
.mod
	cp c
	jr c, .done
	sub c
	jr .mod
.done
	pop bc
	ret

; In their own 16-byte aligned section so LoadWeatherGraphics can load them
; with GDMA (SafeHDMATransfer) instead of Request2bpp, which stalls the
; overworld for a frame or two after a map change.
SECTION "Overworld Weather GFX", ROMX, ALIGN[4]

RainGFX: INCBIN "gfx/overworld/rain_splash.2bpp"
RainGFXEnd:
	assert RainGFXEnd - RainGFX == 2 tiles
SnowGFX: INCBIN "gfx/overworld/snow.2bpp"
SnowGFXEnd:
	assert SnowGFXEnd - SnowGFX == 1 tiles
; The source PNG contains a second unused tile; the renderer uses the first.
SandGFX: INCBIN "gfx/overworld/sand.2bpp", 0, 1 tiles
SandGFXEnd:
	assert SandGFXEnd - SandGFX == 1 tiles

	assert BANK(RainGFX) == BANK(SnowGFX) && BANK(RainGFX) == BANK(SandGFX)

; 128-byte aligned rows let ApplyWeatherTint index them without carries. It
; reads them from its own bank (the "Overworld Weather" section, bank $7B in
; layout.link), so this section must be in the same bank.
SECTION "Weather Tint Tables", ROMX, BANK[$7B], ALIGN[7]

WeatherTintTables:
	table_width 128
; rain
	weather_tint 9, 2, 10, 1, 8, 4 ; morn
	weather_tint 10, 2, 10, 1, 9, 3 ; day
	weather_tint 10, 1, 10, 1, 9, 1 ; nite
	weather_tint 8, 2, 11, 0, 9, 3 ; eve
; snow
	weather_tint 12, 2, 12, 3, 12, 6 ; morn
	weather_tint 12, 2, 12, 3, 12, 6 ; day
	weather_tint 11, 1, 11, 1, 11, 3 ; nite
	weather_tint 12, 2, 12, 2, 12, 4 ; eve
; sandstorm
	weather_tint 11, 7, 10, 5,  8, 1 ; morn
	weather_tint 11, 7, 10, 5,  8, 1 ; day
	weather_tint 10, 3, 9, 2, 8, 0 ; nite
	weather_tint 11, 6, 10, 4,  8, 1 ; eve
; sun
	weather_tint 16, 2, 16, 2, 16, 1 ; morn
	weather_tint 16, 2, 16, 2, 16, 2 ; day
	weather_tint 16, 1, 16, 1, 16, 1 ; nite
	weather_tint 16, 2, 16, 1, 16, 0 ; eve
	assert_table_length (NUM_WEATHER_TINTS - 1) * NUM_DAYTIMES

	assert BANK(WeatherTintTables) == BANK(ApplyWeatherTint), \
		"WeatherTintTables must be in ApplyWeatherTint's bank"
