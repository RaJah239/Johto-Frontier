PlayRadioShow:
; Jump to the currently loaded station.  The index to which we need to jump is in wCurRadioLine.
	jumptable RadioJumptable, wCurRadioLine

RadioJumptable:
; entries correspond to constants/radio_constants.asm
	table_width 2, RadioJumptable
	dw OaksPKMNTalk1     ; $00
	dw PokedexShow1      ; $01
	dw BenMonMusic1      ; $02
	dw CasinoBeats       ; $03
	dw BuenasPassword1   ; $04
	dw UnownRadio        ; $05
	dw EvolutionRadio    ; $06
	dw NationalPark      ; $07
	assert_table_length NUM_RADIO_CHANNELS
; OaksPKMNTalk
	dw OaksPKMNTalk2     ; $08
	dw OaksPKMNTalk3     ; $09
	dw OaksPKMNTalk4     ; $0a
	dw OaksPKMNTalk5     ; $0b
	dw OaksPKMNTalk6     ; $0c
	dw OaksPKMNTalk7     ; $0d
	dw OaksPKMNTalk8     ; $0e
	dw OaksPKMNTalk9     ; $0f
	dw PokedexShow2      ; $10
	dw PokedexShow3      ; $11
	dw PokedexShow4      ; $12
	dw PokedexShow5      ; $13
; Ben Music
	dw BenMonMusic2      ; $14
	dw BenMonMusic3      ; $15
	dw BenFernMusic4     ; $16
	dw BenFernMusic5     ; $17
	dw BenFernMusic6     ; $18
	dw BenFernMusic7     ; $19
; More Pokemon Channel stuff
	dw OaksPKMNTalk10    ; $1a
	dw OaksPKMNTalk11    ; $1b
	dw OaksPKMNTalk12    ; $1c
	dw OaksPKMNTalk13    ; $1d
	dw OaksPKMNTalk14    ; $1e
; Buenas Password
	dw BuenasPassword2   ; $1f
	dw BuenasPassword3   ; $20
	dw BuenasPassword4   ; $21
	dw BuenasPassword5   ; $22
	dw BuenasPassword6   ; $23
	dw BuenasPassword7   ; $24
	dw BuenasPassword8   ; $25
	dw BuenasPassword9   ; $26
	dw BuenasPassword10  ; $27
	dw BuenasPassword11  ; $28
	dw BuenasPassword12  ; $29
	dw BuenasPassword13  ; $2a
	dw BuenasPassword14  ; $2b
	dw BuenasPassword15  ; $2c
	dw BuenasPassword16  ; $2d
	dw BuenasPassword17  ; $2e
	dw BuenasPassword18  ; $2f
	dw BuenasPassword19  ; $30
	dw BuenasPassword20  ; $31
	dw BuenasPassword21  ; $32
	dw RadioScroll       ; $33
; More Pokemon Channel stuff
	dw PokedexShow6      ; $34
	dw PokedexShow7      ; $35
	dw PokedexShow8      ; $36
	assert_table_length NUM_RADIO_SEGMENTS

PrintRadioLine:
	ld [wNextRadioLine], a
	ld hl, wRadioText
	ld a, [wNumRadioLinesPrinted]
	cp 2
	jr nc, .print
	inc hl
	ld [hl], TX_START
	inc a
	ld [wNumRadioLinesPrinted], a
	cp 2
	jr nz, .print
	bccoord 1, 16
	call PrintTextboxTextAt
	jr .skip
.print
	call PrintTextboxText
.skip
	ld a, RADIO_SCROLL
	ld [wCurRadioLine], a
	ld a, 100
	ld [wRadioTextDelay], a
	ret

RadioScroll:
	ld hl, wRadioTextDelay
	ld a, [hl]
	and a
	jr z, .proceed
	dec [hl]
	ret
.proceed
	ld a, [wNextRadioLine]
	ld [wCurRadioLine], a
	ld a, [wNumRadioLinesPrinted]
	cp 1
	call nz, CopyBottomLineToTopLine
	jmp ClearBottomLine

