; Persistent per-species palette overrides and the editor
;
; The override store lives in WRAM bank 5 (see wMonPalOverride* in
; ram/wram.asm) so the palette loader can read it directly while that
; bank is mapped. It is mirrored into the save file (see ram/sram.asm).
;
; This file is assembled into the same ROM bank as the debug colour
; picker (engine/debug/color_picker.asm) so the editor can reuse its
; screen drawing helpers.

; ----------------------------------------------------------------------
; Save/load
; ----------------------------------------------------------------------

; Copy the runtime store to the main save slot. The caller must have the
; "Save" SRAM bank open.
SaveMonPalOverridesToSRAM::
	ld hl, sMonPalOverrides
	jr _SaveMonPalOverrides

; Copy the runtime store to the backup save slot. The caller must have
; the "Backup Save" SRAM bank open.
SaveBackupMonPalOverridesToSRAM::
	ld hl, sBackupMonPalOverrides
	; fallthrough

_SaveMonPalOverrides:
; hl = destination struct (count, check, entries)
	ld d, h
	ld e, l
	ldh a, [rSVBK]
	push af
	ld a, BANK(wMonPalOverrideCount)
	ldh [rSVBK], a
	ld a, [wMonPalOverrideCount]
	ld [de], a
	inc de
	ld a, SAVE_CHECK_VALUE_1
	ld [de], a
	inc de
	ld hl, wMonPalOverrideEntries
	ld bc, MAX_MON_PAL_OVERRIDES * MON_PAL_OVERRIDE_SIZE
	call CopyBytes
	pop af
	ldh [rSVBK], a
	ret

; Restore the runtime store from the main save slot.
LoadMonPalOverridesFromSRAM::
	ld hl, sMonPalOverrides
	jr _LoadMonPalOverrides

; Restore the runtime store from the backup save slot.
LoadBackupMonPalOverridesFromSRAM::
	ld hl, sBackupMonPalOverrides
	; fallthrough

_LoadMonPalOverrides:
; hl = source struct (count, check, entries)
	ld d, h
	ld e, l
	ldh a, [rSVBK]
	push af
	ld a, BANK(wMonPalOverrideCount)
	ldh [rSVBK], a
	ld a, [de]
	ld b, a
	inc de
	ld a, [de]
	cp SAVE_CHECK_VALUE_1
	jr nz, .invalid
	inc de
	ld a, b
	cp MAX_MON_PAL_OVERRIDES + 1
	jr c, .count_ok
	ld a, MAX_MON_PAL_OVERRIDES
.count_ok
	ld [wMonPalOverrideCount], a
	; CopyBytes goes hl -> de, so the SRAM cursor (currently in de,
	; already advanced past count and check) must be the source and the
	; WRAM store the destination. de covers both the main and backup
	; slots, since they share this routine.
	ld h, d
	ld l, e
	ld de, wMonPalOverrideEntries
	ld bc, MAX_MON_PAL_OVERRIDES * MON_PAL_OVERRIDE_SIZE
	call CopyBytes
	call MonPalOverrides_RebuildSlots
	pop af
	ldh [rSVBK], a
	ret
.invalid
	call MonPalOverrides_Clear
	pop af
	ldh [rSVBK], a
	ret

; Clear the runtime store. Requires SVBK = BANK(wMonPalOverrideCount).
MonPalOverrides_Clear:
	xor a
	ld [wMonPalOverrideCount], a
	ld hl, wMonPalOverrideSlots
	ld bc, NUM_POKEMON + 1
	jmp ByteFill

; Rebuild the species -> entry lookup from the entries. Requires SVBK =
; BANK(wMonPalOverrideCount).
MonPalOverrides_RebuildSlots:
	xor a
	ld hl, wMonPalOverrideSlots
	ld bc, NUM_POKEMON + 1
	call ByteFill
	ld a, [wMonPalOverrideCount]
	and a
	ret z
	ld c, a
	ld b, 0
	ld hl, wMonPalOverrideEntries
