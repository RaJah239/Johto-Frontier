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
	const ROCKET_RADIO           ; 05
	const UNOWN_RADIO            ; 06
	const EVOLUTION_RADIO        ; 07
	const NATIONAL_PARK_RADIO    ; 08
DEF NUM_RADIO_CHANNELS EQU const_value
; internal indexes for channel segments
	const OAKS_POKEMON_TALK_2    ; 09
	const OAKS_POKEMON_TALK_3    ; 0a
	const OAKS_POKEMON_TALK_4    ; 0b
	const OAKS_POKEMON_TALK_5    ; 0c
	const OAKS_POKEMON_TALK_6    ; 0d
	const OAKS_POKEMON_TALK_7    ; 0e
	const OAKS_POKEMON_TALK_8    ; 0f
	const OAKS_POKEMON_TALK_9    ; 10
	const POKEDEX_SHOW_2         ; 11
	const POKEDEX_SHOW_3         ; 12
	const POKEDEX_SHOW_4         ; 13
	const POKEDEX_SHOW_5         ; 14
	const POKEMON_MUSIC_2        ; 15
	const POKEMON_MUSIC_3        ; 16
	const POKEMON_MUSIC_4        ; 17
	const POKEMON_MUSIC_5        ; 18
	const POKEMON_MUSIC_6        ; 19
	const POKEMON_MUSIC_7        ; 1a
	const ROCKET_RADIO_2         ; 1b
	const ROCKET_RADIO_3         ; 1c
	const ROCKET_RADIO_4         ; 1d
	const ROCKET_RADIO_5         ; 1e
	const ROCKET_RADIO_6         ; 1f
	const ROCKET_RADIO_7         ; 20
	const ROCKET_RADIO_8         ; 21
	const ROCKET_RADIO_9         ; 22
	const ROCKET_RADIO_10        ; 23
	const OAKS_POKEMON_TALK_10   ; 24
	const OAKS_POKEMON_TALK_11   ; 25
	const OAKS_POKEMON_TALK_12   ; 26
	const OAKS_POKEMON_TALK_13   ; 27
	const OAKS_POKEMON_TALK_14   ; 28
	const BUENAS_PASSWORD_2      ; 29
	const BUENAS_PASSWORD_3      ; 2a
	const BUENAS_PASSWORD_4      ; 2b
	const BUENAS_PASSWORD_5      ; 2c
	const BUENAS_PASSWORD_6      ; 2d
	const BUENAS_PASSWORD_7      ; 2e
	const BUENAS_PASSWORD_8      ; 2f
	const BUENAS_PASSWORD_9      ; 30
	const BUENAS_PASSWORD_10     ; 31
	const BUENAS_PASSWORD_11     ; 32
	const BUENAS_PASSWORD_12     ; 33
	const BUENAS_PASSWORD_13     ; 34
	const BUENAS_PASSWORD_14     ; 35
	const BUENAS_PASSWORD_15     ; 36
	const BUENAS_PASSWORD_16     ; 37
	const BUENAS_PASSWORD_17     ; 38
	const BUENAS_PASSWORD_18     ; 39
	const BUENAS_PASSWORD_19     ; 3a
	const BUENAS_PASSWORD_20     ; 3b
	const BUENAS_PASSWORD_21     ; 3c
	const RADIO_SCROLL           ; 3d
	const POKEDEX_SHOW_6         ; 3e
	const POKEDEX_SHOW_7         ; 3f
	const POKEDEX_SHOW_8         ; 40
DEF NUM_RADIO_SEGMENTS EQU const_value

; PlayRadioStationPointers indexes (see engine/pokegear/pokegear.asm)
	const_def
	const MAPRADIO_POKEMON_CHANNEL
	const MAPRADIO_OAKS_POKEMON_TALK
	const MAPRADIO_POKEDEX_SHOW
	const MAPRADIO_POKEMON_MUSIC
	const MAPRADIO_CASINO_BEATS
	const MAPRADIO_UNOWN
	const MAPRADIO_ROCKET
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