OaksPKMNTalk1:
	ld a, 5
	ld [wOaksPKMNTalkSegmentCounter], a
	call StartRadioStation
	ld hl, OPT_IntroText1
	ld a, OAKS_POKEMON_TALK_2
	jmp NextRadioLine

OaksPKMNTalk2:
	ld hl, OPT_IntroText2
	ld a, OAKS_POKEMON_TALK_3
	jmp NextRadioLine

OaksPKMNTalk3:
	ld hl, OPT_IntroText3
	ld a, OAKS_POKEMON_TALK_4
	jmp NextRadioLine

OaksPKMNTalk4:
; Choose a random route, and a random Pokemon from that route.
.sample
	call Random
	and %11111
	cp (OaksPKMNTalkRoutes.End - OaksPKMNTalkRoutes) / 2
	jr nc, .sample
	ld hl, OaksPKMNTalkRoutes
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld b, [hl]
	inc hl
	ld c, [hl]
	; bc now contains the chosen map's group and number indices.
	push bc

	; Search the JohtoGrassWildMons array for the chosen map.
	ld hl, JohtoGrassWildMons
.loop
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	cp -1
	jr z, .overflow
	inc hl
	cp b
	jr nz, .next
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	cp c
	jr z, .done
.next
	dec hl
	ld de, GRASS_WILDDATA_LENGTH
	add hl, de
	jr .loop

.done
	; Point hl to the list of morning Pokémon., skipping percentages
rept 4
	inc hl
endr
	; Generate a number, either 0, 1, or 2, to choose a time of day.
	; Can't pick 3 since evening does not have wild data.
.loop2
	call Random
	maskbits NUM_DAYTIMES
	cp EVE_F
	jr z, .loop2

	ld bc, 2 * NUM_GRASSMON
	call AddNTimes
.loop3
	; Choose one of the middle three Pokemon.
	call Random
	maskbits NUM_GRASSMON
	cp 2
	jr c, .loop3
	cp 5
	jr nc, .loop3
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	inc hl ; skip level
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	ld [wNamedObjectIndex], a
	ld [wCurPartySpecies], a
	call GetPokemonName
	ld hl, wStringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, MON_NAME_LENGTH
	call CopyBytes

	; Now that we've chosen our wild Pokemon,
	; let's recover the map index info and get its name.
	pop bc
	call GetWorldMapLocation
	ld e, a
	farcall GetLandmarkName
	ld hl, OPT_OakText1
	call CopyRadioTextToRAM
	ld a, OAKS_POKEMON_TALK_5
	jmp PrintRadioLine

.overflow
	pop bc
	ld a, OAKS_POKEMON_TALK
	jmp PrintRadioLine

INCLUDE "data/radio/oaks_pkmn_talk_routes.asm"

OaksPKMNTalk5:
	ld hl, OPT_OakText2
	ld a, OAKS_POKEMON_TALK_6
	jmp NextRadioLine

OaksPKMNTalk6:
	ld hl, OPT_OakText3
	ld a, OAKS_POKEMON_TALK_7
	jmp NextRadioLine

OPT_IntroText1:
	text_far _OPT_IntroText1
	text_end

OPT_IntroText2:
	text_far _OPT_IntroText2
	text_end

OPT_IntroText3:
	text_far _OPT_IntroText3
	text_end

OPT_OakText1:
	text_far _OPT_OakText1
	text_end

OPT_OakText2:
	text_far _OPT_OakText2
	text_end

OPT_OakText3:
	text_far _OPT_OakText3
	text_end

OaksPKMNTalk7:
	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld hl, OPT_MaryText1
	ld a, OAKS_POKEMON_TALK_8
	jmp NextRadioLine

OPT_MaryText1:
	text_far _OPT_MaryText1
	text_end

OaksPKMNTalk8:
	; 0-15 are all valid indexes into .Adverbs,
	; so no need for a retry loop
	call Random
	maskbits NUM_OAKS_POKEMON_TALK_ADVERBS
	assert_power_of_2 NUM_OAKS_POKEMON_TALK_ADVERBS
	ld e, a
	ld d, 0
	ld hl, .Adverbs
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, OAKS_POKEMON_TALK_9
	jmp NextRadioLine

