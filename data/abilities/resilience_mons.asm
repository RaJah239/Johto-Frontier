; List of all Pokemon whose stats can't be dropped by the opponent

;Core_ResiliencePokemon:
;   db TENTACOOL
;   db TENTACRUEL
;   db REGIROCK
;   db REGICE
;   db REGISTEEL
;   db -1 ; end

; and engine/battle/ai/ability_lists.asm `ResiliencePokemon_AI:`

; (one list for both the battle and the AI: engine/battle/effect_commands.asm includes it
; as ResiliencePokemon, engine/battle/ai/ability_lists.asm as ResiliencePokemon_AI)
	db TENTACOOL
	db TENTACRUEL
	db REGIROCK
	db REGICE
	db REGISTEEL
    db -1 ; end
