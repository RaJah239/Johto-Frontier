; radio channel ids
; indexes for:
; - RadioChannelSongs (see data/radio/channel_music.asm)
; - PlayRadioShow/RadioJumptable (see engine/pokegear/radio.asm)
; - RadioChannels (see engine/pokegear/pokegear.asm)
	const_def
	const OAKS_POKEMON_TALK      ; 00
	const POKEDEX_SHOW           ; 01
	const POKEMON_MUSIC          ; 02
	const CASINO_BEATS           ; 03
	const BUENAS_PASSWORD        ; 04
	const UNOWN_RADIO            ; 05
	const EVOLUTION_RADIO        ; 06
	const NATIONAL_PARK_RADIO    ; 07
DEF NUM_RADIO_CHANNELS EQU const_value
; internal indexes for channel segments
	const OAKS_POKEMON_TALK_2    ; 08
	const OAKS_POKEMON_TALK_3    ; 09
	const OAKS_POKEMON_TALK_4    ; 0a
	const OAKS_POKEMON_TALK_5    ; 0b
	const OAKS_POKEMON_TALK_6    ; 0c
	const OAKS_POKEMON_TALK_7    ; 0d
	const OAKS_POKEMON_TALK_8    ; 0e
	const OAKS_POKEMON_TALK_9    ; 0f
	const POKEDEX_SHOW_2         ; 10
	const POKEDEX_SHOW_3         ; 11
	const POKEDEX_SHOW_4         ; 12
	const POKEDEX_SHOW_5         ; 13
	const POKEMON_MUSIC_2        ; 14
	const POKEMON_MUSIC_3        ; 15
	const POKEMON_MUSIC_4        ; 16
	const POKEMON_MUSIC_5        ; 17
	const POKEMON_MUSIC_6        ; 18
	const POKEMON_MUSIC_7        ; 19
	const OAKS_POKEMON_TALK_10   ; 1a
	const OAKS_POKEMON_TALK_11   ; 1b
	const OAKS_POKEMON_TALK_12   ; 1c
	const OAKS_POKEMON_TALK_13   ; 1d
	const OAKS_POKEMON_TALK_14   ; 1e
	const BUENAS_PASSWORD_2      ; 1f
	const BUENAS_PASSWORD_3      ; 20
	const BUENAS_PASSWORD_4      ; 21
	const BUENAS_PASSWORD_5      ; 22
	const BUENAS_PASSWORD_6      ; 23
	const BUENAS_PASSWORD_7      ; 24
	const BUENAS_PASSWORD_8      ; 25
	const BUENAS_PASSWORD_9      ; 26
	const BUENAS_PASSWORD_10     ; 27
	const BUENAS_PASSWORD_11     ; 28
	const BUENAS_PASSWORD_12     ; 29
	const BUENAS_PASSWORD_13     ; 2a
	const BUENAS_PASSWORD_14     ; 2b
	const BUENAS_PASSWORD_15     ; 2c
	const BUENAS_PASSWORD_16     ; 2d
	const BUENAS_PASSWORD_17     ; 2e
	const BUENAS_PASSWORD_18     ; 2f
	const BUENAS_PASSWORD_19     ; 30
	const BUENAS_PASSWORD_20     ; 31
	const BUENAS_PASSWORD_21     ; 32
	const RADIO_SCROLL           ; 33
	const POKEDEX_SHOW_6         ; 34
	const POKEDEX_SHOW_7         ; 35
	const POKEDEX_SHOW_8         ; 36
DEF NUM_RADIO_SEGMENTS EQU const_value

; PlayRadioStationPointers indexes (see engine/pokegear/pokegear.asm)
	const_def
	const MAPRADIO_POKEMON_CHANNEL
	const MAPRADIO_OAKS_POKEMON_TALK
	const MAPRADIO_POKEDEX_SHOW
	const MAPRADIO_POKEMON_MUSIC
	const MAPRADIO_CASINO_BEATS
	const MAPRADIO_UNOWN
DEF NUM_MAP_RADIO_STATIONS EQU const_value

; These tables in engine/pokegear/radio.asm are all sized to a power of 2
; so there's no need for a rejection sampling loop
DEF NUM_OAKS_POKEMON_TALK_ADVERBS    EQU 16 ; OaksPKMNTalk8.Adverbs
DEF NUM_OAKS_POKEMON_TALK_ADJECTIVES EQU 16 ; OaksPKMNTalk9.Adjectives

; BuenasPasswordTable sizes (see data/radio/buenas_passwords.asm)
DEF NUM_PASSWORD_CATEGORIES    EQU 11
DEF NUM_PASSWORDS_PER_CATEGORY EQU  3

; BuenaPrizeItems size (see data/items/buena_prizes.asm)
DEF NUM_BUENA_PRIZES EQU 9

; GetBuenasPassword.StringFunctionJumpTable indexes (see engine/pokegear/radio.asm)
	const_def
	const BUENA_MON
	const BUENA_ITEM
	const BUENA_MOVE
	const BUENA_STRING
DEF NUM_BUENA_FUNCTIONS EQU const_value
