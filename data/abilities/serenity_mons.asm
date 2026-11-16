; List of all Pokemon that are immune to all status problems:
; paralysis, burn (including flame orb), frostbite,
; poison (including toxic spikes & toxic orb),
; sleep (not including rest) and confusion (no including hurricane or swagger)

; Toxic Spikes (engine/battle/core.asm) and Flame / Toxic Orb
; (engine/battle/turn_end_effects.asm) use this list too, through
; UserHasSerenity (engine/battle/effect_commands.asm).

; Note: This list must match engine/battle/ai/ability_lists.asm `SerenityPokemon_AI:`

SerenityPokemon:
;    db MEGANIUM
;    db SYLVEON
;    db MEW
    db -1 ; end
