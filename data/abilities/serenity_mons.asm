; List of all Pokemon that are immune to all status problems:
; paralysis, burn (including flame orb), frostbite,
; poison (including toxic spikes & toxic orb),
; sleep (including rest) and confusion

; Note: This list must match engine/battle/core.asm

; ====================================
; === Ability: Serenity - Pokemon List
; ====================================
;   call GetCurrentMon
;   cp MEGANIUM
;   jr z, .pop
;   cp SYLVEON
;   jr z, .pop
;   cp MEW
;   jr z, .pop

; and engine/battle/turn_end_effects.asm `ShouldIgniteFlameOrb:`
;.checkDetails
;   cp MEGANIUM
;   jr z, .no
;   cp SYLVEON
;   jr z, .no
;   cp MEW
;   jr z, .no

; and engine/battle/turn_end_effects.asm `ShouldTriggerToxicOrb`
;.checkDetails
;   cp CHIKORITA ; to prevent poisoning
;   jr z, .no
;   cp BAYLEEF ; to prevent poisoning
;   jr z, .no
;   cp MEGANIUM
;   jr z, .no
;   cp SYLVEON
;   jr z, .no
;   cp MEW
;   jr z, .no

; and engine/battle/ai/ability_lists.asm `SerenityPokemon_AI:`
;SerenityPokemon_AI:
;   db MEGANIUM
;   db SYLVEON
;   db MEW
;   db -1

; it couldn't be worked around afaik

SerenityPokemon:
    db MEGANIUM
    db SYLVEON
    db MEW
    db -1 ; end