.Adverbs:
	table_width 2, OaksPKMNTalk8.Adverbs
	dw .OPT_SweetAdorablyText
	dw .OPT_WigglySlicklyText
	dw .OPT_AptlyNamedText
	dw .OPT_UndeniablyKindOfText
	dw .OPT_UnbearablyText
	dw .OPT_WowImpressivelyText
	dw .OPT_AlmostPoisonouslyText
	dw .OPT_SensuallyText
	dw .OPT_MischievouslyText
	dw .OPT_TopicallyText
	dw .OPT_AddictivelyText
	dw .OPT_LooksInWaterText
	dw .OPT_EvolutionMustBeText
	dw .OPT_ProvocativelyText
	dw .OPT_FlippedOutText
	dw .OPT_HeartMeltinglyText
	assert_table_length NUM_OAKS_POKEMON_TALK_ADVERBS

.OPT_SweetAdorablyText:
	text_far _OPT_SweetAdorablyText
	text_end

.OPT_WigglySlicklyText:
	text_far _OPT_WigglySlicklyText
	text_end

.OPT_AptlyNamedText:
	text_far _OPT_AptlyNamedText
	text_end

.OPT_UndeniablyKindOfText:
	text_far _OPT_UndeniablyKindOfText
	text_end

.OPT_UnbearablyText:
	text_far _OPT_UnbearablyText
	text_end

.OPT_WowImpressivelyText:
	text_far _OPT_WowImpressivelyText
	text_end

.OPT_AlmostPoisonouslyText:
	text_far _OPT_AlmostPoisonouslyText
	text_end

.OPT_SensuallyText:
	text_far _OPT_SensuallyText
	text_end

.OPT_MischievouslyText:
	text_far _OPT_MischievouslyText
	text_end

.OPT_TopicallyText:
	text_far _OPT_TopicallyText
	text_end

.OPT_AddictivelyText:
	text_far _OPT_AddictivelyText
	text_end

.OPT_LooksInWaterText:
	text_far _OPT_LooksInWaterText
	text_end

.OPT_EvolutionMustBeText:
	text_far _OPT_EvolutionMustBeText
	text_end

.OPT_ProvocativelyText:
	text_far _OPT_ProvocativelyText
	text_end

.OPT_FlippedOutText:
	text_far _OPT_FlippedOutText
	text_end

.OPT_HeartMeltinglyText:
	text_far _OPT_HeartMeltinglyText
	text_end

OaksPKMNTalk9:
	; 0-15 are all valid indexes into .Adjectives,
	; so no need for a retry loop
	call Random
	maskbits NUM_OAKS_POKEMON_TALK_ADJECTIVES
	assert_power_of_2 NUM_OAKS_POKEMON_TALK_ADJECTIVES
	ld e, a
	ld d, 0
	ld hl, .Adjectives
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wOaksPKMNTalkSegmentCounter]
	dec a
	ld [wOaksPKMNTalkSegmentCounter], a
	ld a, OAKS_POKEMON_TALK_4
	jr nz, .ok
	ld a, 5
	ld [wOaksPKMNTalkSegmentCounter], a
	ld a, OAKS_POKEMON_TALK_10
.ok
	jmp NextRadioLine

.Adjectives:
	table_width 2, OaksPKMNTalk9.Adjectives
	dw .OPT_CuteText
	dw .OPT_WeirdText
	dw .OPT_PleasantText
	dw .OPT_BoldSortOfText
	dw .OPT_FrighteningText
	dw .OPT_SuaveDebonairText
	dw .OPT_PowerfulText
	dw .OPT_ExcitingText
	dw .OPT_GroovyText
	dw .OPT_InspiringText
	dw .OPT_FriendlyText
	dw .OPT_HotHotHotText
	dw .OPT_StimulatingText
	dw .OPT_GuardedText
	dw .OPT_LovelyText
	dw .OPT_SpeedyText
	assert_table_length NUM_OAKS_POKEMON_TALK_ADJECTIVES

.OPT_CuteText:
	text_far _OPT_CuteText
	text_end

.OPT_WeirdText:
	text_far _OPT_WeirdText
	text_end

.OPT_PleasantText:
	text_far _OPT_PleasantText
	text_end

.OPT_BoldSortOfText:
	text_far _OPT_BoldSortOfText
	text_end

