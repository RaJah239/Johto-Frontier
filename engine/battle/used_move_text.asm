; ====================================
; === Debug Move Animation Testing ===
; ====================================
; "View Animations" in the debug book (maps/PlayersHouse2F.asm) starts a wild
; battle with wBattleType = BATTLETYPE_DEBUG. The first move used in it plays
; every move's animation, in alphabetical order: each move first with the
; player as the user (player -> enemy), then with the enemy as the user
; (enemy -> player). Then the battle goes on as normal.
IF DEF(_DEBUG)
SetDebugAnimationBattle:
	ld a, BATTLETYPE_DEBUG
	ld [wBattleType], a
	ret

MoveTable: ; every move, alphabetically by name
	db ABSORB        ; Absorb
	db ACID          ; Acid
	db ACROBATICS    ; Acrobatics
	db AEROBLAST     ; Aeroblast
	db AGILITY       ; Agility
	db AIR_SLASH     ; Air Slash
	db AMNESIA       ; Amnesia
	db ANCIENTPOWER  ; AncientPower
	db AQUA_JET      ; Aqua Jet
	db ATTRACT       ; Attract
	db AURA_SPHERE   ; Aura Sphere
	db AURORA_BEAM   ; Aurora Beam
	db AVALANCHE     ; Avalanche
	db BARRIER       ; Barrier
	db BATON_PASS    ; Baton Pass
	db BITE          ; Bite
	db BLIZZARD      ; Blizzard
	db BODY_PRESS    ; Body Press
	db BODY_SLAM     ; Body Slam
	db BOOMBURST     ; Boomburst
	db BRICK_BREAK   ; Brick Break
	db BUBBLEBEAM    ; Bubblebeam
	db BUG_BITE      ; Bug Bite
	db BUG_BUZZ      ; Bug Buzz
	db BULK_UP       ; Bulk Up
	db BULLDOZE      ; Bulldoze
	db BULLET_PUNCH  ; Bullet Punch
	db CALM_MIND     ; Calm Mind
	db CHARM         ; Charm
	db CLOSE_COMBAT  ; Close Combat
	db CONFUSE_RAY   ; Confuse Ray
	db CONFUSION     ; Confusion
	db COUNTER       ; Counter
	db CRUNCH        ; Crunch
	db CURSE         ; Curse
	db CUT           ; Cut
	db DARK_PULSE    ; Dark Pulse
	db DEFENSE_CURL  ; Defense Curl
	db DEFOG         ; Defog
	db DESTINY_BOND  ; Destiny Bond
	db DIG           ; Dig
	db DISABLE       ; Disable
	db DISARM_VOICE  ; Disarm Voice
	db DIVE_BOMB     ; Dive Bomb
	db DOUBLE_TEAM   ; Double Team
	db DOUBLE_EDGE   ; Double-Edge
	db DRAGON_CLAW   ; Dragon Claw
	db DRAGON_DANCE  ; Dragon Dance
	db DRAGON_PULSE  ; Dragon Pulse
	db DRAGON_RAGE   ; Dragon Rage
	db DRAIN_KISS    ; Drain Kiss
	db DRAIN_PUNCH   ; Drain Punch
	db DREAM_EATER   ; Dream Eater
	db DRILL_PECK    ; Drill Peck
	db DYNAMICPUNCH  ; DynamicPunch
	db EARTH_POWER   ; Earth Power
	db EARTHQUAKE    ; Earthquake
	db EMBER         ; Ember
	db ENCORE        ; Encore
	db EXPLOSION     ; Explosion
	db EXTREMESPEED  ; ExtremeSpeed
	db FACADE        ; Facade
	db FAIRY_FLASH   ; Fairy Flash
	db FALSE_SWIPE   ; False Swipe
	db FIRE_BLAST    ; Fire Blast
	db FIRE_FANG     ; Fire Fang
	db FIRE_PUNCH    ; Fire Punch
	db FIRE_SPIN     ; Fire Spin
	db FLAIL         ; Flail
	db FLAME_CHARGE  ; Flame Charge
	db FLAMETHROWER  ; Flamethrower
	db FLARE_BLITZ   ; Flare Blitz
	db FLASH_CANNON  ; Flash Cannon
	db FLY           ; Fly
	db FOCUS_BLAST   ; Focus Blast
	db FOCUS_ENERGY  ; Focus Energy
	db FORESIGHT     ; Foresight
	db FREEZE_DRY    ; Freeze-Dry
	db FURY_DRIVE    ; Fury Drive
	db FURY_STRIKES  ; Fury Strikes
	db GIGA_DRAIN    ; Giga Drain
	db GIGA_IMPACT   ; Giga Impact
	db GROWL         ; Growl
	db GROWTH        ; Growth
	db GUNK_SHOT     ; Gunk Shot
	db GUST          ; Gust
	db HAIL          ; Hail
	db HARDEN        ; Harden
	db HAZE          ; Haze
	db HEADBUTT      ; Headbutt
	db HEAL_BELL     ; Heal Bell
	db HEALING_LIGHT ; HealingLight
	db HEX           ; Hex
	db HI_JUMP_KICK  ; Hi-Jump Kick
	db HIDDEN_FORCE  ; Hidden Force
	db HIDDEN_POWER  ; Hidden Power
	db HORN_ATTACK   ; Horn Attack
	db HURRICANE     ; Hurricane
	db HYDRO_PUMP    ; Hydro Pump
	db HYPER_BEAM    ; Hyper Beam
	db HYPNOSIS      ; Hypnosis
	db ICE_BEAM      ; Ice Beam
	db ICE_FANG      ; Ice Fang
	db ICE_PUNCH     ; Ice Punch
	db ICE_SHARD     ; Ice Shard
	db ICICLE_CRASH  ; Icicle Crash
	db ICY_WIND      ; Icy Wind
	db IRON_BASH     ; Iron Bash
	db IRON_DUKES    ; Iron Dukes
	db IRON_HEAD     ; Iron Head
	db KARATE_CHOP   ; Karate Chop
	db KINGS_SHIELD  ; King's Shield
	db KNOCK_OFF     ; Knock Off
	db LEAF_BLADE    ; Leaf Blade
	db LEECH_LIFE    ; Leech Life
	db LEECH_SEED    ; Leech Seed
	db LEER          ; Leer
	db LICK          ; Lick
	db LIGHT_SCREEN  ; Light Screen
	db LOVELY_KISS   ; Lovely Kiss
	db LOW_KICK      ; Low Kick
	db MACH_PUNCH    ; Mach Punch
	db MEAN_LOOK     ; Mean Look
	db MEGA_DRAIN    ; Mega Drain
	db MEGAHORN      ; Megahorn
	db METAL_CLAW    ; Metal Claw
	db METEOR_MASH   ; Meteor Mash
	db METRONOME     ; Metronome
	db MILK_DRINK    ; Milk Drink
	db MIRROR_COAT   ; Mirror Coat
	db MIRROR_SHOT   ; Mirror Shot
	db MIST          ; Mist
	db MOONBLAST     ; Moonblast
	db MUD_SLAP      ; Mud-Slap
	db MYSTIC_DANCE  ; Mystic Dance
	db NASTY_PLOT    ; Nasty Plot
	db NIGHT_SHADE   ; Night Shade
	db NIGHT_SLASH   ; Night Slash
	db OUTRAGE       ; Outrage
	db PAIN_SPLIT    ; Pain Split
	db PECK          ; Peck
	db PERISH_SONG   ; Perish Song
	db PHOTON_BLAST  ; Photon Blast
	db PLAY_ROUGH    ; Play Rough
	db POISON_JAB    ; Poison Jab
	db POISON_STING  ; Poison Sting
	db POISONPOWDER  ; PoisonPowder
	db POUNCE        ; Pounce
	db POWDER_SNOW   ; Powder Snow
	db POWER_GEM     ; Power Gem
	db PROTECT       ; Protect
	db PSYBEAM       ; Psybeam
	db PSYBLAST      ; Psyblast
	db PSYCHIC_M     ; Psychic
	db PSYSHOCK      ; Psyshock
	db PURSUIT       ; Pursuit
	db QUICK_ATTACK  ; Quick Attack
	db QUIVER_DANCE  ; Quiver Dance
	db RAIN_DANCE    ; Rain Dance
	db RAPID_SPIN    ; Rapid Spin
	db RECOVER       ; Recover
	db REFLECT       ; Reflect
	db REST          ; Rest
	db RETURN        ; Return
	db ROAR          ; Roar
	db ROCK_BLAST    ; Rock Blast
	db ROCK_SLIDE    ; Rock Slide
	db ROCK_THROW    ; Rock Throw
	db ROCK_TOMB     ; Rock Tomb
	db ROLLOUT       ; Rollout
	db ROOST         ; Roost
	db RUNIC_POWER   ; Runic Power
	db SACRED_FIRE   ; Sacred Fire
	db SAFEGUARD     ; Safeguard
	db SAND_TOMB     ; Sand Tomb
	db SANDSTORM     ; Sandstorm
	db SCALD         ; Scald
	db SCARY_FACE    ; Scary Face
	db SCREECH       ; Screech
	db SEED_BOMB     ; Seed Bomb
	db SEISMIC_TOSS  ; Seismic Toss
	db SHADOW_BALL   ; Shadow Ball
	db SHADOW_PUNCH  ; Shadow Punch
	db SILVER_WIND   ; Silver Wind
	db SING          ; Sing
	db SIGNAL_BEAM   ; Singal Beam
	db SKETCH        ; Sketch
	db SKY_ATTACK    ; Sky Attack
	db SLACK_OFF     ; Slack Off
	db SLASH         ; Slash
	db SLEEP_POWDER  ; Sleep Powder
	db SLEEP_TALK    ; Sleep Talk
	db SLUDGE        ; Sludge
	db SLUDGE_BOMB   ; Sludge Bomb
	db SMOKESCREEN   ; Smokescreen
	db SOFTBOILED    ; Softboiled
	db SOLARBEAM     ; Solarbeam
	db SPARK         ; Spark
	db SPIDER_WEB    ; Spider Web
	db SPIKES        ; Spikes
	db SPITE         ; Spite
	db SPLASH        ; Splash
	db SPORE         ; Spore
	db STEALTH_ROCK  ; Stealth Rock
	db STEEL_WING    ; Steel Wing
	db STICKY_WEB    ; Sticky Web
	db STOMP         ; Stomp
	db STONE_EDGE    ; Stone Edge
	db STRING_SHOT   ; String Shot
	db STRUGGLE      ; Struggle
	db STUN_SPORE    ; Stun Spore
	db SUBSTITUTE    ; Substitute
	db SUCKER_PUNCH  ; Sucker Punch
	db SUNNY_DAY     ; Sunny Day
	db SUPER_FANG    ; Super Fang
	db SUPERSONIC    ; Supersonic
	db SURF          ; Surf
	db SWAGGER       ; Swagger
	db SWIFT         ; Swift
	db SWORDS_DANCE  ; Swords Dance
	db TACKLE        ; Tackle
	db TAUNT         ; Taunt
	db TELEPORT      ; Teleport
	db THRASH        ; Thrash
	db THROAT_CHOP   ; Throat Chop
	db THUNDER       ; Thunder
	db THUNDER_FANG  ; Thunder Fang
	db THUNDER_WAVE  ; Thunder Wave
	db THUNDERBOLT   ; Thunderbolt
	db THUNDERPUNCH  ; ThunderPunch
	db THUNDERSHOCK  ; Thundershock
	db TOXIC         ; Toxic
	db TOXIC_SPIKES  ; Toxic Spikes
	db TRANSFORM     ; Transform
	db TREMOR        ; Tremor
	db TRICK         ; Trick
	db TRICK_ROOM    ; Trick Room
	db U_TURN        ; U-Turn
	db VENOSHOCK     ; Venoshock
	db VINE_WHIP     ; Vine Whip
	db VOLT_SWITCH   ; Volt Switch
	db WATER_GUN     ; Water Gun
	db WATERFALL     ; Waterfall
	db WHIRLPOOL     ; Whirlpool
	db WHIRLWIND     ; Whirlwind
	db WILD_CHARGE   ; Wild Charge
	db WILL_O_WISP   ; Will-O-Wisp
	db WING_ATTACK   ; Wing Attack
	db WOOD_BASH     ; Wood Bash
	db WRAP          ; Wrap
	db X_SCISSOR     ; X-Scissor
	db ZEN_HEADBUTT  ; Zen Headbutt
	db 0

