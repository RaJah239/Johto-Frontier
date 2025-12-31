; List of all Pokemon that are immune to all status problems:
; paralysis, burn, frostbite, poison - including toxic spikes, sleep and confusion

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

; it couldn't be worked around afaik

SerenityPokemon:
    db MEGANIUM
    db SYLVEON
    db MEW
    db -1
