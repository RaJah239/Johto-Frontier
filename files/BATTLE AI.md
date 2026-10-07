# AI

## The AI does not read the player's input

## Reworked forced switches (KO replacement, Baton Pass) and voluntary AI switches to best answer the player active Pokémon, in priority order:
- a Pokémon that takes 0x or <=0.5x from every damaging move the player knows
- a Pokémon with a super-effective move against the player active mon
- a Pokémon that takes the least damage from the player moves (via the
   existing damage calculation)
