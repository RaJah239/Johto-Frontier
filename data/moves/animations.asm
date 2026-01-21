BattleAnim_Mimic:
BattleAnim_Miss:
BattleAnim_Dummy:
	anim_ret

BattleAnim_StatUp:
	anim_1gfx BATTLE_ANIM_GFX_SPEED
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_FADE_MON_TO_LIGHT, $0, $1, $40
	anim_sound 0, 0, SFX_STAT_UP
.loop
	anim_obj BATTLE_ANIM_OBJ_STAT_UP,   5, 4,  13, 6, $6
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_STAT_UP,   4, 4,  13, 6, $6
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_STAT_UP,   6, 4,  13, 6, $8
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_STAT_UP,   3, 4,  13, 6, $8
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_STAT_UP,   7, 4,  13, 6, $6
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_STAT_UP,   2, 4,  13, 6, $8
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_STAT_UP,   8, 4,  13, 6, $8
	anim_wait 2
	anim_loop 3, .loop
	anim_wait 8
	anim_incbgeffect BATTLE_BG_EFFECT_FADE_MON_TO_LIGHT
	anim_jump BattleAnim_ShowMon_0

BattleAnim_StatDown:
	anim_1gfx BATTLE_ANIM_GFX_SPEED
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_FADE_MON_TO_LIGHT, $0, $1, $40
	anim_sound 0, 0, SFX_STAT_DOWN
.loop
	anim_obj BATTLE_ANIM_OBJ_STAT_DOWN, 5, 4,  7, 6, $6
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_STAT_DOWN, 4, 4,  7, 6, $6
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_STAT_DOWN, 6, 4,  7, 6, $8
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_STAT_DOWN, 3, 4,  7, 6, $8
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_STAT_DOWN, 7, 4,  7, 6, $6
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_STAT_DOWN, 2, 4,  7, 6, $8
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_STAT_DOWN, 8, 4,  7, 6, $8
	anim_wait 2
	anim_loop 3, .loop
	anim_wait 8
	anim_incbgeffect BATTLE_BG_EFFECT_FADE_MON_TO_LIGHT
	anim_jump BattleAnim_ShowMon_0

BattleAnim_AnimBattleMiss:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_call BattleAnim_TargetObj_1Row
	anim_sound 0, 0, SFX_SUBMISSION
	anim_bgeffect BATTLE_BG_EFFECT_FLAIL, $0, BG_EFFECT_USER, $0
	anim_wait 32
	anim_incbgeffect BATTLE_BG_EFFECT_FLAIL
	anim_jump BattleAnim_ShowMon_0

BattleAnim_WoodBash:
	anim_2gfx BATTLE_ANIM_GFX_PLANT, BATTLE_ANIM_GFX_HIT
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $14, $2, $0
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_FADE_MON_TO_LIGHT_REPEATING, $0, $1, $40
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $0, $0
	anim_sound 0, 0, SFX_OUTRAGE
	anim_wait 72
	anim_incbgeffect BATTLE_BG_EFFECT_CYCLE_MON_LIGHT_DARK_REPEATING
	anim_call BattleAnim_ShowMon_0
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $4, $3
	anim_sound 0, 1, SFX_MOVE_PUZZLE_PIECE
	anim_call BattleAnim_LeavesStub
	anim_wait 6
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 136, 56, $0
	anim_wait 6
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 152, 40, $0
	anim_wait 16
	anim_ret

BattleAnim_LeavesStub:
	anim_obj BATTLE_ANIM_OBJ_RAZOR_LEAF, 136, 56, $28
	anim_obj BATTLE_ANIM_OBJ_RAZOR_LEAF, 136, 56, $5c
	anim_obj BATTLE_ANIM_OBJ_RAZOR_LEAF, 136, 56, $10
	anim_obj BATTLE_ANIM_OBJ_RAZOR_LEAF, 136, 56, $e8
	anim_obj BATTLE_ANIM_OBJ_RAZOR_LEAF, 136, 56, $9c
	anim_obj BATTLE_ANIM_OBJ_RAZOR_LEAF, 136, 56, $d0
	anim_ret

BattleAnim_Bulldoze:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_call BattleAnim_TargetObj_2Row
	anim_bgeffect BATTLE_BG_EFFECT_WITHDRAW, $0, $1, $50
	anim_wait 4
	anim_incbgeffect BATTLE_BG_EFFECT_WITHDRAW
	anim_call BattleAnim_ShowMon_0
	anim_wait 1
.loop
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $08, $2, $0
	anim_sound 0, 1, SFX_SPARK
	anim_wait 8
	anim_loop 6, .loop
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $40, $2, $0
.loop2
	anim_sound 0, 1, SFX_SPARK
	anim_wait 4
	anim_loop 12, .loop2
	anim_wait 48
	anim_incbgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X
	anim_ret

BattleAnim_ThrowPokeBall:
	anim_if_param_equal NO_ITEM, .TheTrainerBlockedTheBall
	anim_if_param_equal MASTER_BALL, .MasterBall
	; any other ball
	anim_4gfx BATTLE_ANIM_GFX_POKE_BALL, ANIM_GFX_POKE_BALL_BG, BATTLE_ANIM_GFX_SMOKE, BATTLE_ANIM_GFX_OBJECTS
	anim_sound 6, 2, SFX_THROW_BALL
	anim_obj BATTLE_ANIM_OBJ_POKE_BALL, 68, 92, $30
	anim_obj ANIM_OBJ_POKE_BALL_BG, 68, 92, $30
	anim_wait 36
	anim_obj BATTLE_ANIM_OBJ_POKE_BALL, 136, 65, $0
	anim_setobj $3, $7
	anim_obj ANIM_OBJ_POKE_BALL_BG, 136, 65, $0
	anim_setobj $4, $7
	anim_wait 16
	anim_sound 0, 1, SFX_BALL_POOF
	anim_obj BATTLE_ANIM_OBJ_BALL_POOF, 136, 60, $10
	anim_wait 16
	anim_jump .Shake

.TheTrainerBlockedTheBall:
	anim_2gfx BATTLE_ANIM_GFX_POKE_BALL, BATTLE_ANIM_GFX_HIT
	anim_sound 6, 2, SFX_THROW_BALL
	anim_obj BATTLE_ANIM_OBJ_POKE_BALL_BLOCKED, 64, 92, $20
	anim_wait 20
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 112, 40, $0
	anim_wait 32
	anim_ret

.MasterBall:
	anim_5gfx BATTLE_ANIM_GFX_POKE_BALL, ANIM_GFX_POKE_BALL_BG, BATTLE_ANIM_GFX_SMOKE, BATTLE_ANIM_GFX_SPEED, BATTLE_ANIM_GFX_OBJECTS
	anim_sound 6, 2, SFX_THROW_BALL
	anim_obj BATTLE_ANIM_OBJ_POKE_BALL, 68, 92, $30
	anim_obj ANIM_OBJ_POKE_BALL_BG, 68, 92, $30
	anim_wait 36
	anim_obj BATTLE_ANIM_OBJ_POKE_BALL, 136, 65, $0
	anim_setobj $3, $7
	anim_obj ANIM_OBJ_POKE_BALL_BG, 136, 65, $0
	anim_setobj $4, $7
	anim_wait 16
	anim_sound 0, 1, SFX_BALL_POOF
	anim_obj BATTLE_ANIM_OBJ_BALL_POOF, 136, 60, $10
	anim_wait 24
	anim_sound 0, 1, SFX_MASTER_BALL
	anim_obj BATTLE_ANIM_OBJ_MASTER_BALL_SPARKLE, 136, 56, $31
	anim_obj BATTLE_ANIM_OBJ_MASTER_BALL_SPARKLE, 136, 56, $33
	anim_obj BATTLE_ANIM_OBJ_MASTER_BALL_SPARKLE, 136, 56, $35
	anim_obj BATTLE_ANIM_OBJ_MASTER_BALL_SPARKLE, 136, 56, $37
	anim_wait 64
.Shake:
	anim_bgeffect BATTLE_BG_EFFECT_RETURN_MON, $0, BG_EFFECT_TARGET, $0
	anim_wait 8
	anim_incobj 3
	anim_incobj 4
	anim_wait 16
	anim_sound 0, 1, SFX_CHANGE_DEX_MODE
	anim_incobj 1
	anim_incobj 2
	anim_wait 32
	anim_sound 0, 1, SFX_BALL_BOUNCE
	anim_wait 104
	anim_setvar $0
.Loop:
	anim_wait 48
	anim_checkpokeball
	anim_if_var_equal $1, .Click
	anim_if_var_equal $2, .BreakFree
	anim_incobj 1
	anim_incobj 2
	anim_sound 0, 1, SFX_BALL_WOBBLE
	anim_jump .Loop

.Click:
	anim_obj BATTLE_ANIM_OBJ_ENCORE_STAR, 120, 52, $2c
	anim_obj BATTLE_ANIM_OBJ_ENCORE_STAR, 152, 52, $34
	anim_sound 0, 1, SFX_PECK
	anim_wait 4
	anim_sound 0, 1, SFX_PECK
	anim_wait 12
	anim_keepspritesandoam
	anim_ret

.BreakFree:
	anim_setobj $1, $b
	anim_setobj $2, $b
	anim_sound 0, 1, SFX_BALL_POOF
	anim_obj BATTLE_ANIM_OBJ_BALL_POOF, 136, 56, $10
	anim_wait 2
	anim_bgeffect BATTLE_BG_EFFECT_ENTER_MON, $0, BG_EFFECT_TARGET, $0
	anim_wait 32
	anim_ret

BattleAnim_SendOutMon:
	anim_if_param_equal $1, .Shiny
	anim_1gfx BATTLE_ANIM_GFX_SMOKE
	anim_sound 0, 0, SFX_BALL_POOF
	anim_obj BATTLE_ANIM_OBJ_BETA_BALL_POOF, 48, 96, $0
	anim_wait 4
	anim_bgeffect BATTLE_BG_EFFECT_ENTER_MON, $0, BG_EFFECT_USER, $0
	anim_wait 32
	anim_ret

.Shiny:
	anim_1gfx BATTLE_ANIM_GFX_SPEED
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $4, $3
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 0, 0, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_SHINY, 48, 96, $0
	anim_wait 4
	anim_sound 0, 0, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_SHINY, 48, 96, $8
	anim_wait 4
	anim_sound 0, 0, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_SHINY, 48, 96, $10
	anim_wait 4
	anim_sound 0, 0, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_SHINY, 48, 96, $18
	anim_wait 4
	anim_sound 0, 0, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_SHINY, 48, 96, $20
	anim_wait 4
	anim_sound 0, 0, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_SHINY, 48, 96, $28
	anim_wait 4
	anim_sound 0, 0, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_SHINY, 48, 96, $30
	anim_wait 4
	anim_sound 0, 0, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_SHINY, 48, 96, $38
	anim_wait 32
	anim_ret

BattleAnim_ReturnMon:
	anim_sound 0, 0, SFX_BALL_POOF
BattleAnimSub_Return:
	anim_bgeffect BATTLE_BG_EFFECT_RETURN_MON, $0, BG_EFFECT_USER, $0
	anim_wait 32
	anim_ret

BattleAnim_Confused:
	anim_1gfx BATTLE_ANIM_GFX_STATUS
	anim_sound 0, 0, SFX_KINESIS
	anim_obj BATTLE_ANIM_OBJ_CHICK, 44, 56, $15
	anim_obj BATTLE_ANIM_OBJ_CHICK, 44, 56, $aa
	anim_obj BATTLE_ANIM_OBJ_CHICK, 44, 56, $bf
	anim_wait 96
	anim_ret

BattleAnim_PoisonJab:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_PURPLE
	anim_3gfx BATTLE_ANIM_GFX_HORN, BATTLE_ANIM_GFX_HIT, BATTLE_ANIM_GFX_POISON
	anim_obp0 $ef
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $55, $1, $0
.loop
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 132, 40, $0
	anim_wait 8
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 8
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 126, 50, $0
	anim_wait 8
	anim_loop 3, .loop
	anim_clearobjs
	anim_obp0 $e4
	anim_jump BattleAnimSub_Sludge

BattleAnim_Slp:
BattleAnim_Rest:
	anim_1gfx BATTLE_ANIM_GFX_STATUS
	anim_sound 0, 0, SFX_TAIL_WHIP
.loop
	anim_obj BATTLE_ANIM_OBJ_ASLEEP, 64, 80, $0
	anim_wait 40
	anim_loop 3, .loop
	anim_wait 32
	anim_ret

BattleAnim_Brn:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_1gfx BATTLE_ANIM_GFX_FIRE
.loop
	anim_sound 0, 0, SFX_BURN
	anim_obj BATTLE_ANIM_OBJ_BURNED, 56, 88, $10
	anim_wait 4
	anim_loop 3, .loop
	anim_wait 6
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_RED
	anim_ret

BattleAnim_Psn:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_PURPLE
	anim_1gfx BATTLE_ANIM_GFX_POISON
	anim_sound 0, 0, SFX_POISON
	anim_obj BATTLE_ANIM_OBJ_SKULL, 64, 56, $0
	anim_wait 8
	anim_sound 0, 0, SFX_POISON
	anim_obj BATTLE_ANIM_OBJ_SKULL, 48, 56, $0
	anim_wait 8
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_Sap:
	anim_1gfx BATTLE_ANIM_GFX_CHARGE
	anim_sound 6, 3, SFX_WATER_GUN
	anim_obj BATTLE_ANIM_OBJ_ABSORB, 128, 48, $2
	anim_wait 3
	anim_sound 6, 3, SFX_WATER_GUN
	anim_obj BATTLE_ANIM_OBJ_ABSORB, 136, 64, $3
	anim_wait 3
	anim_sound 6, 3, SFX_WATER_GUN
	anim_obj BATTLE_ANIM_OBJ_ABSORB, 136, 32, $4
	anim_wait 16
	anim_ret

BattleAnim_Frz:
	anim_1gfx BATTLE_ANIM_GFX_ICE
	anim_obj BATTLE_ANIM_OBJ_FROZEN, 44, 110, $0
	anim_sound 0, 0, SFX_SHINE
	anim_wait 16
	anim_sound 0, 0, SFX_SHINE
	anim_wait 16
	anim_ret

BattleAnim_Par:
	anim_1gfx BATTLE_ANIM_GFX_STATUS
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 0, 0, SFX_THUNDERSHOCK
	anim_obj BATTLE_ANIM_OBJ_PARALYZED, 20, 88, $42
	anim_obj BATTLE_ANIM_OBJ_PARALYZED, 76, 88, $c2
	anim_wait 96
	anim_ret

BattleAnim_InLove:
	anim_1gfx BATTLE_ANIM_GFX_OBJECTS
	anim_sound 0, 0, SFX_LICK
	anim_obj BATTLE_ANIM_OBJ_HEART, 64, 76, $0
	anim_wait 32
	anim_sound 0, 0, SFX_LICK
	anim_obj BATTLE_ANIM_OBJ_HEART, 36, 72, $0
	anim_wait 32
	anim_ret

BattleAnim_InNightmare:
	anim_1gfx BATTLE_ANIM_GFX_ANGELS
	anim_sound 0, 0, SFX_BUBBLEBEAM
	anim_obj BATTLE_ANIM_OBJ_IN_NIGHTMARE, 68, 80, $0
	anim_wait 40
	anim_ret

BattleAnim_HitConfusion:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_sound 0, 0, SFX_POUND
	anim_obj BATTLE_ANIM_OBJ_HIT, 44, 96, $0
	anim_wait 16
	anim_ret

BattleAnim_EnemyDamage:
.loop
	anim_bgeffect BATTLE_BG_EFFECT_HIDE_MON, $0, BG_EFFECT_TARGET, $0
	anim_wait 5
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, BG_EFFECT_TARGET, $0
	anim_wait 5
	anim_loop 3, .loop
	anim_ret

BattleAnim_PlayerDamage:
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_Y, $20, $2, $20
	anim_wait 40
	anim_ret

BattleAnim_Wobble:
	anim_bgeffect BATTLE_BG_EFFECT_WOBBLE_SCREEN, $0, $0, $0
	anim_wait 40
	anim_ret

BattleAnim_Shake:
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $20, $2, $40
	anim_wait 40
	anim_ret

BattleAnim_KarateChop:
	anim_2gfx BATTLE_ANIM_GFX_HIT, BATTLE_ANIM_GFX_CHOP
 	anim_obj BATTLE_ANIM_OBJ_KARATE_CHOP, 136, 71, $0
 	anim_wait 8
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 40, $0
	anim_wait 3
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 52, $0
 	anim_wait 3
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 64, $0
 	anim_wait 20
	anim_ret

BattleAnim_BugBite:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GREEN
	anim_2gfx BATTLE_ANIM_GFX_ROCKS, BATTLE_ANIM_GFX_HIT
.loop
	anim_sound 0, 1, SFX_BITE
	anim_obj BATTLE_ANIM_OBJ_HIT_SMALL_YFIX, 132, 64, $0
	anim_obj BATTLE_ANIM_OBJ_ROCK_SMASH, 132, 64, $5c
	anim_wait 4
	anim_sound 0, 1, SFX_BITE
	anim_obj BATTLE_ANIM_OBJ_HIT_SMALL_YFIX, 128, 48, $0
	anim_obj BATTLE_ANIM_OBJ_ROCK_SMASH, 128, 48, $5c
	anim_wait 4
	anim_sound 0, 1, SFX_BITE
	anim_obj BATTLE_ANIM_OBJ_HIT_SMALL_YFIX, 144, 56, $0
	anim_obj BATTLE_ANIM_OBJ_ROCK_SMASH, 144, 56, $d0
	anim_wait 4
	anim_sound 0, 1, SFX_BITE
	anim_obj BATTLE_ANIM_OBJ_HIT_SMALL_YFIX, 122, 52, $0
	anim_obj BATTLE_ANIM_OBJ_ROCK_SMASH, 122, 52, $50
	anim_wait 4
	anim_loop 5, .loop
	anim_wait 32
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_EarthPower:
	anim_2gfx BATTLE_ANIM_GFX_FIRE, BATTLE_ANIM_GFX_ROCKS
	anim_sound 0, 0, SFX_EGG_BOMB
	anim_bgp $1b
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $28, $2, $0
	anim_obj BATTLE_ANIM_OBJ_ROCK_SMASH, 120, 68, $5c
	anim_obj BATTLE_ANIM_OBJ_ROCK_SMASH, 120, 68, $e8
	anim_obj BATTLE_ANIM_OBJ_ROCK_SMASH, 120, 68, $9c
	anim_obj BATTLE_ANIM_OBJ_ROCK_SMASH, 120, 68, $50
	anim_obj BATTLE_ANIM_OBJ_EMBER, 120, 68, $30
	anim_wait 40
	anim_clearobjs
	anim_wait 8
	anim_sound 0, 0, SFX_EGG_BOMB
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $28, $2, $0
	anim_obj BATTLE_ANIM_OBJ_ROCK_SMASH, 144, 68, $5c
	anim_obj BATTLE_ANIM_OBJ_ROCK_SMASH, 144, 68, $e8
	anim_obj BATTLE_ANIM_OBJ_ROCK_SMASH, 144, 68, $d0
	anim_obj BATTLE_ANIM_OBJ_ROCK_SMASH, 144, 68, $10
	anim_obj BATTLE_ANIM_OBJ_EMBER, 144, 68, $30
	anim_wait 40
	anim_clearobjs
	anim_wait 8
	anim_sound 0, 0, SFX_EGG_BOMB
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $28, $2, $0
	anim_obj BATTLE_ANIM_OBJ_ROCK_SMASH, 132, 68, $28
	anim_obj BATTLE_ANIM_OBJ_ROCK_SMASH, 132, 68, $e8
	anim_obj BATTLE_ANIM_OBJ_ROCK_SMASH, 132, 68, $d0
	anim_obj BATTLE_ANIM_OBJ_ROCK_SMASH, 132, 68, $50
	anim_obj BATTLE_ANIM_OBJ_EMBER, 132, 68, $30
	anim_wait 48
	anim_ret

BattleAnim_Stomp:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_METALLIC
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_sound 0, 1, SFX_STOMP
	anim_obj BATTLE_ANIM_OBJ_KICK, 136, 40, $0
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 40, $0
	anim_wait 6
	anim_sound 0, 1, SFX_STOMP
	anim_obj BATTLE_ANIM_OBJ_KICK, 136, 44, $0
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 44, $0
	anim_wait 6
	anim_sound 0, 1, SFX_STOMP
	anim_obj BATTLE_ANIM_OBJ_KICK, 136, 48, $0
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 48, $0
	anim_wait 16
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_Roost:
	anim_2gfx BATTLE_ANIM_GFX_MISC, BATTLE_ANIM_GFX_SHINE
	anim_bgeffect BATTLE_BG_EFFECT_FADE_MON_TO_LIGHT_REPEATING, $0, $1, $40
	anim_wait 16
.loop
	anim_call BattleAnim_SwordsStub
	anim_wait 34
	anim_loop 2, .loop
	anim_wait 28
	anim_jump BattleAnimSub_Glimmer

BattleAnim_HiJumpKick:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $40, $2, $0
	anim_if_param_equal $1, .alternate
	anim_wait 32
	anim_sound 0, 1, SFX_JUMP_KICK
	anim_obj BATTLE_ANIM_OBJ_KICK, 112, 72, $0
	anim_setobj $1, $2
	anim_wait 16
	anim_sound 0, 1, SFX_DOUBLE_KICK
	anim_obj BATTLE_ANIM_OBJ_HIT, 136, 48, $0
	anim_wait 16
	anim_ret

.alternate:
	anim_wait 16
	anim_sound 0, 0, SFX_DOUBLE_KICK
	anim_obj BATTLE_ANIM_OBJ_HIT, 44, 88, $0
	anim_wait 16
	anim_ret

BattleAnim_SignalBeam:
	anim_1gfx BATTLE_ANIM_GFX_BEAM
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect BATTLE_BG_EFFECT_ALTERNATE_HUES, $0, $2, $0
	anim_wait 64
	anim_sound 0, 0, SFX_PERISH_SONG
	anim_obj BATTLE_ANIM_OBJ_BEAM, 64, 92, $0
	anim_wait 4
	anim_sound 0, 0, SFX_PERISH_SONG
	anim_obj BATTLE_ANIM_OBJ_BEAM, 80, 84, $0
	anim_wait 4
	anim_sound 0, 1, SFX_PERISH_SONG
	anim_obj BATTLE_ANIM_OBJ_BEAM, 96, 76, $0
	anim_wait 4
	anim_sound 0, 1, SFX_PERISH_SONG
	anim_obj BATTLE_ANIM_OBJ_BEAM, 112, 68, $0
	anim_obj BATTLE_ANIM_OBJ_BEAM_TIP, 126, 62, $0
	anim_wait 48
	anim_incobj  5
	anim_wait 64
	anim_ret

BattleAnim_SuperFang:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $40, $2, $0
	anim_wait 48
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $8, $3
.loop
	anim_sound 0, 1, SFX_BITE
	anim_obj BATTLE_ANIM_OBJ_FANG, 136, 56, $0
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 136, 56, $0
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_FANG, 136, 56, $0
	anim_wait 6
	anim_loop 3, .loop
	anim_ret

BattleAnim_WillOWisp:
	anim_2gfx BATTLE_ANIM_GFX_ANGELS, BATTLE_ANIM_GFX_FIRE
	anim_obj BATTLE_ANIM_OBJ_SPITE, 132, 16, $0
	anim_sound 0, 1, SFX_SPITE
	anim_wait 32
	; fallthrough

BattleAnimSub_Fire:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_sound 0, 1, SFX_EMBER
.loop
	anim_obj BATTLE_ANIM_OBJ_BURNED, 136, 56, $10
	anim_obj BATTLE_ANIM_OBJ_BURNED, 136, 56, $90
	anim_wait 4
	anim_loop 4, .loop
	anim_wait 48
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_Ember:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_1gfx BATTLE_ANIM_GFX_FIRE
	anim_sound 6, 2, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_EMBER, 64, 96, $12
	anim_wait 4
	anim_sound 6, 2, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_EMBER, 64, 100, $14
	anim_wait 4
	anim_sound 6, 2, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_EMBER, 64, 84, $13
	anim_wait 16
	anim_incobj 1
	anim_incobj 2
	anim_incobj 3
	anim_sound 0, 1, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_EMBER, 120, 68, $30
	anim_obj BATTLE_ANIM_OBJ_EMBER, 132, 68, $30
	anim_obj BATTLE_ANIM_OBJ_EMBER, 144, 68, $30
	anim_wait 32
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_FirePunch:
	anim_2gfx BATTLE_ANIM_GFX_HIT, BATTLE_ANIM_GFX_FIRE
	anim_obj BATTLE_ANIM_OBJ_PUNCH_SHAKE, 136, 56, $43
	anim_jump BattleAnimSub_Fire

BattleAnim_FireSpin:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_1gfx BATTLE_ANIM_GFX_FIRE
.loop
	anim_sound 6, 2, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_FIRE_SPIN, 64, 88, $4
	anim_wait 2
	anim_sound 6, 2, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_FIRE_SPIN, 64, 96, $3
	anim_wait 2
	anim_sound 6, 2, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_FIRE_SPIN, 64, 88, $3
	anim_wait 2
	anim_sound 6, 2, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_FIRE_SPIN, 64, 96, $4
	anim_wait 2
	anim_loop 2, .loop
	anim_wait 96
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_DragonRage:
	anim_1gfx BATTLE_ANIM_GFX_FIRE
.loop
	anim_sound 6, 2, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_DRAGON_RAGE, 64, 92, $0
	anim_wait 3
	anim_loop 16, .loop
	anim_wait 64
	anim_ret

BattleAnim_Flamethrower:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_1gfx BATTLE_ANIM_GFX_FIRE
	anim_sound 6, 2, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_FLAMETHROWER, 64, 92, $3
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_FLAMETHROWER, 75, 86, $5
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_FLAMETHROWER, 85, 81, $7
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_FLAMETHROWER, 96, 76, $9
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_FLAMETHROWER, 106, 71, $b
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_FLAMETHROWER, 116, 66, $c
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_FLAMETHROWER, 126, 61, $a
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_FLAMETHROWER, 136, 56, $8
	anim_wait 16
