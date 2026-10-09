; ====================================
; === Debug Move Animation Testing ===
; ====================================
IF DEF(_DEBUG) ; for testing animations
MoveTable:
	db ZEN_HEADBUTT ; 01
	db KARATE_CHOP  ; 02
	db BUG_BITE     ; 03
	db STONE_EDGE   ; 04
	db MOONBLAST    ; 05
	db PLAY_ROUGH   ; 06
	db FIRE_PUNCH   ; 07
	db ICE_PUNCH    ; 08
	db THUNDERPUNCH ; 09
	db AQUA_JET     ; 0a
	db BULK_UP      ; 0b
	db FLASH_CANNON ; 0c
	db AIR_SLASH    ; 0d
	db SWORDS_DANCE ; 0e
	db CUT          ; 0f
	db GUST         ; 10
	db WING_ATTACK  ; 11
	db WHIRLWIND    ; 12
	db FLY          ; 13
	db ICICLE_CRASH ; 14
	db POWER_GEM    ; 15
	db VINE_WHIP    ; 16
	db STOMP        ; 17
	db ROOST        ; 18
	db FOCUS_BLAST  ; 19
	db STICKY_WEB   ; 1a
	db SEED_BOMB    ; 1b
	db DRAIN_KISS   ; 1c
	db HEADBUTT     ; 1d
	db HORN_ATTACK  ; 1e
	db GIGA_IMPACT  ; 1f
	db ROCK_TOMB    ; 20
	db TACKLE       ; 21
	db BODY_SLAM    ; 22
	db WRAP         ; 23
	db PSYBLAST     ; 24
	db SUCKER_PUNCH ; 25
	db DOUBLE_EDGE  ; 26
	db DRAIN_PUNCH  ; 27
	db POISON_STING ; 28
	db MILK_DRINK   ; 29
	db THRASH       ; 2a
	db LEER         ; 2b
	db BITE         ; 2c
	db GROWL        ; 2d
	db ROAR         ; 2e
	db SING         ; 2f
	db SUPERSONIC   ; 30
	db NASTY_PLOT   ; 31
	db DISABLE      ; 32
	db ACID         ; 33
	db EMBER        ; 34
	db FLAMETHROWER ; 35
	db MIST         ; 36
	db WATER_GUN    ; 37
	db HYDRO_PUMP   ; 38
	db SURF         ; 39
	db ICE_BEAM     ; 3a
	db BLIZZARD     ; 3b
	db PSYBEAM      ; 3c
	db BUBBLEBEAM   ; 3d
	db AURORA_BEAM  ; 3e
	db HYPER_BEAM   ; 3f
	db PECK         ; 40
	db DRILL_PECK   ; 41
	db CLOSE_COMBAT ; 42
	db LOW_KICK     ; 43
	db COUNTER      ; 44
	db SEISMIC_TOSS ; 45
	db ROCK_THROW   ; 46
	db ABSORB       ; 47
	db MEGA_DRAIN   ; 48
	db LEECH_SEED   ; 49
	db GROWTH       ; 4a
	db LEAF_BLADE   ; 4b
	db SOLARBEAM    ; 4c
	db POISONPOWDER ; 4d
	db STUN_SPORE   ; 4e
	db SLEEP_POWDER ; 4f
	db AVALANCHE    ; 50
	db STRING_SHOT  ; 51
	db DRAGON_RAGE  ; 52
	db FIRE_SPIN    ; 53
	db THUNDERSHOCK ; 54
	db THUNDERBOLT  ; 55
	db THUNDER_WAVE ; 56
	db THUNDER      ; 57
	db ROCK_BLAST   ; 58
	db EARTHQUAKE   ; 59
	db PSYCHO_CUT   ; 5a
	db DIG          ; 5b
	db TOXIC        ; 5c
	db CONFUSION    ; 5d
	db PSYCHIC_M    ; 5e
	db HYPNOSIS     ; 5f
	db DIVE_BOMB    ; 60
	db AGILITY      ; 61
	db QUICK_ATTACK ; 62
	db IRON_HEAD    ; 63
	db TELEPORT     ; 64
	db NIGHT_SHADE  ; 65
	db SCREECH      ; 67
	db GUNK_SHOT    ; 68
	db RECOVER      ; 69
	db HARDEN       ; 6a
	db THUNDER_FANG ; 6b
	db SMOKESCREEN  ; 6c
	db CONFUSE_RAY  ; 6d
	db WILD_CHARGE  ; 6e
	db DEFENSE_CURL ; 6f
	db BARRIER      ; 70
	db LIGHT_SCREEN ; 71
	db HAZE         ; 72
	db REFLECT      ; 73
	db FOCUS_ENERGY ; 74
	db DARK_PULSE   ; 75
	db METRONOME    ; 76
	db BULLDOZE     ; 77
	db THROAT_CHOP  ; 78
	db EGG_BOMB     ; 79
	db LICK         ; 7a
	db POUNCE       ; 7b
	db SLUDGE       ; 7c
	db DISARM_VOICE ; 7d
	db FIRE_BLAST   ; 7e
	db WATERFALL    ; 7f
	db BULLET_PUNCH ; 80
	db SWIFT        ; 81
	db NIGHT_SLASH  ; 82
	db FAKE_OUT     ; 83
	db FURY_DRIVE   ; 84
	db AMNESIA      ; 85
	db BUG_BUZZ     ; 86
	db SOFTBOILED   ; 87
	db HI_JUMP_KICK ; 88
	db ICE_SHARD    ; 89
	db DREAM_EATER  ; 8a
	db TAUNT        ; 8b
	db TREMOR       ; 8c
	db LEECH_LIFE   ; 8d
	db LOVELY_KISS  ; 8e
	db SKY_ATTACK   ; 8f
	db TRANSFORM    ; 90
	db CALM_MIND    ; 91
	db HYPER_VOICE  ; 92
	db ACROBATICS   ; 93
	db MIRROR_SHOT  ; 94
	db SIGNAL_BEAM  ; 95
	db SPLASH       ; 96
	db TRICK_ROOM   ; 97
	db FAIRY_FLASH  ; 98
	db EXPLOSION    ; 99
	db FURY_STRIKES ; 9a
	db HIDDEN_FORCE ; 9b
	db REST         ; 9c
	db ROCK_SLIDE   ; 9d
	db RUNIC_POWER  ; 9e
	db FACADE       ; 9f
	db HEX          ; a0
	db PHOTON_BLAST ; a1
	db SUPER_FANG   ; a2
	db SLASH        ; a3
	db SUBSTITUTE   ; a4
	db STRUGGLE     ; a5
	db SKETCH       ; a6
	db AERIAL_ACE   ; a7
	db KNOCK_OFF    ; a8
	db SPIDER_WEB   ; a9
	db DRAGON_DANCE ; aa
	db TRICK        ; ab
	db FLAME_CHARGE ; ac
	db SLACK_OFF    ; ad
	db CURSE        ; ae
	db FLAIL        ; af
	db HURRICANE    ; b0
	db AEROBLAST    ; b1
	db VENOSHOCK    ; b2
	db IRON_BASH    ; b3
	db SPITE        ; b4
	db POWDER_SNOW  ; b5
	db PROTECT      ; b6
	db MACH_PUNCH   ; b7
	db SCARY_FACE   ; b8
	db FEINT_ATTACK ; b9
	db EARTH_POWER  ; ba
	db BELLY_DRUM   ; bb
	db SLUDGE_BOMB  ; bc
	db MUD_SLAP     ; bd
	db PSYSHOCK     ; be
	db SPIKES       ; bf
	db ICE_FANG     ; c0
	db FORESIGHT    ; c1
	db DESTINY_BOND ; c2
	db PERISH_SONG  ; c3
	db ICY_WIND     ; c4
	db SAND_TOMB    ; c5
	db SNARL        ; c6
	db FREEZE_DRY   ; c7
	db OUTRAGE      ; c8
	db SANDSTORM    ; c9
	db GIGA_DRAIN   ; ca
	db FIRE_FANG    ; cb
	db CHARM        ; cc
	db ROLLOUT      ; cd
	db FALSE_SWIPE  ; ce
	db SWAGGER      ; cf
	db SCALD        ; d0
	db SPARK        ; d1
	db SHADOW_PUNCH ; d2
	db STEEL_WING   ; d3
	db MEAN_LOOK    ; d4
	db ATTRACT      ; d5
	db SLEEP_TALK   ; d6
	db HEAL_BELL    ; d7
	db RETURN       ; d8
	db DEFOG        ; d9
	db AURA_SPHERE  ; da
	db SAFEGUARD    ; db
	db PAIN_SPLIT   ; dc
	db SACRED_FIRE  ; dd
	db QUIVER_DANCE ; de
	db METEOR_MASH  ; df
	db MEGAHORN     ; e0
	db DRAGON_PULSE ; e1
	db BATON_PASS   ; e2
	db ENCORE       ; e3
	db PURSUIT      ; e4
	db RAPID_SPIN   ; e5
	db WILL_O_WISP  ; e6
	db SILVER_WIND  ; e7
	db METAL_CLAW   ; e8
	db BODY_PRESS   ; e9
	db HEALING_LIGHT; ea
	db HAIL         ; eb
	db X_SCISSOR    ; ec
	db HIDDEN_POWER ; ed
	db CROSS_CHOP   ; ee
	db DRAGON_CLAW  ; ef
	db RAIN_DANCE   ; f0
	db SUNNY_DAY    ; f1
	db CRUNCH       ; f2
	db MIRROR_COAT  ; f3
	db TOXIC_SPIKES ; f4
	db EXTREMESPEED ; f5
	db ANCIENTPOWER ; f6
	db SHADOW_BALL  ; f7
	db STEALTH_ROCK ; f8
	db BRICK_BREAK  ; f9
	db WHIRLPOOL    ; fa
	db FLARE_BLITZ  ; fb
	db POISON_JAB   ; fc
	db WOOD_BASH    ; fd
	db 0