.loop
	push bc
	ld a, [hl]
	ld e, a
	ld d, 0
	push hl
	ld hl, wMonPalOverrideSlots
	add hl, de
	ld a, b
	inc a
	ld [hl], a
	pop hl
	ld de, MON_PAL_OVERRIDE_SIZE
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop
	ret

; Drop every entry whose species byte is 0. Callers mark an entry for
; removal by zeroing that byte, since species 0 never occurs in a real
; entry. Compacts the array, updates the count and rebuilds the lookup.
; Requires SVBK = BANK(wMonPalOverrideEntries).
MonPalOverrides_RemoveMarked:
	ld a, [wMonPalOverrideCount]
	ld b, a
	ld c, 0
	ld hl, wMonPalOverrideEntries
	ld de, wMonPalOverrideEntries
.loop
	ld a, b
	and a
	jr z, .done
	ld a, [hl]
	and a
	jr z, .drop
	; keep this entry: copy it down to the write position
	push bc
	ld c, MON_PAL_OVERRIDE_SIZE
.keep
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .keep
	pop bc
	inc c
	jr .next

.drop
	; marked for removal: just step over it
	push bc
	ld c, MON_PAL_OVERRIDE_SIZE
.skip
	inc hl
	dec c
	jr nz, .skip
	pop bc
.next
	dec b
	jr .loop

.done
	ld a, c
	ld [wMonPalOverrideCount], a
	jr MonPalOverrides_RebuildSlots

; ----------------------------------------------------------------------
; Runtime store access
; ----------------------------------------------------------------------

; Input: a = species. Requires SVBK = BANK(wMonPalOverrideSlots).
; Output: carry set and no valid hl if the species has no entry, else
; hl = pointer to its entry.
MonPalEdit_EntryPtr:
	cp NUM_POKEMON + 1
	jr nc, .none
	ld e, a
	ld d, 0
	ld hl, wMonPalOverrideSlots
	add hl, de
	ld a, [hl]
	and a
	jr z, .none
	dec a
	ld l, a
	ld h, 0
	add hl, hl
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, de
	ld de, wMonPalOverrideEntries
	add hl, de
	and a
	ret

.none
	scf
	ret

; Create an entry for wCurPartySpecies if it does not have one. Returns
; carry if the store is full and the species is new.
MonPalEdit_EnsureEntry:
	ldh a, [rSVBK]
	push af
	ld a, [wCurPartySpecies]
	ld b, a
	ld a, BANK(wMonPalOverrideSlots)
	ldh [rSVBK], a
	ld a, b
	call MonPalEdit_EntryPtr
	jr nc, .done
	ld a, [wMonPalOverrideCount]
	cp MAX_MON_PAL_OVERRIDES
	jr nc, .full
	ld c, a
	inc a
	ld [wMonPalOverrideCount], a
	; hl = wMonPalOverrideEntries + c * MON_PAL_OVERRIDE_SIZE
	ld a, c
	ld l, a
	ld h, 0
	add hl, hl
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, de
	ld de, wMonPalOverrideEntries
	add hl, de
	; species and flags
	ld a, b
	ld [hli], a
	xor a
	ld [hli], a
	; start from the default ROM palettes
	ld d, h
	ld e, l
	push bc
	ld a, b
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld bc, PokemonPalettes
	add hl, bc
	ld b, 2 * PAL_COLOR_SIZE * 2 ; normal and shiny
.rom_loop
	ld a, BANK(PokemonPalettes)
	call GetFarByte
	ld [de], a
	inc hl
	inc de
	dec b
	jr nz, .rom_loop
	pop bc
	; point the lookup at the new entry
	ld e, b
	ld d, 0
	ld hl, wMonPalOverrideSlots
	add hl, de
	ld a, c
	inc a
	ld [hl], a
.done
	pop af
	ldh [rSVBK], a
	and a
	ret

.full
	pop af
	ldh [rSVBK], a
	scf
	ret

