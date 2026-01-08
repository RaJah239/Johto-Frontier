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
INCLUDE "engine/battle/move_effects/ohko.asm"
INCLUDE "engine/battle/move_effects/splash.asm"
INCLUDE "engine/battle/move_effects/leech_seed.asm"
INCLUDE "engine/battle/move_effects/trick.asm"

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