.loop
	anim_sound 0, 1, SFX_EMBER
	anim_wait 16
	anim_loop 6, .loop
	anim_wait 16
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_FireBlast:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_1gfx BATTLE_ANIM_GFX_FIRE
.loop1
	anim_sound 6, 2, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_FIRE_BLAST, 64, 92, $7
	anim_wait 6
	anim_loop 10, .loop1
.loop2
	anim_sound 0, 1, SFX_EMBER
	anim_wait 8
	anim_loop 10, .loop2
	anim_incobj 1
	anim_incobj 2
	anim_incobj 3
	anim_incobj 4
	anim_incobj 5
	anim_incobj 6
	anim_incobj 7
	anim_incobj 8
	anim_incobj 9
	anim_incobj 10
	anim_wait 2
.loop3
	anim_sound 0, 1, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_FIRE_BLAST, 136, 56, $1
	anim_obj BATTLE_ANIM_OBJ_FIRE_BLAST, 136, 56, $2
	anim_obj BATTLE_ANIM_OBJ_FIRE_BLAST, 136, 56, $3
	anim_obj BATTLE_ANIM_OBJ_FIRE_BLAST, 136, 56, $4
	anim_obj BATTLE_ANIM_OBJ_FIRE_BLAST, 136, 56, $5
	anim_wait 16
	anim_loop 2, .loop3
	anim_wait 32
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_IcePunch:
	anim_2gfx BATTLE_ANIM_GFX_HIT, BATTLE_ANIM_GFX_ICE
	anim_obj BATTLE_ANIM_OBJ_PUNCH_SHAKE, 136, 56, $43
	; fallthrough

BattleAnimSub_Ice:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_ICE
	anim_sound 0, 1, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_ICE, 128, 42, $0
	anim_wait 6
	anim_sound 0, 1, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_ICE, 144, 70, $0
	anim_wait 6
	anim_sound 0, 1, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_ICE, 120, 56, $0
	anim_wait 6
	anim_sound 0, 1, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_ICE, 152, 56, $0
	anim_wait 6
	anim_sound 0, 1, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_ICE, 144, 42, $0
	anim_wait 6
	anim_sound 0, 1, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_ICE, 128, 70, $0
	anim_wait 32
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_BLUE
	anim_ret

BattleAnim_Moonblast:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_BLUE
	anim_3gfx BATTLE_ANIM_GFX_GLOBE, BATTLE_ANIM_GFX_SHINE, BATTLE_ANIM_GFX_CHARGE
	anim_bgp $1b
	anim_obj ANIM_OBJ_MOON, 44, 104, $1
	anim_obj ANIM_OBJ_MOON_CHARGE, 44, 88, $30
	anim_obj ANIM_OBJ_MOON_CHARGE, 44, 88, $31
	anim_obj ANIM_OBJ_MOON_CHARGE, 44, 88, $32
	anim_obj ANIM_OBJ_MOON_CHARGE, 44, 88, $33
	anim_obj ANIM_OBJ_MOON_CHARGE, 44, 88, $34
	anim_obj ANIM_OBJ_MOON_CHARGE, 44, 88, $35
	anim_obj ANIM_OBJ_MOON_CHARGE, 44, 88, $36
	anim_obj ANIM_OBJ_MOON_CHARGE, 44, 88, $37
	anim_wait 1
	anim_sound 0, 0, SFX_MOONLIGHT
	anim_wait 96
	anim_clearobjs
	anim_sound 3, 0, SFX_RAZOR_WIND
	anim_obj ANIM_OBJ_MOONBLAST, 64, 92, $4
	anim_wait 16
	anim_sound 0, 0, SFX_METRONOME
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_BLUE
	anim_obj BATTLE_ANIM_OBJ_GLIMMER, 132, 28, $0
	anim_wait 5
	anim_obj BATTLE_ANIM_OBJ_GLIMMER, 112, 60, $0
	anim_wait 5
	anim_obj BATTLE_ANIM_OBJ_GLIMMER, 144, 68, $0
	anim_wait 24
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_YELLOW
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_DisarmVoice:
	anim_2gfx BATTLE_ANIM_GFX_HEARTS, BATTLE_ANIM_GFX_PSYCHIC
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_battlergfx_2row
.loop
	anim_sound 0, 0, SFX_ATTRACT
	anim_obj BATTLE_ANIM_OBJ_SHOOTING_HEART, 64, 88, $4
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_SHOOTING_HEART, 64, 80, $4
	anim_obj BATTLE_ANIM_OBJ_WAVE, 64, 88, $2
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_SHOOTING_HEART, 64, 96, $4
	anim_wait 6
	anim_loop 3, .loop
	anim_wait 16
	anim_bgeffect BATTLE_BG_EFFECT_BATTLEROBJ_1ROW, $0, $1, $0
	anim_wait 6
	anim_bgeffect BATTLE_BG_EFFECT_VIBRATE_MON, $0, $0, $0
	anim_wait 32
	; fallthrough

BattleAnim_ShowMon_1:
	anim_wait 1
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, BG_EFFECT_USER, $0
	anim_wait 4
	anim_incobj 1
	anim_wait 1
	anim_ret

BattleAnim_PlayRough:
	anim_1gfx BATTLE_ANIM_GFX_SPEED
	anim_sound 6, 2, SFX_THROW_BALL
	anim_bgeffect BATTLE_BG_EFFECT_HIDE_MON, $0, $1, $0
	anim_call BattleAnimSub_SpeedLines
	anim_3gfx BATTLE_ANIM_GFX_STARS, BATTLE_ANIM_GFX_HIT, BATTLE_ANIM_GFX_HEARTS
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $55, $2, $0
.loop
	anim_sound 0, 1, SFX_BONE_CLUB
	anim_obj BATTLE_ANIM_OBJ_STAR_BURST, 128, 48, $28
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 128, 48, $0
	anim_wait 3
	anim_obj BATTLE_ANIM_OBJ_HEART_BURST, 144, 64, $5c
	anim_wait 3
	anim_obj BATTLE_ANIM_OBJ_STAR_BURST, 144, 64, $10
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 144, 64, $0
	anim_wait 3
	anim_sound 0, 1, SFX_DOUBLESLAP
	anim_obj BATTLE_ANIM_OBJ_HEART_BURST, 120, 52, $e8
	anim_wait 3
	anim_obj BATTLE_ANIM_OBJ_STAR_BURST, 120, 52, $9c
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 120, 52, $0
	anim_wait 3
	anim_obj BATTLE_ANIM_OBJ_STAR_BURST, 152, 48, $d0
	anim_wait 3
	anim_sound 6, 2, SFX_SLUDGE_BOMB
	anim_obj BATTLE_ANIM_OBJ_HEART_BURST, 152, 48, $1c
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 152, 48, $0
	anim_wait 3
	anim_obj BATTLE_ANIM_OBJ_STAR_BURST, 136, 56, $50
	anim_wait 3
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj BATTLE_ANIM_OBJ_HEART_BURST, 136, 56, $dc
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 3
	anim_obj BATTLE_ANIM_OBJ_STAR_BURST, 128, 48, $90
	anim_loop 2, .loop
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, $1, $0
	anim_ret

BattleAnim_IceBeam:
	anim_1gfx BATTLE_ANIM_GFX_ICE
.loop
	anim_sound 6, 2, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_ICE_BEAM, 64, 92, $4
	anim_wait 4
	anim_loop 5, .loop
	anim_obj BATTLE_ANIM_OBJ_ICE_BUILDUP, 136, 74, $10
.loop2
	anim_sound 6, 2, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_ICE_BEAM, 64, 92, $4
	anim_wait 4
	anim_loop 15, .loop2
	anim_wait 48
	anim_sound 0, 1, SFX_SHINE
	anim_wait 8
	anim_sound 0, 1, SFX_SHINE
	anim_wait 8
	anim_ret

BattleAnim_Blizzard:
	anim_1gfx BATTLE_ANIM_GFX_ICE
.loop
	anim_sound 6, 2, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_BLIZZARD, 64, 88, $63
	anim_wait 2
	anim_sound 6, 2, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_BLIZZARD, 64, 80, $64
	anim_wait 2
	anim_sound 6, 2, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_BLIZZARD, 64, 96, $63
	anim_wait 2
	anim_loop 3, .loop
	anim_1gfx BATTLE_ANIM_GFX_ICE
	anim_bgeffect BATTLE_BG_EFFECT_WHITE_HUES, $0, $8, $0
	anim_wait 32
	anim_obj BATTLE_ANIM_OBJ_ICE_BUILDUP, 136, 74, $10
	anim_wait 128
	anim_sound 0, 1, SFX_SHINE
	anim_wait 8
	anim_sound 0, 1, SFX_SHINE
	anim_wait 24
	anim_ret

BattleAnim_Bubblebeam:
	anim_1gfx BATTLE_ANIM_GFX_BUBBLE
.loop
	anim_sound 16, 2, SFX_BUBBLEBEAM
	anim_obj BATTLE_ANIM_OBJ_BUBBLE, 64, 92, $92
	anim_wait 6
	anim_sound 16, 2, SFX_BUBBLEBEAM
	anim_obj BATTLE_ANIM_OBJ_BUBBLE, 64, 92, $b3
	anim_wait 6
	anim_sound 16, 2, SFX_BUBBLEBEAM
	anim_obj BATTLE_ANIM_OBJ_BUBBLE, 64, 92, $f4
	anim_wait 8
	anim_loop 3, .loop
	anim_wait 64
	anim_clearobjs
	anim_bgeffect BATTLE_BG_EFFECT_START_WATER, $0, BG_EFFECT_TARGET, $0
	anim_wait 1
	anim_call BattleAnim_UserObj_2Row
	anim_bgeffect BATTLE_BG_EFFECT_WATER, $1c, $0, $0
	anim_wait 19
	anim_call BattleAnim_ShowMon_1
	anim_bgeffect BATTLE_BG_EFFECT_END_WATER, $0, $0, $0
	anim_wait 8
	anim_ret

BattleAnim_WaterGun:
	anim_bgeffect BATTLE_BG_EFFECT_START_WATER, $0, BG_EFFECT_TARGET, $0
	anim_1gfx BATTLE_ANIM_GFX_WATER
	anim_call BattleAnim_UserObj_2Row
	anim_sound 16, 2, SFX_WATER_GUN
	anim_obj BATTLE_ANIM_OBJ_WATER_GUN, 64, 88, $0
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_WATER_GUN, 64, 76, $0
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_WATER_GUN, 64, 82, $0
	anim_wait 24
	anim_bgeffect BATTLE_BG_EFFECT_WATER, $1c, $0, $0
	anim_wait 8
	anim_bgeffect BATTLE_BG_EFFECT_WATER, $8, $0, $0
	anim_wait 8
	anim_bgeffect BATTLE_BG_EFFECT_WATER, $30, $0, $0
	anim_wait 32
	anim_call BattleAnim_ShowMon_1
	anim_bgeffect BATTLE_BG_EFFECT_END_WATER, $0, $0, $0
	anim_wait 16
	anim_ret

BattleAnim_HydroPump:
	anim_2gfx BATTLE_ANIM_GFX_WATER, BATTLE_ANIM_GFX_WATER_BALL
	anim_battlergfx_1row
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $40, $2, $0
.loop
	anim_sound 0, 1, SFX_AEROBLAST
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP_SHOT, 64, 88, $6
	anim_wait 1
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP_SHOT, 64, 88, $6
	anim_wait 1
	anim_loop 14, .loop
	anim_wait 6
	anim_bgeffect BATTLE_BG_EFFECT_BATTLEROBJ_2ROW, $0, BG_EFFECT_USER, $0
	anim_wait 2
	anim_bgeffect BATTLE_BG_EFFECT_NIGHT_SHADE, $0, BG_EFFECT_TARGET, $8
	anim_sound 0, 1, SFX_HYDRO_PUMP
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 132, 72, $3a
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 124, 72, $3a
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 140, 72, $3a
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 116, 72, $3a
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 148, 72, $3a
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 108, 72, $3a
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 156, 72, $3a
	anim_wait 32
	anim_incbgeffect BATTLE_BG_EFFECT_NIGHT_SHADE
	anim_call BattleAnim_ShowMon_1
	anim_wait 16
	anim_ret

BattleAnim_Surf:
	anim_1gfx BATTLE_ANIM_GFX_BUBBLE
	anim_bgeffect BATTLE_BG_EFFECT_SURF, $0, $0, $0
	anim_obj BATTLE_ANIM_OBJ_SURF, 11, 0,  13, 0, $8
	anim_sound 0, 1, SFX_SURF
	anim_wait 112
	anim_incobj 1
	anim_wait 56
	anim_ret

BattleAnim_VineWhip:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GREEN
	anim_1gfx BATTLE_ANIM_GFX_WHIP
	anim_sound 0, 1, SFX_VINE_WHIP
	anim_obj BATTLE_ANIM_OBJ_VINE_WHIP2, 116, 52, $80
	anim_wait 4
	anim_sound 0, 1, SFX_VINE_WHIP
	anim_obj BATTLE_ANIM_OBJ_VINE_WHIP1, 128, 60, $0
	anim_wait 4
	anim_incobj 1
	anim_wait 4
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_LeechSeed:
	anim_1gfx BATTLE_ANIM_GFX_PLANT
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_obj BATTLE_ANIM_OBJ_LEECH_SEED, 48, 80, $20
	anim_wait 8
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_obj BATTLE_ANIM_OBJ_LEECH_SEED, 48, 80, $30
	anim_wait 8
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_obj BATTLE_ANIM_OBJ_LEECH_SEED, 48, 80, $28
	anim_wait 32
	anim_sound 0, 1, SFX_CHARGE
	anim_wait 128
	anim_ret

BattleAnim_SeedBomb:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_2gfx BATTLE_ANIM_GFX_PLANT, BATTLE_ANIM_GFX_EXPLOSION
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_obj BATTLE_ANIM_OBJ_LEECH_SEED,  6, 0, 10, 0, $20
	anim_wait 2
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_obj BATTLE_ANIM_OBJ_LEECH_SEED,  6, 0, 10, 0, $28
	anim_wait 2
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_obj BATTLE_ANIM_OBJ_LEECH_SEED,  6, 0, 10, 0, $30
	anim_wait 28
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $60, $4, $10
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $8, $24
	anim_clearobjs
	anim_call BattleAnimSub_Explosion2
	anim_wait 16
	anim_bgp $e4
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_RED
	anim_ret

BattleAnim_MeteorMash:
	anim_3gfx BATTLE_ANIM_GFX_STARS, BATTLE_ANIM_GFX_HIT, BATTLE_ANIM_GFX_WATER
	anim_bgp $1b
	anim_sound 0, 1, SFX_MORNING_SUN
	anim_obj BATTLE_ANIM_OBJ_RAIN, 88, 0, $2
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_RAIN, 88, 0, $2
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_RAIN, 88, 0, $2
	anim_wait 64
	anim_clearobjs
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $28, $2, $0
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_LONG_PUNCH, 136, 56, $0
	anim_wait 3
	anim_obj BATTLE_ANIM_OBJ_STAR_BURST, 136, 56, $28
	anim_wait 3
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj BATTLE_ANIM_OBJ_STAR_BURST, 136, 56, $5c
	anim_wait 3
	anim_obj BATTLE_ANIM_OBJ_STAR_BURST, 136, 56, $10
	anim_wait 3
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj BATTLE_ANIM_OBJ_STAR_BURST, 136, 56, $e8
	anim_wait 3
	anim_obj BATTLE_ANIM_OBJ_STAR_BURST, 136, 56, $9c
	anim_wait 3
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj BATTLE_ANIM_OBJ_STAR_BURST, 136, 56, $d0
	anim_wait 3
	anim_obj BATTLE_ANIM_OBJ_STAR_BURST, 136, 56, $1c
	anim_wait 3
	anim_obj BATTLE_ANIM_OBJ_STAR_BURST, 136, 56, $50
	anim_wait 3
	anim_obj BATTLE_ANIM_OBJ_STAR_BURST, 136, 56, $dc
	anim_wait 3
	anim_obj BATTLE_ANIM_OBJ_STAR_BURST, 136, 56, $90
	anim_wait 32
	anim_ret

BattleAnim_DrainPunch:
	anim_setobjpal PAL_BATTLE_OB_GREEN, PAL_BTLCUSTOM_BROWN
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_BROWN
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $20, $1, $0
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj BATTLE_ANIM_OBJ_PUNCH_SHAKE, 17, 0,  7, 0, $0
	anim_wait 6
	anim_sound 0, 1, SFX_PLACE_PUZZLE_PIECE_DOWN
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 17, 0,  7, 0, $0
	anim_wait 20
	; fallthrough

BattleAnim_Absorb:
	anim_2gfx BATTLE_ANIM_GFX_CHARGE, BATTLE_ANIM_GFX_SHINE
	anim_call SappingStub
	anim_wait 36
	anim_jump BattleAnimSub_Glimmer

BattleAnim_ShadowPunch:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_bgeffect BATTLE_BG_EFFECT_HIDE_MON, $0, $1, $0
	anim_bgp $1b
	anim_wait 24
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj BATTLE_ANIM_OBJ_PUNCH_SHAKE, 136, 56, $43
	anim_wait 16
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, $1, $0
	anim_ret

BattleAnim_IronBash:
	anim_1gfx BATTLE_ANIM_GFX_REFLECT
	anim_obp0 $0
	anim_sound 0, 0, SFX_RAGE
	anim_call BattleAnim_TargetObj_1Row
	anim_call BattleAnimSub_Metallic
	anim_call BattleAnim_ShowMon_0
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_resetobp0
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $14, $2, $0
.loop
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $14, $2, $0
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 132, 40, $0
	anim_wait 8
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $14, $2, $0
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 140, 48, $0
	anim_wait 8
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $14, $2, $0
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 132, 56, $0
	anim_wait 8
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $14, $2, $0
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 124, 48, $0
	anim_wait 8
	anim_loop 3, .loop
	anim_ret

BattleAnim_LeafBlade:
	anim_2gfx BATTLE_ANIM_GFX_PLANT, BATTLE_ANIM_GFX_CUT
	anim_sound 0, 1, SFX_CUT
	anim_obj BATTLE_ANIM_OBJ_CUT_LONG_DOWN_LEFT, 152, 40, $0
	anim_call BattleAnim_LeavesStub
	anim_wait 32
	anim_ret

BattleAnim_Solarbeam:
	anim_if_param_equal $0, .FireSolarBeam
	; charge turn
	anim_1gfx BATTLE_ANIM_GFX_CHARGE
	anim_sound 0, 0, SFX_CHARGE
	anim_obj BATTLE_ANIM_OBJ_ABSORB_CENTER, 48, 84, $0
	anim_obj BATTLE_ANIM_OBJ_SOLAR_BEAM_CHARGE, 48, 84, $0
	anim_obj BATTLE_ANIM_OBJ_SOLAR_BEAM_CHARGE, 48, 84, $8
	anim_obj BATTLE_ANIM_OBJ_SOLAR_BEAM_CHARGE, 48, 84, $10
	anim_obj BATTLE_ANIM_OBJ_SOLAR_BEAM_CHARGE, 48, 84, $18
	anim_obj BATTLE_ANIM_OBJ_SOLAR_BEAM_CHARGE, 48, 84, $20
	anim_obj BATTLE_ANIM_OBJ_SOLAR_BEAM_CHARGE, 48, 84, $28
	anim_obj BATTLE_ANIM_OBJ_SOLAR_BEAM_CHARGE, 48, 84, $30
	anim_obj BATTLE_ANIM_OBJ_SOLAR_BEAM_CHARGE, 48, 84, $38
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_WHITE, $0, $4, $2
	anim_wait 168
	anim_ret

.FireSolarBeam
	anim_1gfx BATTLE_ANIM_GFX_BEAM
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_jump BattleAnimSub_Beam

BattleAnim_Thunderpunch:
	anim_2gfx BATTLE_ANIM_GFX_HIT, BATTLE_ANIM_GFX_LIGHTNING
	anim_obj BATTLE_ANIM_OBJ_PUNCH_SHAKE, 136, 56, $43
BattleAnim_Thunderpunch_Stub:
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $8, $2
	anim_sound 0, 1, SFX_THUNDER
	anim_obj BATTLE_ANIM_OBJ_THUNDER_RIGHT, 152, 68, $0
	anim_wait 64
	anim_ret

BattleAnim_Thundershock:
	anim_2gfx BATTLE_ANIM_GFX_LIGHTNING, BATTLE_ANIM_GFX_EXPLOSION
	anim_obj BATTLE_ANIM_OBJ_THUNDERSHOCK_BALL, 136, 56, $2
	anim_wait 16
	anim_sound 0, 1, SFX_THUNDERSHOCK
	anim_obj BATTLE_ANIM_OBJ_SPARKS_CIRCLE, 136, 56, $0
	anim_wait 96
	anim_ret

BattleAnim_Thunderbolt:
	anim_2gfx BATTLE_ANIM_GFX_LIGHTNING, BATTLE_ANIM_GFX_EXPLOSION
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_obj BATTLE_ANIM_OBJ_THUNDERBOLT_BALL, 132, 52, $2
	anim_wait 16
	anim_obj BATTLE_ANIM_OBJ_SPARKS_CIRCLE_BIG, 132, 52, $0
.loop
	anim_sound 0, 1, SFX_THUNDERBOLT
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $7, $6
	anim_wait 66
	anim_loop 2, .loop
	anim_ret

BattleAnim_PowerGem:
	anim_1gfx BATTLE_ANIM_GFX_SHINE
	anim_bgp $1b
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 0, 0, SFX_METRONOME
	anim_obj ANIM_OBJ_POWER_GEM, 46, 88, $0
	anim_wait 1
	anim_obj ANIM_OBJ_POWER_GEM, 24, 90, $0
	anim_wait 1
	anim_obj ANIM_OBJ_POWER_GEM, 36, 72, $0
	anim_wait 1
	anim_obj ANIM_OBJ_POWER_GEM, 44, 112, $0
	anim_wait 1
	anim_obj ANIM_OBJ_POWER_GEM, 30, 106, $0
	anim_wait 1
	anim_obj ANIM_OBJ_POWER_GEM, 64, 104, $0
	anim_wait 1
	anim_obj ANIM_OBJ_POWER_GEM, 54, 68, $0
	anim_wait 1
	anim_obj ANIM_OBJ_POWER_GEM, 72, 82, $0
	anim_wait 80
	anim_sound 0, 1, SFX_SHINE
	anim_incobj  8
	anim_wait 2
	anim_incobj  7
	anim_wait 2
	anim_sound 0, 1, SFX_SHINE
	anim_incobj  6
	anim_wait 4
	anim_sound 0, 1, SFX_SHINE
	anim_incobj  4
	anim_wait 2
	anim_incobj  1
	anim_wait 2
	anim_sound 0, 1, SFX_SHINE
	anim_incobj  3
	anim_wait 2
	anim_incobj  5
	anim_wait 2
	anim_sound 0, 1, SFX_SHINE
	anim_incobj  2
	anim_wait 34
	anim_ret

BattleAnim_ThunderWave:
	anim_1gfx BATTLE_ANIM_GFX_LIGHTNING
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $4, $3
	anim_sound 0, 1, SFX_THUNDERSHOCK
	anim_obj BATTLE_ANIM_OBJ_THUNDER_WAVE, 136, 56, $0
	anim_wait 20
	anim_bgp $1b
	anim_incobj 1
	anim_wait 96
	anim_ret

BattleAnim_MilkDrink:
	anim_2gfx BATTLE_ANIM_GFX_MISC, BATTLE_ANIM_GFX_BUBBLE
	anim_obj BATTLE_ANIM_OBJ_MILK_DRINK, 74, 104, $0
	anim_wait 16
	anim_bgeffect BATTLE_BG_EFFECT_FADE_MON_TO_LIGHT_REPEATING, $0, BG_EFFECT_USER, $40
	anim_sound 0, 0, SFX_MILK_DRINK
	anim_jump BattleAnimSub_SoftboiledHeal

BattleAnim_Thunder:
	anim_1gfx BATTLE_ANIM_GFX_LIGHTNING
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $6, $20
	anim_sound 0, 1, SFX_THUNDER
	anim_obj BATTLE_ANIM_OBJ_THUNDER_LEFT, 120, 68, $0
	anim_wait 16
	anim_sound 0, 1, SFX_THUNDER
	anim_obj BATTLE_ANIM_OBJ_THUNDER_RIGHT, 152, 68, $0
	anim_wait 16
	anim_sound 0, 1, SFX_THUNDER
	anim_obj BATTLE_ANIM_OBJ_THUNDER_CENTER, 136, 68, $0
	anim_wait 48
	anim_ret

BattleAnim_RazorWind:
	anim_1gfx BATTLE_ANIM_GFX_WHIP
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $1, $0
.loop
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $4, $2
	anim_sound 0, 1, SFX_RAZOR_WIND
	anim_obj BATTLE_ANIM_OBJ_RAZOR_WIND2, 152, 40, $3
	anim_wait 4
	anim_sound 0, 1, SFX_RAZOR_WIND
	anim_obj BATTLE_ANIM_OBJ_RAZOR_WIND2, 136, 56, $3
	anim_wait 4
	anim_sound 0, 1, SFX_RAZOR_WIND
	anim_obj BATTLE_ANIM_OBJ_RAZOR_WIND2, 152, 64, $3
	anim_wait 4
	anim_sound 0, 1, SFX_RAZOR_WIND
	anim_obj BATTLE_ANIM_OBJ_RAZOR_WIND1, 120, 40, $83
	anim_wait 4
	anim_sound 0, 1, SFX_RAZOR_WIND
	anim_obj BATTLE_ANIM_OBJ_RAZOR_WIND1, 120, 64, $83
	anim_wait 4
	anim_loop 3, .loop
	anim_wait 24
	anim_ret

BattleAnim_Gust:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_BROWN
	anim_2gfx BATTLE_ANIM_GFX_WIND, BATTLE_ANIM_GFX_HIT