; Copy the entry for the current variant into wDebugOriginalColors so the
; shared colour picker helpers can read it.
MonPalEdit_LoadVariant:
	ldh a, [rSVBK]
	push af
	ld a, [wCurPartySpecies]
	ld b, a
	ld a, [wDebugColorIsShiny]
	ld c, a
	ld a, BANK(wMonPalOverrideSlots)
	ldh [rSVBK], a
	ld a, b
	call MonPalEdit_EntryPtr
	jr c, .done
	; hl = entry; add 2 (species, flags) + variant
	ld a, c
	ld e, a
	ld d, 0
	inc hl
	inc hl
	add hl, de
	push hl
	ld a, b
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld de, wDebugOriginalColors
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ld b, PAL_COLOR_SIZE * 2
.copy
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .copy
.done
	pop af
	ldh [rSVBK], a
	ret

; Write the live palette (wDebugMiddleColors) into the entry for the
; current variant.
MonPalEdit_Commit:
	ldh a, [rSVBK]
	push af
	ld a, [wCurPartySpecies]
	ld b, a
	ld a, [wDebugColorIsShiny]
	ld c, a
	ld a, BANK(wMonPalOverrideSlots)
	ldh [rSVBK], a
	ld a, b
	call MonPalEdit_EntryPtr
	jr c, .done
	; set the flag for the current variant
	inc hl
	ld a, c
	and a
	jr nz, .shiny
	set MON_PAL_FLAG_NORMAL, [hl]
	jr .flagged

.shiny
	set MON_PAL_FLAG_SHINY, [hl]
.flagged
	; hl = entry + 1; colours start at entry + 2 + variant
	ld a, c
	ld e, a
	ld d, 0
	inc hl
	add hl, de
	ld de, wDebugMiddleColors
	ld b, PAL_COLOR_SIZE * 2
.copy
	ld a, [de]
	ld [hli], a
	inc de
	dec b
	jr nz, .copy
.done
	pop af
	ldh [rSVBK], a
	ret

; ----------------------------------------------------------------------
; Editor
; ----------------------------------------------------------------------

; Special called by a map script. Selects a party Pokemon, then runs the
; palette editor.
;
; wScriptVar: 0 = the selection was cancelled (or not a CGB),
;             1 = the editor was used,
;             2 = the override store is full,
;             3 = the selected Pokemon is an Egg.
MonPaletteEditor::
	xor a
	ld [wScriptVar], a
	ldh a, [hCGB]
	and a
	ret z
	farcall SelectMonFromPartyNoMap
	jr nc, .selected
	xor a
	ld [wScriptVar], a
	ret

.selected
	ld a, [wCurPartySpecies]
	cp EGG
	jr nz, .not_egg
	; Eggs cannot be recoloured. Put the map and speech textbox back so
	; the script can explain why.
	call ReturnToMapWithSpeechTextbox
	ld a, 3
	ld [wScriptVar], a
	ret

.not_egg
	call MonPalEdit_EnsureEntry
	jr c, .full
	farcall FadeOutPalettes
	call ClearSprites
	call DelayFrame
	call EnableSpriteUpdates

	; The editor owns the screen, so stop overworld tile animations from
	; drawing into it. Restored below, after the map has been rebuilt.
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a

	ldh a, [hInMenu]
	push af
	ld a, TRUE
	ldh [hInMenu], a

	call DisableLCD
	call DebugColor_InitVRAM
	call DebugColor_LoadGFX
	call DebugColor_InitPalettes
	call MonPalEdit_Begin
	call EnableLCD

	xor a
	ld [wJumptableIndex], a
.loop
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .exit
	call MonPalEditMain
	call DebugColor_PlaceCursor
	call DelayFrame
	jr .loop

.exit
	call MonPalEdit_Commit
	call MonPalEdit_SaveToSRAM

	pop af
	ldh [hInMenu], a

	; DebugColor_InitVRAM/LoadGFX overwrote the tileset graphics and the
	; tilemap in VRAM, so the overworld has to be rebuilt before we hand
	; control back to the script (which then closes the speech textbox).
	call ReturnToMapWithSpeechTextbox

	pop af
	ldh [hMapAnims], a

	ld a, 1
	ld [wScriptVar], a
	ret
