Mobile22_PromptButton:
	call JoyWaitAorB
	call PlayClickSFX
	ret

Function893b3:
	call DisableLCD
	call ClearSprites
	call LoadStandardFont
	call LoadFontsExtra
	call Function893ef
	call Function8942b
	call Function89455
	call EnableLCD
	ret

Function893ef:
	ld de, vTiles0
	ld hl, EZChatCursorGFX
	ld bc, $20
	ld a, BANK(EZChatCursorGFX)
	call FarCopyBytes
	ret

EZChatCursorGFX:
INCBIN "gfx/mobile/ez_chat_cursor.2bpp"

Function8942b:
	ld de, vTiles0 tile $02
	ld hl, CardLargeSpriteAndFolderGFX
	ld bc, 8 tiles ; just the large card sprite
	ld a, BANK(CardLargeSpriteAndFolderGFX)
	call FarCopyBytes
	ld de, vTiles0 tile $0a
	ld hl, CardSpriteGFX
	ld bc, 4 tiles
	ld a, BANK(CardSpriteGFX)
	call FarCopyBytes
	ret

Function89455:
	ld hl, CardLargeSpriteAndFolderGFX
	ld de, vTiles2 tile $0c
	ld bc, (8 + 65) tiles ; large card sprite + folder
	ld a, BANK(CardLargeSpriteAndFolderGFX)
	call FarCopyBytes
	ret