.loop
	anim_sound 0, 1, SFX_RAZOR_WIND
	anim_obj BATTLE_ANIM_OBJ_GUST, 136, 72, $0
	anim_wait 6
	anim_loop 9, .loop
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 144, 64, $18
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 128, 32, $18
	anim_wait 16
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_ThroatChop:
	anim_call BattleAnim_InvertScreenColoursSub
	; fallthrough

BattleAnim_CrossChop:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_GRAY
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_FIRE
	anim_3gfx BATTLE_ANIM_GFX_CUT, BATTLE_ANIM_GFX_CHOP, BATTLE_ANIM_GFX_HIT
 	anim_sound 0, 1, SFX_MEGA_PUNCH
 	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $58, $1, $0
 	anim_obj BATTLE_ANIM_OBJ_CROSS_CHOP1, 128, 48, $28
 	anim_obj BATTLE_ANIM_OBJ_CROSS_CHOP2, 142, 48, $38
 	anim_setobj $1, $2
 	anim_setobj $2, $2
 	anim_wait 48
 	anim_clearobjs
 	anim_obj BATTLE_ANIM_OBJ_CROSS_CHOP1, 116, 36, $8
 	anim_obj BATTLE_ANIM_OBJ_CROSS_CHOP2, 154, 36, $18
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $58, $2, $0
	anim_setobj $3, $3
 	anim_setobj $4, $3
	anim_sound 0, 1, SFX_VICEGRIP
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $8, $10
	anim_obj BATTLE_ANIM_OBJ_CUT_LONG_DOWN_LEFT, 150, 38, $0
 	anim_obj BATTLE_ANIM_OBJ_CUT_LONG_DOWN_RIGHT, 120, 38, $0
 	anim_wait 32
 	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
 	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_BLUE
	anim_ret

BattleAnim_Explosion:
	anim_1gfx BATTLE_ANIM_GFX_EXPLOSION
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $60, $4, $10
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $8, $24
	anim_if_param_equal $1, .loop
	anim_call BattleAnimSub_Explosion2
	anim_wait 16
	anim_ret

.loop
	anim_call BattleAnimSub_Explosion1
	anim_wait 5
	anim_bgeffect BATTLE_BG_EFFECT_HIDE_MON, $0, BG_EFFECT_USER, $0
	anim_loop 2, .loop
	anim_wait 16
	anim_ret

BattleAnim_Acid:
	anim_1gfx BATTLE_ANIM_GFX_POISON
	anim_call BattleAnimSub_Acid
	anim_wait 64
	anim_ret

BattleAnim_RockBlast:
	anim_2gfx BATTLE_ANIM_GFX_ROCKS, BATTLE_ANIM_GFX_HIT
	anim_sound 6, 2, SFX_SPARK
	anim_obj BATTLE_ANIM_OBJ_ROCK_BLAST, 64, 92, $4
	anim_wait 16
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 128, 56, $0
	anim_obj BATTLE_ANIM_OBJ_ROCK_SMASH, 128, 56, $5c
	anim_obj BATTLE_ANIM_OBJ_ROCK_SMASH, 128, 56, $e8
	anim_obj BATTLE_ANIM_OBJ_ROCK_SMASH, 128, 56, $d0
	anim_obj BATTLE_ANIM_OBJ_ROCK_SMASH, 128, 56, $50
	anim_wait 32
	anim_ret

BattleAnim_StoneEdge:
	anim_2gfx BATTLE_ANIM_GFX_HIT, BATTLE_ANIM_GFX_ROCKS
	anim_sound 0, 0, SFX_SPARK
	anim_obj BATTLE_ANIM_OBJ_STONE_EDGE_STILL, 156, 64, $8
	anim_wait 1
	anim_obj BATTLE_ANIM_OBJ_STONE_EDGE_STILL, 152, 64, $8
	anim_wait 1
	anim_sound 0, 0, SFX_SPARK
	anim_obj BATTLE_ANIM_OBJ_STONE_EDGE_STILL, 128, 64, $8
	anim_wait 1
	anim_obj BATTLE_ANIM_OBJ_STONE_EDGE_STILL, 108, 64, $8
	anim_wait 1
	anim_sound 0, 0, SFX_SPARK
	anim_obj BATTLE_ANIM_OBJ_STONE_EDGE_STILL, 112, 64, $8
	anim_wait 1
	anim_obj BATTLE_ANIM_OBJ_STONE_EDGE_STILL, 148, 64, $8
	anim_wait 1
	anim_sound 0, 0, SFX_SPARK
	anim_obj BATTLE_ANIM_OBJ_STONE_EDGE_STILL, 118, 64, $8
	anim_wait 1
	anim_obj BATTLE_ANIM_OBJ_STONE_EDGE_STILL, 136, 64, $8
	anim_wait 1
	anim_sound 0, 0, SFX_SPARK
	anim_obj BATTLE_ANIM_OBJ_STONE_EDGE_STILL, 116, 64, $8
	anim_wait 1
	anim_obj BATTLE_ANIM_OBJ_STONE_EDGE_STILL, 144, 64, $8
	anim_wait 32
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj BATTLE_ANIM_OBJ_STONE_EDGE, 156, 64, $8
	anim_wait 2
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $55, $1, $0
	anim_obj BATTLE_ANIM_OBJ_STONE_EDGE, 152, 64, $8
	anim_wait 2
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj BATTLE_ANIM_OBJ_STONE_EDGE, 128, 64, $8
	anim_obj BATTLE_ANIM_OBJ_HIT_SMALL_YFIX, 120, 40, $0
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_STONE_EDGE, 108, 64, $8
	anim_wait 2
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj BATTLE_ANIM_OBJ_STONE_EDGE, 112, 64, $8
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_STONE_EDGE, 148, 64, $8
	anim_obj BATTLE_ANIM_OBJ_HIT_SMALL_YFIX, 152, 48, $0
	anim_wait 2
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj BATTLE_ANIM_OBJ_STONE_EDGE, 118, 64, $8
	anim_wait 2
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $4, $2
	anim_obj BATTLE_ANIM_OBJ_STONE_EDGE, 136, 64, $8
	anim_wait 2
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj BATTLE_ANIM_OBJ_STONE_EDGE, 116, 64, $8
	anim_obj BATTLE_ANIM_OBJ_HIT_SMALL_YFIX, 136, 56, $0
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_STONE_EDGE, 144, 64, $8
	anim_wait 32
	anim_ret

BattleAnim_RockSlide:
	anim_1gfx BATTLE_ANIM_GFX_ROCKS
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $c0, $1, $0
.loop
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj BATTLE_ANIM_OBJ_SMALL_ROCK, 128, 64, $40
	anim_wait 4
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj BATTLE_ANIM_OBJ_BIG_ROCK, 120, 68, $30
	anim_wait 4
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj BATTLE_ANIM_OBJ_SMALL_ROCK, 152, 68, $30
	anim_wait 4
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj BATTLE_ANIM_OBJ_BIG_ROCK, 144, 64, $40
	anim_wait 4
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj BATTLE_ANIM_OBJ_SMALL_ROCK, 136, 68, $30
	anim_wait 16
	anim_loop 4, .loop
	anim_wait 96
	anim_ret

BattleAnim_Sing:
	anim_1gfx BATTLE_ANIM_GFX_NOISE
	anim_sound 16, 2, SFX_SING
.loop
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_AURORA
	anim_obj BATTLE_ANIM_OBJ_SING, 64, 92, $0
	anim_wait 8
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_PURPLE
	anim_obj BATTLE_ANIM_OBJ_SING, 64, 92, $1
	anim_wait 8
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_BULK_UP
	anim_obj BATTLE_ANIM_OBJ_SING, 64, 92, $2
	anim_wait 8
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_FIRE
	anim_obj BATTLE_ANIM_OBJ_SING, 64, 92, $0
	anim_wait 8
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_PINK
	anim_obj BATTLE_ANIM_OBJ_SING, 64, 92, $2
	anim_wait 8
	anim_loop 4, .loop
	anim_wait 64
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_Acrobatics:
	anim_2gfx BATTLE_ANIM_GFX_SPEED, BATTLE_ANIM_GFX_HIT
	anim_battlergfx_1row
	anim_bgeffect BATTLE_BG_EFFECT_BATTLEROBJ_2ROW, $0, $0, $0
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $0, $11, $4
.loop
	anim_sound 0, 0, SFX_SQUEAK
	anim_wait 8
	anim_loop 3, .loop
	anim_sound 0, 0, SFX_RAZOR_WIND
	anim_bgeffect BATTLE_BG_EFFECT_HIDE_MON, $0, $1, $0
	anim_incbgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X
	anim_call BattleAnimSub_SpeedLines
	anim_wait 12
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, $0, $0
	anim_wait 12
	anim_clearobjs
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $0, $0
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 140, 44, $0
	anim_wait 4
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 124, 60, $0
	anim_wait 4
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 140, 60, $0
	anim_wait 4
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 124, 44, $0
	anim_wait 4
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 132, 52, $0
	anim_wait 8
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $a, $0
	anim_wait 8
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, $1, $0
	anim_wait 16
	anim_ret

BattleAnim_Poisonpowder:
BattleAnim_SleepPowder:
BattleAnim_StunSpore:
	anim_1gfx BATTLE_ANIM_GFX_POWDER
.loop
	anim_sound 0, 1, SFX_POWDER
	anim_obj BATTLE_ANIM_OBJ_POWDER, 104, 16, $0
	anim_wait 4
	anim_sound 0, 1, SFX_POWDER
	anim_obj BATTLE_ANIM_OBJ_POWDER, 136, 16, $0
	anim_wait 4
	anim_sound 0, 1, SFX_POWDER
	anim_obj BATTLE_ANIM_OBJ_POWDER, 112, 16, $0
	anim_wait 4
	anim_sound 0, 1, SFX_POWDER
	anim_obj BATTLE_ANIM_OBJ_POWDER, 128, 16, $0
	anim_wait 4
	anim_sound 0, 1, SFX_POWDER
	anim_obj BATTLE_ANIM_OBJ_POWDER, 120, 16, $0
	anim_wait 4
	anim_loop 2, .loop
	anim_wait 96
	anim_ret

BattleAnim_HyperBeam:
	anim_1gfx BATTLE_ANIM_GFX_BEAM
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $30, $4, $10
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $8, $40
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	; fallthrough

BattleAnimSub_Beam:
	anim_sound 0, 0, SFX_HYPER_BEAM
	anim_obj BATTLE_ANIM_OBJ_BEAM, 64, 92, $0
	anim_wait 4
	anim_sound 0, 0, SFX_HYPER_BEAM
	anim_obj BATTLE_ANIM_OBJ_BEAM, 80, 84, $0
	anim_wait 4
	anim_sound 0, 1, SFX_HYPER_BEAM
	anim_obj BATTLE_ANIM_OBJ_BEAM, 96, 76, $0
	anim_wait 4
	anim_sound 0, 1, SFX_HYPER_BEAM
	anim_obj BATTLE_ANIM_OBJ_BEAM, 112, 68, $0
	anim_obj BATTLE_ANIM_OBJ_BEAM_TIP, 126, 62, $0
	anim_wait 48
	anim_ret

BattleAnim_AuroraBeam:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_AURORA
	anim_1gfx BATTLE_ANIM_GFX_BEAM_LIGHT
	anim_1gfx BATTLE_ANIM_GFX_BEAM
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect BATTLE_BG_EFFECT_ALTERNATE_HUES, $0, $2, $0
	anim_wait 64
	anim_call BattleAnimSub_Beam
	anim_incobj 5
	anim_wait 64
	anim_ret

BattleAnim_FuryStrikes:
	anim_2gfx BATTLE_ANIM_GFX_MISC, BATTLE_ANIM_GFX_HIT
	anim_sound 0, 1, SFX_KINESIS_2
	anim_obj BATTLE_ANIM_OBJ_ANGER, 72, 72, $0
	anim_wait 40
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_obj BATTLE_ANIM_OBJ_HIT, 128, 40, $0
	anim_wait 8
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_obj BATTLE_ANIM_OBJ_HIT, 136, 56, $0
	anim_wait 8
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_obj BATTLE_ANIM_OBJ_HIT, 132, 48, $0
	anim_wait 8
	anim_ret

BattleAnim_Cut:
	anim_2gfx BATTLE_ANIM_GFX_REFLECT, BATTLE_ANIM_GFX_HIT
	anim_obp0 $0
	anim_sound 0, 0, SFX_RAGE
	anim_call BattleAnim_TargetObj_1Row
	anim_call BattleAnimSub_Metallic
	anim_call BattleAnim_ShowMon_0
	anim_resetobp0
	anim_call BattleAnim_TargetObj_1Row
	anim_1gfx BATTLE_ANIM_GFX_CUT
	anim_sound 0, 1, SFX_CUT
	anim_obj BATTLE_ANIM_OBJ_CUT_LONG_DOWN_LEFT, 152, 40, $0
	anim_wait 24
	anim_jump BattleAnim_ShowMon_0

BattleAnim_Slash:
	anim_1gfx BATTLE_ANIM_GFX_CUT
	; fallthrough

BattleAnim_SlashPartSub:
	anim_sound 0, 1, SFX_CUT
	anim_obj BATTLE_ANIM_OBJ_CUT_LONG_DOWN_LEFT, 19, 0,  5, 0, $0
	anim_obj BATTLE_ANIM_OBJ_CUT_LONG_DOWN_LEFT, 18, 4,  4, 4, $0
	anim_wait 32
	anim_ret

BattleAnim_BulletPunch:
	anim_3gfx BATTLE_ANIM_GFX_REFLECT, BATTLE_ANIM_GFX_SPEED, BATTLE_ANIM_GFX_HIT
	anim_call BattleAnim_TargetObj_1Row
	anim_obp0 0, 0, 0, 0
	anim_call BattleAnimSub_Metallic
	anim_call BattleAnim_ShowMon_0
	anim_bgeffect BATTLE_BG_EFFECT_HIDE_MON, $0, $1, $0
	anim_resetobp0
	anim_jump BattleAnim_SpeedPunchStub

BattleAnim_MachPunch:
	anim_2gfx BATTLE_ANIM_GFX_SPEED, BATTLE_ANIM_GFX_HIT
	anim_bgeffect BATTLE_BG_EFFECT_HIDE_MON, $0, BG_EFFECT_USER, $0
	; fallthrough

BattleAnim_SpeedPunchStub:
	anim_sound 0, 0, SFX_MENU
	anim_call BattleAnimSub_SpeedLines
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj BATTLE_ANIM_OBJ_PUNCH, 136, 56, $0
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 8
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, BG_EFFECT_USER, $0
	anim_wait 16
	anim_ret

BattleAnim_Bite:
	anim_2gfx BATTLE_ANIM_GFX_CUT, BATTLE_ANIM_GFX_HIT
	anim_obj BATTLE_ANIM_OBJ_BITE, 136, 56, $98
	anim_obj BATTLE_ANIM_OBJ_BITE, 136, 56, $18
	anim_wait 8
	anim_sound 0, 1, SFX_BITE
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 144, 48, $18
	anim_wait 16
	anim_sound 0, 1, SFX_BITE
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 128, 64, $18
	anim_wait 8
	anim_ret

BattleAnim_Teleport:
	anim_1gfx BATTLE_ANIM_GFX_SPEED
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_TELEPORT, $0, BG_EFFECT_USER, $0
	anim_wait 32
	anim_bgeffect BATTLE_BG_EFFECT_HIDE_MON, $0, BG_EFFECT_USER, $0
	anim_wait 3
	anim_incbgeffect BATTLE_BG_EFFECT_TELEPORT
	anim_call BattleAnim_ShowMon_0
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $1, $0
	anim_call BattleAnimSub_WarpAway
	anim_wait 64
	anim_ret

BattleAnim_Fly:
	anim_if_param_equal $1, .turn1
	anim_if_param_equal $2, .miss
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_sound 0, 1, SFX_WING_ATTACK
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 32
.miss:
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, BG_EFFECT_USER, $0
	anim_wait 32
	anim_ret

.turn1:
	anim_1gfx BATTLE_ANIM_GFX_SPEED
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $1, $0
	anim_bgeffect BATTLE_BG_EFFECT_HIDE_MON, $0, BG_EFFECT_USER, $0
	anim_call BattleAnimSub_WarpAway
	anim_wait 64
	anim_ret

BattleAnim_GunkShot:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_PURPLE
	anim_1gfx BATTLE_ANIM_GFX_POISON
	anim_bgp $f8
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $85, $2, $0
	anim_sound 6, 2, SFX_BUBBLEBEAM
	anim_obj ANIM_OBJ_GUNKSHOT, 64, 92, $4
	anim_wait 3
	anim_obj ANIM_OBJ_GUNKSHOT, 64, 92, $4
	anim_wait 3
.loop
	anim_obj BATTLE_ANIM_OBJ_SLUDGE, 132, 72, $0
	anim_sound 6, 2, SFX_BUBBLEBEAM
	anim_obj ANIM_OBJ_GUNKSHOT, 64, 92, $4
	anim_wait 3
	anim_obj ANIM_OBJ_GUNKSHOT, 64, 92, $4
	anim_wait 3
	anim_obj BATTLE_ANIM_OBJ_SLUDGE, 116, 72, $0
	anim_sound 6, 2, SFX_BUBBLEBEAM
	anim_obj ANIM_OBJ_GUNKSHOT, 64, 92, $4
	anim_wait 3
	anim_obj ANIM_OBJ_GUNKSHOT, 64, 92, $4
	anim_wait 3
	anim_obj BATTLE_ANIM_OBJ_SLUDGE, 148, 72, $0
	anim_sound 6, 2, SFX_BUBBLEBEAM
	anim_obj ANIM_OBJ_GUNKSHOT, 64, 92, $4
	anim_wait 3
	anim_obj ANIM_OBJ_GUNKSHOT, 64, 92, $4
	anim_wait 3
	anim_loop 4, .loop
	anim_wait 32
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnimSub_Sludge:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_PURPLE
.loop
	anim_sound 0, 1, SFX_TOXIC
	anim_obj BATTLE_ANIM_OBJ_SLUDGE, 132, 72, $0
	anim_wait 8
	anim_sound 0, 1, SFX_TOXIC
	anim_obj BATTLE_ANIM_OBJ_SLUDGE, 116, 72, $0
	anim_wait 8
	anim_sound 0, 1, SFX_TOXIC
	anim_obj BATTLE_ANIM_OBJ_SLUDGE, 148, 72, $0
	anim_wait 8
	anim_loop 3, .loop
	anim_wait 36
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_Recover:
	anim_2gfx BATTLE_ANIM_GFX_BUBBLE, BATTLE_ANIM_GFX_SHINE
	anim_sound 0, 0, SFX_SHARPEN
	anim_bgeffect BATTLE_BG_EFFECT_FADE_MON_TO_LIGHT_REPEATING, $0, BG_EFFECT_USER, $40
	anim_obj BATTLE_ANIM_OBJ_RECOVER, 44, 88, $30
	anim_obj BATTLE_ANIM_OBJ_RECOVER, 44, 88, $31
	anim_obj BATTLE_ANIM_OBJ_RECOVER, 44, 88, $32
	anim_obj BATTLE_ANIM_OBJ_RECOVER, 44, 88, $33
	anim_obj BATTLE_ANIM_OBJ_RECOVER, 44, 88, $34
	anim_obj BATTLE_ANIM_OBJ_RECOVER, 44, 88, $35
	anim_obj BATTLE_ANIM_OBJ_RECOVER, 44, 88, $36
	anim_obj BATTLE_ANIM_OBJ_RECOVER, 44, 88, $37
	anim_wait 96
	anim_incbgeffect BATTLE_BG_EFFECT_FADE_MON_TO_LIGHT_REPEATING
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $0, $0
	anim_sound 0, 0, SFX_METRONOME
	anim_obj BATTLE_ANIM_OBJ_GLIMMER, 44, 64, $0
	anim_wait 5
	anim_obj BATTLE_ANIM_OBJ_GLIMMER, 24, 96, $0
	anim_wait 5
	anim_obj BATTLE_ANIM_OBJ_GLIMMER, 56, 104, $0
	anim_wait 24
	anim_ret

BattleAnim_MegaDrain:
	anim_2gfx BATTLE_ANIM_GFX_CHARGE, BATTLE_ANIM_GFX_SHINE
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_FADE_MONS_TO_BLACK_REPEATING, $0, BG_EFFECT_TARGET, $10
	anim_obj BATTLE_ANIM_OBJ_ABSORB_CENTER, 44, 88, $0
	anim_call SappingStub
	anim_wait 120
	anim_incbgeffect BATTLE_BG_EFFECT_FADE_MONS_TO_BLACK_REPEATING
	anim_call BattleAnim_ShowMon_0
	anim_jump BattleAnimSub_Glimmer

SappingStub:
.loop
	anim_sound 6, 3, SFX_WATER_GUN
	anim_obj BATTLE_ANIM_OBJ_ABSORB, 128, 48, $2
	anim_wait 2
	anim_sound 6, 3, SFX_WATER_GUN
	anim_obj BATTLE_ANIM_OBJ_ABSORB, 136, 64, $3
	anim_wait 3
	anim_sound 6, 3, SFX_WATER_GUN
	anim_obj BATTLE_ANIM_OBJ_ABSORB, 136, 32, $4
	anim_wait 1
	anim_loop 4, .loop
	anim_ret

BattleAnim_EggBomb:
	anim_2gfx BATTLE_ANIM_GFX_EGG, BATTLE_ANIM_GFX_EXPLOSION
	anim_sound 6, 2, SFX_THROW_BALL
	anim_obj BATTLE_ANIM_OBJ_EGG_BOMB, 48, 80, $28
	anim_wait 32
	anim_clearobjs
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $8, $3
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj BATTLE_ANIM_OBJ_EXPLOSION2, 128, 64, $0
	anim_wait 8
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj BATTLE_ANIM_OBJ_EXPLOSION2, 144, 68, $0
	anim_wait 8
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj BATTLE_ANIM_OBJ_EXPLOSION2, 136, 72, $0
	anim_wait 24
	anim_ret

BattleAnim_Softboiled:
	anim_2gfx BATTLE_ANIM_GFX_EGG, BATTLE_ANIM_GFX_BUBBLE
	anim_sound 0, 0, SFX_SWITCH_POKEMON
	anim_obj BATTLE_ANIM_OBJ_EGG, 44, 104, $6
	anim_wait 128
	anim_incobj 1
	anim_obj BATTLE_ANIM_OBJ_EGG, 76, 104, $b
	anim_wait 16
	anim_bgeffect BATTLE_BG_EFFECT_FADE_MON_TO_LIGHT_REPEATING, $0, BG_EFFECT_USER, $40
	anim_sound 0, 0, SFX_METRONOME
	;fallthrough

BattleAnimSub_SoftboiledHeal:
.loop
	anim_obj BATTLE_ANIM_OBJ_RECOVER, 44, 88, $20
	anim_wait 8
	anim_loop 8, .loop
	anim_wait 128
	anim_incbgeffect BATTLE_BG_EFFECT_FADE_MON_TO_LIGHT_REPEATING
	anim_ret

BattleAnim_BulkUp:
	anim_2gfx BATTLE_ANIM_GFX_BULK_UP, BATTLE_ANIM_GFX_WIND
	anim_sound 0, 0, SFX_SQUEAK
	anim_obj BATTLE_ANIM_OBJ_BULK_UP, 48, 88, $0
	anim_wait 32
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $08, $2, $0
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_BULK_UP
	anim_sound 0, 0, SFX_HORN_ATTACK
	anim_wait 16
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_wait 8
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $08, $2, $0
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_BULK_UP
	anim_sound 0, 0, SFX_HORN_ATTACK
	anim_wait 24
	anim_clearobjs
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_sound 0, 0, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_SWAGGER, 72, 88, $44
	anim_wait 32
	anim_ret

BattleAnim_FuryDrive:
	anim_1gfx BATTLE_ANIM_GFX_MISC
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $c0, $1, $0
	anim_sound 0, 0, SFX_KINESIS_2
	anim_obj BATTLE_ANIM_OBJ_ANGER, 72, 80, $0
	anim_wait 40
	; fallthrough

BattleAnim_FocusEnergy:
	anim_1gfx BATTLE_ANIM_GFX_SPEED
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_FADE_MON_TO_LIGHT, $0, BG_EFFECT_USER, $40
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
.loop
	; fallthrough

BattleAnim_SubFocusingAnim:
.loop
	anim_sound 0, 0, SFX_SWORDS_DANCE
	anim_obj BATTLE_ANIM_OBJ_FOCUS, 44, 108, $6
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_FOCUS, 36, 108, $6
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_FOCUS, 52, 108, $8
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_FOCUS, 28, 108, $8
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_FOCUS, 60, 108, $6
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_FOCUS, 20, 108, $8
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_FOCUS, 68, 108, $8
	anim_wait 2
	anim_loop 2, .loop
	anim_wait 8
	anim_incbgeffect BATTLE_BG_EFFECT_CYCLE_MON_LIGHT_DARK_REPEATING
	anim_jump BattleAnim_ShowMon_0

BattleAnim_DarkPulse:
	anim_1gfx BATTLE_ANIM_GFX_CHARGE
	anim_bgeffect BATTLE_BG_EFFECT_WHIRLPOOL, $0, $0, $0
	anim_bgp $1b
	anim_sound 0, 1, SFX_SPITE
	anim_obj ANIM_OBJ_DARK_PULSE, 44, 88, $0
	anim_obj ANIM_OBJ_DARK_PULSE, 44, 88, $8
	anim_obj ANIM_OBJ_DARK_PULSE, 44, 88, $10
	anim_obj ANIM_OBJ_DARK_PULSE, 44, 88, $18
	anim_obj ANIM_OBJ_DARK_PULSE, 44, 88, $20
	anim_obj ANIM_OBJ_DARK_PULSE, 44, 88, $28
	anim_obj ANIM_OBJ_DARK_PULSE, 44, 88, $30
	anim_obj ANIM_OBJ_DARK_PULSE, 44, 88, $38
	anim_incobj 1
	anim_incobj 2
	anim_incobj 3
	anim_incobj 4
	anim_incobj 5
	anim_incobj 6
	anim_incobj 7
	anim_incobj 8
	anim_wait 96
	anim_incbgeffect BATTLE_BG_EFFECT_WHIRLPOOL
	anim_ret