.OPT_FrighteningText:
	text_far _OPT_FrighteningText
	text_end

.OPT_SuaveDebonairText:
	text_far _OPT_SuaveDebonairText
	text_end

.OPT_PowerfulText:
	text_far _OPT_PowerfulText
	text_end

.OPT_ExcitingText:
	text_far _OPT_ExcitingText
	text_end

.OPT_GroovyText:
	text_far _OPT_GroovyText
	text_end

.OPT_InspiringText:
	text_far _OPT_InspiringText
	text_end

.OPT_FriendlyText:
	text_far _OPT_FriendlyText
	text_end

.OPT_HotHotHotText:
	text_far _OPT_HotHotHotText
	text_end

.OPT_StimulatingText:
	text_far _OPT_StimulatingText
	text_end

.OPT_GuardedText:
	text_far _OPT_GuardedText
	text_end

.OPT_LovelyText:
	text_far _OPT_LovelyText
	text_end

.OPT_SpeedyText:
	text_far _OPT_SpeedyText
	text_end

OaksPKMNTalk10:
	farcall RadioMusicRestartPokemonChannel
	ld hl, OPT_RestartText
	call PrintText
	call WaitBGMap
	ld hl, OPT_PokemonChannelText
	call PrintText
	ld a, OAKS_POKEMON_TALK_11
	ld [wCurRadioLine], a
	ld a, 100
	ld [wRadioTextDelay], a
	ret

OPT_PokemonChannelText:
	text_far _OPT_PokemonChannelText
	text_end

OPT_RestartText:
	text_end

OaksPKMNTalk11:
	ld hl, wRadioTextDelay
	dec [hl]
	ret nz
	hlcoord 9, 14
	ld de, .pokemon_string
	ld a, OAKS_POKEMON_TALK_12
	jr PlaceRadioString

.pokemon_string
	db "#MON@"

OaksPKMNTalk12:
	ld hl, wRadioTextDelay
	dec [hl]
	ret nz
	hlcoord 1, 16
	ld de, .pokemon_channel_string
	ld a, OAKS_POKEMON_TALK_13
	jr PlaceRadioString

.pokemon_channel_string
	db "#MON Channel@"

OaksPKMNTalk13:
	ld hl, wRadioTextDelay
	dec [hl]
	ret nz
	hlcoord 12, 16
	ld de, .terminator
	ld a, OAKS_POKEMON_TALK_14
	jr PlaceRadioString

.terminator
	db "@"

OaksPKMNTalk14:
	ld hl, wRadioTextDelay
	dec [hl]
	ret nz
	ld e, MUSIC_POKEMON_TALK
	callfar RadioMusicRestartDE
	ld hl, .terminator
	call PrintText
	ld a, OAKS_POKEMON_TALK_4
	ld [wNextRadioLine], a
	xor a
	ld [wNumRadioLinesPrinted], a
	ld a, RADIO_SCROLL
	ld [wCurRadioLine], a
	ld a, 10
	ld [wRadioTextDelay], a
	ret

.terminator
	db "@"

PlaceRadioString:
	ld [wCurRadioLine], a
	ld a, 100
	ld [wRadioTextDelay], a
	jmp PlaceString

CopyBottomLineToTopLine:
	hlcoord 0, 15
	decoord 0, 13
	ld bc, SCREEN_WIDTH * 2
	jmp CopyBytes

ClearBottomLine:
	hlcoord 1, 15
	ld bc, SCREEN_WIDTH - 2
	ld a, " "
	call ByteFill
	hlcoord 1, 16
	ld bc, SCREEN_WIDTH - 2
	ld a, " "
	jmp ByteFill

.PokedexEntryBanks:
	db BANK("Pokedex Entries 001-064")
	db BANK("Pokedex Entries 065-128")
	db BANK("Pokedex Entries 129-192")
	db BANK("Pokedex Entries 193-251")

PokedexShow1:
	call StartRadioStation
.loop
	call Random
	cp NUM_POKEMON
	jr nc, .loop
	ld c, a
	push bc
	ld a, c
	call CheckCaughtMon
	pop bc
	jr z, .loop
	inc c
	ld a, c
	ld [wCurPartySpecies], a
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld hl, PokedexShowText
	ld a, POKEDEX_SHOW_2
	jmp NextRadioLine