DisplayUsedMoveText:
	ld a, [wBattleType]
	cp BATTLETYPE_DEBUG
	jr nz, .do_it
	; play the animations once, then back to a normal battle
	xor a ; BATTLETYPE_NORMAL
	ld [wBattleType], a
	ldh a, [hBattleTurn]
	push af
	ld de, MoveTable
.loop
	ld a, [de]
	inc de
	and a
	jr z, .done
	ld b, a
	push de
	xor a ; the player uses it
	call .play
	ld a, 1 ; the enemy uses it
	call .play
	pop de
	jr .loop

.done
	pop af
	ldh [hBattleTurn], a
	jr .do_it

.play
; a = whose turn (0 player, 1 enemy), b = move
	ldh [hBattleTurn], a
	push bc
	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	pop bc
	ld [hl], b
	push bc
	farcall UpdateMoveData
	call .do_it
	farcall AnimateCurrentMove
	call .reset_mons
	pop bc
	ret

.reset_mons
; Put both mons back to normal for the next move: Transform swaps the two
; pictures, Substitute replaces the user's, and some moves (Teleport) make it
; vanish.
	farcall DropPlayerSub ; the player's back pic
	farcall DropEnemySub ; the enemy's front pic
	; put both pictures back on screen (Teleport and others hide the user)
	ldh a, [hBattleTurn]
	push af
	xor a
	ldh [hBattleTurn], a
	farcall AppearUser
	ld a, 1
	ldh [hBattleTurn], a
	farcall AppearUser
	pop af
	ldh [hBattleTurn], a
	ld b, SCGB_BATTLE_COLORS
	call GetSGBLayout
	call SetDefaultBGPAndOBP
	call DelayFrame
	jmp WaitBGMap

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
	ldh a, [hBattleTurn]
	and a
	jr z, .player_move
	ld a, [wTempByteValue]
	ld [wBattleLastEnemyMove], a
.player_move
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