BattleAnim_InvertScreenColoursSub:
	anim_2gfx BATTLE_ANIM_GFX_HIT, BATTLE_ANIM_GFX_EGG
	anim_sound 0, 0, SFX_RAGE
	anim_bgp $1b
	anim_wait 32
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $60, $2, $0
	anim_ret

BattleAnim_Avalanche:
	anim_2gfx BATTLE_ANIM_GFX_ROCKS, BATTLE_ANIM_GFX_ICE
	anim_setobjpal PAL_BATTLE_OB_BROWN, PAL_BTLCUSTOM_WATER
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $60, $1, $0
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj BATTLE_ANIM_OBJ_SMALL_ROCK, 128, 64, $40
	anim_wait 4
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj BATTLE_ANIM_OBJ_BIG_ROCK, 120, 68, $30
	anim_wait 4
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj BATTLE_ANIM_OBJ_SMALL_ROCK, 152, 68, $30
	anim_wait 4
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj BATTLE_ANIM_OBJ_BIG_ROCK, 144, 64, $40
	anim_wait 4
	anim_call BattleAnimSub_Ice
	anim_obj BATTLE_ANIM_OBJ_SMALL_ROCK, 136, 68, $30
	anim_setobjpal PAL_BATTLE_OB_BROWN, PAL_BTLCUSTOM_BROWN
	anim_ret

BattleAnim_IcicleCrash:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_ICE
	anim_2gfx BATTLE_ANIM_GFX_ICICLECRASH, BATTLE_ANIM_GFX_ICE
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $60, $1, $0
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj BATTLE_ANIM_OBJ_ICICLE_CRASH, 120, 64, $40
	anim_wait 2
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj BATTLE_ANIM_OBJ_ICICLE_CRASH, 112, 68, $30
	anim_wait 2
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj BATTLE_ANIM_OBJ_ICICLE_CRASH, 142, 68, $30
	anim_wait 2
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj BATTLE_ANIM_OBJ_ICICLE_CRASH, 136, 64, $40
	anim_wait 2
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj BATTLE_ANIM_OBJ_ICICLE_CRASH, 128, 68, $30
	anim_bgeffect BATTLE_BG_EFFECT_WHITE_HUES, $0, $8, $0
	anim_wait 40
	anim_obj BATTLE_ANIM_OBJ_ICE_SPLASH, 128, 66, $28
	anim_obj BATTLE_ANIM_OBJ_ICE_SPLASH, 120, 66, $9c
	anim_obj BATTLE_ANIM_OBJ_ICE_SPLASH, 152, 66, $28
	anim_obj BATTLE_ANIM_OBJ_ICE_SPLASH, 152, 66, $9c
	anim_obj BATTLE_ANIM_OBJ_ICE_SPLASH, 144, 66, $28
	anim_obj BATTLE_ANIM_OBJ_ICE_SPLASH, 136, 66, $9c
	anim_wait 32
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_BLUE
	anim_ret

BattleAnim_Wrap:
	anim_1gfx BATTLE_ANIM_GFX_ROPE
	anim_sound 0, 1, SFX_BIND
	anim_obj BATTLE_ANIM_OBJ_BIND, 132, 64, $0
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_BIND, 132, 56, $0
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_BIND, 132, 48, $0
	anim_wait 64
	anim_sound 0, 1, SFX_BIND
	anim_incobj 1
	anim_incobj 2
	anim_incobj 3
	anim_wait 96
	anim_ret

BattleAnim_Confusion:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_call BattleAnim_UserObj_2Row
	anim_sound 0, 1, SFX_PSYCHIC
	anim_bgeffect BATTLE_BG_EFFECT_NIGHT_SHADE, $0, BG_EFFECT_TARGET, $8
	anim_wait 128
	anim_incbgeffect BATTLE_BG_EFFECT_NIGHT_SHADE
	anim_jump BattleAnim_ShowMon_1

BattleAnim_Earthquake:
	anim_1gfx BATTLE_ANIM_GFX_ROCKS
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $8, $40
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $60, $4, $10
.loop
	anim_sound 0, 1, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_ROCK_SMASH, 128, 72, $5c
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_ROCK_SMASH, 136, 72, $d0
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_ROCK_SMASH, 144, 72, $e8
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_ROCK_SMASH, 152, 72, $50
	anim_wait 4
	anim_loop 5, .loop
	anim_ret

BattleAnim_Growl:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_FIRE
	anim_1gfx BATTLE_ANIM_GFX_NOISE
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_cry $0
.loop
	anim_call BattleAnimSub_Sound
	anim_wait 16
	anim_loop 3, .loop
	anim_wait 17
	anim_bgeffect BATTLE_BG_EFFECT_FADE_MON_TO_BLACK_REPEATING, $0, BG_EFFECT_TARGET, $40
	anim_wait 64
	anim_incbgeffect BATTLE_BG_EFFECT_FADE_MON_TO_BLACK_REPEATING
	anim_wait 1
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, BG_EFFECT_USER, $0
	anim_wait 5
	anim_incobj 9
	anim_wait 8
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_Roar:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_FIRE
	anim_1gfx BATTLE_ANIM_GFX_NOISE
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_cry $1
.loop
	anim_call BattleAnimSub_Sound
	anim_wait 16
	anim_loop 3, .loop
	anim_wait 16
	anim_if_param_equal $0, .done
	anim_bgeffect BATTLE_BG_EFFECT_REMOVE_MON, $0, BG_EFFECT_TARGET, $0
	anim_wait 64
.done
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_Supersonic:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_YELLOW
	anim_1gfx BATTLE_ANIM_GFX_PSYCHIC
.loop
	anim_sound 6, 2, SFX_SUPERSONIC
	anim_obj BATTLE_ANIM_OBJ_WAVE, 64, 88, $2
	anim_wait 4
	anim_loop 10, .loop
	anim_wait 64
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_IceFang:
	anim_call BattleAnim_Bite
	anim_clearobjs
	anim_1gfx BATTLE_ANIM_GFX_ICE
	anim_jump BattleAnimSub_Ice

BattleAnim_Screech:
	anim_1gfx BATTLE_ANIM_GFX_PSYCHIC
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $8, $1, $20
	anim_sound 6, 2, SFX_SCREECH
.loop
	anim_obj BATTLE_ANIM_OBJ_WAVE, 64, 88, $2
	anim_wait 2
	anim_loop 2, .loop
	anim_wait 64
	anim_ret

BattleAnim_XScissor:
	anim_1gfx BATTLE_ANIM_GFX_CUT
	anim_sound 0, 1, SFX_CUT
	anim_obj BATTLE_ANIM_OBJ_CUT_LONG_DOWN_LEFT, 18, 0,  6, 0, $0
	anim_obj BATTLE_ANIM_OBJ_CUT_LONG_DOWN_RIGHT, 15, 0,  6, 0, $0
	anim_wait 8
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $58, $2, $0
	anim_sound 0, 1, SFX_CUT
	anim_obj BATTLE_ANIM_OBJ_CUT_LONG_DOWN_LEFT, 18, 4,  5, 0, $0
	anim_obj BATTLE_ANIM_OBJ_CUT_LONG_DOWN_RIGHT, 14, 4,  5, 0, $0
	anim_wait 8
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $58, $2, $0
	anim_sound 0, 1, SFX_CUT
	anim_obj BATTLE_ANIM_OBJ_CUT_LONG_DOWN_LEFT, 19, 0,  4, 0, $0
	anim_obj BATTLE_ANIM_OBJ_CUT_LONG_DOWN_RIGHT, 14, 0,  4, 0, $0
	anim_wait 32
	anim_sound 0, 1, SFX_VICEGRIP
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $8, $10
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_CUT_LONG_DOWN_LEFT, 18, 4,  5, 0, $0
	anim_obj BATTLE_ANIM_OBJ_CUT_LONG_DOWN_RIGHT, 14, 4,  5, 0, $0
	anim_wait 20
	anim_bgp $e4
	anim_ret

BattleAnim_ConfuseRay:
	anim_1gfx BATTLE_ANIM_GFX_SPEED
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_BGPALS_INVERTED, $0, $4, $0
	anim_obj BATTLE_ANIM_OBJ_CONFUSE_RAY, 64, 88, $0
	anim_obj BATTLE_ANIM_OBJ_CONFUSE_RAY, 64, 88, $80
	anim_obj BATTLE_ANIM_OBJ_CONFUSE_RAY, 64, 88, $88
	anim_obj BATTLE_ANIM_OBJ_CONFUSE_RAY, 64, 88, $90
	anim_obj BATTLE_ANIM_OBJ_CONFUSE_RAY, 64, 88, $98
	anim_obj BATTLE_ANIM_OBJ_CONFUSE_RAY, 64, 88, $a0
	anim_obj BATTLE_ANIM_OBJ_CONFUSE_RAY, 64, 88, $a8
	anim_obj BATTLE_ANIM_OBJ_CONFUSE_RAY, 64, 88, $b0
	anim_obj BATTLE_ANIM_OBJ_CONFUSE_RAY, 64, 88, $b8
.loop
	anim_sound 6, 2, SFX_WHIRLWIND
	anim_wait 16
	anim_loop 8, .loop
	anim_wait 32
	anim_ret

BattleAnim_Leer:
	anim_1gfx BATTLE_ANIM_GFX_BEAM
	; fallthrough

BattleAnimSub_EyeBeams:
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 6, 2, SFX_LEER
	anim_obj BATTLE_ANIM_OBJ_LEER, 72, 84, $0
	anim_obj BATTLE_ANIM_OBJ_LEER, 64, 80, $0
	anim_obj BATTLE_ANIM_OBJ_LEER, 88, 76, $0
	anim_obj BATTLE_ANIM_OBJ_LEER, 80, 72, $0
	anim_obj BATTLE_ANIM_OBJ_LEER, 104, 68, $0
	anim_obj BATTLE_ANIM_OBJ_LEER, 96, 64, $0
	anim_obj BATTLE_ANIM_OBJ_LEER, 120, 60, $0
	anim_obj BATTLE_ANIM_OBJ_LEER, 112, 56, $0
	anim_obj BATTLE_ANIM_OBJ_LEER_TIP, 130, 54, $0
	anim_obj BATTLE_ANIM_OBJ_LEER_TIP, 122, 50, $0
	anim_wait 16
	anim_ret

BattleAnim_Reflect:
	anim_1gfx BATTLE_ANIM_GFX_REFLECT
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $4, $2
	anim_sound 0, 0, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_SCREEN, 72, 80, $0
	anim_wait 24
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $4, $2
	anim_sound 0, 0, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_SCREEN, 72, 80, $0
	anim_wait 64
	anim_ret

BattleAnim_LightScreen:
	anim_2gfx BATTLE_ANIM_GFX_SPEED, BATTLE_ANIM_GFX_REFLECT
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 0, 0, SFX_FLASH
	anim_call BattleAnim_LightScreen_Branch
	anim_wait 64
	anim_ret

BattleAnim_LightScreen_Branch:
	anim_obj BATTLE_ANIM_OBJ_SCREEN, 72, 80, $0
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_SHINY, 72, 80, $0
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_SHINY, 72, 80, $8
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_SHINY, 72, 80, $10
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_SHINY, 72, 80, $18
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_SCREEN, 72, 80, $0
	anim_obj BATTLE_ANIM_OBJ_SHINY, 72, 80, $20
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_SHINY, 72, 80, $28
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_SHINY, 72, 80, $30
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_SHINY, 72, 80, $38
	anim_ret

BattleAnim_Amnesia:
	anim_1gfx BATTLE_ANIM_GFX_STATUS
	anim_sound 0, 0, SFX_LICK
	anim_obj BATTLE_ANIM_OBJ_AMNESIA, 64, 80, $2
	anim_wait 16
	anim_obj BATTLE_ANIM_OBJ_AMNESIA, 68, 80, $1
	anim_wait 16
	anim_obj BATTLE_ANIM_OBJ_AMNESIA, 72, 80, $0
	anim_wait 64
	anim_ret

BattleAnim_TrickRoom:
	anim_1gfx BATTLE_ANIM_GFX_WIND
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect BATTLE_BG_EFFECT_ALTERNATE_HUES, $0, $2, $0
	anim_bgeffect BATTLE_BG_EFFECT_PSYCHIC, $0, $0, $0
	anim_call BattleAnimSub_Agility
.loop
	anim_sound 0, 0, SFX_THROW_BALL
	anim_wait 16
	anim_loop 4, .loop
	anim_incbgeffect BATTLE_BG_EFFECT_PSYCHIC
	anim_ret

BattleAnim_Splash:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_sound 0, 0, SFX_VICEGRIP
	anim_call BattleAnim_TargetObj_2Row
	anim_bgeffect BATTLE_BG_EFFECT_BOUNCE_DOWN, $0, BG_EFFECT_USER, $0
	anim_wait 96
	anim_incbgeffect BATTLE_BG_EFFECT_BOUNCE_DOWN
	anim_jump BattleAnim_ShowMon_0

BattleAnim_Dig:
	anim_2gfx BATTLE_ANIM_GFX_SAND, BATTLE_ANIM_GFX_HIT
	anim_if_param_equal $0, .hit
	anim_if_param_equal $2, .fail
	anim_call BattleAnim_TargetObj_2Row
	anim_bgeffect BATTLE_BG_EFFECT_DIG, $0, BG_EFFECT_USER, $1
	anim_obj BATTLE_ANIM_OBJ_DIG_PILE, 72, 104, $0
.loop
	anim_sound 0, 0, SFX_RAZOR_WIND
	anim_obj BATTLE_ANIM_OBJ_DIG_SAND, 56, 104, $0
	anim_wait 16
	anim_loop 6, .loop
	anim_wait 32
	anim_bgeffect BATTLE_BG_EFFECT_HIDE_MON, $0, BG_EFFECT_USER, $0
	anim_wait 8
	anim_incbgeffect BATTLE_BG_EFFECT_DIG
	anim_jump BattleAnim_ShowMon_0

.hit
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 32
.fail
	anim_bgeffect BATTLE_BG_EFFECT_ENTER_MON, $0, BG_EFFECT_USER, $0
	anim_wait 32
	anim_ret

BattleAnim_DrainKiss:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_PINK
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_PINK
	anim_2gfx BATTLE_ANIM_GFX_OBJECTS, BATTLE_ANIM_GFX_ANGELS
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_obj BATTLE_ANIM_OBJ_SWEET_KISS, 96, 40, $0
	anim_sound 0, 1, SFX_SWEET_KISS
	anim_wait 32
	anim_clearobjs
	anim_sound 0, 1, SFX_SWEET_KISS_2
	anim_1gfx BATTLE_ANIM_GFX_BUBBLE
	anim_sound 6, 3, SFX_WATER_GUN
	anim_call BattleAnimSub_Drain
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_BLUE
	anim_1gfx BATTLE_ANIM_GFX_SHINE
	anim_call BattleAnimSub_Glimmer
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_BLUE
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_StringShot:
	anim_1gfx BATTLE_ANIM_GFX_WEB
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 6, 2, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_STRING_SHOT, 64, 80, $0
	anim_wait 4
	anim_sound 0, 1, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_STRING_SHOT, 132, 48, $1
	anim_wait 4
	anim_sound 6, 2, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_STRING_SHOT, 64, 88, $0
	anim_wait 4
	anim_sound 0, 1, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_STRING_SHOT, 132, 64, $1
	anim_wait 4
	anim_sound 6, 2, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_STRING_SHOT, 64, 84, $0
	anim_wait 4
	anim_sound 0, 1, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_STRING_SHOT, 132, 56, $2
	anim_wait 64
	anim_ret

BattleAnim_Tackle:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_TACKLE, $0, BG_EFFECT_USER, $0
	anim_wait 4
	anim_sound 0, 1, SFX_TACKLE
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 136, 48, $0
	anim_wait 8
	anim_jump BattleAnim_ShowMon_0

BattleAnim_BodyPress:
	anim_2gfx BATTLE_ANIM_GFX_SPEED, BATTLE_ANIM_GFX_HIT
	anim_if_param_equal $1, BattleAnim_HiJumpKick
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $1, $0
	anim_bgeffect BATTLE_BG_EFFECT_HIDE_MON, $0, $1, $0
	anim_sound 0, 0, SFX_OUTRAGE
	anim_call BattleAnim_DiveBomb_Branch
	anim_wait 32
	anim_sound 0, 1, SFX_TACKLE
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 136, 43, $0
	anim_wait 8
	anim_sound 0, 1, SFX_TACKLE
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 136, 53, $0
	anim_wait 16
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, $1, $0
	anim_ret

BattleAnim_BodySlam:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_call BattleAnim_TargetObj_2Row
	anim_bgeffect BATTLE_BG_EFFECT_BOUNCE_DOWN, $0, BG_EFFECT_USER, $0
	anim_wait 32
	anim_incbgeffect BATTLE_BG_EFFECT_BOUNCE_DOWN
	anim_wait 4
	anim_bgeffect BATTLE_BG_EFFECT_BODY_SLAM, $0, BG_EFFECT_USER, $0
	anim_wait 3
	anim_sound 0, 1, SFX_TACKLE
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 48, $0
	anim_wait 6
	anim_sound 0, 1, SFX_TACKLE
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 144, 48, $0
	anim_wait 3
	anim_jump BattleAnim_ShowMon_0

BattleAnim_Psyshock:
	anim_2gfx BATTLE_ANIM_GFX_SHINE, BATTLE_ANIM_GFX_CHARGE
	anim_call BattleAnim_UserObj_1Row
	anim_sound 0, 0, SFX_RAGE
	anim_obj BATTLE_ANIM_OBJ_GLIMMER, 44, 96, $0
	anim_wait 32
	anim_bgeffect BATTLE_BG_EFFECT_ALTERNATE_HUES, $0, $2, $0
	anim_sound 0, 1, SFX_PSYCHIC
	anim_bgeffect BATTLE_BG_EFFECT_TELEPORT, $0, $0, $0
.loop
	anim_obj ANIM_OBJ_PSYSHOCK, 136, 56, $38
	anim_wait 4
	anim_obj ANIM_OBJ_PSYSHOCK, 136, 56, $20
	anim_wait 4
	anim_obj ANIM_OBJ_PSYSHOCK, 136, 56, $8
	anim_wait 4
	anim_obj ANIM_OBJ_PSYSHOCK, 136, 56, $10
	anim_wait 4
	anim_obj ANIM_OBJ_PSYSHOCK, 136, 56, $28
	anim_wait 4
	anim_obj ANIM_OBJ_PSYSHOCK, 136, 56, $0
	anim_wait 4
	anim_obj ANIM_OBJ_PSYSHOCK, 136, 56, $18
	anim_wait 4
	anim_obj ANIM_OBJ_PSYSHOCK, 136, 56, $30
	anim_wait 4
	anim_loop 2, .loop
	anim_wait 32
	anim_incbgeffect BATTLE_BG_EFFECT_TELEPORT
	anim_jump BattleAnim_ShowMon_1

BattleAnim_FocusBlast:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_YELLOW
	anim_3gfx BATTLE_ANIM_GFX_SPEED, BATTLE_ANIM_GFX_EGG, BATTLE_ANIM_GFX_EXPLOSION
	anim_call BattleAnim_SubFocusingAnim
	anim_sound 6, 2, SFX_SLUDGE_BOMB
	anim_obj BATTLE_ANIM_OBJ_OCTAZOOKA, 64, 92, $4
	anim_wait 24
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $30, $3, $0
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_YELLOW 
	anim_call BattleAnimSub_Explosion2
	anim_wait 32
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_RED
	anim_ret

BattleAnim_Psyblast:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_PURPLE
	anim_2gfx BATTLE_ANIM_GFX_SPEED, BATTLE_ANIM_GFX_BEAM
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_FADE_MON_TO_LIGHT, $0, BG_EFFECT_USER, $40
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
.loop
	anim_call BattleAnim_SubFocusingAnim
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $30, $4, $10
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $8, $40
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_call BattleAnimSub_Beam
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_YELLOW
	anim_ret

BattleAnimSub_Agility:
	anim_obj BATTLE_ANIM_OBJ_AGILITY, 8, 24, $10
	anim_obj BATTLE_ANIM_OBJ_AGILITY, 8, 48, $2
	anim_obj BATTLE_ANIM_OBJ_AGILITY, 8, 88, $8
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_AGILITY, 8, 32, $6
	anim_obj BATTLE_ANIM_OBJ_AGILITY, 8, 56, $c
	anim_obj BATTLE_ANIM_OBJ_AGILITY, 8, 80, $4
	anim_obj BATTLE_ANIM_OBJ_AGILITY, 8, 104, $e
	anim_ret

BattleAnim_CloseCombat:
	anim_2gfx BATTLE_ANIM_GFX_SPEED, BATTLE_ANIM_GFX_HIT
	anim_sound 0, 0, SFX_RAZOR_WIND
	anim_bgeffect BATTLE_BG_EFFECT_HIDE_MON, $0, BG_EFFECT_USER, $0
	anim_call BattleAnimSub_SpeedLines
	anim_wait 12
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $60, $2, $0
	anim_bgp $90
.loop
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj BATTLE_ANIM_OBJ_PUNCH, 148, 56, $0
	anim_wait 1
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 148, 56, $0
	anim_wait 2
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj BATTLE_ANIM_OBJ_PUNCH, 122, 34, $0
	anim_wait 1
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 122, 34, $0
	anim_wait 2
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj BATTLE_ANIM_OBJ_PUNCH, 132, 64, $0
	anim_wait 1
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 132, 64, $0
	anim_wait 2
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj BATTLE_ANIM_OBJ_PUNCH, 140, 42, $0
	anim_wait 1
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 140, 42, $0
	anim_wait 2
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj BATTLE_ANIM_OBJ_PUNCH, 114, 52, $0
	anim_wait 1
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 114, 52, $0
	anim_wait 2
	anim_loop 4, .loop
	anim_wait 8
	anim_call BattleAnimSub_SpeedLines
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, BG_EFFECT_USER, $0
	anim_wait 8
	anim_ret

BattleAnim_Defog:
BattleAnim_Whirlwind:
	anim_1gfx BATTLE_ANIM_GFX_WIND
.loop
	anim_sound 0, 0, SFX_RAZOR_WIND
	anim_obj BATTLE_ANIM_OBJ_GUST, 64, 112, $0
	anim_wait 6
	anim_loop 9, .loop
	anim_incobj 1
	anim_incobj 2
	anim_incobj 3
	anim_incobj 4
	anim_incobj 5
	anim_incobj 6
	anim_incobj 7
	anim_incobj 8
	anim_incobj 9
	anim_sound 16, 2, SFX_WHIRLWIND
	anim_wait 128
	anim_if_param_equal $0, .done
	anim_bgeffect BATTLE_BG_EFFECT_REMOVE_MON, $0, BG_EFFECT_TARGET, $0
	anim_wait 64
.done
	anim_ret

BattleAnim_Hypnosis:
	anim_1gfx BATTLE_ANIM_GFX_PSYCHIC
.loop
	anim_sound 6, 2, SFX_SUPERSONIC
	anim_obj BATTLE_ANIM_OBJ_WAVE, 64, 88, $2
	anim_obj BATTLE_ANIM_OBJ_WAVE, 56, 80, $2
	anim_wait 8
	anim_loop 3, .loop
	anim_wait 56
	anim_ret

BattleAnim_Haze:
	anim_1gfx BATTLE_ANIM_GFX_HAZE
	anim_sound 0, 1, SFX_SURF
.loop
	anim_obj BATTLE_ANIM_OBJ_HAZE, 48, 56, $0
	anim_obj BATTLE_ANIM_OBJ_HAZE, 132, 16, $0
	anim_wait 12
	anim_loop 5, .loop
	anim_wait 96
	anim_ret

BattleAnim_Mist:
	anim_obp0 $54
	anim_1gfx BATTLE_ANIM_GFX_HAZE
	anim_sound 0, 0, SFX_SURF
.loop
	anim_obj BATTLE_ANIM_OBJ_MIST, 48, 56, $0
	anim_wait 8
	anim_loop 10, .loop
	anim_wait 96
	anim_ret

BattleAnim_HornAttack:
	anim_2gfx BATTLE_ANIM_GFX_HORN, BATTLE_ANIM_GFX_HIT
	anim_obj BATTLE_ANIM_OBJ_HORN, 72, 80, $1
	anim_wait 16
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 16
	anim_ret

BattleAnim_GigaImpact:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_FIRE
	anim_2gfx BATTLE_ANIM_GFX_HIT, BATTLE_ANIM_GFX_CHARGE
	anim_bgeffect BATTLE_BG_EFFECT_WHITE_HUES, $0, $8, $0
	anim_sound 0, 0, SFX_OUTRAGE
.loop
	anim_obj BATTLE_ANIM_OBJ_GROWTH, 48, 108, $0
	anim_obj BATTLE_ANIM_OBJ_GROWTH, 48, 108, $20
	anim_wait 4
	anim_loop 4, .loop
	anim_wait 48
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $8, $40
	anim_call BattleAnim_TargetObj_2Row
	anim_bgeffect BATTLE_BG_EFFECT_TACKLE, $0, $1, $0
	anim_sound 0, 0, SFX_SPARK
	anim_wait 16
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, $0, $0
	anim_wait 4
	anim_clearobjs
	anim_sound 0, 1, SFX_THUNDER
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $60, $4, $10
.loop2
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 136, 48, $0
	anim_wait 20
	anim_loop 3, .loop2
	anim_wait 16
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_DoubleEdge:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_FIRE
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $4, $10
	anim_bgeffect BATTLE_BG_EFFECT_TACKLE, $0, BG_EFFECT_USER, $0
	anim_wait 3
	anim_sound 0, 1, SFX_TACKLE
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 128, 48, $0
	anim_wait 6
	anim_sound 0, 1, SFX_TACKLE
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 144, 48, $0
	anim_wait 3
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_jump BattleAnim_ShowMon_0