PokedexShow2:
	ld a, [wCurPartySpecies]
	dec a
	ld hl, PokedexDataPointerTable
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	add hl, bc
 	; b = bank
 	ld a, BANK(PokedexDataPointerTable)
 	call GetFarByte
 	ld b, a
 	inc hl
 	; hl = address
	ld a, BANK(PokedexDataPointerTable)
	call GetFarWord
	ld a, b
	push af
	push hl
	call CopyDexEntryPart1
	dec hl
	ld [hl], "<DONE>"
	ld hl, wPokedexShowPointerAddr
	call CopyRadioTextToRAM
	pop hl
	pop af
	call CopyDexEntryPart2
rept 4
	inc hl
endr
	ld a, l
	ld [wPokedexShowPointerAddr], a
	ld a, h
	ld [wPokedexShowPointerAddr + 1], a
	ld a, POKEDEX_SHOW_3
	jmp PrintRadioLine

PokedexShow3:
	call CopyDexEntry
	ld a, POKEDEX_SHOW_4
	jmp PrintRadioLine

PokedexShow4:
	call CopyDexEntry
	ld a, POKEDEX_SHOW_5
	jmp PrintRadioLine

PokedexShow5:
	call CopyDexEntry
	ld a, POKEDEX_SHOW_6
	jmp PrintRadioLine

PokedexShow6:
	call CopyDexEntry
	ld a, POKEDEX_SHOW_7
	jmp PrintRadioLine

PokedexShow7:
	call CopyDexEntry
	ld a, POKEDEX_SHOW_8
	jmp PrintRadioLine

PokedexShow8:
	call CopyDexEntry
	ld a, POKEDEX_SHOW
	jmp PrintRadioLine

CopyDexEntry:
	ld a, [wPokedexShowPointerAddr]
	ld l, a
	ld a, [wPokedexShowPointerAddr + 1]
	ld h, a
	ld a, [wPokedexShowPointerBank]
	push af
	push hl
	call CopyDexEntryPart1
	dec hl
	ld [hl], "<DONE>"
	ld hl, wPokedexShowPointerAddr
	call CopyRadioTextToRAM
	pop hl
	pop af
	call CopyDexEntryPart2
	ret

CopyDexEntryPart1:
	ld de, wPokedexShowPointerBank
	ld bc, SCREEN_WIDTH - 1
	call FarCopyBytes
	ld hl, wPokedexShowPointerAddr
	ld [hl], TX_START
	inc hl
	ld [hl], "<LINE>"
	inc hl
.loop
	ld a, [hli]
	cp "@"
	ret z
	cp "<NEXT>"
	ret z
	cp "<DEXEND>"
	ret z
	jr .loop

CopyDexEntryPart2:
	ld d, a
.loop
	ld a, d
	call GetFarByte
	inc hl
	cp "@"
	jr z, .okay
	cp "<NEXT>"
	jr z, .okay
	cp "<DEXEND>"
	jr nz, .loop
.okay
	ld a, l
	ld [wPokedexShowPointerAddr], a
	ld a, h
	ld [wPokedexShowPointerAddr + 1], a
	ld a, d
	ld [wPokedexShowPointerBank], a
	ret

PokedexShowText:
	text_far _PokedexShowText
	text_end

BenMonMusic1:
	call StartPokemonMusicChannel
	ld hl, BenIntroText1
	ld a, POKEMON_MUSIC_2
	jmp NextRadioLine

BenMonMusic2:
	ld hl, BenIntroText2
	ld a, POKEMON_MUSIC_3
	jmp NextRadioLine

BenMonMusic3:
	ld hl, BenIntroText3
	ld a, POKEMON_MUSIC_4
	jmp NextRadioLine

BenFernMusic4:
	ld hl, BenFernText1
	ld a, POKEMON_MUSIC_5
	jmp NextRadioLine

BenFernMusic5:
	call GetWeekday
	and 1
	ld hl, BenFernText2A
	jr z, .SunTueThurSun
	ld hl, BenFernText2B
