# Battle AI

How opposing trainers decide what to do each turn: which move to use, when to switch, and when to use an item.

- **Trainers** (including Battle Tower and Grand Gauntlet opponents) use everything below. Every trainer class has the same AI
- **Battle Tower** trainers never use items just like the player
- **Wild Pokémon** pick a random usable move. They skip moves that can't affect you as long as they have another move that can (see [Moves that can't hit you](#moves-that-cant-hit-you)).
- **Link battles** use no AI.

## What the AI knows
- It can see all of your Pokémon's moves and held items
- It does **not** see which move you pick this turn. It only knows the last move you used
- You can view the opponent's moves and items in the 'Info' tab during trainer battles
- Before deciding, it works out:
  - how much damage its moves do to you, and yours to it
  - how many hits it needs to knock you out, and how many you need to knock it out
  - who is faster (counting paralysis, Trick Room, Choice Scarf and weather speed abilities)
  - which moves have no effect because of type matchups or abilities like Levitate

## A turn, step by step
1. **Pick a move.** Every move is scored (see below). The AI also decides here whether it *should* switch out (see [Smart switching](#smart-switching)).
2. **Switch or use an item, at the start of the turn.**
   - If step 1 asked for a switch, it switches (unless it's trapped or set up, see [When it won't switch](#when-it-wont-switch)).
   - Otherwise it may switch anyway, by chance (see [Switching by chance](#switching-by-chance)).
   - If it doesn't switch, it may use an item (see [Items](#items)).
3. **Attack** with the chosen move if it didn't switch or use an item.

## How the AI picks a move
Every move starts at the same score. Each part of the AI below then makes moves more or less likely, and the AI uses the move it likes best. When several moves tie, it picks one of them at random. Moves that are out of PP or disabled are never picked while another move can be used.

The parts run in this order:

### 1. Basics: don't waste the turn
A move is strongly avoided when:
- it would fail or do nothing right now, for example:
  - Dream Eater on an awake target
  - healing at full HP
  - a screen, Mist, Safeguard, Substitute, Leech Seed, Spikes, weather or Perish Song that is already up
  - Encore, Disable, Mean Look, Attract or Foresight when they're already in effect or can't work
  - Sleep Talk while awake
- it's a status move (no damage) and it's Taunted or holding an Assault Vest
- it only inflicts a status and you:
  - already have a status
  - have Serenity
  - have Hydration and it's raining
- you're behind a Substitute and the move only inflicts a status or lowers stats (sleep, poison, paralysis, burn, confusion, Leech Seed, stat drops, Transform, Swagger)
- your ability makes you immune to its type (Levitate, Waterproof, Flame Ward, Grounded, Immunity)

If it's Encored, it sticks with the move it's locked into.

**Knock-out bonus:** a move that would knock you out (strongest roll) gets a bonus. The bonus depends on the move:
- **biggest:** a 100% accurate move
- **smaller:** a recoil move (no recoil penalty with Rock Head)
- **smaller still:** a less accurate move
- **smallest:** Explosion, or any attack when it's at 1/4 HP or less and has a healing move (so it still considers healing)

If it's faster and you're in the air (Fly) or underground (Dig), there's no KO bonus.

### 2. Smart switching
Decides whether it wants to switch out this turn (see [Smart switching](#smart-switching)).

### 3. Type matchups
- Super-effective moves are favoured
- Not very effective moves are avoided if it has a damaging move of another type
- Moves your type is immune to are strongly avoided

### 4. Smart play
Each kind of move gets its own check. The main ones:
- **Setting up** (Swords Dance, Nasty Plot, Calm Mind, Bulk Up, Dragon Dance, Quiver Dance, Growth, Agility, Amnesia…):
  - only when you can't knock it out this turn
  - Agility only when it's slower
  - it won't boost while you can force it out (Roar, Whirlwind, Haze, Reset Stats) or when you're behind a Substitute
  - it stops boosting once it's at +2, or when it and you could each knock the other out in two hits
  - it may set up while you're asleep for long enough
- **Status moves:**
  - Sleep, paralysis, burn, Toxic and confusion are avoided if you can't get that status or are behind a Substitute or Safeguard
  - Sleep is favoured if it has Dream Eater or Bad Dreams
  - Leech Seed is never used on Grass types
- **Weather:**
  - Rain Dance, Sunny Day, Sandstorm and Hail aren't used when that weather is already up
  - Solar Beam is favoured in sun and avoided in rain
  - Thunder and Hurricane are favoured in rain and avoided in sun
- **Hazards:**
  - Spikes, Stealth Rock, Toxic Spikes and Sticky Web aren't used when already up
  - they're avoided if you have Rapid Spin or Defog
  - Rapid Spin is favoured when it's trapped, seeded or has hazards on its side
  - Defog isn't used when you have one Pokémon left
- **Protect and King's Shield:** not used twice in a row
- **Situational attacks:**
  - Facade when it has a status
  - Hex when you have a status
  - Venoshock when you're poisoned
  - Acrobatics with no held item
  - Brick Break after you set up a screen
  - Body Press at +1 Defense
  - Knock Off when you hold a useful item
  - Earthquake when you're underground
  - Gust when you're flying (and it's faster)
- **Risky moves:**
  - Explosion is never used on Ghost types
  - Close Combat is less likely above half HP
  - Flail is held back until 1/4 HP
  - Super Fang is avoided when you're low
  - Avalanche is avoided when it's low
  - Sucker Punch may be avoided after you used a status move
- **Other:**
  - Sleep Talk only while asleep
  - Heal Bell only if a teammate has a status
  - Baton Pass only with a teammate to pass to
  - Pursuit is less likely against your last Pokémon
  - Encore only when faster
  - Attract mostly on your Pokémon's first turn
  - U-turn and other pivot moves are favoured when you could knock it out in two hits but it can't do the same to you
- **Flinch moves:** only favoured when it's faster and you're paralyzed, or when it has Serene Grace
- **Thunderbolt and similar attacks** aren't avoided just because you can't be paralyzed
- **Special priority moves:** Blastoise's Iron Head and Drowzee's and Hypno's Zen Headbutt count as priority moves

### 5. Final attack
When you could knock it out this turn (your strongest roll), it strongly avoids stall moves, so it attacks while it still can: Leer, Growl, Disable, Counter, Leech Seed, Growth, Agility, Screech, Harden, Defense Curl, Light Screen, Haze, Reflect, Focus Energy, Amnesia, Transform, Splash and Substitute.

### 6. Aggressive
It finds its single most damaging move against you and slightly avoids every other attack, so it usually uses its strongest hit. These moves don't count as its strongest:
- Explosion
- moves your ability makes you immune to

Moves with fixed or variable damage (Seismic Toss, Counter, Hidden Power…) are left alone.

### 7. Final checks
These run after everything above and can override it.
- **Knock-outs:** the AI only counts on a knock-out if even its weakest damage roll would do it. When judging whether *you* can knock *it* out, it assumes your strongest roll
- **Priority KO:** if a priority move like ExtremeSpeed would knock you out for sure, it uses that, even if you could knock it out first
- **Speed first, then KO:** if it can knock you out but is slower, it first uses a move that makes it faster, so it is also faster than your next Pokémon. That can be:
  - a speed-boosting move (Agility, Dragon Dance, Quiver Dance or Flame Charge), or
  - a weather move that turns on its weather speed ability: Rain Dance with Swift Swim, Sunny Day with Chlorophyll, Sandstorm with Sand Rush, or Hail with Slush Rush

  It only does this when:
  - the move would actually make it faster than you
  - it can survive your attack that turn
  - for weather moves: that weather isn't already up, your Pokémon doesn't have the same ability, it isn't paralyzed or at -2 Speed or lower, your Pokémon isn't at +2 Speed or higher, Trick Room isn't active, and it can still knock you out in the new weather
- **Draining moves** (Absorb, Mega Drain, Giga Drain, Drain Punch, Drain Kiss, Leech Life, Aeroblast, Sacred Fire, and Dream Eater on a sleeping target) give back half the damage they deal:
  - **Finish and heal:** when it is at half HP or less, moves first (it is faster, or the move has priority) and a draining move would knock you out for sure, it always uses that move
  - **Drain to win:** if it would lose the one-on-one by just attacking, but wins it by using a draining move every turn and healing each time, it strongly favors that move. It plays this out with its weakest damage roll against your strongest
  - **Dream Eater while you sleep:** Dream Eater has priority, so it hits before you every turn you're asleep, including the turn you wake up. If those hits are enough to knock you out, it strongly favors Dream Eater, since you can't hit back. It counts one hit fewer if you have a move that would go first on your waking turn (like Protect), and doesn't do this at all if you know Sleep Talk
- <a id="moves-that-cant-hit-you"></a>**Moves that can't hit you:**
  - It never uses a damaging move you're immune to while another usable move would work. That covers your type (a Normal move into a Ghost, Ground into Flying) and your ability (Levitate, Waterproof, Flame Ward, Grounded, Immunity). Nothing the other parts of the AI favour can override this.
  - After Foresight, Odor Sleuth or Miracle Eye, Normal and Fighting moves can hit Ghosts again, so it uses them. Ghost moves still can't hit Normal types.
  - If every move it can use would fail, it still picks one of them rather than a move that's out of PP or disabled.

## Switching

### Smart switching
While picking its move, it decides to switch out at the start of the turn when:
- it's locked into a move (Choice item or Encore) that:
  - does nothing to your Pokémon (type or ability)
  - is not very effective
  - has no PP left

  This applies at any HP.
- its Accuracy is at -2 or lower

These only apply when it has more than 1/4 of its HP. Otherwise it stays in and takes the hit:
- its main attacking stat (Attack for physical attackers, Sp. Atk for special ones) is at -2 or lower and neither is boosted: 80% of the time
- it's cursed
- it's badly poisoned for 4+ turns: always below half HP, 50% of the time above
- it's seeded by Leech Seed: 30% each turn

For the last four:
- It stays in if it can knock you out this turn. It still switches if you just used Protect or Substitute, or have an intact Focus Sash or Sturdy, because the knock-out isn't sure then.
- It stays in if it's already set up.
- Magic Guard Pokémon ignore curse, poison and Leech Seed.

### Switching by chance
If it didn't decide to switch above, it looks at how its team matches up against you.
- **It wants to switch a lot** when its Perish Song count is about to run out.
- **It wants to switch quite a bit** when, while your attacks are hurting the one that's out, one of its other Pokémon:
  - is immune to the attack you just used, and
  - has a super-effective move against you
- **It wants to switch a little** when:
  - that other Pokémon only has the super-effective move, or
  - there's no immune Pokémon, but one of its Pokémon resists you, has at least 1/4 of its HP and has a super-effective move, while your moves do well against the one that's out

It then switches with a 20%, 50% or 80% chance, depending on how much it wants to. It won't do this while it's at +2 Attack or Sp. Atk, or at 1/4 of its HP or less (it stays in and takes the hit).

### When it won't switch
It never switches out when:
- it's trapped:
  - Mean Look or Spider Web
  - Wrap, Fire Spin, Sand Tomb or Whirlpool
  - your Shadow Tag
  - your Arena Trap, unless it's a Flying type or has Levitate
  - your Magnet Pull, if it's a Steel type

  A Pokémon with Run Away escapes the three abilities, but not the moves.
- it's at +2 or more in Attack, Sp. Atk, Defense or Sp. Def
- it has no other Pokémon left

### Which Pokémon it sends in
After a knock-out, U-turn, Volt Switch, Baton Pass or any of the switches above, it picks, skipping Pokémon that are asleep or frozen:
1. The first Pokémon in its party with a super-effective move against yours
2. Otherwise, the first one that none of your Pokémon's moves hit super effectively
3. Otherwise, a random one

Roar and Whirlwind bring in a random Pokémon.

## Items
Trainers that carry items (never in the Battle Tower) only use them on a turn they don't switch, and only while the Pokémon that's out is their highest-level one (or tied for it). Each item is used on that Pokémon:
- **Potion, Super Potion, Hyper Potion, Max Potion:** used at 1/4 HP or less. Between 1/4 and 1/2 HP, used 20% of the time. Never above half HP.
- **Full Restore:**
  - heals by the same rule as the potions
  - otherwise also used to cure being asleep, or to cure bad poison that has lasted 4+ turns (50% of the time)
- **Full Heal:** cures being asleep, or bad poison that has lasted 4+ turns (50% of the time)
