; Music Player: three rows, picked with Up/Down, each changed with
; Left/Right:
; - Current Track: any song, played with A
; - Battle Track: replaces the battle theme (or Default)
; - Overworld Track: replaces the music of every map, the bike and Surf
;   music included (or Default); saved with the game
; Select puts the picked row back to Default (or the first song).

	const_def
	const MUSICPLAYER_CURRENT   ; 0
	const MUSICPLAYER_BATTLE    ; 1
	const MUSICPLAYER_OVERWORLD ; 2
DEF NUM_MUSICPLAYER_ROWS EQU const_value

_MusicPlayer:
	xor a
	ld [wUnusedScriptByte], a
	ld [wMenuCursorY], a ; MUSICPLAYER_CURRENT
	ld a, 1
	ld [wTempByteValue], a
	; to restart the map music on exit if the Overworld Track changed
	ld a, [wOverworldMusicOverride]
	push af

	call ClearBGPalettes
	call ClearTilemap
	call ClearSprites

	ld hl, MusicPlayerPalettes
	ld de, wBGPals1
	ld bc, 2 palettes
	call FarCopyColorWRAM

	ld hl, MusicPlayerGFX
	ld de, vTiles2
	lb bc, BANK(MusicPlayerGFX), 25
	call DecompressRequest2bpp

	ld hl, MusicPlayerTilemap
	decoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call CopyBytes

	call .DrawMusicPlayer

	call WaitBGMap
	ld b, SCGB_MUSIC_PLAYER
	call GetSGBLayout
	call SetDefaultBGPAndOBP

.loop
	call .GetMusicPlayerJoypad
	bit B_BUTTON_F, a
	jr nz, .exit
	bit A_BUTTON_F, a
	jr nz, .play
	bit SELECT_F, a
	jr nz, .default
	bit D_UP_F, a
	jr nz, .up
	bit D_DOWN_F, a
	jr nz, .down
	bit D_LEFT_F, a
	jr nz, .prev
	bit D_RIGHT_F, a
	jr nz, .next
	jr .loop

.up
	ld a, [wMenuCursorY]
	and a
	jr nz, .store_row_up
	ld a, NUM_MUSICPLAYER_ROWS
.store_row_up
	dec a
	jr .store_row

.down
	ld a, [wMenuCursorY]
	inc a
	cp NUM_MUSICPLAYER_ROWS
	jr c, .store_row
	xor a
.store_row
	ld [wMenuCursorY], a
	call .PlaceCursor
	call ApplyTilemap
	jr .loop

.prev
	ld c, -1
	jr .change

.next
	ld c, 1
.change
	call .ChangeTrack
	call .RefreshSongNames
	jr .loop

.play
	call .PlaySelectedRow
	jr .loop

.default
	call .SetRowDefault
	call .RefreshSongNames
	jr .loop

.exit
	pop af
	ld b, a
	ld a, [wOverworldMusicOverride]
	cp b
	call nz, PlayMapMusicBike
	call UpdateSprites
	call WaitBGMap
	ld hl, .ExitScript
	jmp QueueScript

.ChangeTrack:
; Move the picked row's track by c (+1/-1) through the song list; the
; Battle and Overworld rows have Default before the first song.
	ld a, [wMenuCursorY]
	and a ; MUSICPLAYER_CURRENT
	jr nz, .change_saved
	; 1..count, wrapping
	ld a, [wTempByteValue]
	add c
	jr z, .wrap_to_last
	ld b, a
	call .GetSongCount
	cp b
	ld a, b
	jr nc, .store_current
	ld a, 1
	jr .store_current
.wrap_to_last
	call .GetSongCount
.store_current
	ld [wTempByteValue], a
	ret

.change_saved
	; 0 (Default)..count, wrapping
	call .GetSavedRowSongIndex
	add c
	cp -1
	jr z, .saved_wrap_to_last
	ld b, a
	call .GetSongCount
	cp b
	ld a, b
	jr nc, .store_saved
	xor a
	jr .store_saved
.saved_wrap_to_last
	call .GetSongCount
.store_saved
	and a
	jr z, .store_saved_id
	call .GetSongIDAtIndex
.store_saved_id
	jr .SetSavedRowSong

.SetRowDefault:
	ld a, [wMenuCursorY]
	and a ; MUSICPLAYER_CURRENT
	jr nz, .default_saved
	ld a, 1
	ld [wTempByteValue], a
	ret

.default_saved
	xor a
	; fallthrough

.SetSavedRowSong:
; Save song ID a (0 = Default) for the picked Battle/Overworld row.
	ld b, a
	ld a, [wMenuCursorY]
	cp MUSICPLAYER_BATTLE
	ld a, b
	jr nz, .set_overworld
	ld [wPersistentBattleMusicOverride], a
	xor a
	ld [wPersistentBattleMusicOverride + 1], a
	ret

.set_overworld
	ld [wOverworldMusicOverride], a
	ret

.GetSavedRowSongID:
; a = song ID saved for the picked Battle/Overworld row (0 = Default)
	ld a, [wMenuCursorY]
	cp MUSICPLAYER_BATTLE
	jr nz, .get_overworld
	ld a, [wPersistentBattleMusicOverride]
	ret

.get_overworld
	ld a, [wOverworldMusicOverride]
	ret

