; List of all Pokemon that recover from any non-volatile
; status at the end of each turn when in rain

; Note: This list must match engine/battle/ai/ability_lists.asm `HydrationPokemon_AI:`

;HydrationPokemon_AI:
;   db SEEL
;   db DEWGONG
;   db LAPRAS
;   db -1 ; end

HydrationPokemon:
    db SEEL
    db DEWGONG
    db LAPRAS
    db -1 ; end
