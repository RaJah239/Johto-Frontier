; List of all Pokemon that prevents steel types from switching or escaping wild battles

; Note: This list must match engine/battle/ai/items.asm `MagnetPullPokemon_AI:`

;MagnetPullPokemon_AI:
;    db MAGNEMITE
;    db MAGNETON
;    db MAGNEZONE
;   db -1 ; end

MagnetPullPokemon:
;   dw MAGNEMITE
;   dw MAGNETON
;   dw MAGNEZONE
    dw -1 ; end