.GetSavedRowSongIndex:
; a = list index (1..count) of the picked row's saved song, 0 if Default
; (or a song that isn't in the list). Preserves c.
	call .GetSavedRowSongID
	and a
	ret z
	ld e, a
	call .GetSongCount
	ld d, a
	ld b, 1
.find_loop
	ld a, b
	push de
	call .GetSongIDAtIndex
	pop de
	cp e
	ld a, b
	ret z
	inc b
	ld a, d
	cp b
	jr nc, .find_loop
	xor a
	ret

.PlaySelectedRow:
	ld a, [wMenuCursorY]
	and a ; MUSICPLAYER_CURRENT
	jr nz, .play_saved
	call .GetSelectedSongID
	jr .play_song

.play_saved
	call .GetSavedRowSongID
	and a
	ret z ; Default: nothing to play
.play_song
	ld e, a
	ld d, 0
	ld a, 1
	ld [wUnusedScriptByte], a
	jmp PlayMusic2

.GetSongCount:
	ld hl, MusicPlayerSongs
	ld a, BANK(MusicPlayerSongs)
	jmp GetFarByte

.GetSelectedSongID:
	ld a, [wTempByteValue]
	; fallthrough

.GetSongIDAtIndex:
; a = song ID of list entry a (1..count). Preserves bc.
	push bc
	dec a
	ld c, a
	ld b, 0
	ld hl, MusicPlayerSongs + 1
	add hl, bc
	pop bc
	ld a, BANK(MusicPlayerSongs)
	jmp GetFarByte

.PlaceCurrentSongName:
	hlcoord 1, 5
	lb bc, 1, 18
	call ClearBox
	call .GetCurrentSongName
	hlcoord 1, 5
	jmp FarPlaceString

.PlaceSavedSongName:
; song ID a (0 = Default) at hl
	push hl
	push af
	lb bc, 1, 18
	call ClearBox
	pop af
	pop hl
	and a
	jr nz, .saved_song
	ld bc, 6
	add hl, bc
	ld de, .DefaultName
	jmp PlaceString

.saved_song
	push hl
	call .GetSongName
	pop hl
	jmp FarPlaceString

.RefreshSongNames:
	call .PlaceCurrentSongName
	hlcoord 1, 7
	ld a, [wPersistentBattleMusicOverride]
	call .PlaceSavedSongName
	hlcoord 1, 9
	ld a, [wOverworldMusicOverride]
	call .PlaceSavedSongName
	jmp ApplyTilemap

.PlaceCursor:
; ▶ before the picked row's label, blank before the others
	hlcoord 1, 4
	ld de, SCREEN_WIDTH * 2
	ld a, [wMenuCursorY]
	ld c, a
	ld b, 0
.cursor_loop
	ld a, b
	cp c
	ld a, "▶"
	jr z, .place_cursor
	ld a, " "
.place_cursor
	ld [hl], a
	add hl, de
	inc b
	ld a, b
	cp NUM_MUSICPLAYER_ROWS
	jr c, .cursor_loop
	ret

.GetCurrentSongName:
	call .GetSelectedSongID

.GetSongName:
	; Read the far pointer for the selected song name from the packed pointer table.
	ld hl, MusicPlayerSongNamePointers
	ld c, 3
	ld b, 0
	call AddNTimes
	ld a, BANK(MusicPlayerSongNamePointers)
	call GetFarByte
	ld b, a
	inc hl
	ld a, BANK(MusicPlayerSongNamePointers)
	call GetFarByte
	ld e, a
	inc hl
	ld a, BANK(MusicPlayerSongNamePointers)
	call GetFarByte
	ld d, a
	ret

.DrawMusicPlayer:
	hlcoord 4, 1
	ld de, .Title
	call PlaceString
	hlcoord 2, 4
	ld de, .CurrentLabel
	call PlaceString
	hlcoord 2, 6
	ld de, .BattleLabel
	call PlaceString
	hlcoord 2, 8
	ld de, .OverworldLabel
	call PlaceString
	call .PlaceCursor
	hlcoord 1, 12
	ld de, .ABButtons
	call PlaceString
	hlcoord 1, 14
	ld de, .DPadButtons
	call PlaceString
	hlcoord 1, 16
	ld de, .SelectButton
	call PlaceString
	jmp .RefreshSongNames

.GetMusicPlayerJoypad:
.wait
	call JoyTextDelay_ForcehJoyDown
	ld a, c
	and A_BUTTON | B_BUTTON | SELECT
	jr nz, .done_repeat
	ldh a, [hJoyPressed]
	and D_PAD
	jr nz, .done
	jr .wait

.done_repeat
	ld a, c
.done
	ret

.ExitScript:
	refreshmap
	endtext

.ABButtons:
	db " A: Play  B: Quit@"

.DPadButtons:
	db "▲▼: Row ←→: Track@"

.SelectButton:
	db " Select: Default@"

.CurrentLabel:
	db "Current Track:@"

.BattleLabel:
	db "Battle Track:@"

.OverworldLabel:
	db "Overworld Track:@"

.DefaultName:
	db "Default@"

.Title:
	db "Music Player@"

MusicPlayerPalettes:
INCLUDE "gfx/music_player/music_player.pal"
MusicPlayerGFX:
INCBIN "gfx/music_player/music_player.2bpp.lz"
MusicPlayerTilemap:
INCBIN "gfx/music_player/music_player.tilemap"
