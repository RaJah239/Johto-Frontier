; List of all Pokemon that are immune to residual damage

; This list must also be apart of SpikesImmunePokemon in
; data/residual_damage/spike_immune_mons.asm

; Note: This list must match engine/battle/ai/ability_lists.asm `MagicGuardPokemon_AI:`

;MagicGuardPokemon_AI:
; 26 levitating pokemon
;	db CHARIZARD
;	db BEAUTIFLY
;	db DUSTOX
;	db MAGNEMITE
;	db MAGNETON
;	db MAGNEZONE
;	db ALTARIA
;	db GASTLY
;	db HAUNTER
;	db GENGAR
;	db LARVESTA
;	db VOLCARONA
;	db KOFFING
;	db WEEZING
;	db SOLROCK
;	db LUNATONE
;	db CLAYDOL
;	db BRONZOR
;	db BRONZONG
;	db MISDREAVUS
;	db MISMAGIUS
;	db UNOWN
;	db NOWN
;	db VICTINI
;	db CELEBI
;	db MEW
;
; 2 magic guard pokemon
;	db CLEFAIRY
;	db CLEFABLE
;	db -1 ; end

MagicGuardPokemon:
	db CLEFAIRY
	db CLEFABLE
    db -1 ; end