BattleAnim_RockTomb:
	anim_1gfx BATTLE_ANIM_GFX_ROCKS
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $4, $2, $0
	anim_obj BATTLE_ANIM_OBJ_ROCK_TOMB, 128, 18, $10
	anim_wait 12
	anim_sound 0, 1, SFX_EGG_BOMB	
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $4, $2, $0
	anim_obj BATTLE_ANIM_OBJ_ROCK_TOMB, 152, 17, $10
	anim_wait 12
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $4, $2, $0
	anim_obj BATTLE_ANIM_OBJ_ROCK_TOMB, 112, 17, $10
	anim_wait 12
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $20, $2, $0
	anim_obj BATTLE_ANIM_OBJ_ROCK_TOMB, 136, 16, $10
	anim_wait 12
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_wait 36
	anim_ret

;BattleAnim_RockThrow:
;	anim_1gfx BATTLE_ANIM_GFX_ROCKS
;	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $60, $1, $0
;	anim_sound 0, 1, SFX_STRENGTH
;	anim_obj BATTLE_ANIM_OBJ_SMALL_ROCK, 128, 64, $40
;	anim_wait 2
;	anim_sound 0, 1, SFX_STRENGTH
;	anim_obj BATTLE_ANIM_OBJ_BIG_ROCK, 120, 68, $30
;	anim_wait 2
;	anim_sound 0, 1, SFX_STRENGTH
;	anim_obj BATTLE_ANIM_OBJ_SMALL_ROCK, 152, 68, $30
;	anim_wait 2
;	anim_sound 0, 1, SFX_STRENGTH
;	anim_obj BATTLE_ANIM_OBJ_BIG_ROCK, 144, 64, $40
;	anim_wait 2
;	anim_sound 0, 1, SFX_STRENGTH
;	anim_obj BATTLE_ANIM_OBJ_SMALL_ROCK, 136, 68, $30
;	anim_wait 96
;	anim_ret

BattleAnim_PoisonSting:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_PURPLE
	anim_2gfx BATTLE_ANIM_GFX_HORN, BATTLE_ANIM_GFX_HIT
	anim_obj BATTLE_ANIM_OBJ_NEEDLE, 64, 92, $14
	anim_wait 16
	anim_sound 0, 1, SFX_POISON_STING
	anim_obj BATTLE_ANIM_OBJ_HIT_SMALL, 136, 56, $0
	anim_wait 16
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_Thrash:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $30, $2, $0
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_FIRE
	anim_sound 0, 1, SFX_POUND
	anim_obj BATTLE_ANIM_OBJ_PALM, 120, 72, $0
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 120, 72, $0
	anim_wait 6
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_PURPLE
	anim_sound 0, 1, SFX_MOVE_PUZZLE_PIECE
	anim_obj BATTLE_ANIM_OBJ_PUNCH, 136, 56, $0
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 136, 56, $0
	anim_wait 6
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GREEN
	anim_sound 0, 1, SFX_DOUBLE_KICK
	anim_obj BATTLE_ANIM_OBJ_KICK, 152, 40, $0
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 152, 40, $0
	anim_wait 16
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_FakeOut:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj BATTLE_ANIM_OBJ_PALM, 116, 48, $0
	anim_obj BATTLE_ANIM_OBJ_PALM, 156, 48, $0
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 116, 48, $0
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 156, 48, $0
	anim_wait 16
	anim_ret

BattleAnim_Transform:
	anim_call BattleAnim_TargetObj_2Row
	anim_transform
	anim_bgeffect BATTLE_BG_EFFECT_WAVE_DEFORM_MON, $0, BG_EFFECT_USER, $0
	anim_wait 16
	anim_updateactorpic
	anim_incbgeffect BATTLE_BG_EFFECT_WAVE_DEFORM_MON
	anim_wait 16
	anim_jump BattleAnim_ShowMon_0

BattleAnim_Tremor:
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $60, $4, $10
	anim_sound 0, 1, SFX_EMBER
	anim_wait 24
	anim_ret

BattleAnim_LovelyKiss:
	anim_2gfx BATTLE_ANIM_GFX_OBJECTS, BATTLE_ANIM_GFX_ANGELS
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_obj BATTLE_ANIM_OBJ_LOVELY_KISS, 152, 40, $0
	anim_wait 32
	anim_sound 0, 1, SFX_LICK
	anim_obj BATTLE_ANIM_OBJ_HEART, 128, 40, $0
	anim_wait 40
	anim_ret

BattleAnim_Swift:
	anim_1gfx BATTLE_ANIM_GFX_OBJECTS
	anim_sound 6, 2, SFX_METRONOME
	anim_obj BATTLE_ANIM_OBJ_SWIFT, 64, 88, $4
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_SWIFT, 64, 72, $4
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_SWIFT, 64, 76, $4
	anim_wait 64
	anim_ret

BattleAnim_FairyFlash:
	anim_3gfx BATTLE_ANIM_GFX_SPEED, BATTLE_ANIM_GFX_HIT, BATTLE_ANIM_GFX_SHINE
	anim_sound 0, 1, SFX_MOONLIGHT
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect BATTLE_BG_EFFECT_ALTERNATE_HUES, $0, $2, $0
	anim_obj BATTLE_ANIM_OBJ_DAZZLE, 44, 88, $0
	anim_obj BATTLE_ANIM_OBJ_DAZZLE, 44, 88, $8
	anim_obj BATTLE_ANIM_OBJ_DAZZLE, 44, 88, $10
	anim_obj BATTLE_ANIM_OBJ_DAZZLE, 44, 88, $18
	anim_obj BATTLE_ANIM_OBJ_DAZZLE, 44, 88, $20
	anim_obj BATTLE_ANIM_OBJ_DAZZLE, 44, 88, $28
	anim_obj BATTLE_ANIM_OBJ_DAZZLE, 44, 88, $30
	anim_obj BATTLE_ANIM_OBJ_DAZZLE, 44, 88, $38
	anim_wait 64
	anim_incbgeffect BATTLE_BG_EFFECT_ALTERNATE_HUES
	anim_sound 0, 1, SFX_FLASH
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $6, $20
	anim_wait 4
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_MON_LIGHT_DARK_REPEATING, $0, $1, $20
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_obj BATTLE_ANIM_OBJ_GLIMMER, 24, 64, $0
	anim_wait 5
	anim_obj BATTLE_ANIM_OBJ_GLIMMER, 56, 104, $0
	anim_wait 5
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 136, 56, $0
	anim_obj BATTLE_ANIM_OBJ_GLIMMER, 24, 104, $0
	anim_wait 5
	anim_obj BATTLE_ANIM_OBJ_GLIMMER, 56, 64, $0
	anim_wait 5
	anim_obj BATTLE_ANIM_OBJ_GLIMMER, 40, 84, $0
	anim_wait 32
	anim_ret

BattleAnim_PsychoCut:
	anim_2gfx BATTLE_ANIM_GFX_WHIP, BATTLE_ANIM_GFX_HIT
	anim_bgeffect BATTLE_BG_EFFECT_PSYCHIC, $0, $0, $0
.loop
	anim_sound 3, 0, SFX_RAZOR_WIND
	anim_obj BATTLE_ANIM_OBJ_SONICBOOM_JP, 64, 80, $3
	anim_wait 4
	anim_sound 3, 0, SFX_RAZOR_WIND
	anim_obj BATTLE_ANIM_OBJ_SONICBOOM_JP, 64, 88, $2
	anim_wait 4
	anim_sound 3, 0, SFX_RAZOR_WIND
	anim_obj BATTLE_ANIM_OBJ_SONICBOOM_JP, 64, 96, $4
	anim_wait 4
	anim_loop 2, .loop
	anim_wait 16
	anim_incobj 1
	anim_incobj 2
	anim_incobj 3
	anim_incobj 4
	anim_incobj 5
	anim_incobj 6
	anim_sound 0, 1, SFX_CUT
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 16
	anim_incbgeffect BATTLE_BG_EFFECT_PSYCHIC
	anim_wait 4
	anim_ret

BattleAnim_NightSlash:
	anim_1gfx BATTLE_ANIM_GFX_CUT
	anim_bgp $1b
	anim_obp0 0, 1, 2, 3
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $60, $2, $0
	anim_call BattleAnim_SlashPartSub
	anim_bgp $e4
	anim_ret

BattleAnim_BugBuzz:
	anim_2gfx BATTLE_ANIM_GFX_NOISE, BATTLE_ANIM_GFX_PSYCHIC
.loop
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_Y, $14, $2, $0
	anim_sound 0, 0, SFX_OUTRAGE
	anim_wait 8
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_Y, $14, $2, $0
	anim_sound 0, 0, SFX_SNORE
	anim_call BattleAnimSub_Sound
	anim_obj BATTLE_ANIM_OBJ_WAVE,  7, 0, 11, 0, $2
	anim_obj BATTLE_ANIM_OBJ_WAVE,  9, 0, 11, 0, $2
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_WAVE,  8, 0, 11, 0, $2
	anim_wait 4
	anim_sound 0, 0, SFX_SNORE
	anim_call BattleAnimSub_Sound
	anim_obj BATTLE_ANIM_OBJ_WAVE,  7, 4, 11, 0, $2
	anim_obj BATTLE_ANIM_OBJ_WAVE,  8, 4, 11, 0, $2
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_WAVE,  8, 0, 11, 0, $2
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_WAVE,  7, 6, 11, 0, $2
	anim_obj BATTLE_ANIM_OBJ_WAVE,  8, 2, 11, 0, $2
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_WAVE,  8, 0, 11, 0, $2
	anim_wait 24
	anim_ret

BattleAnim_Peck:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_sound 0, 1, SFX_PECK
	anim_obj BATTLE_ANIM_OBJ_HIT_SMALL_YFIX, 128, 48, $0
	anim_wait 8
	anim_sound 0, 1, SFX_PECK
	anim_obj BATTLE_ANIM_OBJ_HIT_SMALL_YFIX, 136, 56, $0
	anim_wait 16
	anim_ret

BattleAnim_DrillPeck:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $64, $1, $0
.loop
	anim_sound 0, 1, SFX_PECK
	anim_obj BATTLE_ANIM_OBJ_HIT_SMALL_YFIX, 128, 40, $0
	anim_wait 2
	anim_sound 0, 1, SFX_PECK
	anim_obj BATTLE_ANIM_OBJ_HIT_SMALL_YFIX, 139, 45, $0
	anim_wait 2
	anim_sound 0, 1, SFX_PECK
	anim_obj BATTLE_ANIM_OBJ_HIT_SMALL_YFIX, 144, 56, $0
	anim_wait 2
	anim_sound 0, 1, SFX_PECK
	anim_obj BATTLE_ANIM_OBJ_HIT_SMALL_YFIX, 139, 67, $0
	anim_wait 2
	anim_sound 0, 1, SFX_PECK
	anim_obj BATTLE_ANIM_OBJ_HIT_SMALL_YFIX, 128, 72, $0
	anim_wait 2
	anim_sound 0, 1, SFX_PECK
	anim_obj BATTLE_ANIM_OBJ_HIT_SMALL_YFIX, 117, 67, $0
	anim_wait 2
	anim_sound 0, 1, SFX_PECK
	anim_obj BATTLE_ANIM_OBJ_HIT_SMALL_YFIX, 112, 56, $0
	anim_wait 2
	anim_sound 0, 1, SFX_PECK
	anim_obj BATTLE_ANIM_OBJ_HIT_SMALL_YFIX, 117, 45, $0
	anim_wait 2
	anim_loop 3, .loop
	anim_wait 16
	anim_ret

BattleAnim_DragonPulse:
	anim_2gfx BATTLE_ANIM_GFX_GLOW, BATTLE_ANIM_GFX_CHARGE
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $55, $1, $0
	anim_bgeffect BATTLE_BG_EFFECT_ALTERNATE_HUES, $0, $2, $0
	anim_jump BattleAnim_CannonSub

BattleAnim_FlashCannon:
	anim_2gfx BATTLE_ANIM_GFX_GLOW, BATTLE_ANIM_GFX_CHARGE
	anim_bgeffect BATTLE_BG_EFFECT_ALTERNATE_HUES, $0, $2, $0
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $60, $2, $0
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_GRAY
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_GRAY
BattleAnim_CannonSub:
	anim_obj BATTLE_ANIM_OBJ_SMALL_GLOW, 48, 96, $0
.loop
	anim_sound 0, 1, SFX_AEROBLAST
	anim_obj BATTLE_ANIM_OBJ_DRAGON_PULSE, 64, 88, $4
	anim_wait 4
	anim_loop 16, .loop
	anim_incobj 1
	anim_wait 16
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, $1, $0
	anim_wait 4
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_BLUE
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_YELLOW
	anim_ret

BattleAnim_MirrorShot:
	anim_3gfx BATTLE_ANIM_GFX_REFLECT, BATTLE_ANIM_GFX_SPEED, BATTLE_ANIM_GFX_BEAM
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 0, 0, SFX_FLASH
	anim_call BattleAnim_LightScreen_Branch
	anim_wait 24
	anim_obj BATTLE_ANIM_OBJ_BEAM, 64, 92, $0
	anim_wait 4
	anim_sound 0, 0, SFX_FLASH
	anim_obj BATTLE_ANIM_OBJ_BEAM, 80, 84, $0
	anim_wait 4
	anim_sound 0, 1, SFX_FLASH
	anim_obj BATTLE_ANIM_OBJ_BEAM, 96, 76, $0
	anim_wait 4
	anim_sound 0, 1, SFX_FLASH
	anim_obj BATTLE_ANIM_OBJ_BEAM, 112, 68, $0
	anim_obj BATTLE_ANIM_OBJ_BEAM_TIP, 126, 62, $0
	anim_wait 16
	anim_incobj  5
	anim_wait 64
	anim_ret

BattleAnim_Substitute:
	anim_sound 0, 0, SFX_SURF
	anim_if_param_equal $3, .dropsub2
	anim_if_param_equal $2, .raisesub
	anim_if_param_equal $1, .dropsub
	anim_1gfx BATTLE_ANIM_GFX_SMOKE
	anim_bgeffect BATTLE_BG_EFFECT_REMOVE_MON, $0, BG_EFFECT_USER, $0
	anim_wait 48
	anim_raisesub
	anim_obj BATTLE_ANIM_OBJ_BALL_POOF, 48, 96, $0
	anim_bgeffect BATTLE_BG_EFFECT_ENTER_MON, $0, BG_EFFECT_USER, $0
	anim_wait 32
	anim_ret

.dropsub:
	anim_bgeffect BATTLE_BG_EFFECT_REMOVE_MON, $0, BG_EFFECT_USER, $0
	anim_wait 48
	anim_dropsub
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, BG_EFFECT_USER, $0
	anim_wait 32
	anim_ret

.raisesub:
	anim_bgeffect BATTLE_BG_EFFECT_REMOVE_MON, $0, BG_EFFECT_USER, $0
	anim_wait 48
	anim_raisesub
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, BG_EFFECT_USER, $0
	anim_wait 32
	anim_ret

.dropsub2:
	anim_bgeffect BATTLE_BG_EFFECT_HIDE_MON, $0, BG_EFFECT_USER, $0
	anim_wait 48
	anim_dropsub
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, BG_EFFECT_USER, $0
	anim_wait 32
	anim_ret

BattleAnim_ThunderFang:
	anim_call BattleAnim_Bite
	anim_clearobjs
	anim_1gfx BATTLE_ANIM_GFX_LIGHTNING
	anim_jump BattleAnim_Thunderpunch_Stub

BattleAnim_SkyAttack:
	anim_1gfx BATTLE_ANIM_GFX_SKY_ATTACK
	anim_bgeffect BATTLE_BG_EFFECT_REMOVE_MON, $0, BG_EFFECT_USER, $0
	anim_wait 32
	anim_sound 0, 0, SFX_HYPER_BEAM
	anim_obj BATTLE_ANIM_OBJ_SKY_ATTACK, 48, 88, $40
	anim_wait 64
	anim_incobj 1
	anim_wait 21
	anim_sound 0, 1, SFX_HYPER_BEAM
	anim_bgeffect BATTLE_BG_EFFECT_ALTERNATE_HUES, $0, $2, $0
	anim_wait 64
	anim_incobj 1
	anim_wait 32
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, BG_EFFECT_USER, $0
	anim_wait 16
	anim_ret

BattleAnim_NightShade:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_bgp $1b
	anim_obp1 $1b
	anim_wait 32
	anim_call BattleAnim_UserObj_2Row
	anim_bgeffect BATTLE_BG_EFFECT_NIGHT_SHADE, $0, BG_EFFECT_TARGET, $8
	anim_sound 0, 1, SFX_PSYCHIC
	anim_wait 96
	anim_incbgeffect BATTLE_BG_EFFECT_NIGHT_SHADE
	anim_jump BattleAnim_ShowMon_1

BattleAnim_Lick:
	anim_1gfx BATTLE_ANIM_GFX_WATER
	anim_sound 0, 1, SFX_LICK
	anim_obj BATTLE_ANIM_OBJ_LICK, 136, 56, $0
	anim_wait 64
	anim_ret

BattleAnim_PhotonBlast:
	anim_2gfx BATTLE_ANIM_GFX_ICE, BATTLE_ANIM_GFX_SPEED
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect BATTLE_BG_EFFECT_ALTERNATE_HUES, $0, $2, $0
	anim_sound 0, 0, SFX_FLASH
	anim_obj BATTLE_ANIM_OBJ_SHINY, 72, 80, $0
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_SHINY, 72, 80, $8
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_SHINY, 72, 80, $10
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_SHINY, 72, 80, $18
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_SHINY, 72, 80, $20
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_SHINY, 72, 80, $28
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_SHINY, 72, 80, $30
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_SHINY, 72, 80, $38
	anim_wait 16
	
.loop
	anim_sound 6, 2, SFX_SHINE
	anim_obj ANIM_OBJ_POWER_GEM2, 64, 92, $4
	anim_wait 4
	anim_loop 20, .loop
	anim_wait 32
	anim_ret

BattleAnim_Psybeam:
	anim_1gfx BATTLE_ANIM_GFX_PSYCHIC
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_BGPALS_INVERTED, $0, $4, $0
.loop
	anim_sound 6, 2, SFX_PSYBEAM
	anim_obj BATTLE_ANIM_OBJ_WAVE, 64, 88, $4
	anim_wait 4
	anim_loop 10, .loop
	anim_wait 48
	anim_ret

BattleAnim_DreamEater:
	anim_1gfx BATTLE_ANIM_GFX_BUBBLE
	anim_bgp $1b
	anim_obp0 $27
	anim_sound 6, 3, SFX_WATER_GUN
	anim_jump BattleAnimSub_Drain

BattleAnim_LeechLife:
	anim_1gfx BATTLE_ANIM_GFX_BUBBLE
	anim_sound 6, 3, SFX_WATER_GUN
	; fallthrough

BattleAnimSub_Drain:
	anim_obj BATTLE_ANIM_OBJ_DRAIN, 132, 44, $0
	anim_obj BATTLE_ANIM_OBJ_DRAIN, 132, 44, $8
	anim_obj BATTLE_ANIM_OBJ_DRAIN, 132, 44, $10
	anim_obj BATTLE_ANIM_OBJ_DRAIN, 132, 44, $18
	anim_obj BATTLE_ANIM_OBJ_DRAIN, 132, 44, $20
	anim_obj BATTLE_ANIM_OBJ_DRAIN, 132, 44, $28
	anim_obj BATTLE_ANIM_OBJ_DRAIN, 132, 44, $30
	anim_obj BATTLE_ANIM_OBJ_DRAIN, 132, 44, $38
	anim_wait 176
	anim_ret

BattleAnim_Harden:
	anim_1gfx BATTLE_ANIM_GFX_REFLECT
	anim_obp0 $0
	anim_call BattleAnim_TargetObj_1Row
	anim_call BattleAnimSub_Metallic
	anim_jump BattleAnim_ShowMon_0

BattleAnim_IceShard:
	anim_1gfx BATTLE_ANIM_GFX_ICE
.loop
	anim_sound 6, 2, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_ICE_BEAM, 64, 92, $4
	anim_wait 4
	anim_loop 5, .loop
	anim_wait 48
	anim_ret

BattleAnim_CalmMind:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_PINK
	anim_3gfx BATTLE_ANIM_GFX_BIG_RINGS, BATTLE_ANIM_GFX_RINGS, BATTLE_ANIM_GFX_GLOW
	anim_bgp $1b
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 0, 0, SFX_ATTRACT
	anim_obj BATTLE_ANIM_OBJ_SMALL_GLOW, 48, 96, $0
	anim_wait 32
	anim_clearobjs
	anim_sound 0, 1, SFX_GAME_FREAK_LOGO_GS
.loop
	anim_obj BATTLE_ANIM_OBJ_SHRINKING_RING_BIG, 48, 96, $0
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_SHRINKING_RING_SMALL, 48, 96, $0
	anim_wait 16
	anim_loop 4, .loop
	anim_wait 16
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_Growth:
	anim_bgeffect BATTLE_BG_EFFECT_WHITE_HUES, $0, $8, $0
	anim_1gfx BATTLE_ANIM_GFX_CHARGE
	anim_sound 0, 0, SFX_SWORDS_DANCE
	anim_obj BATTLE_ANIM_OBJ_GROWTH, 48, 108, $0
	anim_obj BATTLE_ANIM_OBJ_GROWTH, 48, 108, $8
	anim_obj BATTLE_ANIM_OBJ_GROWTH, 48, 108, $10
	anim_obj BATTLE_ANIM_OBJ_GROWTH, 48, 108, $18
	anim_obj BATTLE_ANIM_OBJ_GROWTH, 48, 108, $20
	anim_obj BATTLE_ANIM_OBJ_GROWTH, 48, 108, $28
	anim_obj BATTLE_ANIM_OBJ_GROWTH, 48, 108, $30
	anim_obj BATTLE_ANIM_OBJ_GROWTH, 48, 108, $38
	anim_wait 64
	anim_ret

BattleAnim_Hurricane:
	anim_2gfx BATTLE_ANIM_GFX_HURRICANE, BATTLE_ANIM_GFX_WIND
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $90, $4, $10
	anim_bgeffect BATTLE_BG_EFFECT_ALTERNATE_HUES, $0, $4, $0
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $4, $0
	anim_obj BATTLE_ANIM_OBJ_HURRICANE, 132, 56, $38
	anim_obj BATTLE_ANIM_OBJ_AGILITY, 8, 24, $10
	anim_obj BATTLE_ANIM_OBJ_AGILITY, 8, 48, $2
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_AGILITY, 8, 56, $c
	anim_obj BATTLE_ANIM_OBJ_AGILITY, 8, 80, $4
	anim_obj BATTLE_ANIM_OBJ_AGILITY, 8, 104, $e
.loop
	anim_sound 0, 1, SFX_THUNDER
	anim_wait 4
	anim_loop 18, .loop
	anim_wait 24
	anim_ret

BattleAnim_Smokescreen:
	anim_3gfx BATTLE_ANIM_GFX_HAZE, BATTLE_ANIM_GFX_EGG, BATTLE_ANIM_GFX_SMOKE
	anim_sound 6, 2, SFX_THROW_BALL
	anim_obj BATTLE_ANIM_OBJ_SMOKESCREEN, 64, 92, $6c
	anim_wait 24
	anim_incobj 1
	anim_sound 0, 1, SFX_BALL_POOF
	anim_obj BATTLE_ANIM_OBJ_BALL_POOF, 108, 70, $10
	anim_wait 8
.loop
	anim_sound 0, 1, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_SMOKE, 132, 60, $20
	anim_wait 8
	anim_loop 5, .loop
	anim_wait 128
	anim_ret

BattleAnim_RockThrow:
	anim_2gfx BATTLE_ANIM_GFX_ROCKS, BATTLE_ANIM_GFX_HIT
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_Y, $10, $1, $20
	anim_sound 0, 0, SFX_STRENGTH
	anim_obj BATTLE_ANIM_OBJ_STRENGTH, 64, 104, $1
.hit
	anim_wait 128
	anim_incobj 1
	anim_wait 20
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 132, 40, $0
	anim_wait 16
	anim_ret

BattleAnim_SwordsDance:
	anim_1gfx BATTLE_ANIM_GFX_WHIP
	anim_call BattleAnim_SwordsStub
	anim_wait 56
	anim_ret

BattleAnim_SwordsStub:
	anim_sound 0, 0, SFX_SWORDS_DANCE
	anim_obj BATTLE_ANIM_OBJ_SWORDS_DANCE, 48, 108, $0
	anim_obj BATTLE_ANIM_OBJ_SWORDS_DANCE, 48, 108, $d
	anim_obj BATTLE_ANIM_OBJ_SWORDS_DANCE, 48, 108, $1a
	anim_obj BATTLE_ANIM_OBJ_SWORDS_DANCE, 48, 108, $27
	anim_obj BATTLE_ANIM_OBJ_SWORDS_DANCE, 48, 108, $34
	anim_ret

BattleAnim_QuickAttack:
	anim_2gfx BATTLE_ANIM_GFX_SPEED, BATTLE_ANIM_GFX_HIT
	anim_sound 0, 0, SFX_MENU
	anim_bgeffect BATTLE_BG_EFFECT_HIDE_MON, $0, BG_EFFECT_USER, $0
	anim_call BattleAnimSub_SpeedLines
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 8
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, BG_EFFECT_USER, $0
	anim_wait 16
	anim_ret

BattleAnim_Pounce:
	anim_2gfx BATTLE_ANIM_GFX_SPEED, BATTLE_ANIM_GFX_HIT
	anim_if_param_equal $1, BattleAnim_HiJumpKick
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $1, $0
	anim_bgeffect BATTLE_BG_EFFECT_HIDE_MON, $0, $1, $0
	anim_sound 0, 0, SFX_OUTRAGE
	anim_call BattleAnim_DiveBomb_Branch
	anim_wait 32
	anim_sound 0, 1, SFX_HEADBUTT
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 16
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, $1, $0
	anim_ret

