; List of all Pokemon whose megahorn never misses

TrueHornPokemon:
;    db HERACROSS
    db MAGIKARP
    db -1 ; end

AbilityPopup_TrueHornText: db "True Horn@"

ResetSureHitEvents:
    ResetEventFlag EVENT_TRUE_HORN
    ResetEventFlag EVENT_STORMBOUND
    ResetEventFlag EVENT_TRUE_FLAME
    ResetEventFlag EVENT_FROST_LOCK
    ResetEventFlag EVENT_HYDRO_AIM
    ResetEventFlag EVENT_STONE_FALL
    ResetEventFlag EVENT_STONEBOUND
    ret