DisplayUsedMoveText:
	jr .do_it ; comment this out for testing all move animations
	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	ld de, MoveTable
.loop
	ld a, [de]
	inc de
	and a
	ret z
	ld [hl], a
	push hl
	push de
	farcall UpdateMoveData
	call .do_it
	farcall AnimateCurrentMove
	pop de
	pop hl
	jr .loop

.do_it
ELSE
DisplayUsedMoveText:
ENDC
	ld hl, UsedMoveText
	call BattleTextbox
	jmp WaitBGMap

UsedMoveText:
	text_far _ActorNameText
	text_asm

	ldh a, [hBattleTurn]
	and a
	jr nz, .start

	ld a, [wPlayerMoveStruct + MOVE_ANIM]
	call UpdateUsedMoves

.start
	ld a, BATTLE_VARS_LAST_MOVE
	call GetBattleVarAddr
	ld d, h
	ld e, l

	ld a, BATTLE_VARS_LAST_COUNTER_MOVE
	call GetBattleVarAddr

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld [wTempByteValue], a

	push hl
	farcall CheckUserIsCharging
	pop hl
	jr nz, .ok

	; update last move
	ld a, [wTempByteValue]
	ld [hl], a
	ld [de], a

.ok
	ld hl, UsedMoveInsteadText
	ret

UsedMoveInsteadText:
	text_far _UsedMoveText
	text_asm
	ld hl, MoveNameText
	ret

MoveNameText:
	text_far _MoveNameText
	text_end

UpdateUsedMoves:
; append move a to wPlayerUsedMoves unless it has already been used

	push bc
; start of list
	ld hl, wPlayerUsedMoves
; get move id
	ld b, a
; next count
	ld c, NUM_MOVES

.loop
; get move from the list
	ld a, [hli]
; not used yet?
	and a
	jr z, .add
; already used?
	cp b
	jr z, .quit
; next byte
	dec c
	jr nz, .loop

; if the list is full and the move hasn't already been used
; shift the list back one byte, deleting the first move used
; this can occur with struggle or a new learned move
	ld hl, wPlayerUsedMoves + 1
; 1 = 2
	ld a, [hld]
	ld [hli], a
; 2 = 3
	inc hl
	ld a, [hld]
	ld [hli], a
; 3 = 4
	inc hl
	ld a, [hld]
	ld [hl], a
; 4 = new move
	ld a, b
	ld [wPlayerUsedMoves + 3], a
	jr .quit

.add
; go back to the byte we just inced from
	dec hl
; add the new move
	ld [hl], b

.quit
; list updated
	pop bc
	ret
