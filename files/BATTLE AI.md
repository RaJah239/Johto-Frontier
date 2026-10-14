# AI

## The AI does not read the player's input

## General
- If the enemy can KO but is slower and player has no priority move, speed boosting moves are encouraged to possibly get the jump on the next Pokémon to be sent out
- AI doesn't switch if already set up (+2 or higher in Attack/Special Attack/Defense/Special Defense, or +3 or higher in any stat)
- Switches if enemy is choice locked into a move that is not very effective or a doesn't affect or has zero PP
- Switch if enemy attack or special attack at -2 or lower, unless the other offense is boosted
- Switches to a fresh Clean Sweep (Defog ability) Pokémon when the player hits +4 in any stat, even if one was already out
- 80+% to switch if under a curse, nightmare, in love, confused, leech seed, badly poisoned after 4 turns
- 80+% chance to switch if Accuracy is below -1
- 80+% chance to switch if any non-Speed stat (because of Curse) is below -2
- 40% to switch if Encored or Destiny Bonded
- ~33% chance to switch if any non-Speed stat is at -2

## Reworked forced switches (KO replacement, Baton Pass) and voluntary AI switches to best answer the player active Pokémon, in priority order:
- Switches to a fresh Clean Sweep (Defog ability) Pokémon when the player hits +4 in any stat
- A Pokémon that takes 0x or <=0.5x from every damaging move the player knows
- A Pokémon with a super-effective move against the player active mon
- A Pokémon that takes the least damage from the player moves (via the
   existing damage calculation)
