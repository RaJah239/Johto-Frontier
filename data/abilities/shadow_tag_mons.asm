; List of all Pokemon that prevents switching or escaping wild battles

; Note: This list must match engine/battle/ai/switch.asm

; can't switch if trapped
;   ld a, [wBattleMonSpecies]
;   cp GENGAR
;   ret z
;   cp CHANDELURE
;   ret z

ShadowTagPokemon:
    db CHANDELURE
    db GENGAR
    db -1 ; end