.SunTueThurSun:
	ld a, POKEMON_MUSIC_6
	jmp NextRadioLine

BenFernMusic6:
	call GetWeekday
	and 1
	ld hl, BenFernText3A
	jr z, .SunTueThurSun
	ld hl, BenFernText3B
.SunTueThurSun:
	ld a, POKEMON_MUSIC_7
	jmp NextRadioLine

BenFernMusic7:
	ret

StartPokemonMusicChannel:
	call RadioTerminator
	call PrintText
	ld e, MUSIC_POKEMON_MARCH
	call GetWeekday
	and 1
	jr z, .SunTueThurSun
	ld e, MUSIC_POKEMON_LULLABY
.SunTueThurSun:
	farjp RadioMusicRestartDE

BenIntroText1:
	text_far _BenIntroText1
	text_end

BenIntroText2:
	text_far _BenIntroText2
	text_end

BenIntroText3:
	text_far _BenIntroText3
	text_end

BenFernText1:
	text_far _BenFernText1
	text_end

BenFernText2A:
	text_far _BenFernText2A
	text_end

BenFernText2B:
	text_far _BenFernText2B
	text_end

BenFernText3A:
	text_far _BenFernText3A
	text_end

BenFernText3B:
	text_far _BenFernText3B
	text_end

CasinoBeats:
	call StartRadioStation
	ld a, 1
	ld [wNumRadioLinesPrinted], a
	ret

UnownRadio:
	call StartRadioStation
	ld a, 1
	ld [wNumRadioLinesPrinted], a
	ret

EvolutionRadio:
	call StartRadioStation
	ld a, 1
	ld [wNumRadioLinesPrinted], a
	ret

NationalPark:
	call StartRadioStation
	ld a, 1
	ld [wNumRadioLinesPrinted], a
	ret

BuenasPassword1:
; Determine if we need to be here
	call BuenasPasswordCheckTime
	jr nc, .PlayPassword
	ld a, [wNumRadioLinesPrinted]
	and a
	jmp z, BuenasPassword20
	jmp BuenasPassword8

.PlayPassword:
	call StartRadioStation
	ldh a, [hBGMapMode]
	push af
	xor a
	ldh [hBGMapMode], a
	ld de, BuenasPasswordChannelName
	hlcoord 2, 9
	call PlaceString
	pop af
	ldh [hBGMapMode], a
	ld hl, BuenaRadioText1
	ld a, BUENAS_PASSWORD_2
	jmp NextRadioLine

BuenasPassword2:
	ld hl, BuenaRadioText2
	ld a, BUENAS_PASSWORD_3
	jmp NextRadioLine

BuenasPassword3:
	call BuenasPasswordCheckTime
	ld hl, BuenaRadioText3
	jmp c, BuenasPasswordAfterMidnight
	ld a, BUENAS_PASSWORD_4
	jmp NextRadioLine

BuenasPassword4:
	call BuenasPasswordCheckTime
	jmp c, BuenasPassword8
	ld a, [wBuenasPassword]
; If we already generated the password today, we don't need to generate a new one.
	ld hl, wDailyFlags2
	bit DAILYFLAGS2_BUENAS_PASSWORD_F, [hl]
	jr nz, .AlreadyGotIt
; There are only 11 groups to choose from.
.greater_than_11
	call Random
	maskbits NUM_PASSWORD_CATEGORIES
	cp NUM_PASSWORD_CATEGORIES
	jr nc, .greater_than_11
; Store it in the high nybble of e.
	swap a
	ld e, a
; For each group, choose one of the three passwords.
.greater_than_three
	call Random
	maskbits NUM_PASSWORDS_PER_CATEGORY
	cp NUM_PASSWORDS_PER_CATEGORY
	jr nc, .greater_than_three
; The high nybble of wBuenasPassword will now contain the password group index, and the low nybble contains the actual password.
	add e
	ld [wBuenasPassword], a
; Set the flag so that we don't generate a new password this week.
	ld hl, wDailyFlags2
	set DAILYFLAGS2_BUENAS_PASSWORD_F, [hl]
.AlreadyGotIt:
	ld c, a
	call GetBuenasPassword
	ld hl, BuenaRadioText4
	ld a, BUENAS_PASSWORD_5
	jmp NextRadioLine

