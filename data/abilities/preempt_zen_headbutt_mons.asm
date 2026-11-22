; List of all Pokemon that get priority (+2) on Zen Headbutt
; (Preempt)

; (one list for the battle and the AI: engine/battle/core.asm includes it as
; PreemptZenHeadbuttPokemon (priority), engine/battle/effect_commands_far.asm as
; PreemptZenHeadbuttPokemon_Popup (ability popup) and
; engine/battle/ai/ability_lists.asm as PreemptZenHeadbuttPokemon_AI)

	db DROWZEE
	db HYPNO
	db -1 ; end
