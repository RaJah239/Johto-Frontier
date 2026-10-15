# AI

## General Information
- The AI *does not* read the player’s input
- The AI *knows* all of the player’s moves and held items
- The player can view the enemy’s moves and items via the ‘Info’ tab during trainer battles

## Extensively Improved AI (Credit: Pokémon Ambrosia)
- The AI constantly evaluates the following:
  - Whether it can 1HKO, 2HKO or 3HKO the player from both their current and maximum HP
  - Whether the player can 1HKO, 2HKO or 3HKO the AI from both its current and maximum HP
  - Whether it can outspeed the player (taking into account, weather boosting abilities)
  - If the enemy can KO but is slower and player has no priority move, speed boosting moves are encouraged to possibly get the jump on the next Pokémon to be sent out
  - Which item the player's Pokémon is holding
  - It does not know which move the player has selected for the current turn

The AI uses this information to make smarter decisions, as demonstrated by the following examples:
 - Recover
   - Uses Recover when it would otherwise have only one turn remaining before being defeated by the player
   - Avoids using Recover when the player cannot 2HKO it from full HP, since healing would be unnecessary in that situation
 - Swords Dance
   - Uses Swords Dance only when it can survive long enough to land at least one attack afterward
   - Avoids using Swords Dance if the player can 1HKO it, unless all of the following conditions are met:
   - The AI outspeeds the player
   - Its Focus Sash is intact or it has Sturdy
   - The player does not have a priority move

## Switches
- AI doesn't switch if already set up (+2 or higher in Attack/Special Attack/Defense/Special Defense, or +3 or higher in any stat)
- Switches if enemy is choice locked into a move that is not very effective or a doesn't affect or has zero PP
- Switch if enemy attack or special attack at -2 or lower, unless the other offense is boosted
- Switches to a fresh Clean Sweep (Defog ability) Pokémon when the player hits +4 in any stat, even if one was already out
- 80+% to switch if under a curse, nightmare, in love, confused, leech seed, badly poisoned after 4 turns
- 80+% chance to switch if Accuracy is below -1
- 80+% chance to switch if any non-Speed stat (because of Curse) is below -2
- 40% to switch if Encored or Destiny Bonded
- ~33% chance to switch if any non-Speed stat is at -2

## Reworked forced switches (KO replacement, Baton Pass, U-Turn, Volt Switch) and voluntary AI switches to best answer the player active Pokémon, in priority order:
- Switches to a fresh Clean Sweep (Defog ability) Pokémon when the player hits +4 in any stat
- A Pokémon that takes 0x or <=0.5x from every damaging move the player knows
- A Pokémon with a super-effective move against the player active mon
- A Pokémon that takes the least damage from the player moves