.full
	; The editor never took over the screen, so the party menu is still
	; up. Rebuild the map and the speech textbox for the script's message.
	call ReturnToMapWithSpeechTextbox
	ld a, 2
	ld [wScriptVar], a
	ret

; Point the shared picker at the chosen species and load its normal
; palette as the starting point.
MonPalEdit_Begin:
	ld a, [wCurPartySpecies]
	dec a
	ld [wDebugColorCurMon], a
	xor a
	ld [wDebugColorIsTrainer], a
	ld [wDebugColorIsShiny], a
	ld [wDebugColorCurColor], a
	ld [wDebugColorRGBJumptableIndex], a
	jmp MonPalEdit_LoadVariant

MonPalEditMain:
	call JoyTextDelay
	; Start and Select are deliberately ignored here. B leaves the
	; editor; a Pokemon is returned to its default colours from the
	; NPC's menu instead.
	jumptable .Jumptable, wJumptableIndex

.Jumptable:
	dw DebugColor_InitScreen
	dw DebugColor_UpdateScreen
	dw DebugColor_UpdatePalettes
	dw MonPalEdit_Joypad

.exit
	ld a, $80
	ld [wJumptableIndex], a
	ret

MonPalEdit_Joypad:
	ldh a, [hJoyLast]
	and B_BUTTON
	jr nz, MonPalEditMain.exit
	ldh a, [hJoyLast]
	and A_BUTTON
	jr nz, .toggle
	ld a, [wDebugColorRGBJumptableIndex]
	maskbits 4
	ld e, a
	ld d, 0
	ld hl, .PointerTable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl
.toggle
	jr MonPalEdit_ToggleShiny

.PointerTable:
	dw DebugColor_SelectColorBox
	dw DebugColor_ChangeRedValue
	dw DebugColor_ChangeGreenValue
	dw DebugColor_ChangeBlueValue

MonPalEdit_ToggleShiny:
	call MonPalEdit_Commit
	ld a, [wDebugColorIsShiny]
	xor %00000100
	ld [wDebugColorIsShiny], a
	call MonPalEdit_LoadVariant
	call DebugColor_SetRGBMeter
	ld a, DEBUGCOLORMAIN_INITSCREEN
	ld [wJumptableIndex], a
	ret

MonPalEdit_SaveToSRAM:
	ld a, BANK(sMonPalOverrides)
	call OpenSRAM
	call SaveMonPalOverridesToSRAM
	jmp CloseSRAM

; ----------------------------------------------------------------------
; Reset to default
; ----------------------------------------------------------------------

; Special: pick a party Pokemon and discard its palette override, so
; both its normal and shiny palettes come from the ROM again. This also
; frees the slot the species was occupying in the override store.
;
; wScriptVar: 0 = selection cancelled (or not a CGB), 1 = the override
; was dropped, 2 = the Pokemon had no override to drop, 3 = the selected
; Pokemon is an Egg.
MonPaletteReset::
	xor a
	ld [wScriptVar], a
	ldh a, [hCGB]
	and a
	ret z
	farcall SelectMonFromParty
	ret c                      ; carry set = cancelled (wScriptVar stays 0)
	ld a, [wCurPartySpecies]
	cp EGG
	jr nz, .not_egg
	; Eggs have no editable colours to reset.
	ld a, 3
	ld [wScriptVar], a
	ret

.not_egg
	; Capture state before touching SVBK.
	ld a, [wCurPartySpecies]
	ld b, a
	ldh a, [rSVBK]
	push af
	ld a, BANK(wMonPalOverrideSlots)
	ldh [rSVBK], a
	ld a, b
	call MonPalEdit_EntryPtr
	jr c, .at_default
	; Mark the entry for removal and compact the store.
	xor a
	ld [hl], a
	call MonPalOverrides_RemoveMarked
	pop af
	ldh [rSVBK], a
	call MonPalEdit_SaveToSRAM
	ld a, 1
	ld [wScriptVar], a
	ret

.at_default
	pop af
	ldh [rSVBK], a
	ld a, 2
	ld [wScriptVar], a
	ret