BattleAnim_DiveBomb:
	anim_2gfx BATTLE_ANIM_GFX_SPEED, BATTLE_ANIM_GFX_HIT
	anim_if_param_equal $1, BattleAnim_HiJumpKick
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $1, $0
	anim_bgeffect BATTLE_BG_EFFECT_HIDE_MON, $0, $1, $0
	anim_sound 0, 0, SFX_OUTRAGE
	anim_call BattleAnim_DiveBomb_Branch
	anim_wait 32
	anim_call BattleAnim_OutrageHit
	anim_wait 16
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, $1, $0
	anim_ret

BattleAnim_Facade:
	anim_2gfx BATTLE_ANIM_GFX_HIT, BATTLE_ANIM_GFX_WATER
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_FLAIL, $0, $1, $0
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_MON_LIGHT_DARK_REPEATING, $0, $1, $20
	anim_wait 8
.loop
	anim_sound 0, 0, SFX_RETURN
	anim_obj BATTLE_ANIM_OBJ_WATER_GUN, 56, 80, $0
	anim_wait 14
	anim_incobj 2
	anim_clearobjs
	anim_call BattleAnim_TargetObj_1Row
	anim_obj BATTLE_ANIM_OBJ_WATER_GUN, 56, 80, $0
	anim_wait 14
	anim_incobj 2
	anim_clearobjs
	anim_call BattleAnim_TargetObj_1Row
	anim_obj BATTLE_ANIM_OBJ_WATER_GUN, 56, 80, $0
	anim_wait 14
	anim_incobj 2
	anim_clearobjs
	anim_call BattleAnim_TargetObj_1Row
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj BATTLE_ANIM_OBJ_PUNCH_SHAKE, 136, 48, $0
	anim_wait 24
	anim_incbgeffect BATTLE_BG_EFFECT_FLAIL
	anim_jump BattleAnim_ShowMon_0

BattleAnim_DefenseCurl:
	anim_1gfx BATTLE_ANIM_GFX_SHAPES
	anim_obp0 $e4
	anim_call BattleAnim_TargetObj_1Row
	anim_sound 0, 0, SFX_SHARPEN
	anim_bgeffect BATTLE_BG_EFFECT_FADE_MON_TO_LIGHT_REPEATING, $0, BG_EFFECT_USER, $40
	anim_obj BATTLE_ANIM_OBJ_DEFENSE_CURL, 48, 88, $0
	anim_wait 96
	anim_incobj 2
	anim_incbgeffect BATTLE_BG_EFFECT_FADE_MON_TO_LIGHT_REPEATING
	anim_jump BattleAnim_ShowMon_0

BattleAnim_SeismicToss:
	anim_2gfx BATTLE_ANIM_GFX_GLOBE, BATTLE_ANIM_GFX_HIT
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_Y, $10, $1, $20
	anim_sound 0, 0, SFX_STRENGTH
	anim_obj BATTLE_ANIM_OBJ_SEISMIC_TOSS, 64, 104, $1
	anim_jump BattleAnim_RockThrow.hit

BattleAnim_ZenHeadbutt:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_YELLOW
	anim_2gfx BATTLE_ANIM_GFX_SHINE, BATTLE_ANIM_GFX_HIT
	anim_battlergfx_1row
	anim_bgeffect BATTLE_BG_EFFECT_FADE_MON_TO_LIGHT_REPEATING, $0, $1, $40
	anim_sound 0, 1, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_FORESIGHT, 44, 104, $0
	anim_wait 4
	anim_sound 0, 1, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_FORESIGHT, 44, 96, $0
	anim_wait 4
	anim_sound 0, 1, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_FORESIGHT, 44, 88, $0
	anim_wait 4
	anim_sound 0, 1, SFX_FORESIGHT
	anim_obj BATTLE_ANIM_OBJ_GLIMMER, 44, 80, $0
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $0, $0
	anim_wait 64
	anim_incbgeffect BATTLE_BG_EFFECT_FADE_MON_TO_LIGHT_REPEATING
	anim_bgeffect BATTLE_BG_EFFECT_BATTLEROBJ_2ROW, $0, $0, $0
	anim_bgeffect BATTLE_BG_EFFECT_TACKLE, $0, $1, $0
	anim_wait 4
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $4, $2
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 136, 48, $0
	anim_wait 8
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_jump BattleAnim_ShowMon_0

BattleAnim_Headbutt:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $14, $2, $0
	anim_wait 32
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_TACKLE, $0, BG_EFFECT_USER, $0
	anim_wait 4
	anim_sound 0, 1, SFX_HEADBUTT
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 8
	anim_jump BattleAnim_ShowMon_0

BattleAnim_Agility:
	anim_1gfx BATTLE_ANIM_GFX_WIND
	anim_obp0 $fc
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_FADE_MON_TO_LIGHT_REPEATING, $0, BG_EFFECT_USER, $40
	anim_call BattleAnimSub_Agility
.loop
	anim_sound 0, 0, SFX_RAZOR_WIND
	anim_wait 4
	anim_loop 18, .loop
	anim_incbgeffect BATTLE_BG_EFFECT_FADE_MON_TO_LIGHT_REPEATING
	anim_jump BattleAnim_ShowMon_0

BattleAnim_Barrier:
	anim_1gfx BATTLE_ANIM_GFX_REFLECT
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_wait 8
	anim_sound 0, 0, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_SCREEN, 72, 80, $0
	anim_wait 32
	anim_sound 0, 0, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_SCREEN, 72, 80, $0
	anim_wait 32
	anim_ret

BattleAnim_Waterfall:
	anim_2gfx BATTLE_ANIM_GFX_HIT, BATTLE_ANIM_GFX_WATER
	anim_call BattleAnim_TargetObj_2Row
	anim_bgeffect BATTLE_BG_EFFECT_BODY_SLAM, $0, BG_EFFECT_USER, $0
	anim_wait 16
	anim_call BattleAnim_ShowMon_0
	anim_sound 0, 0, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 9, 4, 13, 0, $0
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 10, 4, 12, 2, $0
	anim_wait 1
	anim_sound 0, 0, SFX_MENU
	anim_wait 1
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 11, 4, 11, 4, $0
	anim_wait 2
	anim_sound 0, 0, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 12, 4, 10, 6, $0
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 13, 4, 10, 0, $0
	anim_wait 1
	anim_sound 0, 0, SFX_MENU
	anim_wait 1
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 14, 4, 9, 2, $0
	anim_wait 2
	anim_sound 0, 0, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 15, 4, 8, 4, $0
	anim_wait 3
	anim_sound 0, 1, SFX_LICK
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 3
	anim_sound 0, 1, SFX_LICK
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 48, $0
	anim_wait 3
	anim_sound 0, 1, SFX_LICK
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 40, $0
	anim_wait 3
	anim_sound 0, 1, SFX_LICK
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 32, $0
	anim_wait 3
	anim_sound 0, 1, SFX_LICK
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 24, $0
	anim_wait 3
	anim_ret

BattleAnim_AquaJet:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_WATER
	anim_3gfx BATTLE_ANIM_GFX_SPEED, BATTLE_ANIM_GFX_HIT, BATTLE_ANIM_GFX_WATER
	anim_sound 0, 0, SFX_MENU
	anim_bgeffect BATTLE_BG_EFFECT_HIDE_MON, $0, $1, $0
	anim_call BattleAnimSub_SpeedLines
	anim_wait 4
	anim_sound 0, 0, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 9, 4, 13, 0, $0
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 10, 4, 12, 2, $0
	anim_wait 1
	anim_sound 0, 0, SFX_MENU
	anim_wait 1
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 11, 4, 11, 4, $0
	anim_wait 2
	anim_sound 0, 0, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 12, 4, 10, 6, $0
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 13, 4, 10, 0, $0
	anim_wait 1
	anim_sound 0, 0, SFX_MENU
	anim_wait 1
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 14, 4, 9, 2, $0
	anim_wait 2
	anim_sound 0, 0, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 15, 4, 8, 4, $0
	anim_wait 3
	anim_sound 0, 0, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 17, 0, 7, 0, $0
	anim_wait 8
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, $1, $0
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_BLUE
	anim_ret

BattleAnim_PsychicM:
	anim_1gfx BATTLE_ANIM_GFX_PSYCHIC
	anim_bgeffect BATTLE_BG_EFFECT_ALTERNATE_HUES, $0, $2, $0
	anim_bgeffect BATTLE_BG_EFFECT_PSYCHIC, $0, $0, $0
.loop
	anim_sound 6, 2, SFX_PSYCHIC
	anim_obj BATTLE_ANIM_OBJ_WAVE, 64, 88, $2
	anim_wait 8
	anim_loop 8, .loop
	anim_wait 96
	anim_incbgeffect BATTLE_BG_EFFECT_PSYCHIC
	anim_wait 4
	anim_ret

BattleAnim_Sludge:
	anim_1gfx BATTLE_ANIM_GFX_POISON
	anim_jump BattleAnimSub_Sludge

BattleAnim_Toxic:
	anim_1gfx BATTLE_ANIM_GFX_POISON
	anim_bgeffect BATTLE_BG_EFFECT_BLACK_HUES, $0, $8, $0
	anim_call BattleAnimSub_Acid
	anim_wait 32
	anim_jump BattleAnimSub_Sludge

BattleAnim_Taunt:
	anim_2gfx BATTLE_ANIM_GFX_TAUNT1, BATTLE_ANIM_GFX_TAUNT2
.loop
	anim_obj BATTLE_ANIM_OBJ_TAUNT1, 72, 84, $0
	anim_wait 16
	anim_sound 0, 0, SFX_SQUEAK
	anim_wait 3
	anim_clearobjs
	anim_obj BATTLE_ANIM_OBJ_TAUNT2, 72, 84, $0
	anim_wait 16
	anim_clearobjs
	anim_loop 2, .loop
	anim_1gfx BATTLE_ANIM_GFX_MISC
	anim_sound 0, 1, SFX_KINESIS_2
	anim_obj BATTLE_ANIM_OBJ_ANGER, 112, 50, $0
	anim_wait 16
	anim_sound 0, 1, SFX_KINESIS_2
	anim_obj BATTLE_ANIM_OBJ_ANGER, 148, 32, $0
	anim_wait 32
	anim_ret

BattleAnim_Metronome:
	anim_2gfx BATTLE_ANIM_GFX_MISC, BATTLE_ANIM_GFX_SPEED
	anim_sound 0, 0, SFX_METRONOME
	anim_obj BATTLE_ANIM_OBJ_METRONOME_HAND, 72, 88, $0
.loop
	anim_obj BATTLE_ANIM_OBJ_METRONOME_SPARKLE, 72, 80, $0
	anim_wait 8
	anim_loop 5, .loop
	anim_wait 48
	anim_ret

BattleAnim_Counter:
	anim_1gfx BATTLE_ANIM_GFX_HIT
.loop
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $6, $2
	anim_sound 0, 1, SFX_POUND
	anim_obj BATTLE_ANIM_OBJ_PALM, 120, 72, $0
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 120, 72, $0
	anim_wait 6
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $6, $2
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj BATTLE_ANIM_OBJ_PUNCH, 136, 40, $0
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 136, 40, $0
	anim_wait 6
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $6, $2
	anim_sound 0, 1, SFX_MEGA_KICK
	anim_obj BATTLE_ANIM_OBJ_KICK, 152, 56, $0
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 152, 56, $0
	anim_wait 6
	anim_loop 3, .loop
	anim_wait 16
	anim_ret

BattleAnim_LowKick:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $4, $2
	anim_sound 0, 1, SFX_DOUBLE_KICK
	anim_obj BATTLE_ANIM_OBJ_KICK, 124, 64, $0
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 124, 64, $0
	anim_wait 6
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $4, $2
	anim_sound 0, 1, SFX_DOUBLE_KICK
	anim_obj BATTLE_ANIM_OBJ_KICK, 132, 64, $0
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 132, 64, $0
	anim_wait 6
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $4, $2
	anim_sound 0, 1, SFX_DOUBLE_KICK
	anim_obj BATTLE_ANIM_OBJ_KICK, 140, 64, $0
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 140, 64, $0
	anim_wait 16
	anim_ret

BattleAnim_WingAttack:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_METALLIC
	anim_1gfx BATTLE_ANIM_GFX_HIT
.hit
	anim_sound 0, 1, SFX_WING_ATTACK
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 148, 56, $0
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 116, 56, $0
	anim_wait 6
	anim_sound 0, 1, SFX_WING_ATTACK
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 144, 56, $0
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 120, 56, $0
	anim_wait 6
	anim_sound 0, 1, SFX_WING_ATTACK
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 140, 56, $0
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 124, 56, $0
	anim_wait 16
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_Disable:
	anim_2gfx BATTLE_ANIM_GFX_LIGHTNING, BATTLE_ANIM_GFX_STATUS
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_obj BATTLE_ANIM_OBJ_DISABLE, 132, 56, $0
	anim_wait 16
	anim_sound 0, 1, SFX_BIND
	anim_obj BATTLE_ANIM_OBJ_PARALYZED, 104, 56, $42
	anim_obj BATTLE_ANIM_OBJ_PARALYZED, 160, 56, $c2
	anim_wait 96
	anim_ret

BattleAnim_Struggle:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_sound 0, 1, SFX_POUND
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 16
	anim_ret

BattleAnim_Sketch:
	anim_1gfx BATTLE_ANIM_GFX_OBJECTS
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_MON_LIGHT_DARK_REPEATING, $0, BG_EFFECT_USER, $20
	anim_sound 0, 0, SFX_SKETCH
	anim_obj BATTLE_ANIM_OBJ_SKETCH, 72, 80, $0
	anim_wait 80
	anim_incbgeffect BATTLE_BG_EFFECT_CYCLE_MON_LIGHT_DARK_REPEATING
	anim_jump BattleAnim_ShowMon_0

BattleAnim_AerialAce:
	anim_2gfx BATTLE_ANIM_GFX_SPEED, BATTLE_ANIM_GFX_CUT
	anim_sound 0, 0, SFX_MENU
	anim_bgeffect BATTLE_BG_EFFECT_HIDE_MON, $0, $1, $0
	anim_call BattleAnimSub_SpeedLines
	anim_wait 12
	anim_sound 0, 1, SFX_WING_ATTACK
	anim_obj BATTLE_ANIM_OBJ_CUT_LONG_DOWN_LEFT, 160, 40, $0
	anim_wait 24
	anim_sound 0, 1, SFX_CUT
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $8, $2
	anim_obj BATTLE_ANIM_OBJ_CUT_UP_RIGHT, 120, 68, $0
	anim_wait 8
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, $1, $0
	anim_wait 24
	anim_ret

BattleAnim_KnockOff:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_sound 3, 0, SFX_RAZOR_WIND
	anim_obj BATTLE_ANIM_OBJ_PALM, 136, 08, $0
	anim_wait 1
	anim_obj BATTLE_ANIM_OBJ_PALM, 136, 16, $0
	anim_wait 1
	anim_obj BATTLE_ANIM_OBJ_PALM, 136, 24, $0
	anim_wait 1
	anim_obj BATTLE_ANIM_OBJ_PALM, 136, 32, $0
	anim_wait 1
	anim_obj BATTLE_ANIM_OBJ_PALM, 136, 40, $0
	anim_wait 1
	anim_obj BATTLE_ANIM_OBJ_PALM, 136, 48, $0
	anim_wait 1
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_Y  , $10, $1, $20
	anim_sound 0, 1, SFX_TACKLE
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 136, 48, $0
	anim_obj BATTLE_ANIM_OBJ_PALM, 136, 56, $0
	anim_wait 1
	anim_obj BATTLE_ANIM_OBJ_PALM, 136, 64, $0
	anim_wait 1
	anim_obj BATTLE_ANIM_OBJ_PALM, 136, 72, $0
	anim_wait 8
	anim_ret

BattleAnim_StickyWeb:
BattleAnim_SpiderWeb:
	anim_1gfx BATTLE_ANIM_GFX_WEB
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_obj BATTLE_ANIM_OBJ_SPIDER_WEB, 132, 48, $0
	anim_sound 6, 2, SFX_SPIDER_WEB
	anim_obj BATTLE_ANIM_OBJ_STRING_SHOT, 64, 80, $0
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_STRING_SHOT, 64, 88, $0
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_STRING_SHOT, 64, 84, $0
	anim_wait 64
	anim_ret

BattleAnim_DragonDance:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_WATER
	anim_2gfx BATTLE_ANIM_GFX_FIRE, BATTLE_ANIM_GFX_SPEED
	anim_call BattleAnim_TargetObj_2Row
	anim_bgeffect BATTLE_BG_EFFECT_WOBBLE_MON, $0, BG_EFFECT_USER, $0
.loop
	anim_sound 0, 0, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_FLAME_WHEEL,   6, 0,  12, 0, $0
	anim_wait 6
	anim_sound 0, 0, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_SACRED_FIRE,   6, 0,  13, 0, $0
	anim_wait 6
	anim_loop 4, .loop
	anim_wait 96
	anim_incbgeffect BATTLE_BG_EFFECT_WOBBLE_MON
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_RED
	anim_jump BattleAnim_ShowMon_0

BattleAnim_QuiverDance:
	anim_2gfx BATTLE_ANIM_GFX_CHARGE, BATTLE_ANIM_GFX_SHINE
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_WOBBLE_MON, $0, $1, $0
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
.loop
	anim_sound 0, 0, SFX_FORESIGHT
	anim_obj ANIM_OBJ_QUIVER_DANCE, 48, 104, $0
	anim_wait 12
	anim_loop 8, .loop
	anim_wait 16
	anim_incbgeffect BATTLE_BG_EFFECT_WOBBLE_MON
	anim_bgeffect BATTLE_BG_EFFECT_FADE_MON_TO_LIGHT_REPEATING, $0, $1, $40
	anim_sound 0, 1, SFX_FLASH
	anim_obj BATTLE_ANIM_OBJ_GLIMMER, 44, 64, $0
	anim_wait 5
	anim_obj BATTLE_ANIM_OBJ_GLIMMER, 24, 96, $0
	anim_wait 5
	anim_obj BATTLE_ANIM_OBJ_GLIMMER, 56, 104, $0
	anim_wait 32
	anim_incbgeffect BATTLE_BG_EFFECT_FADE_MON_TO_LIGHT_REPEATING
	anim_jump BattleAnim_ShowMon_0

; previous quiver dance animation
; i think it was actually originally for dragon rage
;BattleAnim_QuiverDance:
;	anim_2gfx BATTLE_ANIM_GFX_CHARGE, BATTLE_ANIM_GFX_SPEED
;	anim_bgeffect BATTLE_BG_EFFECT_WHITE_HUES, $0, $8, $0
;	anim_sound 0, 0, SFX_OUTRAGE
;.loop
;	anim_obj BATTLE_ANIM_OBJ_GROWTH, 48, 108, $0
;	anim_obj BATTLE_ANIM_OBJ_GROWTH, 48, 108, $20
;	anim_wait 4
;	anim_loop 4, .loop
;	anim_wait 24
;	anim_ret

BattleAnim_Trick:
	anim_1gfx BATTLE_ANIM_GFX_STATUS
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, $0, $0
	anim_sound 0, 1, SFX_GET_COIN_FROM_SLOTS
	anim_obj ANIM_OBJ_TRICK, 90, 68, $18
	anim_obj ANIM_OBJ_TRICK, 90, 68, $38
	anim_wait 16
.loop
	anim_sound 0, 1, SFX_STOP_SLOT
	anim_wait 32
	anim_loop 4, .loop
	anim_wait 7
	anim_sound 0, 1, SFX_SLOT_MACHINE_START
	anim_incobj 1
	anim_incobj 2
	anim_wait 6
	anim_clearobjs
	anim_wait 6
	anim_ret

BattleAnim_FlameCharge:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_1gfx BATTLE_ANIM_GFX_FIRE
.loop
	anim_sound 0, 0, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_FLAME_WHEEL, 48, 96, $0
	anim_wait 6
	anim_loop 8, .loop
	anim_wait 96
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_TACKLE, $0, BG_EFFECT_USER, $0
	anim_wait 4
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $4, $3
.hit
	anim_sound 0, 1, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_FIRE_BLAST, 136, 48, $1
	anim_obj BATTLE_ANIM_OBJ_FIRE_BLAST, 136, 48, $4
	anim_obj BATTLE_ANIM_OBJ_FIRE_BLAST, 136, 48, $5
	anim_wait 8
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, BG_EFFECT_TARGET, $0
	anim_wait 4
	anim_incobj 9
	anim_wait 8
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_Snore:
	anim_2gfx BATTLE_ANIM_GFX_STATUS, BATTLE_ANIM_GFX_NOISE
	anim_obj BATTLE_ANIM_OBJ_ASLEEP, 64, 80, $0
	anim_wait 32
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $60, $2, $0
	anim_sound 0, 0, SFX_SNORE
	anim_jump BattleAnim_SnoreAssist

BattleAnim_Snarl:
	anim_1gfx BATTLE_ANIM_GFX_NOISE
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $60, $2, $0
	anim_sound 0, 0, SFX_SNORE
	; fallthrough

BattleAnim_SnoreAssist:
	.loop
	anim_call BattleAnimSub_Sound
	anim_wait 16
	anim_loop 2, .loop
	anim_wait 8
	anim_ret

BattleAnim_Curse:
	anim_if_param_equal $1, .NotGhost
	anim_2gfx BATTLE_ANIM_GFX_HIT, BATTLE_ANIM_GFX_OBJECTS
	anim_obj BATTLE_ANIM_OBJ_CURSE, 68, 72, $0
	anim_sound 0, 0, SFX_CURSE
	anim_wait 32
	anim_incobj 1
	anim_wait 12
	anim_sound 0, 0, SFX_POISON_STING
	anim_obj BATTLE_ANIM_OBJ_HIT, 44, 96, $0
	anim_wait 16
	anim_ret

.NotGhost:
	anim_1gfx BATTLE_ANIM_GFX_SPEED
	anim_bgeffect BATTLE_BG_EFFECT_FADE_MON_TO_BLACK_REPEATING, $0, BG_EFFECT_USER, $40
	anim_sound 0, 0, SFX_SHARPEN
	anim_wait 64
	anim_incbgeffect BATTLE_BG_EFFECT_FADE_MON_TO_BLACK_REPEATING
	anim_wait 1
	anim_bgeffect BATTLE_BG_EFFECT_FADE_MON_TO_LIGHT, $0, BG_EFFECT_USER, $40
	anim_ret

BattleAnim_Flail:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_WOBBLE_MON, $0, BG_EFFECT_USER, $0
	anim_wait 8
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 120, 48, $0
	anim_wait 8
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 152, 48, $0
	anim_wait 8
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 48, $0
	anim_wait 8
	anim_incbgeffect BATTLE_BG_EFFECT_WOBBLE_MON
	anim_wait 1
	anim_jump BattleAnim_ShowMon_0

BattleAnim_Hex:
	anim_2gfx BATTLE_ANIM_GFX_FIRE, BATTLE_ANIM_GFX_SPEED
	anim_bgp $f8
	anim_wait 8
	anim_sound 6, 2, SFX_SLUDGE_BOMB
	anim_wait 40
	anim_bgp $1b
	anim_sound 0, 0, SFX_CURSE
.loop
	anim_obj ANIM_OBJ_HEX, 136, 72, $6
	anim_wait 2
	anim_obj ANIM_OBJ_HEX, 128, 72, $6
	anim_wait 2
	anim_obj ANIM_OBJ_BLUE_FLAME, 128, 54, $10
	anim_obj ANIM_OBJ_HEX, 144, 72, $8
	anim_wait 2
	anim_obj ANIM_OBJ_HEX, 120, 72, $8
	anim_wait 2
	anim_obj ANIM_OBJ_HEX, 152, 72, $6
	anim_wait 2
	anim_obj ANIM_OBJ_BLUE_FLAME, 144, 38, $90
	anim_obj ANIM_OBJ_HEX, 112, 72, $8
	anim_wait 2
	anim_obj ANIM_OBJ_HEX, 160, 72, $8
	anim_wait 2
	anim_loop 3, .loop
	anim_wait 24
	anim_ret

BattleAnim_Aeroblast:
	anim_2gfx BATTLE_ANIM_GFX_BEAM, BATTLE_ANIM_GFX_AEROBLAST
	anim_bgp $1b
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $50, $4, $10
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 0, 0, SFX_AEROBLAST
	anim_obj BATTLE_ANIM_OBJ_AEROBLAST, 72, 88, $0
	anim_wait 32
	anim_sound 0, 0, SFX_HYPER_BEAM
	anim_obj BATTLE_ANIM_OBJ_BEAM, 80, 84, $0
	anim_wait 2
	anim_sound 0, 1, SFX_HYPER_BEAM
	anim_obj BATTLE_ANIM_OBJ_BEAM, 96, 76, $0
	anim_wait 2
	anim_sound 0, 1, SFX_HYPER_BEAM
	anim_obj BATTLE_ANIM_OBJ_BEAM, 112, 68, $0
	anim_obj BATTLE_ANIM_OBJ_BEAM_TIP, 126, 62, $0
	anim_wait 48
	anim_ret

BattleAnim_Venoshock:
	anim_1gfx BATTLE_ANIM_GFX_POISON
	anim_call BattleAnim_UserObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_BLACK_HUES, $0, $8, $0
	anim_sound 6, 2, SFX_SLUDGE_BOMB
	anim_obj BATTLE_ANIM_OBJ_ACID, 64, 92, $10
	anim_wait 36
	anim_sound 0, 1, SFX_THUNDER
	anim_wait 8
	anim_bgp $1b
	anim_obp0 $30
	anim_bgeffect BATTLE_BG_EFFECT_VIBRATE_MON, $0, $0, $0
	anim_call BattleAnimSub_Sludge
	anim_jump BattleAnim_ShowMon_1

BattleAnim_Spite:
	anim_1gfx BATTLE_ANIM_GFX_ANGELS
	anim_obj BATTLE_ANIM_OBJ_SPITE, 132, 16, $0
	anim_sound 0, 1, SFX_SPITE
	anim_wait 96
	anim_ret

