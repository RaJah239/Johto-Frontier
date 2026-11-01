# Battle AI

## What the AI knows
- The AI can see all of your Pokémon's moves and held items
- The AI does **not** see which move you pick each turn
- You can view the opponent's moves and items in the 'Info' tab during trainer battles
- Before deciding, the AI works out:
  - how many hits it needs to knock you out, and how many you need to knock it out
  - who is faster (counting paralysis, Trick Room, Choice Scarf and weather speed abilities)
  - which moves have no effect because of type matchups or abilities like Levitate

## How the AI picks a move
- Every move gets a score, and good moves get bonuses. A move the AI really likes can never be ruled out by having "too many" bonuses
- **Knock-outs:** the AI only counts on a knock-out if even its weakest damage roll would do it. When judging whether *you* can knock *it* out, it assumes your strongest roll
- **Speed first, then KO:** if it can knock you out but is slower, it uses a speed-boosting move first (Agility, Dragon Dance, Quiver Dance or Flame Charge), so it is also faster than your next Pokémon. It only does this when:
  - the boost would actually make it faster than you, and
  - it can survive your attack that turn
- **Priority KO:** if a priority move like ExtremeSpeed would knock you out for sure, it uses that instead of boosting, even if you could knock it out first
- **Special priority moves:** Blastoise's Iron Head and Drowzee's and Hypno's Zen Headbutt count as priority moves
- **Thunderbolt and similar attacks** aren't avoided just because the target can't be paralyzed
- **Flinch moves** are only favored when the AI is faster and you are paralyzed, or when it has Serene Grace

## When the AI always switches out
- **Stuck with a useless move:** it's locked in by a Choice item to a move that does nothing to your Pokémon (including because of an ability like Levitate) or isn't very effective
- **Hit super effectively:** your attack was super effective, unless it would win the one-on-one anyway (see below)
- **Clean Sweep:** your Pokémon has +4 or more in any stat, so it brings in a fresh Clean Sweep (Defog) Pokémon

## "Would it win the one-on-one?"
After being hit super effectively, the AI plays out the fight before leaving:
- It counts how many hits each side needs to win, using current HP, stat boosts, Reflect and Light Screen
- It stays in if it needs fewer hits than you, or the same number and it's faster
- Healing moves (Recover, Roost, Softboiled, Milk Drink, Slack Off, Healing Light, Rest) are taken into account. A Pokémon that heals more each turn than it loses can only be beaten by a one-hit knock-out

## When the AI sometimes switches out
- About 80% chance: Accuracy at -2 or lower, stuck on a move with no PP left, Nightmare, Curse, in love, confused, Leech Seed, badly poisoned or Encored
- About 40% chance: under Destiny Bond
- Likely to switch if Attack, Defense, Sp. Atk or Sp. Def is at -3 or lower; sometimes at -2
- Otherwise, a 20%, 50% or 80% chance depending on how badly your Pokémon's moves match up against it

## When the AI will NOT switch
- It's set up: +2 or more in Attack, Sp. Atk or Speed, or +3 in any stat
- It's below 1/3 of its HP. It stays in and fights
- Every Pokémon it could send in is weak to the move you just used
- It's trapped (Mean Look, Wrap, Shadow Tag, Arena Trap, Magnet Pull), unless it has Run Away
- It has no other Pokémon left

## Which Pokémon it sends in
**When it chooses to switch** (or uses U-turn, Volt Switch or Baton Pass):
1. Whichever Pokémon takes the least from the move you just used: immune first, then 1/4 damage, then 1/2 damage
2. A Pokémon that takes half damage or less from all of your moves
3. A Pokémon with a super-effective move against you
4. The Pokémon that takes the least damage from your moves

**After you knock one of its Pokémon out:**
1. A Clean Sweep (Defog) Pokémon, if it has one left
2. A Pokémon whose type is strong against yours and that has a super-effective attack (4x is preferred over 2x)
3. A Pokémon that takes half damage or less from all of your moves
4. The Pokémon that takes the least damage from your moves

In both cases, it avoids Pokémon that are weak to your last move whenever a safer option is available.