GetBuenasPassword:
; The password indices are held in c.  High nybble contains the group index, low nybble contains the word index.
; Load the password group pointer in hl.
	ld a, c
	swap a
	and $f
	ld hl, BuenasPasswordTable
	ld d, 0
	ld e, a
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
; Get the password type and store it in b.
	ld a, [hli]
	ld b, a
	push hl
	inc hl
; Get the password index.
	ld a, c
	and $f
	ld c, a
	push hl
	ld hl, .StringFunctionJumptable
	ld e, b
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop de ; de now contains the pointer to the value of this week's password, in Blue Card Points.
	call _hl_
	pop hl
	ld c, [hl]
	ret

.StringFunctionJumptable:
; entries correspond to BUENA_* constants
	table_width 2, GetBuenasPassword.StringFunctionJumptable
	dw .Mon       ; BUENA_MON
	dw .Item      ; BUENA_ITEM
	dw .Move      ; BUENA_MOVE
	dw .RawString ; BUENA_STRING
	assert_table_length NUM_BUENA_FUNCTIONS

.Mon:
	call .GetTheIndex
	call GetPokemonName
	ret

.Item:
	call .GetTheIndex
	call GetItemName
	ret

.Move:
	call .GetTheIndex
	call GetMoveName
	ret

.GetTheIndex:
	ld h, 0
	ld l, c
	add hl, de
	ld a, [hl]
	ld [wNamedObjectIndex], a
	ret

.RawString:
; Get the string from the table...
	ld a, c
	and a
	jr z, .skip
.read_loop
	ld a, [de]
	inc de
	cp "@"
	jr nz, .read_loop
	dec c
	jr nz, .read_loop
; ... and copy it into wStringBuffer1.
.skip
	ld hl, wStringBuffer1
.copy_loop
	ld a, [de]
	inc de
	ld [hli], a
	cp "@"
	jr nz, .copy_loop
	ld de, wStringBuffer1
	ret

INCLUDE "data/radio/buenas_passwords.asm"

BuenasPassword5:
	ld hl, BuenaRadioText5
	ld a, BUENAS_PASSWORD_6
	jmp NextRadioLine

BuenasPassword6:
	ld hl, BuenaRadioText6
	ld a, BUENAS_PASSWORD_7
	jmp NextRadioLine

BuenasPassword7:
	call BuenasPasswordCheckTime
	ld hl, BuenaRadioText7
	jr c, BuenasPasswordAfterMidnight
	ld a, BUENAS_PASSWORD
	jmp NextRadioLine

BuenasPasswordAfterMidnight:
	push hl
	ld hl, wDailyFlags2
	res DAILYFLAGS2_BUENAS_PASSWORD_F, [hl]
	pop hl
	ld a, BUENAS_PASSWORD_8
	jmp NextRadioLine

BuenasPassword8:
	ld hl, wDailyFlags2
	res DAILYFLAGS2_BUENAS_PASSWORD_F, [hl]
	ld hl, BuenaRadioMidnightText10
	ld a, BUENAS_PASSWORD_9
	jmp NextRadioLine

BuenasPassword9:
	ld hl, BuenaRadioMidnightText1
	ld a, BUENAS_PASSWORD_10
	jmp NextRadioLine

BuenasPassword10:
	ld hl, BuenaRadioMidnightText2
	ld a, BUENAS_PASSWORD_11
	jmp NextRadioLine

BuenasPassword11:
	ld hl, BuenaRadioMidnightText3
	ld a, BUENAS_PASSWORD_12
	jmp NextRadioLine

BuenasPassword12:
	ld hl, BuenaRadioMidnightText4
	ld a, BUENAS_PASSWORD_13
	jmp NextRadioLine

BuenasPassword13:
	ld hl, BuenaRadioMidnightText5
	ld a, BUENAS_PASSWORD_14
	jmp NextRadioLine

BuenasPassword14:
	ld hl, BuenaRadioMidnightText6
	ld a, BUENAS_PASSWORD_15
	jmp NextRadioLine