BattleAnim_PowderSnow:
	anim_1gfx BATTLE_ANIM_GFX_POWDER
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect BATTLE_BG_EFFECT_WHITE_HUES, $0, $8, $0
	anim_obj BATTLE_ANIM_OBJ_HAIL, 11, 0,  0, 0, $0
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_HAIL,  9, 0,  0, 0, $1
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_HAIL,  7, 0,  0, 0, $2
.loop
	anim_sound 0, 1, SFX_SHINE
	anim_wait 4
	anim_sound 0, 0, SFX_SHINE
	anim_wait 4
	anim_loop 7, .loop
	anim_wait 8
	anim_ret

BattleAnim_Protect:
	anim_1gfx BATTLE_ANIM_GFX_OBJECTS
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_obj BATTLE_ANIM_OBJ_PROTECT, 80, 80, $0
	anim_obj BATTLE_ANIM_OBJ_PROTECT, 80, 80, $d
	anim_obj BATTLE_ANIM_OBJ_PROTECT, 80, 80, $1a
	anim_obj BATTLE_ANIM_OBJ_PROTECT, 80, 80, $27
	anim_obj BATTLE_ANIM_OBJ_PROTECT, 80, 80, $34
	anim_sound 0, 0, SFX_PROTECT
	anim_wait 96
	anim_ret

BattleAnim_ScaryFace:
	anim_1gfx BATTLE_ANIM_GFX_BEAM
	anim_bgeffect BATTLE_BG_EFFECT_ALTERNATE_HUES, $0, $2, $0
	anim_call BattleAnimSub_EyeBeams
	anim_wait 48
	anim_ret

BattleAnim_HyperVoice:
	anim_2gfx BATTLE_ANIM_GFX_NOISE, BATTLE_ANIM_GFX_PSYCHIC
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $14, $2, $0
	anim_sound 0, 0, SFX_SNORE
	anim_call BattleAnimSub_Sound
	anim_obj BATTLE_ANIM_OBJ_WAVE,  7, 0, 11, 0, $2
	anim_obj BATTLE_ANIM_OBJ_WAVE,  7, 0, 13, 0, $2
	anim_obj BATTLE_ANIM_OBJ_WAVE,  9, 0, 11, 0, $2
	anim_obj BATTLE_ANIM_OBJ_WAVE,  9, 0, 13, 0, $2
	anim_cry $0
	anim_wait 48
	anim_ret

BattleAnim_SuckerPunch:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_PURPLE
	anim_2gfx BATTLE_ANIM_GFX_SPEED, BATTLE_ANIM_GFX_HIT
	anim_sound 0, 0, SFX_LICK
	anim_bgeffect BATTLE_BG_EFFECT_REMOVE_MON, $0, $1, $0
	anim_wait 48
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj BATTLE_ANIM_OBJ_HIT, 104, 34, $0
	anim_wait 2
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj BATTLE_ANIM_OBJ_HIT, 124, 34, $0
	anim_wait 2
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj BATTLE_ANIM_OBJ_HIT, 144, 34, $0
	anim_wait 16
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj BATTLE_ANIM_OBJ_HIT, 156, 52, $0
	anim_wait 2
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj BATTLE_ANIM_OBJ_HIT, 138, 52, $0
	anim_wait 2
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $4, $2
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 122, 52, $0
	anim_wait 12
	anim_call BattleAnimSub_SpeedLines
	anim_wait 8
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, $1, $0
	anim_wait 4
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_FeintAttack:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_sound 0, 0, SFX_CURSE
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_FADE_MON_TO_WHITE_WAIT_FADE_BACK, $0, BG_EFFECT_USER, $80
	anim_wait 36
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj BATTLE_ANIM_OBJ_HIT, 120, 32, $0
	anim_wait 8
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj BATTLE_ANIM_OBJ_HIT, 152, 40, $0
	anim_wait 8
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj BATTLE_ANIM_OBJ_HIT, 136, 48, $0
	anim_wait 32
	anim_incbgeffect BATTLE_BG_EFFECT_FADE_MON_TO_WHITE_WAIT_FADE_BACK
	anim_call BattleAnim_ShowMon_0
	anim_wait 4
	anim_ret

BattleAnim_BellyDrum:
	anim_2gfx BATTLE_ANIM_GFX_HIT, BATTLE_ANIM_GFX_NOISE
	anim_sound 0, 0, SFX_BELLY_DRUM
	anim_obj BATTLE_ANIM_OBJ_BELLY_DRUM_HAND, 64, 104, $0
	anim_obj BATTLE_ANIM_OBJ_BELLY_DRUM_NOTE, 64, 92, $f8
	anim_wait 24
	anim_sound 0, 0, SFX_BELLY_DRUM
	anim_obj BATTLE_ANIM_OBJ_BELLY_DRUM_HAND, 64, 104, $0
	anim_obj BATTLE_ANIM_OBJ_BELLY_DRUM_NOTE, 64, 92, $f8
	anim_wait 24
	anim_sound 0, 0, SFX_BELLY_DRUM
	anim_obj BATTLE_ANIM_OBJ_BELLY_DRUM_HAND, 64, 104, $0
	anim_obj BATTLE_ANIM_OBJ_BELLY_DRUM_NOTE, 64, 92, $f8
	anim_wait 12
	anim_sound 0, 0, SFX_BELLY_DRUM
	anim_obj BATTLE_ANIM_OBJ_BELLY_DRUM_HAND, 64, 104, $0
	anim_obj BATTLE_ANIM_OBJ_BELLY_DRUM_NOTE, 64, 92, $f8
	anim_wait 12
	anim_sound 0, 0, SFX_BELLY_DRUM
	anim_obj BATTLE_ANIM_OBJ_BELLY_DRUM_HAND, 64, 104, $0
	anim_obj BATTLE_ANIM_OBJ_BELLY_DRUM_NOTE, 64, 92, $f8
	anim_wait 24
	anim_sound 0, 0, SFX_BELLY_DRUM
	anim_obj BATTLE_ANIM_OBJ_BELLY_DRUM_HAND, 64, 104, $0
	anim_obj BATTLE_ANIM_OBJ_BELLY_DRUM_NOTE, 64, 92, $f8
	anim_wait 12
	anim_sound 0, 0, SFX_BELLY_DRUM
	anim_obj BATTLE_ANIM_OBJ_BELLY_DRUM_HAND, 64, 104, $0
	anim_obj BATTLE_ANIM_OBJ_BELLY_DRUM_NOTE, 64, 92, $f8
	anim_wait 12
	anim_sound 0, 0, SFX_BELLY_DRUM
	anim_obj BATTLE_ANIM_OBJ_BELLY_DRUM_HAND, 64, 104, $0
	anim_obj BATTLE_ANIM_OBJ_BELLY_DRUM_NOTE, 64, 92, $f8
	anim_wait 12
	anim_sound 0, 0, SFX_BELLY_DRUM
	anim_obj BATTLE_ANIM_OBJ_BELLY_DRUM_HAND, 64, 104, $0
	anim_obj BATTLE_ANIM_OBJ_BELLY_DRUM_NOTE, 64, 92, $f8
	anim_wait 16
	anim_ret

BattleAnim_SludgeBomb:
	anim_2gfx BATTLE_ANIM_GFX_EGG, BATTLE_ANIM_GFX_POISON
	anim_bgeffect BATTLE_BG_EFFECT_BLACK_HUES, $0, $8, $0
	anim_sound 6, 2, SFX_SLUDGE_BOMB
	anim_obj BATTLE_ANIM_OBJ_SLUDGE_BOMB, 64, 92, $10
	anim_wait 36
	anim_jump BattleAnimSub_Sludge

BattleAnim_MudSlap:
	anim_1gfx BATTLE_ANIM_GFX_SAND
	anim_obp0 $fc
	anim_call BattleAnimSub_SandOrMud
	anim_wait 32
	anim_ret

BattleAnim_Spikes:
	anim_1gfx BATTLE_ANIM_GFX_MISC
	anim_sound 6, 2, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_SPIKES, 48, 88, $20
	anim_wait 8
	anim_sound 6, 2, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_SPIKES, 48, 88, $30
	anim_wait 8
	anim_sound 6, 2, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_SPIKES, 48, 88, $28
	anim_wait 32
	anim_ret

BattleAnim_ToxicSpikes:
	anim_call BattleAnim_Spikes
	anim_1gfx BATTLE_ANIM_GFX_POISON
	anim_jump BattleAnimSub_Sludge

BattleAnim_Foresight:
	anim_1gfx BATTLE_ANIM_GFX_SHINE
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $0, $0
	anim_sound 0, 1, SFX_FORESIGHT
	anim_obj BATTLE_ANIM_OBJ_FORESIGHT, 132, 40, $0
	anim_wait 24
	anim_bgeffect BATTLE_BG_EFFECT_FADE_MON_TO_BLACK_REPEATING, $0, BG_EFFECT_TARGET, $40
	anim_wait 64
	anim_incbgeffect BATTLE_BG_EFFECT_FADE_MON_TO_BLACK_REPEATING
	anim_wait 8
	anim_ret

BattleAnim_DestinyBond:
	anim_1gfx BATTLE_ANIM_GFX_ANGELS
	anim_bgp $1b
	anim_obp0 $0
	anim_if_param_equal $1, .fainted
	anim_sound 6, 2, SFX_WHIRLWIND
	anim_obj BATTLE_ANIM_OBJ_DESTINY_BOND, 44, 120, $2
	anim_wait 128
	anim_ret

.fainted:
	anim_obj BATTLE_ANIM_OBJ_DESTINY_BOND, 132, 76, $0
	anim_sound 0, 1, SFX_KINESIS
	anim_bgeffect BATTLE_BG_EFFECT_RETURN_MON, $0, BG_EFFECT_TARGET, $0
	anim_wait 32
	anim_ret

BattleAnim_PerishSong:
	anim_1gfx BATTLE_ANIM_GFX_NOISE
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect BATTLE_BG_EFFECT_ALTERNATE_HUES, $0, $2, $0
	anim_sound 0, 2, SFX_PERISH_SONG
	anim_obj BATTLE_ANIM_OBJ_PERISH_SONG, 88, 0, $0
	anim_obj BATTLE_ANIM_OBJ_PERISH_SONG, 88, 0, $8
	anim_obj BATTLE_ANIM_OBJ_PERISH_SONG, 88, 0, $10
	anim_obj BATTLE_ANIM_OBJ_PERISH_SONG, 88, 0, $18
	anim_obj BATTLE_ANIM_OBJ_PERISH_SONG, 88, 0, $20
	anim_obj BATTLE_ANIM_OBJ_PERISH_SONG, 88, 0, $28
	anim_obj BATTLE_ANIM_OBJ_PERISH_SONG, 88, 0, $30
	anim_obj BATTLE_ANIM_OBJ_PERISH_SONG, 88, 0, $38
	anim_wait 128
	anim_ret

BattleAnim_SandTomb:
	anim_2gfx BATTLE_ANIM_GFX_SAND, BATTLE_ANIM_GFX_WIND
	anim_call BattleAnimSub_SandOrMud
.loop
	anim_sound 0, 1, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_GUST, 132, 72, $0
	anim_wait 6
	anim_loop 9, .loop
	anim_wait 24
	anim_ret

BattleAnim_SilverWind:
	anim_1gfx BATTLE_ANIM_GFX_SPEED
	anim_sound 0, 1, SFX_GAME_FREAK_LOGO_GS
	anim_bgeffect BATTLE_BG_EFFECT_WHIRLPOOL, $0, $0, $0
.loop	
	anim_obj BATTLE_ANIM_OBJ_SHOOTING_SPARKLE, 64, 88, $4
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_SHOOTING_SPARKLE, 64, 80, $4
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_SHOOTING_SPARKLE, 64, 96, $4
	anim_wait 8
	anim_loop 4, .loop
	anim_wait 4
	anim_2gfx BATTLE_ANIM_GFX_WIND, BATTLE_ANIM_GFX_HIT
	anim_call BattleAnim_Gust.loop
	anim_incbgeffect BATTLE_BG_EFFECT_WHIRLPOOL
	anim_wait 16
	anim_ret

BattleAnim_FreezeDry:
	anim_obp0 $54
	anim_2gfx BATTLE_ANIM_GFX_HAZE, BATTLE_ANIM_GFX_ICE
	anim_sound 0, 0, SFX_SURF
.loop
	anim_obj BATTLE_ANIM_OBJ_MIST, 132, 16, $0
	anim_wait 8
	anim_loop 4, .loop
	anim_bgeffect BATTLE_BG_EFFECT_WHITE_HUES, $0, $8, $0
	anim_wait 32
	anim_obj BATTLE_ANIM_OBJ_ICE_BUILDUP, 136, 74, $10
	anim_wait 128
	anim_sound 0, 1, SFX_SHINE
	anim_wait 8
	anim_sound 0, 1, SFX_SHINE
	anim_wait 24
	anim_ret

BattleAnim_IcyWind:
	anim_1gfx BATTLE_ANIM_GFX_ICE
.loop
	anim_sound 6, 2, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_POWDER_SNOW, 64, 88, $23
	anim_wait 2
	anim_sound 6, 2, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_POWDER_SNOW, 64, 80, $24
	anim_wait 2
	anim_sound 6, 2, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_POWDER_SNOW, 64, 96, $23
	anim_wait 2
	anim_loop 2, .loop
	anim_bgeffect BATTLE_BG_EFFECT_WHITE_HUES, $0, $8, $0
	anim_wait 40
	anim_jump BattleAnimSub_Ice

BattleAnim_Outrage:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_MON_LIGHT_DARK_REPEATING, $0, BG_EFFECT_USER, $20
	anim_sound 0, 0, SFX_OUTRAGE
	anim_wait 72
	anim_incbgeffect BATTLE_BG_EFFECT_CYCLE_MON_LIGHT_DARK_REPEATING
	anim_call BattleAnim_ShowMon_0
BattleAnim_OutrageHit:
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $4, $3
	anim_sound 0, 1, SFX_MOVE_PUZZLE_PIECE
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 120, 72, $0
	anim_wait 6
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 136, 56, $0
	anim_wait 6
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 152, 40, $0
	anim_wait 16
	anim_ret

BattleAnim_GigaDrain:
	anim_2gfx BATTLE_ANIM_GFX_BUBBLE, BATTLE_ANIM_GFX_CHARGE
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_FADE_MONS_TO_BLACK_REPEATING, $0, BG_EFFECT_TARGET, $10
	anim_sound 6, 3, SFX_GIGA_DRAIN
	anim_call BattleAnimSub_Drain
	anim_incbgeffect BATTLE_BG_EFFECT_FADE_MONS_TO_BLACK_REPEATING
	anim_call BattleAnim_ShowMon_0
	anim_wait 1
	anim_1gfx BATTLE_ANIM_GFX_SHINE
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $0, $0
	anim_jump BattleAnimSub_Glimmer

BattleAnim_FireFang:
	anim_call BattleAnim_Bite
	anim_clearobjs
	anim_1gfx BATTLE_ANIM_GFX_FIRE
	anim_jump BattleAnimSub_Fire

BattleAnim_Charm:
	anim_1gfx BATTLE_ANIM_GFX_OBJECTS
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_WOBBLE_MON, $0, BG_EFFECT_USER, $0
	anim_sound 0, 0, SFX_ATTRACT
	anim_obj BATTLE_ANIM_OBJ_HEART, 64, 80, $0
	anim_wait 32
	anim_incbgeffect BATTLE_BG_EFFECT_WOBBLE_MON
	anim_jump BattleAnim_ShowMon_0

BattleAnim_Rollout:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_sound 0, 0, SFX_SPARK
	anim_call BattleAnim_TargetObj_2Row
	anim_bgeffect BATTLE_BG_EFFECT_ROLLOUT, $60, $1, $1
	anim_bgeffect BATTLE_BG_EFFECT_BODY_SLAM, $0, BG_EFFECT_USER, $0
	anim_wait 4
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG, 136, 40, $0
	anim_wait 8
	anim_jump BattleAnim_ShowMon_0

BattleAnim_FalseSwipe:
	anim_2gfx BATTLE_ANIM_GFX_SHINE, BATTLE_ANIM_GFX_CUT
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $0, $0
	anim_sound 0, 1, SFX_CUT
	anim_obj BATTLE_ANIM_OBJ_CUT_LONG_DOWN_LEFT, 152, 40, $0
	anim_wait 4
	anim_obj BATTLE_ANIM_OBJ_GLIMMER, 136, 40, $0
	anim_wait 32
	anim_ret

BattleAnim_Swagger:
	anim_2gfx BATTLE_ANIM_GFX_MISC, BATTLE_ANIM_GFX_WIND
.loop
	anim_sound 0, 0, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_SWAGGER, 72, 88, $44
	anim_wait 32
	anim_loop 2, .loop
	anim_wait 32
	anim_sound 0, 1, SFX_KINESIS_2
	anim_obj BATTLE_ANIM_OBJ_ANGER, 104, 40, $0
	anim_wait 48
	anim_ret

BattleAnim_Scald:
	anim_bgeffect BATTLE_BG_EFFECT_START_WATER, $0, BG_EFFECT_TARGET, $0
	anim_1gfx BATTLE_ANIM_GFX_WATER
	anim_call BattleAnim_UserObj_2Row
	anim_sound 0, 1, SFX_HYDRO_PUMP
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 124, 72, $0
	anim_bgeffect BATTLE_BG_EFFECT_WATER, $30, $0, $0
	anim_wait 8
	anim_sound 0, 1, SFX_HYDRO_PUMP
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 132, 72, $0
	anim_bgeffect BATTLE_BG_EFFECT_WATER, $1c, $0, $0
	anim_wait 8
	anim_sound 0, 1, SFX_HYDRO_PUMP
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 140, 72, $0
	anim_bgeffect BATTLE_BG_EFFECT_WATER, $8, $0, $0
	anim_wait 8
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect BATTLE_BG_EFFECT_ALTERNATE_HUES, $0, $2, $0
	anim_call BattleAnim_ShowMon_1
	anim_bgeffect BATTLE_BG_EFFECT_END_WATER, $0, $0, $0
	anim_wait 16
	anim_ret

BattleAnim_WildCharge:
	anim_call BattleAnim_ChargedUpSub
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_TACKLE, $0, BG_EFFECT_USER, $0
	anim_sound 0, 0, SFX_SPARK
	anim_wait 16
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, BG_EFFECT_TARGET, $0
	anim_2gfx BATTLE_ANIM_GFX_HIT, BATTLE_ANIM_GFX_LIGHTNING
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 136, 48, $0
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $8, $2
	anim_sound 0, 1, SFX_THUNDER
	anim_obj BATTLE_ANIM_OBJ_THUNDER_RIGHT, 152, 68, $0
	anim_wait 64
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, BG_EFFECT_USER, $0
	anim_ret

BattleAnim_Spark:
	anim_call BattleAnim_ChargedUpSub
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_TACKLE, $0, BG_EFFECT_USER, $0
	anim_sound 0, 0, SFX_SPARK
	anim_wait 16
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, BG_EFFECT_TARGET, $0
	anim_wait 4
	anim_incobj 2
	anim_wait 1
	anim_sound 0, 1, SFX_THUNDERSHOCK
	anim_obj BATTLE_ANIM_OBJ_THUNDERBOLT_BALL, 136, 56, $2
	anim_obj BATTLE_ANIM_OBJ_SPARKS_CIRCLE, 136, 56, $0
	anim_wait 32
	anim_ret

BattleAnim_ChargedUpSub:
	anim_2gfx BATTLE_ANIM_GFX_LIGHTNING, BATTLE_ANIM_GFX_EXPLOSION
	anim_sound 0, 0, SFX_ZAP_CANNON
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $4, $3
	anim_obj BATTLE_ANIM_OBJ_THUNDER_WAVE, 48, 92, $0
	anim_wait 24
	anim_setobj $1, $3
	anim_wait 3
	anim_ret

BattleAnim_SteelWing:
	anim_1gfx BATTLE_ANIM_GFX_REFLECT
	anim_obp0 $0
	anim_sound 0, 0, SFX_RAGE
	anim_call BattleAnim_TargetObj_1Row
	anim_call BattleAnimSub_Metallic
	anim_call BattleAnim_ShowMon_0
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_resetobp0
	anim_jump BattleAnim_WingAttack.hit

BattleAnim_MeanLook:
	anim_1gfx BATTLE_ANIM_GFX_PSYCHIC
	anim_obp0 $e0
	anim_sound 0, 1, SFX_MEAN_LOOK
	anim_obj BATTLE_ANIM_OBJ_MEAN_LOOK, 148, 32, $0
	anim_wait 5
	anim_obj BATTLE_ANIM_OBJ_MEAN_LOOK, 116, 64, $0
	anim_wait 5
	anim_obj BATTLE_ANIM_OBJ_MEAN_LOOK, 148, 64, $0
	anim_wait 5
	anim_obj BATTLE_ANIM_OBJ_MEAN_LOOK, 116, 32, $0
	anim_wait 5
	anim_obj BATTLE_ANIM_OBJ_MEAN_LOOK, 132, 48, $0
	anim_wait 128
	anim_ret

BattleAnim_Attract:
	anim_1gfx BATTLE_ANIM_GFX_OBJECTS
.loop
	anim_sound 0, 0, SFX_ATTRACT
	anim_obj BATTLE_ANIM_OBJ_ATTRACT, 44, 80, $2
	anim_wait 8
	anim_loop 5, .loop
	anim_wait 128
	anim_ret

BattleAnim_SleepTalk:
	anim_sound 0, 0, SFX_STRENGTH
	anim_obj BATTLE_ANIM_OBJ_ASLEEP, 64, 80, $0
	anim_wait 48
	anim_ret

BattleAnim_HealBell:
	anim_2gfx BATTLE_ANIM_GFX_MISC, BATTLE_ANIM_GFX_NOISE
	anim_obj BATTLE_ANIM_OBJ_HEAL_BELL, 72, 56, $0
	anim_wait 32
.loop
	anim_sound 0, 0, SFX_HEAL_BELL
	anim_obj BATTLE_ANIM_OBJ_HEAL_BELL_NOTE, 72, 52, $0
	anim_wait 8
	anim_sound 0, 0, SFX_HEAL_BELL
	anim_obj BATTLE_ANIM_OBJ_HEAL_BELL_NOTE, 72, 52, $1
	anim_wait 8
	anim_sound 0, 0, SFX_HEAL_BELL
	anim_obj BATTLE_ANIM_OBJ_HEAL_BELL_NOTE, 72, 52, $2
	anim_wait 8
	anim_sound 0, 0, SFX_HEAL_BELL
	anim_obj BATTLE_ANIM_OBJ_HEAL_BELL_NOTE, 72, 52, $0
	anim_wait 8
	anim_sound 0, 0, SFX_HEAL_BELL
	anim_obj BATTLE_ANIM_OBJ_HEAL_BELL_NOTE, 72, 52, $2
	anim_wait 8
	anim_loop 4, .loop
	anim_wait 64
	anim_ret

BattleAnim_Return:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_call BattleAnim_TargetObj_2Row
	anim_bgeffect BATTLE_BG_EFFECT_BOUNCE_DOWN, $0, BG_EFFECT_USER, $0
	anim_sound 0, 0, SFX_RETURN
	anim_wait 64
	anim_incbgeffect BATTLE_BG_EFFECT_BOUNCE_DOWN
	anim_wait 32
	anim_bgeffect BATTLE_BG_EFFECT_BODY_SLAM, $0, BG_EFFECT_USER, $0
	anim_wait 4
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG, 136, 40, $0
	anim_wait 8
	anim_jump BattleAnim_ShowMon_0

BattleAnim_AuraSphere:
	anim_3gfx BATTLE_ANIM_GFX_EGG, BATTLE_ANIM_GFX_AEROBLAST, BATTLE_ANIM_GFX_EXPLOSION
	anim_bgp $1b
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 0, 0, SFX_AEROBLAST
	anim_obj BATTLE_ANIM_OBJ_AEROBLAST, 72, 88, $0
	anim_wait 32
	anim_sound 6, 2, SFX_SLUDGE_BOMB
	anim_obj BATTLE_ANIM_OBJ_OCTAZOOKA, 64, 92, $4
	anim_wait 16
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $30, $3, $0
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj BATTLE_ANIM_OBJ_EXPLOSION2, 136, 56, $0
	anim_wait 16
	anim_ret

BattleAnim_Safeguard:
	anim_1gfx BATTLE_ANIM_GFX_MISC
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_obj BATTLE_ANIM_OBJ_SAFEGUARD, 80, 80, $0
	anim_obj BATTLE_ANIM_OBJ_SAFEGUARD, 80, 80, $d
	anim_obj BATTLE_ANIM_OBJ_SAFEGUARD, 80, 80, $1a
	anim_obj BATTLE_ANIM_OBJ_SAFEGUARD, 80, 80, $27
	anim_obj BATTLE_ANIM_OBJ_SAFEGUARD, 80, 80, $34
	anim_sound 0, 0, SFX_PROTECT
	anim_wait 96
	anim_ret

BattleAnim_PainSplit:
	anim_2gfx BATTLE_ANIM_GFX_HIT, BATTLE_ANIM_GFX_OBJECTS
	anim_call BattleAnim_TargetObj_2Row
	anim_bgeffect BATTLE_BG_EFFECT_BODY_SLAM, $0, BG_EFFECT_USER, $0
	anim_wait 4
	anim_sound 0, 1, SFX_TACKLE
	anim_obj BATTLE_ANIM_OBJ_HIT, 112, 48, $0
	anim_obj BATTLE_ANIM_OBJ_HIT, 76, 96, $0
	anim_wait 8
	anim_jump BattleAnim_ShowMon_0

BattleAnim_FlareBlitz:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_call BattleAnim_FlareBlitz_Stub
	anim_bgp $90
	anim_bgeffect BATTLE_BG_EFFECT_BATTLEROBJ_1ROW, $0, $0, $0
	anim_bgeffect BATTLE_BG_EFFECT_TACKLE, $0, $1, $0
	anim_jump BattleAnim_FlameCharge.hit

BattleAnim_FlareBlitz_Stub:
	anim_2gfx BATTLE_ANIM_GFX_FIRE, BATTLE_ANIM_GFX_HIT
	anim_battlergfx_2row
