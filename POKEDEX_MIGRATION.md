# Pokédex Migration

Completely update the Johto Frontier Pokédex using the supplied Pokémon list and asset folders.

## 1. Pokédex Requirements

- Treat the supplied Pokémon list as the single source of truth. This is the file: new_dex_final.asm
- Include every Pokémon in the list.
- Remove every Pokémon not in the list.
- Do not exceed 253 Pokémon.
- Ensure all Pokémon names and species constants are spelled correctly.
- Arrange Pokémon constants in the exact order of the supplied list.
- Ensure all species-indexed tables and data follow the same order.
- Preserve reserved constants, terminators and special species IDs where required by the engine.
- Do not introduce duplicate species.

## 2. Graphics and Audio

Use the supplied asset folders to obtain the correct:
You have full access to the folder and subfolders in the following links.
C:\Users\RaJah239\Desktop\pokemon_sprites for (some may be created on build):
- Front pictures
- Back pictures
- Animations
- Idle animations
- Animation frames and bitmasks

Take base stats, dex entries, footprints, cries and party icons from: C:\cygwin64\home\RaJah239
- If they are missing, create your own viewing present base stats/dex entries/footprints/cries/party icons as examples

Search the supplied external project folders for any additional required assets.

Ensure all Pokémon graphics folders use only the Pokémon's name in lowercase, with no unnecessary prefixes, suffixes, numbers or additional words. Use consistent, valid naming for species with special characters or forms.

Ensure all graphics, animations and cries are correctly integrated and compatible with Johto Frontier.

Do not silently substitute incorrect or missing assets. Report any missing assets.

## 3. Pokémon Data

Ensure every Pokémon has complete and valid data, including:

- Base stats
- Typing
- Abilities (do not add abilties to any pokemon - will be done by the user)
- Catch rate
- Base experience
- Growth rate
- Gender ratio (always 1:1 unless 100% male, 100 female or no gender)
- Held items
- Egg groups
- Level-up moves (fallthrough to "Splash" like most of the pokemon, will be done by the user in the future)
- TM/HM compatibility (leave blank)
- Tutor compatibility (leave blank)
- Egg moves (leave blank)
- Evolutions (don't add - will be done by user)
- Pokédex entries
- Height and weight
- Sprite and animation pointers
- Footprint and cry references

Preserve existing custom Johto Frontier data and mechanics for retained Pokémon.

For new Pokémon, use appropriate canonical data adapted to the existing engine and supported mechanics.

Remove evolution and breeding references to Pokémon that are no longer included. Ensure retained Pokémon remain obtainable.

## 4. Removing Existing Pokémon

Search the entire repository for references to every removed Pokémon.

### Wild Encounters

Replace removed Pokémon with another retained Pokémon already found in the same area.

Preserve encounter levels, encounter rates, table sizes and time-of-day restrictions.

If no suitable retained Pokémon exists in that area, use an appropriate retained Pokémon from a similar habitat.

### Trainer Parties

Remove excluded Pokémon from trainer parties without replacing them.

Preserve the remaining Pokémon and their configurations.

Ensure no trainer has an empty or invalid party. Flag trainers that would otherwise have empty parties for review.

### Battle Tower

Remove the entire Battle Tower roster entry belonging to an excluded Pokémon, including its moves, held item and associated data.

Do not create replacement sets.

Update roster counts, pointers and selection logic where necessary.

### Other References

Check and update all other references, including:

- Gift Pokémon
- Static encounters
- In-game trades
- Starter selections
- NPC scripts
- Overworld Pokémon
- Battle facilities
- Species-specific abilities and items
- Species-specific battle mechanics
- AI logic
- Evolution and breeding tables
- Pokédex ordering and search tables
- Hall of Fame and party data handling

Remove obsolete species-specific code and assets where safe.

Do not remove shared resources still used by retained Pokémon.

## 5. Migration Process

Before editing:

- Inspect the repository and supplied files.
- Validate the Pokémon list and identify retained, removed and new species.
- Identify all species-indexed tables and dependencies.
- Establish a successful baseline build.
- Plan the migration to avoid invalid intermediate species IDs, mismatched tables and exceeding the species limit.

Process one Pokémon addition, removal or replacement at a time.

For each Pokémon:

1. Complete all required data, asset and reference changes.
2. Update all affected tables, pointers and constants.
3. Check for missing, duplicate or invalid references.
4. Build the game.
5. Run available automated tests and relevant runtime checks.
6. Fix all introduced errors and warnings.
7. Commit the completed changes only after successful verification.

Do not commit broken or incomplete changes.

Use short, descriptive commit messages.

If a runtime test cannot be performed, explicitly record that limitation. Never claim an unperformed test passed.

## 6. Final Verification

After completing the migration:

- Verify that the final Pokédex exactly matches the supplied list and order.
- Verify that the species count does not exceed 253.
- Verify all species-indexed table lengths and ordering.
- Verify that no obsolete species references remain.
- Verify all Pokémon have complete data and valid assets.
- Verify wild encounters, trainer parties and Battle Tower rosters.
- Verify evolution and breeding compatibility.
- Check species ID boundaries and reserved values.
- Check ROM and RAM usage.
- Perform a clean build and run all available tests.
- Check for potential save compatibility issues caused by changed species IDs.
- Commit any final corrections.

## 7. General Rules

- Follow AGENTS.md.
- Preserve existing custom mechanics and unrelated content.
- Avoid unnecessary refactoring.
- Keep code efficient and consistent with the repository.
- Do not introduce unsupported mechanics.
- Do not overwrite unrelated uncommitted changes.
- Do not add unnecessary documentation.
- Keep responses concise.
- Do not include AI attribution or links in commits.
- Work autonomously and continue until the migration is complete unless blocked by a decision requiring user input.

Maintain a concise POKEDEX_PROGRESS.md containing completed Pokémon, remaining Pokémon, commits, unresolved issues and testing limitations so another coding session can resume without repeating completed work.
