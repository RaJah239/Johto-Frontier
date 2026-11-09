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
- **Speed first, then KO:** if it can knock you out but is slower, it first uses a move that makes it faster, so it is also faster than your next Pokémon. That can be:
  - a speed-boosting move (Agility, Dragon Dance, Quiver Dance or Flame Charge), or
  - a weather move that turns on its weather speed ability: Rain Dance with Swift Swim, Sunny Day with Chlorophyll, Sandstorm with Sand Rush, or Hail with Slush Rush (these abilities let it move first in that weather)

  It only does this when:
  - the move would actually make it faster than you
  - it can survive your attack that turn
  - for weather moves: that weather isn't already up, your Pokémon doesn't have the same ability, it isn't paralyzed or at -2 Speed or lower, your Pokémon isn't at +2 Speed or higher, Trick Room isn't active, and it can still knock you out in the new weather
- **Priority KO:** if a priority move like ExtremeSpeed would knock you out for sure, it uses that instead of boosting, even if you could knock it out first
- **Draining moves** (Absorb, Mega Drain, Giga Drain, Drain Punch, Drain Kiss, Leech Life, Aeroblast, Sacred Fire, and Dream Eater on a sleeping target) give back half the damage they deal:
  - **Finish and heal:** when it is at half HP or less, moves first (it is faster, or the move has priority) and a draining move would knock you out for sure, it always uses that move
  - **Drain to win:** if it would lose the one-on-one by just attacking, but wins it by using a draining move every turn and healing each time, it strongly favors that move. It plays this out with its weakest damage roll against your strongest
  - **Dream Eater while you sleep:** Dream Eater has priority, so it hits before you every turn you're asleep, including the turn you wake up. If those hits are enough to knock you out, it strongly favors Dream Eater, since you can't hit back. It counts one hit fewer if you have a move that would go first on your waking turn (like Protect), and doesn't do this at all if you know Sleep Talk
- **Special priority moves:** Blastoise's Iron Head and Drowzee's and Hypno's Zen Headbutt count as priority moves
- **Thunderbolt and similar attacks** aren't avoided just because the target can't be paralyzed
- **Flinch moves** are only favored when the AI is faster and you are paralyzed, or when it has Serene Grace

## Switching
- The AI doesn't switch out by itself
- When it has to send in a Pokémon (after a knock-out, U-turn, Volt Switch or Baton Pass), it picks, skipping Pokémon that are asleep or frozen:
  1. The first Pokémon in its party with a super-effective move against yours
  2. Otherwise, the first one that none of your Pokémon's moves hit super effectively
  3. Otherwise, a random one