.loop
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_FLARE_BLITZ, 44, 108, $6
	anim_wait 2
	anim_obj ANIM_OBJ_FLARE_BLITZ, 36, 108, $6
	anim_wait 2
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_FLARE_BLITZ, 52, 108, $8
	anim_wait 2
	anim_obj ANIM_OBJ_FLARE_BLITZ, 28, 108, $8
	anim_wait 2
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_FLARE_BLITZ, 60, 108, $6
	anim_wait 2
	anim_obj ANIM_OBJ_FLARE_BLITZ, 20, 108, $8
	anim_wait 2
	anim_obj ANIM_OBJ_FLARE_BLITZ, 68, 108, $8
	anim_wait 2
	anim_loop 3, .loop
	anim_wait 16
	anim_ret

BattleAnim_SacredFire:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_1gfx BATTLE_ANIM_GFX_FIRE
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect BATTLE_BG_EFFECT_ALTERNATE_HUES, $0, $2, $0
.loop
	anim_sound 0, 0, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_SACRED_FIRE, 48, 104, $0
	anim_wait 8
	anim_loop 8, .loop
	anim_wait 96
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_TACKLE, $0, BG_EFFECT_USER, $0
	anim_wait 4
	anim_jump BattleAnim_FlameCharge.hit

BattleAnim_Megahorn:
	anim_2gfx BATTLE_ANIM_GFX_HORN, BATTLE_ANIM_GFX_HIT
	anim_battlergfx_2row
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $30, $2, $0
	anim_wait 48
	anim_bgeffect BATTLE_BG_EFFECT_BATTLEROBJ_1ROW, $0, BG_EFFECT_TARGET, $0
	anim_wait 1
	anim_bgeffect BATTLE_BG_EFFECT_TACKLE, $0, BG_EFFECT_USER, $0
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_obj BATTLE_ANIM_OBJ_HORN, 72, 80, $1
	anim_wait 11
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, BG_EFFECT_TARGET, $0
	anim_incobj 1
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $8, $10
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $30, $3, $0
.loop
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 136, 56, $0
	anim_wait 16
	anim_loop 3, .loop
	anim_ret

BattleAnim_BatonPass:
	anim_1gfx BATTLE_ANIM_GFX_MISC
	anim_obj BATTLE_ANIM_OBJ_BATON_PASS, 44, 104, $20
	anim_sound 0, 0, SFX_BATON_PASS
	anim_call BattleAnimSub_Return
	anim_wait 64
	anim_ret

BattleAnim_Encore:
	anim_1gfx BATTLE_ANIM_GFX_OBJECTS
	anim_obj BATTLE_ANIM_OBJ_ENCORE_HAND, 64, 80, $90
	anim_obj BATTLE_ANIM_OBJ_ENCORE_HAND, 64, 80, $10
	anim_sound 0, 0, SFX_ENCORE
	anim_wait 16
	anim_obj BATTLE_ANIM_OBJ_ENCORE_STAR, 64, 72, $2c
	anim_wait 32
	anim_obj BATTLE_ANIM_OBJ_ENCORE_STAR, 64, 72, $34
	anim_wait 16
	anim_ret

BattleAnim_Pursuit:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 16
	anim_ret

BattleAnim_SpinGuard:
	anim_1gfx BATTLE_ANIM_GFX_WIND
	anim_obp0 $e4
.loop
	anim_sound 0, 0, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_RAPID_SPIN, 44, 112, $0
	anim_wait 2
	anim_loop 5, .loop
	anim_wait 24
	anim_ret

BattleAnim_RapidSpin:
	anim_2gfx BATTLE_ANIM_GFX_WIND, BATTLE_ANIM_GFX_HIT
	anim_call BattleAnim_SpinGuard
	anim_call BattleAnim_TargetObj_2Row
	anim_bgeffect BATTLE_BG_EFFECT_BODY_SLAM, $0, BG_EFFECT_USER, $0
	anim_wait 4
	anim_resetobp0
	anim_sound 0, 1, SFX_MEGA_KICK
	anim_obj BATTLE_ANIM_OBJ_HIT, 136, 40, $0
	anim_wait 8
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, BG_EFFECT_TARGET, $0
	anim_wait 4
	anim_incobj 6
	anim_wait 1
	anim_ret

BattleAnim_IronHead:
	anim_2gfx BATTLE_ANIM_GFX_REFLECT, BATTLE_ANIM_GFX_HIT
	anim_obp0 $0
	anim_sound 0, 0, SFX_RAGE
	anim_call BattleAnim_TargetObj_1Row
	anim_call BattleAnimSub_Metallic
	anim_call BattleAnim_ShowMon_0
	anim_resetobp0
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_TACKLE, $0, BG_EFFECT_USER, $0
	anim_wait 4
	anim_sound 0, 1, SFX_HEADBUTT
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 136, 56, $0
	anim_wait 8
	anim_jump BattleAnim_ShowMon_0

BattleAnim_MetalClaw:
	anim_1gfx BATTLE_ANIM_GFX_REFLECT
	anim_obp0 $0
	anim_sound 0, 0, SFX_RAGE
	anim_call BattleAnim_TargetObj_1Row
	anim_call BattleAnimSub_Metallic
	anim_call BattleAnim_ShowMon_0
	anim_1gfx BATTLE_ANIM_GFX_CUT
	anim_resetobp0
	anim_sound 0, 1, SFX_SCRATCH
	anim_obj BATTLE_ANIM_OBJ_CUT_DOWN_LEFT, 144, 48, $0
	anim_obj BATTLE_ANIM_OBJ_CUT_DOWN_LEFT, 140, 44, $0
	anim_obj BATTLE_ANIM_OBJ_CUT_DOWN_LEFT, 136, 40, $0
	anim_wait 32
	anim_ret

; Morning Sun's animation during the morning & day
BattleAnim_HealingLight:
	anim_if_param_equal $1, BattleAnim_Moonlight
	anim_1gfx BATTLE_ANIM_GFX_SHINE
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $0, $0
	anim_sound 0, 0, SFX_MORNING_SUN
.loop
	anim_obj BATTLE_ANIM_OBJ_MORNING_SUN, 16, 48, $88
	anim_wait 6
	anim_loop 5, .loop
	anim_wait 32
	anim_jump BattleAnimSub_Glimmer

; Moonlight's animation during the evening and night
BattleAnim_Moonlight:
	anim_1gfx BATTLE_ANIM_GFX_SHINE
	anim_bgp $1b
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $0, $0
	anim_obj BATTLE_ANIM_OBJ_MOONLIGHT, 0, 40, $0
	anim_obj BATTLE_ANIM_OBJ_MOONLIGHT, 16, 56, $0
	anim_obj BATTLE_ANIM_OBJ_MOONLIGHT, 32, 72, $0
	anim_obj BATTLE_ANIM_OBJ_MOONLIGHT, 48, 88, $0
	anim_obj BATTLE_ANIM_OBJ_MOONLIGHT, 64, 104, $0
	anim_wait 1
	anim_sound 0, 0, SFX_MOONLIGHT
	anim_wait 63
	; fallthrough

BattleAnimSub_Glimmer:
	anim_sound 0, 0, SFX_METRONOME
	anim_obj BATTLE_ANIM_OBJ_GLIMMER, 24, 64, $0
	anim_wait 5
	anim_obj BATTLE_ANIM_OBJ_GLIMMER, 56, 104, $0
	anim_wait 5
	anim_obj BATTLE_ANIM_OBJ_GLIMMER, 24, 104, $0
	anim_wait 5
	anim_obj BATTLE_ANIM_OBJ_GLIMMER, 56, 64, $0
	anim_wait 5
	anim_obj BATTLE_ANIM_OBJ_GLIMMER, 40, 84, $0
	anim_wait 37
	anim_setobjpal PAL_BATTLE_OB_GREEN, PAL_BTLCUSTOM_GREEN
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_InSandstorm:
BattleAnim_Sandstorm:
	anim_1gfx BATTLE_ANIM_GFX_POWDER
	anim_obj BATTLE_ANIM_OBJ_SANDSTORM, 88, 0, $0
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_SANDSTORM, 72, 0, $1
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_SANDSTORM, 56, 0, $2
.loop
	anim_sound 0, 1, SFX_MENU
	anim_wait 8
	anim_loop 8, .loop
	anim_wait 8
	anim_ret

BattleAnim_Hail:
BattleAnim_InHail:
	anim_1gfx BATTLE_ANIM_GFX_ICE
	anim_bgeffect BATTLE_BG_EFFECT_WHITE_HUES, $0, $8, $0
	anim_obj ANIM_OBJ_HAIL, 88, 0, $0
	anim_wait 8
	anim_obj ANIM_OBJ_HAIL, 72, 0, $1
	anim_wait 8
	anim_obj ANIM_OBJ_HAIL, 56, 0, $2
.loop
	anim_sound 0, 1, SFX_SHINE
	anim_wait 8
	anim_loop 8, .loop
	anim_wait 8
	anim_ret

BattleAnim_Crunch:
	anim_2gfx BATTLE_ANIM_GFX_CUT, BATTLE_ANIM_GFX_HIT
	anim_bgp $1b
	anim_obp0 $c0
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $20, $2, $0
	anim_obj BATTLE_ANIM_OBJ_BITE, 136, 56, $a8
	anim_obj BATTLE_ANIM_OBJ_BITE, 136, 56, $28
	anim_wait 8
	anim_sound 0, 1, SFX_BITE
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 144, 48, $18
	anim_wait 16
	anim_sound 0, 1, SFX_BITE
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 128, 64, $18
	anim_wait 8
	anim_ret

BattleAnim_HiddenPower:
	anim_1gfx BATTLE_ANIM_GFX_CHARGE
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_MON_LIGHT_DARK_REPEATING, $0, $1, $20
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_obj BATTLE_ANIM_OBJ_HIDDEN_POWER, 44, 88, $0
	anim_obj BATTLE_ANIM_OBJ_HIDDEN_POWER, 44, 88, $e
	anim_obj BATTLE_ANIM_OBJ_HIDDEN_POWER, 44, 88, $1c
	anim_obj BATTLE_ANIM_OBJ_HIDDEN_POWER, 44, 88, $2a
	anim_obj BATTLE_ANIM_OBJ_HIDDEN_POWER, 44, 88, $38
	anim_call BattleAnim_HiddenSfxSub
	anim_incbgeffect BATTLE_BG_EFFECT_CYCLE_MON_LIGHT_DARK_REPEATING
	anim_call BattleAnim_ShowMon_0
	anim_call BattleAnim_HiddenSpinningSub
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 136, 56, $0
	anim_wait 16
	anim_ret

BattleAnim_HiddenForce:
	anim_1gfx BATTLE_ANIM_GFX_CHARGE
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_MON_LIGHT_DARK_REPEATING, $0, $1, $20
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_obj BATTLE_ANIM_OBJ_HIDDEN_POWER, 44, 88, $0
	anim_obj BATTLE_ANIM_OBJ_HIDDEN_POWER, 44, 88, $e
	anim_obj BATTLE_ANIM_OBJ_HIDDEN_POWER, 44, 88, $1c
	anim_obj BATTLE_ANIM_OBJ_HIDDEN_POWER, 44, 88, $2a
	anim_obj BATTLE_ANIM_OBJ_HIDDEN_POWER, 44, 88, $38
	anim_call BattleAnim_HiddenSfxSub
	anim_incbgeffect BATTLE_BG_EFFECT_CYCLE_MON_LIGHT_DARK_REPEATING
	anim_call BattleAnim_ShowMon_0
	anim_call BattleAnim_HiddenSpinningSub
	anim_2gfx BATTLE_ANIM_GFX_EGG, BATTLE_ANIM_GFX_EXPLOSION; bombs start here
	anim_sound 0, 0, SFX_SWITCH_POKEMON
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $8, $3
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj BATTLE_ANIM_OBJ_EXPLOSION2, 136, 56, $0
	anim_wait 16
	anim_ret

BattleAnim_RunicPower:
	anim_1gfx ANIM_GFX_UNOWN
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_MON_LIGHT_DARK_REPEATING, $0, $1, $20
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_obj ANIM_OBJ_UNOWN, 44, 88, $0
	anim_obj ANIM_OBJ_UNOWN, 44, 88, $e
	anim_obj ANIM_OBJ_UNOWN, 44, 88, $1c
	anim_obj ANIM_OBJ_UNOWN, 44, 88, $2a
	anim_obj ANIM_OBJ_UNOWN, 44, 88, $38
	anim_call BattleAnim_HiddenSfxSub
	anim_incbgeffect BATTLE_BG_EFFECT_CYCLE_MON_LIGHT_DARK_REPEATING
	anim_call BattleAnim_ShowMon_0
	anim_call BattleAnim_HiddenSpinningSub
	anim_1gfx BATTLE_ANIM_GFX_EXPLOSION
	anim_call BattleAnimSub_Explosion2
	anim_wait 32
	anim_ret

BattleAnim_HiddenSfxSub:
.loop
	anim_sound 0, 4, SFX_SWORDS_DANCE
	anim_wait 8
	anim_loop 6, .loop
	anim_ret

BattleAnim_HiddenSpinningSub:
	anim_wait 1
	anim_incobj  2
	anim_incobj  3
	anim_incobj  4
	anim_incobj  5
	anim_incobj  6
	anim_incobj  7
	anim_incobj  8
	anim_incobj  9
	anim_wait 16
	anim_ret

BattleAnim_DragonClaw:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_DRAGONBREATH
	anim_call BattleAnim_FlareBlitz_Stub
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_DRAGONBREATH
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_DRAGONBREATH
	anim_1gfx BATTLE_ANIM_GFX_CUT
	anim_incbgeffect BATTLE_BG_EFFECT_FADE_MON_TO_LIGHT_REPEATING
	anim_wait 1
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $14, $2, $0
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $4, $2
	anim_sound 0, 1, SFX_CUT
	anim_obj BATTLE_ANIM_OBJ_CUT_DOWN_LEFT, 144, 48, $0
	anim_obj BATTLE_ANIM_OBJ_CUT_DOWN_LEFT, 140, 44, $0
	anim_obj BATTLE_ANIM_OBJ_CUT_DOWN_LEFT, 136, 40, $0
	anim_wait 32
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_YELLOW
	anim_ret

BattleAnim_RainDance:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_WATER
	anim_1gfx BATTLE_ANIM_GFX_WATER
	anim_bgp $f8
	anim_sound 0, 1, SFX_RAIN_DANCE
	anim_obj BATTLE_ANIM_OBJ_RAIN, 88, 0, $0
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_RAIN, 88, 0, $1
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_RAIN, 88, 0, $2
	anim_wait 96
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_SunnyDay:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_YELLOW
	anim_1gfx BATTLE_ANIM_GFX_WATER
	anim_bgp $90
	anim_sound 0, 1, SFX_MORNING_SUN
	anim_obj BATTLE_ANIM_OBJ_RAIN, 88, 0, $2
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_RAIN, 88, 0, $2
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_RAIN, 88, 0, $2
	anim_wait 96
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_ret

BattleAnim_MirrorCoat:
	anim_2gfx BATTLE_ANIM_GFX_REFLECT, BATTLE_ANIM_GFX_SPEED
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
.loop
	anim_sound 0, 0, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_SCREEN, 72, 80, $0
	anim_obj BATTLE_ANIM_OBJ_SHOOTING_SPARKLE, 64, 72, $4
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_SHOOTING_SPARKLE, 64, 88, $4
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_SHOOTING_SPARKLE, 64, 80, $4
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_SHOOTING_SPARKLE, 64, 96, $4
	anim_wait 8
	anim_loop 3, .loop
	anim_wait 32
	anim_ret

BattleAnim_NastyPlot:
	anim_1gfx BATTLE_ANIM_GFX_STATUS
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_MON_LIGHT_DARK_REPEATING, $0, BG_EFFECT_USER, $20
	anim_sound 0, 0, SFX_SPITE
	anim_obj BATTLE_ANIM_OBJ_PSYCH_UP, 44, 88, $0
	anim_obj BATTLE_ANIM_OBJ_PSYCH_UP, 44, 88, $10
	anim_obj BATTLE_ANIM_OBJ_PSYCH_UP, 44, 88, $20
	anim_obj BATTLE_ANIM_OBJ_PSYCH_UP, 44, 88, $30
	anim_wait 64
	anim_incbgeffect BATTLE_BG_EFFECT_CYCLE_MON_LIGHT_DARK_REPEATING
	anim_jump BattleAnim_ShowMon_0

BattleAnim_Extremespeed:
	anim_1gfx BATTLE_ANIM_GFX_SPEED
	anim_bgeffect BATTLE_BG_EFFECT_HIDE_MON, $0, BG_EFFECT_USER, $0
	anim_sound 0, 0, SFX_RAZOR_WIND
	anim_call BattleAnimSub_SpeedLines
	anim_wait 12
	anim_2gfx BATTLE_ANIM_GFX_HIT, BATTLE_ANIM_GFX_WIND
	anim_call BattleAnimSub_Agility
	anim_wait 32
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $6, $0
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $0a, $2, $0
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj BATTLE_ANIM_OBJ_HIT, 120, 52, $0
	anim_wait 5
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 44, $0
	anim_wait 5
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj BATTLE_ANIM_OBJ_HIT, 152, 48, $0
	anim_wait 24
	anim_clearobjs
	anim_wait 8
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, BG_EFFECT_USER, $0
	anim_wait 16
	anim_ret

BattleAnim_Ancientpower:
	anim_2gfx BATTLE_ANIM_GFX_ROCKS, BATTLE_ANIM_GFX_HIT
	anim_sound 0, 0, SFX_SPARK
	anim_obj BATTLE_ANIM_OBJ_ANCIENTPOWER, 64, 108, $20
	anim_wait 8
	anim_sound 0, 0, SFX_SPARK
	anim_obj BATTLE_ANIM_OBJ_ANCIENTPOWER, 75, 102, $20
	anim_wait 8
	anim_sound 0, 0, SFX_SPARK
	anim_obj BATTLE_ANIM_OBJ_ANCIENTPOWER, 85, 97, $20
	anim_wait 8
	anim_sound 0, 0, SFX_SPARK
	anim_obj BATTLE_ANIM_OBJ_ANCIENTPOWER, 96, 92, $20
	anim_wait 8
	anim_sound 0, 1, SFX_SPARK
	anim_obj BATTLE_ANIM_OBJ_ANCIENTPOWER, 106, 87, $20
	anim_wait 8
	anim_sound 0, 1, SFX_SPARK
	anim_obj BATTLE_ANIM_OBJ_ANCIENTPOWER, 116, 82, $20
	anim_wait 8
	anim_sound 0, 1, SFX_SPARK
	anim_obj BATTLE_ANIM_OBJ_ANCIENTPOWER, 126, 77, $20
	anim_wait 8
	anim_sound 0, 1, SFX_SPARK
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 136, 56, $0
	anim_wait 8
	anim_ret

BattleAnim_ShadowBall:
	anim_2gfx BATTLE_ANIM_GFX_EGG, BATTLE_ANIM_GFX_SMOKE
	anim_bgp $1b
	anim_sound 6, 2, SFX_SLUDGE_BOMB
	anim_obj BATTLE_ANIM_OBJ_SHADOW_BALL, 64, 92, $2
	anim_wait 32
	anim_obj BATTLE_ANIM_OBJ_BALL_POOF, 132, 56, $10
	anim_wait 24
	anim_ret

BattleAnim_StealthRock:
	anim_1gfx BATTLE_ANIM_GFX_ROCKS
	anim_sound 6, 2, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_SMALL_ROCK, 116, 68, $40
	anim_wait 8
	anim_sound 6, 2, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_SMALL_ROCK, 156, 68, $30
	anim_wait 8
	anim_sound 6, 2, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_SMALL_ROCK, 136, 68, $30
	anim_wait 64
	anim_ret

BattleAnim_BrickBreak:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_sound 6, 2, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_PUNCH, 136, 24, $30
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 136, 24, $30
	anim_wait 16
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $55, $2, $0
	anim_wait 64
	anim_clearobjs
	anim_obj BATTLE_ANIM_OBJ_PUNCH, 136, 82, $30
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 136, 82, $30
	anim_wait 8
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $4, $3
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 34
	anim_ret

BattleAnim_InWhirlpool:
BattleAnim_Whirlpool:
	anim_1gfx BATTLE_ANIM_GFX_WIND
	anim_bgeffect BATTLE_BG_EFFECT_WHIRLPOOL, $0, $0, $0
	anim_sound 0, 1, SFX_SURF
	anim_wait 16
.loop
	anim_obj BATTLE_ANIM_OBJ_GUST, 132, 72, $0
	anim_wait 6
	anim_loop 9, .loop
	anim_wait 64
	anim_incbgeffect BATTLE_BG_EFFECT_WHIRLPOOL
	anim_wait 1
	anim_ret

BattleAnimSub_WarpAway:
	anim_sound 0, 0, SFX_WARP_TO
BattleAnim_DiveBomb_Branch:
	anim_obj BATTLE_ANIM_OBJ_WARP, 44, 108, $0
	anim_obj BATTLE_ANIM_OBJ_WARP, 44, 100, $0
	anim_obj BATTLE_ANIM_OBJ_WARP, 44, 92, $0
	anim_obj BATTLE_ANIM_OBJ_WARP, 44, 84, $0
	anim_obj BATTLE_ANIM_OBJ_WARP, 44, 76, $0
	anim_obj BATTLE_ANIM_OBJ_WARP, 44, 68, $0
	anim_obj BATTLE_ANIM_OBJ_WARP, 44, 60, $0
	anim_ret

BattleAnimSub_Explosion1:
	anim_sound 0, 0, SFX_EGG_BOMB
	anim_obj BATTLE_ANIM_OBJ_EXPLOSION1, 24, 64, $0
	anim_wait 5
	anim_sound 0, 0, SFX_EGG_BOMB
	anim_obj BATTLE_ANIM_OBJ_EXPLOSION1, 56, 104, $0
	anim_wait 5
	anim_sound 0, 0, SFX_EGG_BOMB
	anim_obj BATTLE_ANIM_OBJ_EXPLOSION1, 24, 104, $0
	anim_wait 5
	anim_sound 0, 0, SFX_EGG_BOMB
	anim_obj BATTLE_ANIM_OBJ_EXPLOSION1, 56, 64, $0
	anim_wait 5
	anim_sound 0, 0, SFX_EGG_BOMB
	anim_obj BATTLE_ANIM_OBJ_EXPLOSION1, 40, 84, $0
	anim_ret

BattleAnimSub_Explosion2:
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj BATTLE_ANIM_OBJ_EXPLOSION1, 148, 32, $0
	anim_wait 5
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj BATTLE_ANIM_OBJ_EXPLOSION1, 116, 72, $0
	anim_wait 5
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj BATTLE_ANIM_OBJ_EXPLOSION1, 148, 72, $0
	anim_wait 5
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj BATTLE_ANIM_OBJ_EXPLOSION1, 116, 32, $0
	anim_wait 5
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj BATTLE_ANIM_OBJ_EXPLOSION1, 132, 52, $0
	anim_ret

BattleAnimSub_Sound:
	anim_obj BATTLE_ANIM_OBJ_SOUND, 64, 76, $0
	anim_obj BATTLE_ANIM_OBJ_SOUND, 64, 88, $1
	anim_obj BATTLE_ANIM_OBJ_SOUND, 64, 100, $2
	anim_ret

BattleAnimSub_Acid:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_ACID
.loop
	anim_sound 6, 2, SFX_BUBBLEBEAM
	anim_obj BATTLE_ANIM_OBJ_ACID, 64, 92, $10
	anim_wait 5
	anim_loop 8, .loop
	anim_wait 40
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_wait 32
	anim_ret

BattleAnimSub_Metallic:
	anim_sound 0, 0, SFX_SHINE
	anim_bgeffect BATTLE_BG_EFFECT_FADE_MON_TO_BLACK, $0, BG_EFFECT_USER, $40
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_HARDEN, 48, 84, $0
	anim_wait 32
	anim_obj BATTLE_ANIM_OBJ_HARDEN, 48, 84, $0
	anim_wait 64
	anim_incbgeffect BATTLE_BG_EFFECT_FADE_MON_TO_BLACK
	anim_ret

BattleAnimSub_SandOrMud:
.loop
	anim_sound 6, 2, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_SAND, 64, 92, $4
	anim_wait 4
	anim_loop 3, .loop
	anim_ret

BattleAnim_TargetObj_1Row:
	anim_battlergfx_2row
	anim_bgeffect BATTLE_BG_EFFECT_BATTLEROBJ_1ROW, $0, BG_EFFECT_TARGET, $0
	anim_wait 6
	anim_ret

BattleAnim_TargetObj_2Row:
	anim_battlergfx_1row
	anim_bgeffect BATTLE_BG_EFFECT_BATTLEROBJ_2ROW, $0, BG_EFFECT_TARGET, $0
	anim_wait 6
	anim_ret

BattleAnim_ShowMon_0:
	anim_wait 1
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, BG_EFFECT_TARGET, $0
	anim_wait 5
	anim_incobj 1
	anim_wait 1
	anim_ret

BattleAnim_UserObj_1Row:
	anim_battlergfx_2row
	anim_bgeffect BATTLE_BG_EFFECT_BATTLEROBJ_1ROW, $0, BG_EFFECT_USER, $0
	anim_wait 6
	anim_ret

BattleAnim_UserObj_2Row:
	anim_battlergfx_1row
	anim_bgeffect BATTLE_BG_EFFECT_BATTLEROBJ_2ROW, $0, BG_EFFECT_USER, $0
	anim_wait 4
	anim_ret

BattleAnimSub_SpeedLines:
	anim_obj BATTLE_ANIM_OBJ_SPEED_LINE, 24, 88, $2
	anim_obj BATTLE_ANIM_OBJ_SPEED_LINE, 32, 88, $1
	anim_obj BATTLE_ANIM_OBJ_SPEED_LINE, 40, 88, $0
	anim_obj BATTLE_ANIM_OBJ_SPEED_LINE, 48, 88, $80
	anim_obj BATTLE_ANIM_OBJ_SPEED_LINE, 56, 88, $81
	anim_obj BATTLE_ANIM_OBJ_SPEED_LINE, 64, 88, $82
	anim_wait 12
	anim_ret
