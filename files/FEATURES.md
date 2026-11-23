# Features
- Newbox, a generation 3 styled box system for Pokémon management
- Nayru62's Super Pokédex: Base stats and info, Move Info (Lvl-Up Moves -> TM -> Move Tutor -> Egg Moves), Detailed area info, Evolution chart, and sprite page showing animated sprites (shiny toggle too!)
- Dex Nav - in Pokédex, press Start and then "Area Search" to find all Pokémon in the area at that present time
- 60 fps overworld
- Overworld weather with particles
- Can't run past spinning Trainers
- Smooth fading added throughout the game
- Unique Pokémon party icons
- Instant Text
- Option to Hold "A" for 30 frames or 1 second to rapid-fire "A" - ~7.5 "A" presses per second
- Option to Hold "B" to rapid-fire "B" - ~7.5 "B" presses per second
- Option to Hold "Start" for 30 frames to save the game in the overworld
- "Pokemon" menu is now the default selected option in the Start menu
- View Pokédex entry of selected Pokémon in Menu
- Time, day and weather added to Start Menu
- Evening added as the fourth time of day (morning: 5am, day: 10am, evening: 5pm, night: 8pm)
- Evening's wild encounters are 60% of the day's 40% of the night's on each encounter
- All overworld encounters are set to 4% per tile stepped on, this doubles to 8% when running or on the bicycle
- Sped up saving significantly
- Press Up and Start on Suicune running screen to bring up the option to delete save file
- Select + B resets the game
- Set time in PokéGear
- "Set Time" added to the Main Menu
- Display seconds in PokéGear and Main Menu
- All Bag pockets loop when scrolling: Up on the first item jumps to the bottom of the list and Down on the last row jumps back to the top
- Fruit and Battle pockets added + colored Bag Tabs for easier navigation
- Press Start to sort items (Custom or Alphabetical) in Pack pockets (Item, Ball, Fruit, Key and Battle) in and out of battles and the PC (TMs can't be sorted but are always in alphabetical order)
- Cheat NPC to New Bark Town
- Colored trainer card badges and added gym leader's names to their pictures
- Exp.Share added to Option Menu - 100% Exp to all participants and 50% to non-participants until the player has entered the Hall of Fame, then the entire party receives 100% experience points
- Color coded starter Pokéballs
- Displays colored Pokémon pictures in over world
- Overworld Porygons added throughout the game for PC access
- Chanseys that heal the player’s party in the overworld added throughout the game
- View present weather on map change
- Default outdoor maps have 35% chance of rain and 35% chance of sun unless it is night with exceptions
- PC usage sped up
- Buena's Password now operates in the evening
- Animate tiles even when textboxes are open
- Survive overworld poisoning with 1 HP
- Fruits and mushrooms respawn every 1,000 steps taken
- Mart inventory changes with badge count
- Show quantity already in Pack at Marts, (TMs don't show quantity)
- Press Down when buying items to get the maximum affordable quantity
- Pessing Down when selling items, max amount that will max money with a minimum of 1
- Link trade Pokémon from the start of the game. Can't trade with vanilla Pokémon Crystal
- Gender corrected Link Battle/Trade Rooms
- Prompt to automatically reuse Repel when one runs out
- Generation 1 fossils added and a NPC to revive them
- Stats option always displayed before field moves
- Press A or B to stop the Bicycle in any downhill environments that forces bike usage
- Show move names for TMs and HMs when receiving or buying
- Name Rater can change traded Pokémon names
- Name Rater and Move Deleter's menu loops to party after use
- With a Suction Cups Pokémon in the party, every fishing rod gets 100% bites
- Allow fishing while surfing
- Headbutting trees, smashing rocks and fishing may yield items if a Pokémon is encountered or not
- Slot Machines payout adjusted
- Voltorb flip added to Game Corner
- Unused Memory Game added to Game Corner
- Eggs can be released via the PC
- Eggs hatch at Level 1
- Egg get laid always after 255 steps
- Daycare man still gives eggs if refused (he didn't in vanilla)
- Eggs are not displayed in the healing machine animaton
- Hatch Room was added to the Day Care out back. Only accessible via Bicycle. The old man appears there if your Pokémon laid any eggs and there’s a Porygon PC as well
- Day care exp gain has been multiplied by 2 to 13, scales with Pokémon level - high level Pokémon is now a viable option
- Daycare owners now say how many levels a Pokémon grew by and what level it is presently
- Pokémon at the daycare gain 1 level per day the player hasn't played the game (minus one, so it doesn't increase every day)
- Daily Mystery Gift NPC
- Swarm system reworked to trigger by talking to a NPC daily
- Correct grammar for plural trainers like Twins
- Item Finder beep frequency is based on distance to closest hidden item
- Releasing the beasts registers Entei, Raikou and Suicune in the Pokédex
- Riakou and Entei are now stationary encounters
- Sacred Ash doesn't check for a fainted Pokémon to be activated
- "Call" items added that have the same effect as vanilla Crystal's HMs and surfing Pikachu still has a unique sprite
- Moves Tutors, Move Relearner and Egg Tutor
- Trade Back NPC added in Mahogany Town to evolve all Pokémon that require it
- TMs are not infinite use by design choice but all can be obtained infinitely via the Battle Plaza's mart when the original is found/obtained in the Johto
- Cianwood City daily photographer - raises happiness
- All status conditions boost catch rate of all Pokémon
- Can Teleport to the last visited Pokémon Centre from anywhere
- Press A to use Flash in dark caves after obtaining the Mareep Call
- Press Start to skip Credits

## Randomness (RNG)
Everything random in a battle comes from one random number generator that is saved with your game: damage rolls, critical hits, accuracy, extra effects, the AI's tie-breaks, its 10% "don't pivot" chance, which Pokémon Roar sends in, wild encounters, shinies and so on. Link battles are the exception: they use a separate generator shared by both Game Boys so the two stay in sync. Weather particles (falling rain, snow and so on) also have their own, but they're only for looks.

**What it means for you: resetting doesn't reroll anything.**
- Think of the generator as a long, fixed list of random numbers. Each time the game needs one, it takes the next number off the list.
- When you save, the game also saves *where you are in the list*.
- When you load that save, you're back at the same spot. Do exactly the same things and you get exactly the same results: the same damage, the same crits, the same AI choices, the same shiny (or not).
- So "save, try, reset, try again" gives the same outcome every time.

**How to get a different result**
Use up different numbers before the moment that matters. Anything that asks for a random number moves you along the list, so doing things in a different order changes what comes next:
- choose different moves, or switch at a different time
- walk around first (wandering NPCs and encounter checks use numbers)
- or keep playing and save somewhere else

**What doesn't change**
The odds are the same as before. A 10% chance is still 10%; only rerolling by resetting is gone.

**Where the first number comes from**
A new game picks its starting point from the console's timing, so every playthrough gets its own list.

Shiny Pokémon — especially stationary: A mon's shininess comes from the DVs rolled when the encounter starts, so it's part of this sequence.

- Before: save in front of the legend → check → soft reset → a fresh shiny roll every attempt.
- Now: the roll is tied to your save point. Reload and repeat your steps and you get the identical result every time — resetting can no longer reroll a stationary (or wild) shiny.
- Getting a different roll means actually advancing the RNG — keep playing and save at a new point, or do different things between loading and the encounter — not just resetting.
- In short: catching it shiny is still possible, but "reset until it pops" is gone.

## Battle Related
- Type Chart changes: Ice resists Water and Electric
- "Move Dex" item added that displays all moves and their details
- Items forbidden and forced Set Mode for all trainers
- Trainers have no items to use on their Pokémon - just as the player
- Trainers have max PP on all their moves
- Fairy Type added
- Press UP+START in any battle or encounter to open the type chart
- Frostbite replaced Freeze status
- Scaled (higher level foes = more experience to lower level Pokémon) and Zero experience options added 
- Print stat gain on level up
- Max level of Pokémon is 50
- All Pokémon obey regardless if traded or not
- Can't run from wild Shiny Pokémon
- Shiny Pokémon, like all other Pokémon can have all hidden power types except Normal and Fairy
- Shiny Pokémon chance are now 1/256
- Shiny icon added for both player and enemy's Pokémon in battle
- Shiny icon added to naming screen
- Wild Pokémon drop held items after battle (no need to steal/trick/capture)
- Press Start in Battle Menu to go straight to the Pokémon menu
- Press Select to view enemy types in Battle Menu
- Displays type effectiveness in Battle Menu
- Push B in Battle Menu to go to the bottom right option (Run/Info)
- Quadruple effective and ineffective battle texts added
- Removed vanilla Crystal's the 25% failure chance for AI status moves
- Removed vanilla Crystal's the Gym badges boosts
- Stat screen Condition added to display levels of happiness
- Fourth stat page added with Abilities and Press Select to view caught time, level, location, effort values per stat, core trait (hidden power type)
- Move Pokémon in party menu with Select button (only outside battles)
- Can swap held items of Pokémon outside of battles
- Battle HUD Update
- All Pokémon DVs get calculated as 15 per stat
- Show an icon for the current weather and time of day in battle
- Display if items are held in battles
- Option to check the Stats of Pokémon when forced switching
- Physical/Special split added to moves
- Print perfect accuracy as "---"
- Added "Moves" to Menu Option in battle
- Transform gives full PP instead of a flat 5
- Short beeping noise for low HP
- Pokémon asleep last 1-3 turns
- Pokéball's pocket set to default in wild encounters
- Use unique Pokéball graphics in addition to caught ball icon in each Pokémon's status menu
- Gain experience from catching Pokémon
- Effort Values replace Stat Experience, but can max all stats
- Can max out Effort Values on all stats either by battle or item usage alone
- Earned Effort Values are applied to stats after each battle
- Don't gain experience at max level but still get Effort Values
- Trainer's Effort Values scale based on owned badges
- Levitating (up arrow) icon added in Status Screen, Pokédex and Battle
- Upon learning a 5th move, can press Down to view the move's details 
- Can rematch any overworld trainer infinitely
- Lose money proportional to number of badges and lead level Pokémon on whiteout
- Quick Claw now has an activation text
- Prevent burning fire types and frostbite on ice types
- Burn and frostbite deal 1/16 max HP of damage each turn
- Toxic never misses when used by a Poison type
- Electric types can't be paralyzed
- Display TOX instead of PSN if badly poisoned
- Trapping moves do 1/8 damage each turn
- Confusion self-hit chance set to 33% (no longer 50%)
- Grass type Pokémon are immune to Powder/Spore based moves
- Sandstorm raises the Special Defense of Rock type Pokémon by 50%
- Hail raises the Defense of Ice type Pokémon by 50%
- Can use Protect or King's Shield behind Substitute
- Music resumes where it left off after a battle
- While Pokemon are asleep, all moves can't miss
- Reduced happiness required for Pokémon that evolve via happiness
- Life Orb still reduces HP with Pokémon that has Magic Guard ability
- Amulet Coin doubles earnings regardless of Pokémon equipping it


## - Battle Factory
-  Mode in the Battle Tower for both Elite and Champ selection: keep six level-50 rentals for three battles, optionally exchange up to two before entering and after each of the first two wins, and inspect summaries with Start.
- Entry offers are one fresh set of six; later offers come from the just-defeated team.
- Between battles, the attendant asks whether to adjust your party.
- After exchanging, review the final team before continuing.
- Select marks a rental to reorder; move to another rental and press Select or A to swap their positions, or B to cancel.

## Modern Critical hits
- Critical hits now have a 1.5× damage multiplier, or 2.25× with Sniper.
- Critical-hit odds are 1/24 at stage +0, 1/8 at +1, 1/2 at +2, and guaranteed at +3. Focus Energy, Scope Lens, Super Luck, and high-critical-hit moves stack toward that cap.
- A critical hit ignores the attacker’s negative stat stages and the defender’s positive stat stages. It also bypasses Reflect and Light Screen.
- Positive offensive stages, negative defensive stages, and other applicable effects—including burn, frostbite, weather, items, and abilities—still apply.

## Critical Capture
- It triggers randomly when you throw a ball
- You need at least 31 different species registered as caught in your Pokédex. Seen Pokémon and duplicate catches don’t increase that count
- Your chance improves as your caught count reaches 31, 101, 151, 201, and 251 species. Lower HP, status conditions, and better ball bonuses also improve the chance
-  Any Pokémon can be your active Pokémon. Giving that active Pokémon a Catch Charm doubles the critical-capture trigger chance. Keeping the charm in your bag doesn’t count
- No special ball is required. Poké Balls, Great Balls, Ultra Balls, and other balls using the normal catch calculation can trigger it. Master Balls bypass the critical-capture check
- What you hear: a short, high-pitched electronic chirp replaces the normal throwing sound
- What you see: after the Pokémon enters the ball, the ball briefly shakes sideways in midair, then lands and shakes once, instead of the usual three ground shakes
- It can still fail. A critical capture gives improved capture odds through a single success check; it does not guarantee a catch. There’s no separate “Critical capture!” message

## Bug Fixes
- All known vanilla Bugs and Glitches Fixes
- Basic Design Flaws
