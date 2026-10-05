INCLUDE "engine/battle/far_command_index.asm"

; Special Move effects
INCLUDE "engine/battle/move_effects/false_swipe.asm"
INCLUDE "engine/battle/move_effects/pain_split.asm"
INCLUDE "engine/battle/move_effects/disable.asm"
INCLUDE "engine/battle/move_effects/selfdestruct.asm"
INCLUDE "engine/battle/move_effects/thief.asm"
INCLUDE "engine/battle/move_effects/toxic_spikes.asm"
INCLUDE "engine/battle/move_effects/thunder.asm"
INCLUDE "engine/battle/move_effects/hail.asm"
INCLUDE "engine/battle/move_effects/foresight.asm"
INCLUDE "engine/battle/move_effects/fakeout.asm"
INCLUDE "engine/battle/move_effects/freeze_dry.asm"
INCLUDE "engine/battle/move_effects/sucker_punch.asm"
INCLUDE "engine/battle/move_effects/avalanche.asm"
INCLUDE "engine/battle/move_effects/rain_dance.asm"
INCLUDE "engine/battle/move_effects/sunny_day.asm"
INCLUDE "engine/battle/move_effects/sandstorm.asm"
INCLUDE "engine/battle/move_effects/barrier.asm"
INCLUDE "engine/battle/move_effects/trick_room.asm"
INCLUDE "engine/battle/move_effects/taunt.asm"
INCLUDE "engine/battle/move_effects/brick_break.asm"
INCLUDE "engine/battle/move_effects/splash.asm"
INCLUDE "engine/battle/move_effects/leech_seed.asm"
INCLUDE "engine/battle/move_effects/trick.asm"
INCLUDE "engine/battle/move_effects/knock_off.asm"
INCLUDE "engine/battle/move_effects/growth.asm"
INCLUDE "engine/battle/move_effects/curse.asm"
INCLUDE "engine/battle/move_effects/protect.asm"
INCLUDE "engine/battle/move_effects/bulk_up.asm"
INCLUDE "engine/battle/move_effects/calmmind.asm"
INCLUDE "engine/battle/move_effects/dragondance.asm"
INCLUDE "engine/battle/move_effects/close_combat.asm"
INCLUDE "engine/battle/move_effects/hex.asm"
INCLUDE "engine/battle/move_effects/venoshock.asm"
INCLUDE "engine/battle/move_effects/fury_drive.asm"
INCLUDE "engine/battle/move_effects/quiver_dance.asm"
INCLUDE "engine/battle/move_effects/stealth_rock.asm"
INCLUDE "engine/battle/move_effects/defog.asm"
INCLUDE "engine/battle/move_effects/spikes.asm"
INCLUDE "engine/battle/move_effects/perish_song.asm"
INCLUDE "engine/battle/move_effects/attract.asm"
INCLUDE "engine/battle/move_effects/safeguard.asm"
INCLUDE "engine/battle/move_effects/acrobatics.asm"
INCLUDE "engine/battle/move_effects/pursuit.asm"
INCLUDE "engine/battle/move_effects/rapid_spin.asm"
INCLUDE "engine/battle/move_effects/hidden_power.asm"
INCLUDE "engine/battle/move_effects/belly_drum.asm"
INCLUDE "engine/battle/move_effects/counter_mirror_coat.asm"
INCLUDE "engine/battle/move_effects/sticky_web.asm"
INCLUDE "engine/battle/move_effects/hurricane.asm"

; Weather duration when Weather Rock is equipped
; Rock: 16, No Rock: 5
GetWeatherMoveDuration:
	farcall GetUserItem
	ld a, [hl]
	cp WEATHER_ROCK
	ld a, 16
	ret z

	ld a, 5
	ret