BuenasPassword15:
	ld hl, BuenaRadioMidnightText7
	ld a, BUENAS_PASSWORD_16
	jmp NextRadioLine

BuenasPassword16:
	ld hl, BuenaRadioMidnightText8
	ld a, BUENAS_PASSWORD_17
	jmp NextRadioLine

BuenasPassword17:
	ld hl, BuenaRadioMidnightText9
	ld a, BUENAS_PASSWORD_18
	jmp NextRadioLine

BuenasPassword18:
	ld hl, BuenaRadioMidnightText10
	ld a, BUENAS_PASSWORD_19
	jmp NextRadioLine

BuenasPassword19:
	ld hl, BuenaRadioMidnightText10
	ld a, BUENAS_PASSWORD_20
	jmp NextRadioLine

BuenasPassword20:
	ldh a, [hBGMapMode]
	push af
	farcall NoRadioMusic
	farcall NoRadioName
	pop af
	ldh [hBGMapMode], a
	ld hl, wDailyFlags2
	res DAILYFLAGS2_BUENAS_PASSWORD_F, [hl]
	ld a, BUENAS_PASSWORD
	ld [wCurRadioLine], a
	xor a
	ld [wNumRadioLinesPrinted], a
	ld hl, BuenaOffTheAirText
	ld a, BUENAS_PASSWORD_21
	jmp NextRadioLine

BuenasPassword21:
	ld a, BUENAS_PASSWORD
	ld [wCurRadioLine], a
	xor a
	ld [wNumRadioLinesPrinted], a
	call BuenasPasswordCheckTime
	jmp nc, BuenasPassword1
	ld hl, BuenaOffTheAirText
	ld a, BUENAS_PASSWORD_21
	jmp NextRadioLine

BuenasPasswordCheckTime:
	call UpdateTime
	ldh a, [hHours]
	cp EVE_HOUR
	ret

BuenasPasswordChannelName:
	db "BUENA'S PASSWORD@"

BuenaRadioText1:
	text_far _BuenaRadioText1
	text_end

BuenaRadioText2:
	text_far _BuenaRadioText2
	text_end

BuenaRadioText3:
	text_far _BuenaRadioText3
	text_end

BuenaRadioText4:
	text_far _BuenaRadioText4
	text_end

BuenaRadioText5:
	text_far _BuenaRadioText5
	text_end

BuenaRadioText6:
	text_far _BuenaRadioText6
	text_end

BuenaRadioText7:
	text_far _BuenaRadioText7
	text_end

BuenaRadioMidnightText1:
	text_far _BuenaRadioMidnightText1
	text_end

BuenaRadioMidnightText2:
	text_far _BuenaRadioMidnightText2
	text_end

BuenaRadioMidnightText3:
	text_far _BuenaRadioMidnightText3
	text_end

BuenaRadioMidnightText4:
	text_far _BuenaRadioMidnightText4
	text_end

BuenaRadioMidnightText5:
	text_far _BuenaRadioMidnightText5
	text_end

BuenaRadioMidnightText6:
	text_far _BuenaRadioMidnightText6
	text_end

BuenaRadioMidnightText7:
	text_far _BuenaRadioMidnightText7
	text_end

BuenaRadioMidnightText8:
	text_far _BuenaRadioMidnightText8
	text_end

BuenaRadioMidnightText9:
	text_far _BuenaRadioMidnightText9
	text_end

BuenaRadioMidnightText10:
	text_far _BuenaRadioMidnightText10
	text_end

BuenaOffTheAirText:
	text_far _BuenaOffTheAirText
	text_end

CopyRadioTextToRAM:
	ld a, [hl]
	cp TX_FAR
	jmp z, FarCopyRadioText
	ld de, wRadioText
	ld bc, 2 * SCREEN_WIDTH
	jmp CopyBytes

StartRadioStation:
	ld a, [wNumRadioLinesPrinted]
	and a
	ret nz
	call RadioTerminator
	call PrintText
	ld hl, RadioChannelSongs
	ld a, [wCurRadioLine]
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	farjp RadioMusicRestartDE

INCLUDE "data/radio/channel_music.asm"

NextRadioLine:
	push af
	call CopyRadioTextToRAM
	pop af
	jmp PrintRadioLine
