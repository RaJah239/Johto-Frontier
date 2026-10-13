# AI

## The AI does not read the player's input

## General
- If the enemy can KO but is slower and player has no priority move, speed boosting moves are encouraged to possibly get the jump on the next Pokémon to be sent out

## Reworked forced switches (KO replacement, Baton Pass) and voluntary AI switches to best answer the player active Pokémon, in priority order:
- A Pokémon that takes 0x or <=0.5x from every damaging move the player knows
- A Pokémon with a super-effective move against the player active mon
- A Pokémon that takes the least damage from the player moves (via the
   existing damage calculation)
