# Johto Frontier — Comprehensive Repository Audit and Optimisation

## 1. Primary Objective

Act as a senior Game Boy Color software engineer with extensive expertise in:

- Game Boy and Game Boy Color hardware architecture.
- Sharp SM83 assembly language.
- RGBDS assembly.
- The pokecrystal disassembly.
- CPU instruction and machine-cycle optimisation.
- ROM banking and memory management.
- WRAM, HRAM, SRAM and VRAM management.
- Pokémon battle engine mechanics.
- Software debugging and regression testing.
- Git version control.
- Software architecture and code refactoring.

Your objective is to comprehensively audit, debug, optimise and improve the entire Johto Frontier repository.

Make Johto Frontier as fast, stable, reliable, memory-efficient and maintainable as reasonably possible within the limitations of Game Boy Color hardware.

Actively identify and eliminate bugs, inefficiencies, unnecessary processing, memory waste, crashes, freezes, softlocks and unintended behaviour.

This is an implementation project, not merely a code review. You are expected to directly implement verified fixes and optimisations.

## 2. Permanent Operating Rules

The following rules apply throughout the entire project:

1. Correctness takes priority over performance.
2. Stability takes priority over minor optimisations.
3. Preserve all intentional gameplay mechanics.
4. Preserve existing save compatibility.
5. Do not introduce unnecessary new features.
6. Do not rebalance Pokémon, moves, abilities, items or gameplay mechanics.
7. Do not remove functionality to improve performance.
8. Do not assume differences from vanilla pokecrystal are bugs.
9. Do not make speculative changes without supporting evidence.
10. Do not overwrite unrelated user changes.
11. Do not perform destructive Git operations.
12. Work in small, independently verifiable batches.
13. Prefer measurable improvements over theoretical improvements.
14. Do not suppress compiler warnings merely to achieve a clean build.
15. Safely undo unsuccessful optimisations that introduce regressions.
16. Preserve intentional visual effects, animations, audio and gameplay pacing.
17. Do not sacrifice hardware compatibility.
18. Do not introduce unnecessary abstractions.
19. Do not rewrite working code solely for stylistic reasons.
20. Never claim that a test was performed unless it was actually performed.
21. Never claim that the game is completely bug-free without sufficient evidence.
22. Request user approval before changing intended gameplay behaviour or undertaking high-risk architectural changes.
23. Continue autonomously whenever possible.
24. Do not require the user to manually manage routine Git commits.

The existing intentional behaviour of Johto Frontier is the authoritative gameplay specification.

## 3. Session Startup and Continuation

At the beginning of every session:

1. Read this entire document.
2. Read CLAUDE.md, AGENTS.md and OPTIMISATION_RULES.md if they exist.
3. Inspect the current Git branch.
4. Inspect the working tree.
5. Inspect recent Git commits.
6. Identify uncommitted changes.
7. Review the current audit progress.
8. Identify where the previous AI session ended.
9. Investigate any unfinished work.
10. Verify that the current ROM builds successfully.
11. Resume the next outstanding task.

Do not unnecessarily repeat completed work.

Do not blindly trust modifications made by previous AI sessions. Verify relevant assumptions when necessary.

This project may alternate between Claude Code and OpenAI Codex. Maintain sufficient documentation for either AI to continue without access to previous conversations.

If previous work is incomplete, investigate and safely resolve it before beginning unrelated modifications.

Do not overwrite, discard or commit pre-existing user modifications without authorisation.

## 4. Initial Repository Analysis

Before making significant changes:

- Analyse the repository's architecture.
- Understand the build system.
- Identify major engine components.
- Identify custom mechanics.
- Understand how different systems interact.
- Examine relevant Git history.
- Inspect existing documentation and comments.
- Identify frequently executed routines.
- Identify potential performance bottlenecks.
- Identify memory constraints.
- Identify existing compiler warnings.
- Identify suspicious or potentially unsafe code.
- Establish a successful baseline build.
- Determine available testing and profiling tools.
- Record the exact build commands.

Record baseline measurements for:

- Total ROM size.
- Used ROM space.
- Free ROM space.
- ROM bank utilisation.
- WRAM usage.
- WRAM bank utilisation.
- HRAM usage.
- SRAM usage.
- Existing compiler warnings.
- Available performance measurements.
- Build configuration.
- RGBDS version, where available.

Do not invent measurements. Mark unavailable measurements accordingly.

## 5. Comprehensive Bug Audit

Systematically inspect the entire repository for potential bugs.

Investigate:

- Incorrect register usage.
- Unintentionally overwritten registers.
- Incorrect CPU flag handling.
- Incorrect carry flag handling.
- Incorrect zero flag handling.
- Incorrect signed and unsigned comparisons.
- Stack corruption.
- Unbalanced push and pop instructions.
- Incorrect jumps.
- Incorrect calls and returns.
- Incorrect tail calls.
- Incorrect farcalls and farjumps.
- Incorrect ROM bank switching.
- Incorrect WRAM bank switching.
- Incorrect SRAM bank switching.
- Invalid memory accesses.
- Memory corruption.
- Buffer overflows.
- Buffer underflows.
- Integer overflows.
- Integer underflows.
- Off-by-one errors.
- Incorrect loop termination.
- Infinite loops.
- Uninitialised variables.
- Variables not being properly reset.
- Stale variable values.
- Incorrect pointer arithmetic.
- Invalid table indexes.
- Incorrect table lengths.
- Incorrect bit manipulation.
- Incorrect constants.
- Incorrect event flags.
- Incorrect state transitions.
- Interrupt-related issues.
- Timing-related issues.
- Race conditions involving interrupts.
- Save file corruption.
- Crashes.
- Freezes.
- Softlocks.
- Incorrect handling of unusual edge cases.
- Interactions between independently implemented custom features.

Trace suspicious routines through their callers and dependencies before implementing fixes.

Verify register preservation, CPU flags, stack balance, memory state and banking behaviour.

Fix confirmed bugs rather than merely documenting them.

If intended behaviour is ambiguous, record the issue and request clarification when necessary.

## 6. CPU Performance Optimisation

Optimise the game to execute as efficiently as possible on actual Game Boy Color hardware.

Prioritise frequently executed routines and areas where players experience noticeable delays.

Investigate opportunities to:

- Reduce CPU machine cycles.
- Eliminate redundant instructions.
- Eliminate unnecessary register loads.
- Eliminate unnecessary register transfers.
- Reduce unnecessary memory reads.
- Reduce unnecessary memory writes.
- Reduce unnecessary push and pop operations.
- Reduce unnecessary function calls.
- Reduce unnecessary farcalls.
- Reduce unnecessary ROM bank switches.
- Apply safe tail-call optimisations.
- Simplify conditional branches.
- Improve branch ordering where beneficial.
- Optimise loops.
- Optimise arithmetic operations.
- Optimise multiplication routines.
- Optimise division routines.
- Replace expensive calculations with efficient equivalent operations.
- Cache frequently accessed values where safe.
- Improve table lookup efficiency.
- Eliminate repeated calculations.
- Improve register allocation.
- Improve frequently executed memory-copying routines.
- Improve frequently executed memory-clearing routines.
- Use HRAM efficiently.
- Improve frequently executed battle and overworld routines.

Evaluate instruction timing using the correct SM83 instruction timings.

Calculate before-and-after machine-cycle counts for meaningful optimisations where practical.

Consider both taken and untaken conditional branches.

Do not assume that shorter assembly code is necessarily faster.

Do not optimise a routine in isolation without considering its callers.

Preserve all required registers, flags, banking behaviour, interrupt safety and side effects.

Do not sacrifice correctness for speed.

## 7. ROM and Memory Optimisation

Audit and optimise memory usage throughout the repository.

Investigate:

- Duplicate routines.
- Duplicate data.
- Unreachable code.
- Unused routines.
- Unused variables.
- Unused constants.
- Unnecessary data tables.
- Redundant data structures.
- Inefficient data structures.
- Excessive ROM bank switching.
- Poor ROM bank organisation.
- Unnecessary WRAM allocations.
- Variables with non-overlapping lifetimes that can safely share memory.
- Opportunities to improve HRAM utilisation.
- Inefficient SRAM usage.
- Unnecessary memory copying.
- Unnecessary memory clearing.
- Excessive temporary storage.
- Inefficient lookup tables.
- Excessive stack usage.

Only remove code or data after confirming that it is not referenced directly or indirectly.

Account for references through:

- Pointers.
- Jump tables.
- Function tables.
- Scripts.
- Macros.
- Conditional compilation.
- Computed addresses.
- Banked calls.
- Data tables.

Change save file layouts or break existing save compatibility as needed - this is the start of the ROM hack.

Where execution speed and ROM size conflict:

- Prioritise execution speed in frequently executed routines.
- Prioritise ROM efficiency in infrequently executed routines.
- Document significant trade-offs.

Do not move variables between memory regions without verifying their complete usage and lifetime.

## 8. Battle Engine Audit

The battle engine is a critical component of Johto Frontier and must receive especially thorough attention.

Inspect, debug and optimise:

- Damage calculations.
- Critical hits.
- Accuracy.
- Evasion.
- Move priority.
- Speed calculations.
- Speed ties.
- Type effectiveness.
- Physical and special move handling.
- Stat stages.
- Stat modifiers.
- Status conditions.
- Volatile status conditions.
- Frostbite.
- Weather.
- Entry hazards.
- Abilities.
- Dual-ability interactions.
- Held items.
- Switching.
- Forced switching.
- Fainting.
- End-of-turn effects.
- Start-of-turn effects.
- Multi-hit moves.
- Recoil.
- Recovery.
- Substitute.
- Protect.
- Trick Room.
- Move-specific effects.
- Ability-specific effects.
- Item-specific effects.
- Experience calculations.
- Level scaling.
- Capture mechanics.
- Critical capture.
- Random number generation.
- Battle animations.
- Battle text.
- Battle menus.
- Battle information displays.
- Trainer battles.
- Wild battles.
- Battle facility battles.

Pay particular attention to:

- Effect activation order.
- Simultaneous effects.
- Interactions between two abilities.
- Ability and item interactions.
- Ability and move interactions.
- Weather and ability interactions.
- Entry hazard interactions.
- Switching and fainting interactions.
- Effects that activate more than once.
- Effects that fail to activate.
- Effects activating at incorrect times.
- Variables that persist incorrectly between turns.
- Variables that persist incorrectly between Pokémon.
- Variables that persist incorrectly between battles.
- Differences between player-side and enemy-side behaviour.

Test both sides of the battle.

Preserve all intentional custom mechanics, including mechanics that differ from official Pokémon games.

## 9. Battle AI Audit and Optimisation

Thoroughly inspect the trainer AI.

Investigate:

- Move scoring.
- Switching decisions.
- Damage estimation.
- KO detection.
- Speed comparisons.
- Priority detection.
- Type effectiveness calculations.
- Ability awareness.
- Held-item awareness.
- Recovery decisions.
- Setup decisions.
- Status move decisions.
- Hazard decisions.
- Weather decisions.
- Trick Room decisions.
- Choice-locked move handling.
- Immunity detection.
- Trainer AI flags.
- Boss-specific AI behaviour.
- Redundant calculations.
- Incorrect assumptions.
- Potential switching loops.
- Invalid move selection.
- Ineffective move selection.
- Incorrect switching predictions.
- Unnecessary repeated damage calculations.
- Unnecessary repeated type calculations.
- Unnecessary repeated ability checks.

Optimise the AI's execution time without reducing its intelligence or intended decision-making quality.

Preserve the existing intended AI difficulty and information-access rules.

Do not introduce access to player inputs or information that the AI is not intended to possess.

Verify that optimisations do not unintentionally alter AI decisions.

Where random decisions are involved, use controlled testing or reproducible random seeds where practical.

## 10. Overworld Engine Audit

Audit, debug and optimise:

- Map loading.
- Map transitions.
- Warp handling.
- Player movement.
- Running.
- Cycling.
- Collision detection.
- Wild encounters.
- Encounter rate modifiers.
- NPC movement.
- Object movement.
- Event scripts.
- Script execution.
- Event flags.
- Map callbacks.
- Field effects.
- Time-based events.
- Day and night systems.
- Environmental effects.
- Sprite loading.
- Graphics loading.
- Overworld animations.
- Trainer encounters.
- Trainer sight detection.
- Transportation systems.
- Teleportation.
- Battle transitions.

Identify unnecessary delays and redundant processing.

Preserve intentional gameplay pacing and animation timing.

## 11. Menu and Interface Audit

Audit, debug and optimise:

- Main menus.
- Start menu.
- Options menu.
- Battle menus.
- Inventory management.
- Item pockets.
- Item sorting.
- Item usage.
- Shops.
- Buying items.
- Selling items.
- Bulk purchases.
- Quantity selection.
- Money calculations.
- Pokédex.
- Pokémon party management.
- Pokémon summary screens.
- PC storage.
- Pokémon selection screens.
- Move selection screens.
- Move learning.
- Move deletion.
- Text rendering.
- Text scrolling.
- Input handling.
- Cursor movement.
- Menu transitions.
- Graphics loading.
- Sprite handling.

Investigate:

- Unnecessary screen redraws.
- Unnecessary memory copying.
- Slow menu transitions.
- Redundant calculations.
- Incorrect cursor positions.
- Invalid menu selections.
- Incorrect quantity limits.
- Incorrect money calculations.
- Inventory overflows.
- Incorrect handling of empty lists.
- Incorrect handling of full lists.

Improve responsiveness without removing intentional functionality.

## 12. Pokémon Data and Content Validation

Audit game data for structural errors and inconsistencies.

Inspect:

- Pokémon species tables.
- Base stats.
- Typing.
- Ability assignments.
- Evolution data.
- Learnsets.
- Egg moves.
- TM compatibility.
- Move tutor compatibility.
- Pokémon sprites.
- Pokémon palettes.
- Pokémon cries.
- Pokédex entries.
- Move data.
- Item data.
- Trainer parties.
- Trainer AI flags.
- Wild encounter tables.
- Shop inventories.
- Map scripts.
- Event data.
- Text pointers.
- Graphics pointers.
- Animation data.

Verify that:

- Table lengths match their expected constants.
- Species indexes are valid.
- Move indexes are valid.
- Item indexes are valid.
- Pointers reference valid data.
- Required terminators exist.
- Data structures match their consuming routines.
- Removed species or features do not leave invalid references.
- Custom content does not exceed engine limitations.

Create automated data-validation scripts where practical.

Do not alter intentional Pokémon balance or content decisions.

## 13. Battle Facility Audit

Inspect all battle facilities and custom challenges.

Investigate:

- Facility entry.
- Facility exit.
- Challenge initialisation.
- Challenge progression.
- Battle generation.
- Opponent selection.
- Pokémon selection.
- Level scaling.
- Randomisation.
- Rewards.
- Score calculations.
- Score displays.
- Inventory restrictions.
- Party restrictions.
- Challenge resets.
- Victory handling.
- Defeat handling.
- Interrupted challenges.
- Saving and loading.
- Event flag handling.
- Restoration of player state.

Verify that entering or leaving a facility cannot corrupt the player's party, inventory, money, save data or progression.

Investigate potential exploits, crashes and softlocks without changing intentional facility rules.

## 14. Save System and Data Integrity

Thoroughly inspect:

- Saving.
- Loading.
- Save checksums.
- SRAM banking.
- Save data initialisation.
- New game initialisation.
- Party data.
- PC storage data.
- Inventory data.
- Money.
- Event flags.
- Player options.
- Battle facility progress.
- Persistent variables.

Verify that:

- Existing saves remain compatible.
- Saving does not corrupt unrelated data.
- Loading correctly restores game state.
- Temporary variables are not incorrectly persisted.
- Persistent variables are not incorrectly cleared.
- Memory copies use correct lengths.
- Save-related pointers are valid.
- SRAM banks are correctly selected and restored.

Use disposable test saves when performing automated testing.

Never overwrite the user's personal save files.

## 15. Graphics and Audio Audit

Inspect and optimise:

- Graphics decompression.
- Graphics loading.
- Tile transfers.
- Tilemap updates.
- VRAM transfers.
- OAM updates.
- Sprite handling.
- Palette handling.
- Pokémon animations.
- Battle animations.
- Overworld animations.
- Screen transitions.
- Audio engine routines.
- Music playback.
- Sound effects.
- Pokémon cries.
- Audio-related options.

Investigate unnecessary transfers, repeated calculations and avoidable delays.

Preserve intentional visual appearance, animation timing and audio behaviour.

Do not remove effects or reduce visual quality merely to improve performance.

## 16. Hardware Compatibility

Ensure all modifications remain compatible with actual Game Boy Color hardware.

Pay particular attention to:

- VRAM access restrictions.
- OAM access restrictions.
- VBlank timing.
- LCD timing.
- Interrupt handling.
- DMA operations.
- Hardware register behaviour.
- ROM banking.
- WRAM banking.
- SRAM banking.
- Stack usage.
- Frame timing.
- CPU speed modes.
- Hardware-specific instruction behaviour.
- Timing-sensitive routines.

Do not rely on behaviour that works only because an emulator is overly permissive.

Investigate whether performance improvements affect timing-sensitive hardware operations.

If physical hardware testing is unavailable, explicitly document this limitation.

## 17. Code Quality and Maintainability

Improve the overall quality of the codebase by:

- Simplifying unnecessarily complicated routines.
- Consolidating genuinely duplicated logic.
- Improving misleading labels.
- Improving misleading comments.
- Documenting complicated custom routines.
- Documenting register requirements where useful.
- Documenting important side effects.
- Removing obsolete comments.
- Improving consistency with existing repository conventions.
- Reducing unnecessary dependencies.
- Improving readability where doing so does not negatively affect performance.

Avoid cosmetic rewrites that provide no meaningful benefit.

Do not introduce unnecessary abstractions.

Do not restructure working systems merely for stylistic reasons.

Do not create excessively large refactoring commits.

## 18. Testing and Regression Prevention

Testing is mandatory.

Before modifying a system, establish its existing behaviour wherever practical.

After every logical batch of changes:

1. Inspect the Git diff.
2. Rebuild the ROM.
3. Check for compiler errors.
4. Check for new compiler warnings.
5. Check ROM and RAM usage.
6. Verify affected routines.
7. Verify affected callers.
8. Verify register preservation.
9. Verify CPU flag behaviour.
10. Verify stack balance.
11. Verify memory and banking behaviour.
12. Run relevant automated tests.
13. Perform emulator-based tests where available.
14. Test normal behaviour.
15. Test unusual edge cases.
16. Check for unintended behavioural changes.
17. Confirm that the modification achieves its intended improvement.
18. Update this audit document.
19. Create a Git commit.

Create automated regression tests, debugging tools, profiling tools and validation scripts where practical.

A successful compilation is not sufficient evidence that a change is correct.

Where possible, compare original and modified behaviour using equivalent initial conditions.

Distinguish between:

- Successful compilation.
- Static verification.
- Automated testing.
- Emulator testing.
- Physical hardware testing.
- Manual testing still required.

Never fabricate test results.

If necessary testing is unavailable, document the limitation. Do not mark the affected behaviour as fully verified.

Do not commit high-risk behavioural changes that cannot be adequately verified without obtaining approval.

## 19. Mandatory Git Commit Policy

You are authorised and required to create local Git commits autonomously throughout the entire optimisation project.

Follow these rules:

1. Create a Git commit after every successfully completed and verified logical batch of changes.
2. Do not wait until an entire audit phase is completed before committing.
3. Ensure the ROM builds successfully before committing code changes.
4. Perform relevant regression tests before committing.
5. Never knowingly commit broken or incomplete code.
6. Keep commits small, focused and independently reversible.
7. Do not combine unrelated fixes or optimisations into a single commit.
8. Write clear, descriptive commit messages.
9. Update OPTIMISATION_AUDIT.md before each commit.
10. Include relevant audit updates in the corresponding commit.
11. Inspect the Git diff before committing.
12. Inspect the staged diff before committing.
13. Stage only files and changes related to the completed task.
14. Do not commit unrelated user changes.
15. Do not commit generated ROMs.
16. Do not commit temporary files or unnecessary build artifacts.
17. Do not amend existing commits.
18. Do not squash existing commits.
19. Do not delete existing commits.
20. Do not rewrite Git history.
21. Do not perform destructive Git operations.
22. Do not merge branches without explicit permission.
23. Do not push changes to remote repositories without explicit permission.
24. Do not request approval for routine local Git commits.
25. Verify that each commit was successfully created.
26. Automatically continue with the next outstanding task after each successful commit.
27. Do not leave successfully completed work uncommitted.
28. Do not require the user to manually manage commits.

Avoid indiscriminately staging the entire working tree when unrelated modifications exist.

If an optimisation fails verification, safely undo only your own unsuccessful changes and investigate the failure.

If a Git operation fails, investigate and resolve the issue without performing destructive operations.

### Commit Message Conventions

Use the following prefixes:

- `fix:` Confirmed bug fixes.
- `perf:` CPU and execution speed optimisations.
- `memory:` ROM, WRAM, HRAM or SRAM optimisations.
- `refactor:` Code restructuring without behavioural changes.
- `test:` Regression tests and validation tools.
- `docs:` Documentation and audit updates.
- `build:` Build system improvements.

Example commit messages:

- `fix: preserve registers during battle ability checks`
- `perf: optimise AI damage estimation`
- `memory: eliminate redundant WRAM allocations`
- `fix: prevent incorrect hazard activation`
- `perf: reduce unnecessary ROM bank switches`
- `refactor: consolidate duplicated battle routines`
- `test: add battle mechanic regression tests`
- `docs: establish repository optimisation baseline`

Git commits are mandatory throughout this project.
Do not add links or that this was done via AI in commits or the repo's comments.

## 20. Autonomous Execution

You are authorised to:

- Read repository files.
- Inspect repository history.
- Edit repository files.
- Create supporting documentation.
- Create testing scripts.
- Create validation scripts.
- Create profiling tools.
- Execute build commands.
- Execute relevant tests.
- Inspect build outputs.
- Inspect memory maps.
- Create local Git commits.

Work autonomously through the audit phases.

Do not stop after presenting an analysis, recommendation or implementation plan.

Do not repeatedly ask whether you should continue.

Do not request approval for routine, low-risk fixes and optimisations.

Request approval only when:

- Intended gameplay behaviour is ambiguous.
- A high-risk architectural change is required.
- Save compatibility may be affected.
- A potentially destructive operation is required.
- Necessary permissions or tools are unavailable.
- An important decision cannot reasonably be made from existing repository information.

Continue working until the audit is complete, a genuine blocker is encountered or the session cannot continue.

## 21. Claude Code and Codex Compatibility

This project may be worked on by multiple AI coding agents across separate sessions.

Claude Code and OpenAI Codex must use this document as the shared source of instructions and progress.

Maintain CLAUDE.md and AGENTS.md in the repository root, preserving any existing instructions.

Both files should instruct the respective AI to read OPTIMISATION_AUDIT.md before undertaking optimisation work.

Every AI must:

- Review previous findings.
- Review previous commits.
- Review unfinished modifications.
- Preserve verified improvements.
- Follow the same optimisation requirements.
- Follow the same testing requirements.
- Follow the same Git commit policy.
- Maintain the same progress tracker.
- Record outstanding risks.
- Record the next recommended task.
- Avoid unnecessarily repeating completed work.

Do not assume previous AI changes are correct without appropriate verification.

Do not have multiple AI agents simultaneously modify the same working directory.

## 22. Session Handover Requirements

Continuously update this document rather than waiting until the end of a session.

After every completed task, record:

- The system inspected.
- The issue investigated.
- The findings.
- The modifications made.
- The files affected.
- The reason for the modification.
- The performance improvement, if applicable.
- The memory improvement, if applicable.
- The tests performed.
- The test results.
- Remaining risks.
- Manual testing requirements.
- The next recommended task.

Record the current task before beginning substantial modifications.

This ensures another AI can investigate unfinished work if the current session unexpectedly ends.

When possible, before ending a session:

- Complete the current logical batch.
- Rebuild the ROM.
- Perform relevant tests.
- Update this document.
- Commit verified changes.
- Record unfinished work.
- Record the next outstanding task.

If a session ends unexpectedly, the next AI must inspect the actual Git working tree rather than relying exclusively on the last recorded progress.

## 23. Audit Execution Phases

Complete the project systematically using the following phases.

### Phase 1 — Repository Analysis and Baseline

- [x] Understand repository architecture.
- [x] Inspect build system.
- [x] Establish baseline build.
- [x] Record ROM usage.
- [x] Record WRAM usage.
- [x] Record HRAM usage.
- [x] Record SRAM usage.
- [x] Record compiler warnings.
- [x] Identify available testing tools.
- [x] Identify major performance bottlenecks.
- [x] Establish audit infrastructure.
- [x] Commit baseline documentation.

### Phase 2 — Critical Stability Issues

- [x] Audit crashes.
- [x] Audit freezes.
- [x] Audit softlocks.
- [x] Audit memory corruption.
- [x] Audit stack corruption.
- [x] Audit register corruption.
- [x] Audit ROM banking.
- [x] Audit RAM banking.
- [x] Audit interrupt safety.
- [x] Audit invalid memory accesses.

### Phase 3 — Battle Engine Correctness

- [x] Audit damage calculations.
- [x] Audit critical hits.
- [x] Audit accuracy and evasion.
- [x] Audit speed and priority.
- [x] Audit stat calculations.
- [x] Audit status conditions.
- [x] Audit abilities.
- [x] Audit dual-ability interactions.
- [x] Audit held items.
- [x] Audit weather.
- [x] Audit entry hazards.
- [x] Audit switching.
- [x] Audit fainting.
- [x] Audit end-of-turn effects.
- [x] Audit move effects.
- [x] Audit experience.
- [x] Audit level scaling.
- [x] Audit capture mechanics.
- [x] Audit battle state initialisation and cleanup.

### Phase 4 — Battle AI

- [x] Audit move scoring.
- [x] Audit switching decisions.
- [x] Audit damage estimation.
- [x] Audit KO detection.
- [x] Audit AI speed calculations.
- [x] Audit ability awareness.
- [x] Audit item awareness.
- [x] Audit trainer AI flags.
- [x] Eliminate redundant calculations.
- [x] Optimise AI execution speed.
- [x] Verify AI decision quality.

### Phase 5 — CPU Performance

- [x] Identify frequently executed routines.
- [x] Optimise battle routines.
- [x] Optimise overworld routines.
- [x] Optimise arithmetic routines.
- [x] Optimise loops.
- [x] Optimise memory operations.
- [x] Optimise register usage.
- [x] Optimise banked calls.
- [x] Investigate safe tail calls.
- [x] Record measurable cycle savings.

### Phase 6 — ROM and RAM Optimisation

- [x] Audit ROM bank utilisation.
- [x] Audit WRAM bank utilisation.
- [x] Audit HRAM utilisation.
- [x] Audit SRAM utilisation.
- [x] Investigate duplicate routines.
- [x] Investigate duplicate data.
- [x] Investigate unused code.
- [x] Investigate unused variables.
- [x] Investigate safe memory sharing.
- [x] Record memory savings.

### Phase 7 — Overworld and Interface

- [x] Audit movement.
- [x] Audit map loading.
- [x] Audit map transitions.
- [x] Audit wild encounters.
- [x] Audit NPC behaviour.
- [x] Audit scripts.
- [x] Audit menus.
- [x] Audit inventory.
- [x] Audit shops.
- [x] Audit Pokédex.
- [x] Audit party management.
- [x] Audit PC storage.
- [x] Audit input handling.
- [x] Audit text rendering.

### Phase 8 — Data and Remaining Systems

- [x] Audit Pokémon data.
- [x] Audit move data.
- [x] Audit item data.
- [x] Audit trainer data.
- [x] Audit encounter data.
- [x] Audit battle facilities.
- [x] Audit save system.
- [x] Audit graphics engine.
- [x] Audit audio engine.
- [x] Audit hardware compatibility.
- [x] Create data-validation tools where practical.

### Phase 9 — Code Quality

- [x] Investigate duplicated logic.
- [x] Simplify unnecessarily complicated routines (QUAL-001 and BUG-024).
- [x] Improve misleading comments.
- [x] Document complex custom routines (AI score dispatch and the healing-search cursor contract, TEST-096/097).
- [x] Remove confirmed obsolete code.
- [x] Verify all refactoring changes.

### Phase 10 — Comprehensive Regression Testing

- [x] Perform full repository build.
- [x] Run available automated tests.
- [x] Run available data-validation scripts.
- [x] Perform available emulator tests.
- [x] Test custom battle mechanic interactions.
- [x] Test battle AI.
- [x] Test overworld systems.
- [x] Test menus.
- [x] Test save compatibility.
- [x] Test battle facilities (opponent loading, pool boundaries and data; MT-003 covers the room).
- [x] Review hardware compatibility.
- [x] Document outstanding manual testing requirements (Section 32).

### Phase 11 — Final Independent Review

- [x] Review all optimisation commits.
- [x] Review all bug-fix commits.
- [x] Review potential regressions.
- [x] Verify final build.
- [x] Verify final memory usage.
- [x] Verify performance improvements.
- [x] Review outstanding risks.
- [x] Produce final audit report (Section 33, TEST-098–106).

Additional tasks may be added when necessary.

Do not mark a task complete merely because its files have been read. Record the actual verification performed.

## 24. Baseline Measurements

Populate this section during the initial audit.

| Measurement | Historical baseline | Baseline rebuilt for comparison | Final release |
|---|---|---|---|
| Source | `aa0134723` with the clean-build fixes | `936e0c1c1` | `aa50c4784` |
| RGBDS | 0.7.0 | 0.7.0 | 0.7.0 |
| Build | Clean case-sensitive checkout required BUG-001/002 | Clean Linux build | Clean Linux release and debug, byte-identical Cygwin builds |
| ROM capacity | 2,097,152 bytes, 128 banks, MBC3 with RAM, battery and timer | 2,097,152 | 2,097,152 |
| Used ROM | 1,422,490 bytes | 1,423,375 (16,042 ROM0 + 1,407,333 ROMX) | 1,426,845 (16,021 ROM0 + 1,410,824 ROMX) |
| Free ROM | 674,662 bytes | 673,777 (342 ROM0 + 673,435 ROMX) | 670,307 (363 ROM0 + 669,944 ROMX), 31.96% |
| WRAM0 used / capacity | 4,096 / 4,096 | 4,096 / 4,096 | 4,064 / 4,096 |
| WRAMX used / capacity | 28,476 / 28,672 | 28,476 / 28,672 | 28,476 / 28,672 |
| HRAM used / capacity | 125 / 127 | 125 / 127 | 125 / 127 |
| SRAM used / capacity | 32,155 / 32,768 | 32,155 / 32,768 | 32,155 / 32,768 |
| Warnings | Original build log recorded zero | 0 assembler, 11 graphics | 0 assembler, the same 11 graphics warnings |
| Regression tests | 108 scripts, including 4 partial passes and 12 that stopped on obsolete symbols (TEST-002) | Reference for behavioural, graphics, layout, save and performance comparisons | 136 available scripts and 15 data validators passed (TEST-098/099) |

The historical Linux baseline had MD5 `3142da94d2e5cde28cb9df2c79ff8d8b`. The rebuilt baseline had MD5 `b3c3b04a524b515775c95d03823e649d` and 885 fewer free bytes. Rebuilding the starting revision of this session showed the same 885-byte offset from its historical record. Its cause is unverified. The final deltas use the rebuilt baseline and final ROM produced on the same host.

### Build Environment

- Build command: `make -j4` (RGBDS 0.7.0 on `PATH`, or `make RGBDS=<dir>/`). Builds `johtofrontier.gbc` and prints the free space (`tools/free_space.awk`).
- Clean build command: `make clean && make -j4`, or a fresh `git clone` followed by `make -j4` (as done for the baseline).
- Build the debug ROM with `make d` or both ROMs with `make -j4 all d`.
- Testing commands: `python3 .claude-tools/romtest/<test>.py .claude-tools/romtest <dir with johtofrontier.gbc/.sym>`. The tests load the built ROM and symbol file and run real routines on a Python SM83 interpreter (`sm83.py`, `romlib.py`). `gbrender.py` renders screens built by the routines (tilemap, attrmap, VRAM, palettes) to PNG files. `.claude-tools/` is excluded from Git (`.git/info/exclude`), so the tools live only in the working copy.
- Phase 10 added headless PyBoy 2.9.0 in CGB mode. Run `python tools/test_save_compat.py OLD/johtofrontier.gbc NEW/johtofrontier.gbc` with matching symbol files. The interpreter's graphics and timing hooks remain a separate source of coverage.
- Profiling tools: `perfkit.py` (battle/AI M-cycle counting), `prof_frame.py`, `prof_overworld.py`, `prof_mapentry.py`, `prof_pc_step.py`, `prof_vblank.py`, `prof_blockdata.py` (M-cycles per frame/step/map entry), `test_ai_perf.py` (AI frame cost).
- Validation tools: `test_ability_lists.py`, `test_basedata_layout.py`, `test_tileset_data.py`, `test_tileset_tables.py`, `test_decompress_all.py` and the table-length `assert`s in the source.
- Physical hardware testing: not available.
- Regression gate: `python3 .claude-tools/romtest/run_all.py <rom dir> <out file> [baseline file] [first [count]]` runs every test (60 s timeout each) and lists the tests whose result changed from a saved run. The commands are limited to about 3 minutes each, so the suite is run in slices (`first`, `count`). The baseline results are kept outside the repository with the baseline ROM.

### Performance Baseline (interpreter M-cycle counts, baseline ROM)

| Measurement | Cost | Tool |
|---|---|---|
| Overworld tilemap rebuild (any map) | 5,719-5,727 M-cycles (0.16 frames) | `prof_overworld.py` |
| Overworld scroll by one block | 1,218-1,331 M-cycles (0.03-0.04 frames) | `prof_overworld.py` |
| VBlank: BG map buffer row | 883 M-cycles (3.87 of the 10 VBlank lines) | `prof_vblank.py` |
| VBlank: palette upload | 600 M-cycles (2.63 lines) | `prof_vblank.py` |
| VBlank: 16-tile 2bpp chunk | 1,300 M-cycles (5.70 lines) | `prof_vblank.py` |
| Trainer AI switch decision (`AI_MatchupSwitch`, worst case measured) | 30.7 frames | `test_ai_perf.py` |
| Trainer AI switch decision (second mon out) | 4.3 frames | `test_ai_perf.py` |

The trainer AI's 1-on-1 matchup simulation is by far the largest measured cost (about half a second for one decision), so it is the main CPU target for Phases 4 and 5. The overworld and VBlank paths have already been optimised by earlier work.

## 25. Current Project Status

- All eleven repository audit phases are complete. Section 33 contains the final measurements and review outcome.
- Codex verified source revision `aa50c4784` on branch `000-Johto-Frontier`. Release has 670,307 bytes free and debug has 668,839. Cygwin and Linux produced identical images for each configuration.
- All 26 confirmed bugs in Section 26 have fixes. MT-003 passed in the follow-up. The remaining release checks cover two-player link battles, a full Neutralizing Gas switch sequence, and audiovisual transitions. Physical CGB timing remains unverified.

Update this section continuously.

## 26. Confirmed Bug Tracker

Maintain the following table throughout the project.

| ID | System | Bug | Severity | Status | Verification |
|---|---|---|---|---|---|
| BUG-001 | Build | `gfx/pokemon/Golisopod`, `Victini` and `Wimpod` were tracked with capital letters while the code includes the lowercase paths: a case-sensitive checkout (Linux, CI) could not build (`No rule to make target gfx/pokemon/wimpod/front.gbcpal`). Windows hid it. | High | Fixed | Clean clone builds on Linux (TEST-001) |
| BUG-002 | Build | `tools/sub_2bpp.sh` and `tools/free_space.awk` are run directly by the Makefile but were tracked without the executable bit (mode 100644): a fresh checkout failed with "Permission denied". | High | Fixed | Clean clone builds on Linux (TEST-001) |
| BUG-003 | Battle (move selection) | Taunt never blocked a status move at the move menu: `MoveSelectionScreen` got the move's power with `farcall GetMovePower`, but `farcall` returns with a = c (here `MOVE_LENGTH`), so the "power is 0" check always failed. The move was only stopped later, when used, wasting the turn instead of showing "The move is disabled". | Medium | Fixed | `test_farcall_returns` (failed before, passes after) |
| BUG-004 | Pokémon generation | A gift Pokémon sent to a box (`LoadEnemyMon` outside battle) got its Unown form from `farcall GenerateUnownForm`, whose result in a is lost (a = c = $30, the party struct length). Every such gift got form 48: an invalid letter for a gift Unown (out-of-range picture/icon lookups), and a stray non-zero form for every other species. | Medium | Fixed | `test_farcall_returns` (failed before, passes after) |
| BUG-005 | Battle Tower | `LoadOpponentTrainerAndPokemonWithOTSprite` (left over from the dynamic-sprite port) loaded a sprite with made-up inputs: it read the object struct index from ROM ($0000 + object offset: $F3 or $E0, the `di`/`ldh` opcodes) because it added the object's offset to `MAPOBJECT_OBJECT_STRUCT_ID` (0) instead of to `wMapObjects`, and it passed the sprite in a through `farcall GetSpriteVTile`, which overwrites a with the bank (0). `GetSprite` then looked up sprite 0, one entry before `OverworldSprites`, and queued that garbage for a VRAM slot worked out from the bad index. The load was not needed: the opponent is always hidden at this point and the script's `appear` loads its graphics. | Medium | Fixed | `test_bt_ot_sprite` (failed before, passes after) |
| BUG-006 | Stats screen (EV page) | `StatsScreen_PrintEVs` threaded a running value through the stack with a `push bc`/`pop bc` per stat, but only on the non-maxed branches. With Attack EVs at exactly 252 (`MAX_EV`), nothing was pushed for Attack, so the later stats popped the routine's own return address and the final `pop bc` left the stack one short: `ret` went to the wrong address (crash or garbage). The value it built was never used. Any Pokémon with 252 Attack EVs, viewed on the EV page (unlocked by `EVENT_UNLOCK_STAT_SCREEN_EFFORT_VALUES`), triggered it. | Critical | Fixed | `test_stats_evs` (32 of 64 maxed/not-maxed mixes failed before: every one with Attack at 252; all pass after) |
| BUG-007 | NPC trades | `ComputeNPCTrademonStats` stored the level with `ld [MON_LEVEL], a` (inherited from pokecrystal, flagged there by its own comment): `MON_LEVEL` is the struct offset $1F, so this wrote the level to cartridge address $001F, the MBC3 save-RAM enable register. A level ending in $A (10, 26, 42, 58, 74, 90) left save RAM switched on after every in-game trade; any other level switched it off. The stats themselves were right (the trade code already sets `wCurPartyLevel`). | Low | Fixed | `test_npc_trade_stats` (the write to $001F seen on the baseline ROM; none after) |
| BUG-008 | Gift Pokémon / naming screen | Softlock. When `givepoke` sends a Pokémon to a box (full party), `GivePoke` sets `wMonType` to `BOXMON` and offers a nickname. The naming screen then calls `GetGender`, whose `BOXMON` branch was a deliberate `di` / `jr @` trap left from the removal of the old box code, so saying yes to the nickname froze the game. | Critical | Fixed | `test_gender_boxmon` (`BOXMON` froze on the baseline ROM; now returns the same gender as `BUFFERMON` for the same DVs) |
| BUG-009 | Battle (critical hits) | Super Luck's +1 critical stage was lost on Slash and Leaf Blade. For those two moves `_BattleCommand_Critical` took the species off the stack to check the Slash Crits / Leaf Blade Crits list, and on a miss pushed `a` back for the Super Luck check, but `IsInByteArray` returns with a = -1, so Super Luck looked up species -1 and never matched. Latent today: the Super Luck, Slash Crits and Leaf Blade Crits lists are all empty (their species are commented out), so it shows up as soon as one is filled. | Low | Fixed | `test_crit_stages` (4 of 14 failed on the baseline, both sides; 14/14 after) |
| BUG-010 | Link battles (Tenacity) | Tenacity's end-of-turn 1/3 status cure rolled with `Random` instead of `BattleRandom`. In a link battle each Game Boy then rolled its own number, so they could disagree on whether the status was cured and the battle desynced. Haxorus has Tenacity. Single-player is unaffected (`BattleRandom` is `Random` outside link battles). | Medium | Fixed | `test_battle_rng` (Tenacity reached `Random` on the baseline; `BattleRandom` after) |
| BUG-011 | Turn order (Quick Draw) | Quick Draw had the same link-desync roll (`Random`), and its condition was inverted: `cp 33 percent + 1` / `jr c, .continue` skipped on the low third, so it fired on 171 of 256 rolls (2/3) instead of the 1/3 its data file states (Tenacity's identical idiom uses `ret nc`). Latent today: the Quick Draw list is empty. | Low | Fixed | `test_battle_rng`: 171/256 on the baseline (measured), 85/256 after |
| BUG-012 | Battle stats (Choice Scarf) | `ApplyChoiceScarfEffectOnSpeed` added Speed/2 to Speed with the bytes in the wrong order: the high byte was added first and its (never-set) carry went into the low byte, so a carry out of the low byte was lost. Whenever the low byte plus half the Speed passed 255, the boosted Speed came out 256 too low: e.g. 200 Speed became 44 instead of 300, so a Scarf holder was often far slower than without the Scarf. Affects every Speed from 171 up where the low byte overflows (about a third of values), for both sides and for the AI's speed checks that use the same stats. | High | Fixed | `test_battle_stats` (Choice Scarf wrong from Speed 171 up on the baseline, both sides; exact x1.5 for Speed 1-399 and 600-999 after) |
| BUG-013 | Battle weather | Solar Beam was not weakened in hail. The entry `WEATHER_HAIL, EFFECT_SOLARBEAM, NOT_VERY_EFFECTIVE` sat in `WeatherTypeModifiers`, which compares the move's type, so it compared the type against `EFFECT_SOLARBEAM` (115, no type has that ID) and never matched. The rain entry for Solar Beam is correctly in `WeatherMoveModifiers`. | Low | Fixed | `test_weather_modifiers` (Solar Beam in hail 100 -> 100 on the baseline, 100 -> 50 after, both sides) |
| BUG-014 | Battle weather (Magic Guard) | Magic Guard did not protect from hail. `HandleWeather`'s sandstorm damage skips Magic Guard Pokémon, but its hail damage only checked Overcoat, so a Magic Guard Pokémon lost 1/16 HP a turn in hail. The AI's matchup simulator already treats Magic Guard as blocking both weathers, so the AI's predictions were wrong too. | Medium | Fixed | `test_weather_damage` (Magic Guard took hail damage on the baseline, both sides; immune after) |
| BUG-015 | Entry hazards (data) | `SpikesImmunePokemon` still named 27 species as having Levitate or Magic Guard after those abilities were taken off them, so they kept floating over Spikes. Cut down to match the ability lists (Mew), with the rest kept as comments like the ability lists (approved by the user). | Medium | Fixed | `test_ng_passives` (Gengar and Clefable took no Spikes damage on the baseline; 1/8 after; Mew still immune) |
| BUG-016 | Abilities (Neutralizing Gas) | Guts, Resilience and the Spikes immunity kept working under Neutralizing Gas, unlike every other ability. They now use `IsInAbilityList`, and `UpdateNeutralizingGas` recalculates both sides' battle stats whenever the suppressed side changes, so Guts and Resilience switch off (and back on) at once (approved by the user). | Medium | Fixed | `test_ng_passives` (all suppressed cases failed on the baseline; 9/9 after) |
| BUG-017 | Experience | Experience is handled in 16 bits, but with Scaled experience the cubed level ratio ((enemy L + 10) / (own L + 10))^3 can push it past 65535 (up to x162 at the level-50 cap), and the top bytes were silently dropped; the x1.5 boosts (traded, trainer, Lucky Egg) also wrapped round on overflow. Low-level Pokémon (typically Exp. Share recipients) got a fraction of their experience: e.g. level 5 vs a level-50 foe with base EXP 200 got 25,856 instead of 91,392 (now capped at 65,535); level 1 with all three boosts got 14,251. Now capped at 65,535 after the scaling and after each boost. | Medium | Fixed | `test_exp_gain` (4 of 11 overflow cases wrong on the baseline; 11/11 after) |
| BUG-018 | Capture (status bonus) | The catch-rate status check `and 1 << PSN \| BRN \| PAR \| FRZ \| SLP_MASK` put `1 <<` on `PSN` only; `BRN`, `FRZ` and `PAR` are bit numbers (4, 5, 6), so the mask was $0F. Poison and sleep got the intended +15, but burn, frostbite and paralysis fell through to the +5 branch. Now `and ALL_STATUS`. No other mask in the codebase has this mistake (scan). | Medium | Fixed | `test_catch_status` (burn/frostbite/paralysis +5 on the baseline, +15 after) |
| BUG-019 | Capture (Catch Charm) | The Catch Charm (held: "Doubles catch rate of statused foes") never added anything: it added `c` after `farcall GetItemHeldEffect`, which returns the item's own parameter in `c` (0 for the Catch Charm), not the status bonus. The bonus is now kept in `e` across the call. | Medium | Fixed | `test_catch_status` (Catch Charm added nothing on the baseline for most statuses; adds the status bonus again after) |
| BUG-020 | Pokémon data (evolutions) | Evolution lists fall through into the next label by design (families share data), but in the Porygon / Chansey / Magikarp block no entry ended its list: Porygon, Porygon2, Porygon-Z, Chansey and Blissey all ran on into Magikarp's "level 20 -> Gyarados" (and Porygon-Z into a happiness evolution into itself); Chansey evolved into Porygon-Z instead of Blissey. Fixed as the user chose: Porygon, Porygon2 and Chansey end their own lists (with the shared default learnset, so no moves change), Porygon-Z and Blissey have no evolution, Chansey -> Blissey by happiness. The rest of `evos_attacks.asm` is the author's work in progress (most species share a default "no evolution, Splash" entry) and was not touched. | High | Fixed | `test_evolutions` (1/8 on the baseline, 8/8 after) |
| BUG-021 | Battle engine (Blessing ability) | `BattleCommand_EffectChance` doubles the effect chance with `sla [hl]` on a byte where 100% is 255, so any chance above 50% wrapped: 60% became about 20%, and a certain (100%) effect became 99.6%. Latent: no species has Blessing yet (`blessing_mons.asm` is empty) | Low (latent) | Fixed | TEST-071 |
| BUG-022 | Battle Tower / Factory (team generation) | `PickRandomBattleTowerCompactMon`, stepping past a pool, computed the index's new high byte as `count_high - index_high` instead of `index_high - count_high`. With more than 256 mons across a challenge's pools (the design the comments describe), picks landed in the wrong pool or at a garbage address. Latent: today's largest challenge has 133 mons, so the high byte is always 0 | Medium (latent) | Fixed | TEST-073 |
| BUG-023 | Audio engine (music fade) | When a fade-out ends, `FadeMusic` reads `wPlayerState` (WRAMX bank 1) to choose between bike and map music. It runs in VBlank, which does not set the WRAM bank, so if the interrupted code had another bank selected the engine read an unrelated byte and could start the wrong song. Also in vanilla pokecrystal | Low | Fixed | TEST-079 |
| BUG-024 | Basic trainer AI | At low HP a healing-move search replaced the outer move count with an effect ID and overwrote the candidate move. A full set was read past slot four and the AI could give Hydro Pump the accuracy bonus for Tackle. | Medium | Fixed | TEST-096 |
| BUG-025 | Smart trainer AI | The recoil handler used a dispatch address byte as the species and lost the score pointer during the Rock Head lookup. Its low-HP penalty wrote to the cartridge instead of the selected move's score. | Medium | Fixed | TEST-097 |
| BUG-026 | Build report | CRLF linker maps hid completely empty ROM banks from the free-space report. Both Cygwin builds underreported free space by 32,768 bytes. | Low | Fixed | TEST-101 |

Use unique identifiers such as BUG-001, BUG-002 and BUG-003.

Severity classifications:

- Critical: Crashes, corruption, severe softlocks or major game-breaking behaviour.
- High: Significant incorrect gameplay behaviour.
- Medium: Noticeable incorrect behaviour or important edge cases.
- Low: Minor defects with limited impact.

Status classifications:

- Investigating.
- Confirmed.
- Fixed.
- Verified.
- Awaiting clarification.
- Awaiting manual testing.

## 27. Performance Optimisation Tracker

Maintain the following table.

| ID | Routine or System | Optimisation | Before | After | Improvement | Verification |
|---|---|---|---|---|---|---|
| PERF-001 | Far calls into the home bank (9 sites: Neutralizing Gas, turn-end abilities, Curse, Pain Split, three item-effect font reloads, link trade, move learning) | `farcall`/`farjp` to a ROM0 routine replaced with `call`/`jmp` | `farcall`: 6 bytes, the FarCall path (two bank switches, bc saved through WRAM) | `call`: 3 bytes, no bank switch | Calculated: about 30 M-cycles saved per call; not measured (none of these is in a hot loop) | Full suite unchanged |
| PERF-002 | 106 far calls whose caller and target are in the same SECTION (37 files: battle core, AI, events, Pokégear, Pokédex, menus and more) | `farcall`/`callfar`/`newfarcall` replaced with `call`, `farjp` with `jmp` (one `jr` where it reaches) | Far-call path: 4-6 bytes, two bank switches | Direct call: 3 bytes (2 for the `jr`) | Calculated: about 30-60 M-cycles saved per call; not measured | Full suite and the overworld comparison unchanged |
| PERF-003 | `AddNTimes` (hl += bc x a; 299 call sites: move, item, species, party tables) | Counts of 16 or more use shift-and-add (one step per bit of a, at most 8) instead of one `add hl, bc` per unit; small counts (party slots) keep the plain loop | Up to 255 loop passes (~6 M-cycles each) | At most 8 steps | Measured: `AI_MatchupSwitch` (test_ai_perf, Meganium out) 911,400 -> 794,199 M-cycles (25.96 -> 22.62 frames) | `test_addntimes` (all a = 0-255, 2,048 cases), full suite, overworld comparison |
| PERF-004 | `_Divide` (the generic 1- to 4-byte divide behind `Divide`) | A zero dividend byte with no remainder is skipped (its quotient byte is 0); the quotient bits shift into the dividend byte itself instead of a separate register with a per-bit end check | Divide: 152,266 M-cycles over 161 calls in the AI switch (~945 each) | 75,952 M-cycles (~472 each) | Measured: `AI_MatchupSwitch` 794,199 -> 717,885 M-cycles (22.62 -> 20.45 frames); with PERF-003, 25.9 -> 20.4 frames (-21%) | `test_divide` (5,200 cases: arithmetic and byte-for-byte identical to the baseline incl. remainder and buffer), full suite, overworld comparison |
| PERF-005 | `CalcBattleStats` (every battle stat recalculation; the AI sim calls it after each simulated boost) | Stage 0 (x1) copies the stat instead of a Multiply and a Divide, then the same min-1 / max-999 handling | ~5,150 M-cycles per `CalcEnemyStats` (AI move choice profile) | Most stats are at stage 0: one copy each | Measured: `AI_SimMoveChoice` set-up case 12.1 -> 11.0 frames (16.3 on the baseline); `AI_MatchupSwitch` 20.4 -> 20.0 | `test_calc_battle_stats_same` (250 cases identical to the baseline, raw stats 0 to $FFFF), `test_battle_stats`, full suite |
| PERF-006 | Tail calls | Scan for `call X` / `ret` and `farcall X` / `ret` pairs (to become `jmp`/`farjp`), excluding the 34 routines that read their return address (jump tables, text commands, `PopBCDEHL` and the like) | 1 `call`/`ret` pair left (`PlayerGivesAwayAnEggForAdoption`), no `farcall`/`ret` pairs (converted in earlier work) | `jmp AdoptMonFromParty` | 1 byte, ~10 M-cycles (calculated) | Build, full suite |
| PERF-007 | `Random`, LCD interrupt helpers (`home/random.asm`, `home/lcd.asm`) | The 17 remaining HRAM accesses written as `ld a, [hX]` / `ld [hX], a` (3 bytes, 4 M-cycles: RGBDS 0.7 does not shorten them on its own) changed to `ldh` (2 bytes, 3 M-cycles) | 271.0 M-cycles per `Random` call | 260.0 | -4%; 17 bytes of home bank | `prof_random` (same output sequence), full suite |
| PERF-008 | Type chart lookups (`TypeMatchupScan`, `StabTypeScan`; every damage calculation and AI damage estimate) | Instead of walking the ~130-entry list, each chart now also has two page-aligned 32x32 matrices built at assembly time from the same entries (`type_matchup` macro): the multiplier, and the entry's position in the list. A lookup reads one cell per defending type; Stab applies the two matchups in list order (the order changes how damage rounds), then the Foresight list is scanned as before. Types of 32 or more fall back to the old scan | AI switch decision 20.0 frames; move choice 6.1 / 5.2 / 7.9 frames | 17.6; 5.5 / 4.7 / 7.1 | -12% switch, -10% move choice; 4,104 bytes of ROM | `test_type_chart_scan` (769/769 vs the previous build), `test_type_chart_stab_order` (240/240), `prof_ai_movechoice`, `test_ai_perf`, full suite |
| PERF-009 | `IsSideSuppressed`, `IsSpeciesSuppressed` (behind every `IsInAbilityList` ability check) | Test `wNeutralizingGas` first: with no Neutralizing Gas out (nearly always) they return after one load, with one register saved instead of two and no call from one to the other | ~42 and ~70 M-cycles per call | ~22 | 15,003 -> 4,356 M-cycles in the move-choice profile | `prof_flat`, AI suite, `test_ng_passives`, full suite |
| PERF-010 | `GetBattleVarAddr` (every `GetBattleVar`) | One table of both sides' addresses per variable instead of a pair table pointing into a location table; the lookup no longer touches the stack | ~52 M-cycles | ~35 | 6,734 -> 4,458 M-cycles in the profile; tables 136 -> 84 bytes (the old location constants removed) | full suite |
| PERF-011 | `MSim_IsInFarList` (the AI sim's species and effect lists in other banks) | New home routine `IsInFarByteList`: switch bank once and scan, instead of `GetFarByte` (two bank switches) per byte | ~90 M-cycles per list byte | ~10 | see below | `test_far_byte_list`, AI suite, full suite |

Use unique identifiers such as PERF-001, PERF-002 and PERF-003.

Record machine-cycle savings, measured execution time or other relevant performance measurements.

Distinguish between measured improvements and calculated estimates.

Do not invent performance figures.

## 28. Memory Optimisation Tracker

Maintain the following table.

| ID | Memory Region | Modification | Before | After | Bytes Saved | Verification |
|---|---|---|---|---|---|---|
| MEM-001 | ROMX | PERF-001 | 674,694 bytes free | 674,719 bytes free | 25 | Build `free_space.awk` |
| MEM-002 | ROMX | PERF-002 | 674,719 bytes free | 674,986 bytes free | 267 | Build `free_space.awk` |
| MEM-003 | ROMX | BUG-006 rewrite of `StatsScreen_PrintEVs` (one shared print helper instead of six copied blocks) | 674,986 bytes free | 675,214 bytes free | 228 | Build `free_space.awk` |
| MEM-004 | ROMX | Stray byte after three ability-list terminators removed (TEST-035) | 675,209 bytes free | 675,212 bytes free | 3 | Build `free_space.awk` |
| MEM-005 | WRAM0 | Removed `wBoxPartialData` (480 bytes, unreferenced: a leftover from the old box-saving code) from the "Miscellaneous" union; the union now spans the battle data (448 bytes) | WRAM0: 0 bytes free | WRAM0: 32 bytes free ($CFE0-$CFFF) | 32 | Build map, full suite, overworld comparison |
| MEM-006 | ROMX | Removed two dead routines: `IsUnawareRaw` (battle) and `SetSpecificDecorationFlag` (decorations) | 675,139 bytes free | 675,160 bytes free | 21 | Build, full suite |
| MEM-007 | ROMX | Duplicate routines merged into one copy each (TEST-062): five copies of `FillBoxWithByte` in other banks now jump to the home-bank one; `TradeAnim_TubeToOT4`/`TubeToPlayer5` jump to `TubeToOT2`, `TradeAnim_WaitAnim2` to `WaitAnim`, `StepFunction_Bump` to `WaitStep_InPlace` | 675,160 bytes free | 675,264 bytes free | 104 | Build, full suite, trade animation checks |
| MEM-008 | ROMX bank $14 (`engine/pokemon/switchpartymons.asm`) | The party menu's switch had its own 90-line copy of the slot swap (species, struct, OT, nickname, mail); it now calls the PC's `SwapPartyMons` (the upstream TODO there suggested exactly this) | 675,254 bytes free | 675,452 | 198 bytes | `test_party_switch` (12/12 before and after), full suite |

Use unique identifiers such as MEM-001, MEM-002 and MEM-003.

Record negative savings when a justified performance improvement increases memory usage.

Document significant speed-versus-memory trade-offs.

## 29. Testing Tracker

Maintain the following table.

| Test ID | System | Test Description | Test Method | Result | Notes |
|---|---|---|---|---|---|
| TEST-001 | Build | Clean `git clone` of the repository built from scratch on Linux (case-sensitive filesystem) | `make -j4` with RGBDS 0.7.0 | Passed (after BUG-001/002) | Failed before the fixes |
| TEST-002 | All | Baseline run of every interpreter test (108 scripts) against the baseline ROM | `python3 <test>.py` per script, 60 s timeout each | Partially verified | 84 pass fully. Partly passing: `test_ai_anti_boost` 11/15, `test_ai_speed_boost` 7/8, `test_dex_option_no_color` 7/8, `test_nevermelt_ice2` 3/5 (to investigate, Phase 2). Crashing on symbols that no longer exist (features renamed or reverted): `test_dex_white_screen`, `test_evo_spotlight`, `test_gale_wings`, `test_gale_wings_ai`, `test_lzp`, `test_menu_gray_bg`, `test_music_speed`, `test_pc_unown_icon`, `test_status_icon_reload`, `test_teleport`, `test_type_chart_scan`, `test_view_animations`. Other output formats (comparison tests skipped without an older build, profilers printing measurements): `test_bug_contest_judging`, `test_map_blocks`, `test_map_render_same`, `test_map_weather`, `test_options5_save`, `test_overworld_screen_same`, `test_type_chart_screen`, `test_voltorb_turbo_b` |
| TEST-003 | Test harness | Investigation of the four partly passing tests from TEST-002 | Traced each failing case in the interpreter (routine entry logging, damage and flag dumps) against the baseline ROM | Passed (all four now pass fully) | No ROM bug found: all were test-side faults. `test_nevermelt_ice2` expected an old boost size (every type-boosting item is 20% in this game). `test_dex_option_no_color` read tile 0 as text. `test_ai_speed_boost` and `test_ai_anti_boost`: the shared battle setup (`perfkit.Battle.setup`) copied only $20 bytes of the battle struct, which has grown to $21 with `UnownForm`, so the player's `Type2` stayed 0 (Normal) and every player Normal move got a false 1.5x STAB in the matchup sim. The copy now uses the struct's real length. Two cases in `test_ai_recharge_setup` had been tuned around that false STAB; their HP values were rescaled to keep the same intent (14/14). The other 12 tests using the shared setup are unchanged. |
| TEST-004 | Test harness | Repair or retire the 12 tests that crashed in TEST-002, then re-run the whole suite against the baseline ROM | Per-test triage against the current source, then every `test_*.py` (60 s timeout each) | Passed | Repaired: `test_teleport` (`EnemySwitchOrTryItem` is now `TryEnemySwitch`, item step gone: 41/41), `test_gale_wings` and `test_gale_wings_ai` (Aerial Ace no longer exists, its 3 cases disabled: 22/22, 35/35), `test_status_icon_reload` (the move-icon routine it used was reworked; it now garbles tiles $79-$7e directly and also checks the battle gender icons come back: 12/12), `test_pc_unown_icon` (the per-slot letter list was removed; the encode/decode round trip still runs: 12/12). Retired to `romtest/retired/` because the feature is gone: `test_dex_white_screen` (Pokédex switches with `DisableLCD` again), `test_evo_spotlight`, `test_lzp` (no LZP data any more), `test_menu_gray_bg`, `test_music_speed`. Not crashes: `test_type_chart_scan` and `test_view_animations` need an extra argument (an older build, a debug ROM). Suite now: 103 scripts, 93 pass fully, 0 partly, 10 print other formats (profilers and comparisons; the four comparison tests can take the baseline ROM as the older build from now on). |
| TEST-005 | Whole codebase | Static scans for far-call misuse: plain `call`/`jp` between different ROMX banks; `farcall`/`callfar` results read from a (it returns a = c); a or hl set just before `farcall`/`callfar` (both are overwritten) | Python scans over every `.asm` file with bank data from the `.sym` file; every hit reviewed by hand | Passed | Cross-bank: no ROMX-to-ROMX hits; the 32 home-bank hits all switch banks first. Results in a: 18 hits, 2 real (BUG-003, BUG-004); the rest only use the preserved flags or clear carry. Inputs: 4 hits, 1 real (BUG-005); the other callees reload what they need themselves. |
| TEST-006 | Battle, Pokémon generation | `test_farcall_returns`: Taunt at the move menu (status move refused, damaging move and untaunted cases allowed); gift Unown letter in 0-25 and independent of c; gift non-Unown form 0 | Interpreter, run from the routines' own labels | Passed | 2/6 before the fix (the 4 bug cases failed), 6/6 after. Full suite unchanged otherwise. |
| TEST-007 | Battle Tower | `test_bt_ot_sprite`: the opponent's map object gets the trainer class's sprite (3 object/class pairs), and no sprite load is made | Interpreter, from just after the routine's `LoadOpponentTrainerAndPokemon` call | Passed | 3/6 on the baseline ROM (the stray load seen with a = 0 and struct index $F3/$E0), 6/6 after. Full suite unchanged otherwise. |
| TEST-008 | Whole codebase | Static scan for far calls whose target is in ROM0 | Python scan over every `.asm` with the `.sym` file; each callee checked for inputs in a or hl | Passed | 9 hits, none taking a or hl as input (so no wrong results); they ran with bank 1 mapped instead of the caller's bank, harmless here. Replaced by direct calls (PERF-001). |
| TEST-009 | Whole codebase | Static scan for far calls inside one SECTION (always the same bank, wherever the linker puts it) and review of each for register use | Python scan using the `.map` file's section membership; for each `farcall`/`callfar` callee, its first instructions checked for reading a or hl, and each caller checked for reading a afterwards | Passed | 106 hits. No callee reads a or hl on entry (only `push`/`pop` saves or reloads); one caller ends with `ret` after the call (`PlayerGivesAwayAnEggForAdoption`, a special whose result is in `wScriptVar`). `newfarcall`/`farjp` pass every register through, so those are exact. |
| TEST-010 | Overworld rendering | `test_overworld_screen_same` with the baseline ROM as the older build | Every map's screens drawn by the game's own code in both ROMs, all anchor steps and half-block offsets | Passed | 307 maps, 1,941,120 cells identical. `test_map_render_same` runs away decompressing a tileset even with the baseline against itself: it was written for the removed LZP format and is stale. `test_bug_contest_judging` fails its "smaller" case against itself too (it checks a size reduction from an old optimisation), its behaviour cases pass. |
| TEST-011 | Interrupts, RAM banking | VBlank handler review and a static scan for WRAMX (banks 2-7) accesses in routines that never set `rSVBK` | Read `home/vblank.asm` and each routine VBlank0 calls; Python scan with the `.sym` file | Partially verified | VBlank keeps `hROMBank`; `UpdateBGMapBuffer` and `AnimateTileset` save and restore `rVBK`/`rSVBK`. `UpdateBGMap`'s attribute pass forces `rVBK` back to 0, as in vanilla: safe only while main code that leaves `rVBK` = 1 across a frame keeps `hBGMapMode` off attributes (no case found, not proven). The WRAMX scan flags 197 routines; the ones checked are helpers only reached from callers that switch banks (Pokédex grid, palettes, battle animations). A call-graph-aware check is needed to clear the rest. |
| TEST-012 | RAM banking | Call-graph check of WRAMX bank use, both ways: (1) routines reading or writing a bank 2-7 variable on a path where no caller has switched `rSVBK`; (2) routines reading a variable of one bank while a caller has switched to another | Python scripts over every `.asm` with the `.sym` file: line-by-line tracking of `rSVBK` writes (`BANK(w...)`, saved/restored values), call edges including local labels and fall-through, solved to a fixed point | Passed | (1) No unswitched path through direct calls. The 78 remaining hits are routines reached only through jump tables (battle animation commands and BG effects, Pokémon pic animation, Magnet Train, Pokédex grid); each table's entry point switches the bank before dispatching. (2) Three hits, all false: the Battle Tower room menu and title screen restore the bank before the flagged access; Bill's PC switches back inside `_GetCursorMon`. The Battle VS intro deliberately leaves bank 5 selected from "load portrait" to the end of the transition, and everything it touches meanwhile is in bank 5 or WRAM0. |
| TEST-013 | Whole codebase | Static push/pop balance check of every routine | Python: per routine, follows `jr`/`jp`/`jmp` to its own local labels and tracks the stack depth; flags `ret` at a non-zero depth, labels reached at two depths, and jumps or fall-through into another routine with a depth that routine does not pop | Passed | 98 hits reviewed. 1 real (BUG-006). The rest are intended: shared tails where a wrapper pushes and the common routine pops (Gale Wings, max-HP checks, weather likes, mail, trade tubes, HDMA, text commands), push-address-then-`ret` dispatch (`AI_Smart`, `Predef`, far-call internals), and loops that push a counted number of values (`AI_FasterAfterSpeedBoost`). `ReadTrainerPartyPieces` jumps to its end with `hl` still pushed only if a random-party entry starts with $FF, which the data never does (noted, not changed). |
| TEST-014 | Stats screen | `test_stats_evs` plus a screen comparison with the baseline ROM | Interpreter: all 64 combinations of maxed/not-maxed EVs, checking the stack on return and which cells show stars; full 20x18 tilemap compared with the baseline for four EV sets that did not crash there | Passed | 3/3; tilemaps identical to the baseline in all four sets. Full suite unchanged otherwise (106 scripts). |
| TEST-015 | Whole codebase | Invalid memory accesses: writes to ROM labels, literal echo-RAM / unusable-area / ROM addresses, and numeric constants used as addresses | Python scans with the `.sym` file and the constant definitions | Passed | One hit, BUG-007; nothing else. |
| TEST-016 | NPC trades | `test_npc_trade_stats`: no write below $2000 during `ComputeNPCTrademonStats` (levels 10, 26, 31), stats follow the level | Interpreter with a write hook on the cartridge address space | Passed | 1/4 on the baseline (the three register writes), 4/4 after. Full suite unchanged otherwise (107 scripts). |
| TEST-017 | Interrupts, softlocks | Static `di`/`ei` check of every routine (return, tail jump or fall-through with interrupts off; `halt` with interrupts off), then every deliberate `jr @` trap traced to its callers | Python CFG pass like TEST-013, with each hit and each trap's callers read by hand | Passed | 13 hits, all intended: the three `*_WaitHBlank` helpers return with interrupts off by design and every caller does `ei` within a few instructions; `VBlank1/3/5` run inside the interrupt and end in `reti`. Traps: `GetGender` (`BOXMON`) reachable, BUG-008. `CopyMonToTempMon` and `GetMonSpecies` traps: every caller sets `PARTYMON`, `OTPARTYMON` or takes the `BUFFERMON` branch first (party menu, battle, Battle Factory, link, move menus, evolution, Bill's PC), so not reachable. |
| TEST-018 | Pokémon gender | `test_gender_boxmon`: `GetGender` returns for every `wMonType`; `BOXMON` gives the same result as `BUFFERMON` for DVs $96, $66, $77, $F0 | Interpreter | Passed | 5/10 on the baseline (`BOXMON` froze), 10/10 after. Full suite unchanged otherwise (108 scripts). |
| TEST-019 | Memory corruption | Fixed-length `CopyBytes`/`ByteFill` into a WRAM/HRAM variable declared smaller in `ram/` (`ds`/`db`/`dw`) with another label right after it | Python: declared sizes from `ram/*.asm`, lengths evaluated from the constants, destinations from the `.sym` file | Passed | 27 hits, none a bug. Each deliberately spans neighbouring fields (BG and OB palettes cleared or loaded together, HP pairs in the matchup sim, party species plus terminator, mart/phone/decoration lists with their counts, start-time and RTC fields). The Bug-Catching Contest winner name takes 2 bytes past its 11 (class name of 13), but stays inside its `SECTION UNION`, whose other members are not in use during judging (as in pokecrystal). |
| TEST-020 | Freezes | Busy-wait loops on `rLY`/`rSTAT` that never end with the LCD off (LY stays 0, STAT mode 0) | Python scan for such loops, then each routine's callers read by hand | Passed | 28 loops; 8 check `rLCDC` first. The rest (copy-tilemap-at-once variants, HDMA transfers, battle intro, credits, Pokédex grid, Voltorb Flip, init) only run with the LCD on: the Pokédex turns it off only between its own `Pokedex_ScreenOff`/`Pokedex_ScreenOn` pairs, and the grid code runs outside those. No change; noted as a precondition for future callers. |
| TEST-021 | Battle engine (player/enemy symmetry) | Every routine pair whose names differ only by Player/Enemy: one side's body with Player/Enemy, `wBattleMon`/`wEnemyMon` and party names swapped, diffed against the other | Python over `engine/` and `home/` | Passed | 33 pairs differ; all reviewed, none a bug. The differences are shared tails, the player-only low-HP alarm, back vs front sprites, the matchup sim tracking statuses inflicted only on the player's mon, vanilla-only flinch resets, and renaming artefacts of the swap (`AI_Is*ImmuneByAbility` correctly checks the attacker's Mold Breaker and then the defender). |
| TEST-022 | Battle state between battles | Battle variables written by the battle engine and abilities that lie outside `wBattle`..`wBattleEnd` (cleared at battle start) and are not reset in `start_battle.asm` or `CleanUpBattleRAM` | Python with the `.sym` file, then each custom state variable traced to where it is reset | Passed | 358 hits, nearly all scratch, party data, or values set fresh before each use. Custom state checked one by one: `wAISwitchCount` (battle start), `wAITeleportPlan` (every turn), `wEntryAbilitiesPending` incl. Unburden bits (whole byte rewritten by `StartBattleEntryAbilities`), `wNeutralizingGas`, `wHarvestBerries` and `wSendOutPopupsShown` (each send-out), `wEntryHazardSwitchTurn`/`SkipMask` (each switch-in), `wContraryInverted` and `wMagicBounceSavedMove` (set per use). Nothing carries over from one battle to the next. |
| TEST-023 | Damage calculation | `test_damage_formula`: `BattleCommand_DamageCalc` against the reference `min(((2L/5+2)*P*A/D)/50, 997)+2` (integer steps; D=0 treated as 1; Explosion halves D) | Interpreter, 407 input sets (edge cases plus random L 1-100, P 1-250, A 1-255, D 0-255) x both sides x normal/Explosion = 1,628 runs, no items or abilities | Passed | Exact match on every run, including the 997 cap and power-0 early exit. |
| TEST-024 | Damage calculation, held items | `test_damage_items`: Charcoal (+20% on Fire), Life Orb (x1.3), Choice Band (x1.5 physical), Choice Specs (x1.5 special), Muscle Band / Wise Glasses (x1.1 on their category), each applied in the game's order and with its integer rounding | Interpreter, 40 random input sets x both sides x 4 type/category mixes per item | Passed | 7/7. Each boost applies only to the right type or category; the type byte's top two bits are the category (physical $40, special $80, status $C0), which is what the `cp SPECIAL` checks rely on. |
| TEST-025 | Critical hits | `test_crit_stages`: the critical stage reached at `.Tally` for Super Luck with Tackle, Slash and Leaf Blade, Focus Energy (+2) and Scope Lens (+1); Slash Crits with Slash always crits and returns with the stack intact; no crit on a high roll otherwise | Interpreter, ability lists redirected to test species, `BattleRandom` fixed, both sides | Passed | 10/14 on the baseline (BUG-009), 14/14 after. Full suite unchanged otherwise (111 scripts). |
| TEST-026 | Register use after list lookups | Every call to `IsInByteArray`, `IsInArray`, `IsInAbilityList(NG)` and the matchup sim's far list lookups, checked for code that reads `a` afterwards without reloading it (they return a = -1 on a miss) | Python scan as in TEST-005, then the 68 routines that return straight after a lookup checked for any that promise a value in `a` | Passed | No reads of `a` after a lookup other than BUG-009 (already fixed). The 68 wrapper routines all return their answer in carry; the `a =` notes in their headers describe inputs. |
| TEST-027 | Accuracy and evasion | `test_accuracy_stages`: move accuracy after the accuracy and evasion stages (`_BattleCommand_CheckHit.StatModifiers`) against `data/battle/accuracy_multipliers.asm`, two integer steps with a floor of 1, Keen Eye x1.3, cap 255 | Interpreter: every accuracy/evasion stage pair with evasion at or below accuracy x 4 move accuracies x Keen Eye on/off x both sides (1,456 runs), plus evasion-above-accuracy cases without Foresight | Passed | Exact match. With higher evasion and Foresight on the target, stage changes are skipped entirely; that is pokecrystal's original behaviour and is kept. |
| TEST-028 | Battle RNG, turn order | Scan of the battle engine and abilities for `Random` (not shared in link battles) where the roll decides a battle outcome; then `test_battle_rng`: Quick Draw and Tenacity must use `BattleRandom`, and Quick Draw's first-move rate over all 256 rolls | Grep over `engine/battle`, `engine/abilities` and item effects, each hit read; interpreter run of `DetermineMoveOrder` (equal priority, slower Quick Draw mon) and `Tenacity_Activate` with `Random` trapped | Passed | 11 `Random` calls: 2 real (BUG-010, BUG-011); the rest are wild-only (Magikarp size, capture, Shiny Ball tables), cosmetic (transition and VS intro) or outside link battles. 0/4 on the baseline, 4/4 after. Full suite unchanged otherwise (113 scripts). |
| TEST-029 | Speed and priority | `test_move_order`: `DetermineMoveOrder` for speed, move priority, Trick Room from the move and from the battle type (with priority kept), speed ties, Quick Claw, Swift Swim in rain and its exceptions (paralysis, foe at +2 Speed, no rain) | Interpreter, both sides; rates counted over all 256 rolls | Passed | 16/16. Speed ties go to the player on 128/256 rolls; Quick Claw on 60/256 (its item parameter). The weather speed abilities move the holder first rather than doubling Speed, as designed. |
| TEST-030 | Stat calculation | `test_stat_formula`: `CalcMonStats` against this game's formula: every DV counts as 15 (a deliberate design: DVs only decide gender, shininess and Hidden Power), EVs count 1/4 when enabled, `((Base+15)*2 + EV/4)*L/100 + 5` (HP: `+ L + 10`), cap 999 | Interpreter, 303 cases incl. extremes and EVs off | Passed | Exact match. |
| TEST-031 | Battle stats | `test_battle_stats`: `CalcPlayerStats`/`CalcEnemyStats` stage multipliers (`stat_multipliers.asm`, floor, min 1, cap 999), then paralysis (Speed /4), burn (Attack /2), frostbite (Sp. Atk /2), Trick Stick (Speed /4), Choice Scarf (Speed x1.5) | Interpreter, both sides: 60 random stat/stage sets each, each status and item, Choice Scarf over Speed 1-399 and 600-999 | Passed | 10/12 on the baseline (BUG-012 on both sides), 12/12 after. Full suite unchanged otherwise (116 scripts). |
| TEST-032 | 16-bit arithmetic | Scan for hand-written 16-bit adds/subtracts stored low address first with the carry going upwards (`add`/`sub`, store, pointer up, `adc`/`sbc`), the shape of BUG-012, which is wrong for the big-endian battle values | Python over `engine/` and `home/` | Passed | No other occurrence. |
| TEST-033 | Status conditions (residual damage) | `test_residual_damage`: `ResidualDamage` for poison, burn and frostbite (1/16 max HP, at least 1), Toxic (n/16, rising), HP floor at 0, Magic Guard (no damage) | Interpreter, both sides; the test helper now redirects home-bank ability lists across the whole ROM (needed for Magic Guard) | Passed | 14/14. Full suite unchanged (117 scripts). |
| TEST-034 | Status conditions (turn checks) | `BattleCommand_CheckTurn` (player) against `CheckEnemyTurn` with sides swapped: recharge, sleep countdown and waking, flinch, Disable and Taunt wearing off, confusion (1/3 self-hit), attraction (1/2), disabled move, Taunt block | Python diff as in TEST-021, differences read by hand | Passed | Same logic on both sides. Differences: the enemy shows "fast asleep" before the animation and the player after (as in pokecrystal); the player's confusion self-hit goes through `HitConfusion`, the enemy's is the same steps written out; sleep is checked with `and a` vs `and SLP_MASK`, equivalent because sleep excludes the other statuses. |
| TEST-035 | Abilities (data) | All 138 species lists in `data/abilities/`: terminated with -1, no duplicate entries, every list referenced by the code | Python over the data and engine sources | Passed | No missing terminators, duplicates or unused lists. Three lists (`Sanctuary`, `Seedfall`, `SpinGuard`) ended `db -1, end`, which emitted a stray byte after the terminator (harmless); changed to `db -1 ; end` (MEM-004). Full suite unchanged (117 scripts). |
| TEST-036 | Abilities (Neutralizing Gas) | Every raw `IsInByteArray` lookup of an ability list in the battle engine, abilities and item effects (AI excluded), checked for Neutralizing Gas handling: `IsInAbilityList`, `IsSideSuppressed`/`IsSpeciesSuppressed`, or a popup that reports suppression | Python scan, each hit read | Partially verified | 15 hits. Handled: Moxie/Ignis/Flash Step/Blood Lust/Renewal/Life Drain (their popups), Pressure (`IsSideSuppressed` before taking PP), Sturdy (`NGIgnoresSturdy`), Quick Draw (popup), the `*Raw` helpers and Neutralizing Gas itself (callers check). Not handled: Guts and Resilience (`DoesMonHaveGuts`/`DoesMonHaveResilience`, used when battle stats are recalculated) and the Spikes immunity list (`SpikesDamage`) keep working under Neutralizing Gas. Left unchanged pending a design decision (Section 31). |
| TEST-037 | Held items (data) | All 61 `HELD_*` effects: each given to an item in `data/items/attributes.asm` is handled somewhere, and none is handled without an item | Python over constants, item data and code | Passed | Only `HELD_NONE` (no effect) and `HELD_CLEANSE_TAG` have no handler by effect; the Cleanse Tag is checked by item ID in the wild-encounter code, as in pokecrystal. Held-item damage boosts are covered by TEST-024, stat items by TEST-031. |
| TEST-038 | Battle weather | `test_weather_modifiers`: `DoWeatherModifiers` for rain and sun type boosts and penalties, Solar Beam in rain, hail and sun, other moves in hail, no weather | Interpreter, both sides | Passed | 16/18 on the baseline (BUG-013), 18/18 after. Full suite unchanged otherwise (118 scripts). |
| TEST-039 | Battle weather (end of turn) | `test_weather_damage`: `HandleWeather` sandstorm and hail damage (1/16), immunity of Rock/Ground/Steel to sand (either type slot), Ice to hail, Magic Guard and Overcoat to both | Interpreter, both sides | Passed | 16/18 on the baseline (BUG-014), 18/18 after. Full suite unchanged otherwise (119 scripts). |
| TEST-040 | Entry hazards (data) | `SpikesImmunePokemon` against the lists it must mirror (its own comment and `levitate_mons.asm` both say so): Levitate plus Magic Guard | Python comparison of the three lists | Partially verified | Out of step: Levitate now has only Mew and Magic Guard is empty (both had species commented out), but the Spikes list still names 27 species as levitating or Magic Guard (Charizard, Gastly line, Magnemite line, Koffing/Weezing, Bronzor/Bronzong, Misdreavus/Mismagius, Solrock/Lunatone/Claydol, Unown, Victini, Celebi, Clefairy/Clefable, and more). They stay immune to Spikes without the ability. Left unchanged pending a decision (Section 31). The hazard code itself: Hazard Guard and Heavy-Duty Boots skip all hazards, Flying types skip Spikes, Magic Guard skips Stealth Rock, Stealth Rock scales with type matchup. |
| TEST-041 | Abilities, entry hazards | `test_ng_passives`: Guts (burn) and Resilience (paralysis) with and without Neutralizing Gas suppressing them; Neutralizing Gas coming in recalculates the stats; Spikes against Mew (Levitate), suppressed Mew, Gengar and Clefable | Interpreter | Passed | 3/9 on the baseline, 9/9 after. Full suite unchanged otherwise (120 scripts). |
| TEST-042 | Switching | `NewBattleMonStatus` against `NewEnemyMonStatus` (what a switch clears), plus the send-out hooks (`ResetPlayer/EnemySendOutPopups`, `UnburdenRecordSide`, `QueueEntryAbilities`) | Read side by side | Passed | Both clear the five substatus bytes, Disable, Protect, Minimize, both sides' binding, turns taken, Taunt and the opponent's "can't run" flag. Differences are pokecrystal's: only the player's used-move list is cleared (it exists for the player only), and Toxic's counter is reset when Toxic is next inflicted. Custom per-mon state (popups shown, Harvest, Unburden) is reset on each send-out. |
| TEST-043 | Experience | `test_exp_gain`: the amount `GiveExperiencePoints` hands to the experience bar, against base x enemy level / 7, the optional level scaling (three integer multiply/divide steps), the x1.5 boosts, and the 65535 cap | Interpreter, running the real routine up to `AnimateExpBar`; levels within this game's cap of 50 | Passed | 7/11 on the baseline (BUG-017), 11/11 after. Full suite unchanged otherwise (121 scripts). |
| TEST-044 | Capture mechanics | `test_catch_status`: the catch rate after the status step of `PokeBallEffect` (from `.statuscheck` to the roll) for no status and each status, with and without the Catch Charm held, and the 255 cap; plus a scan of every `\|` mask for a bit-number constant without `1 <<` | Interpreter (critical capture stubbed off); Python scan | Passed | 5/13 on the baseline (BUG-018, BUG-019), 13/13 after. The scan found only this line. Full suite unchanged otherwise (122 scripts). |
| TEST-045 | Trainer level scaling | Level-bracket parties (`ApplyScaledTrainerParty`, `data/trainers/scaled_parties.asm`) and `PARTY_LV` dynamic levels (`SetDynamicLevel`) | Code read; Python check of the bracket lists | Passed | 3 bracket lists, each ascending and terminated, all referenced; the last bracket is used above the top level as documented. 81 trainer entries use `PARTY_LV` with no offset (= the player's top level, capped at 50). A negative offset would wrap and be capped at 50; none is used (noted as a precondition). |
| TEST-046 | Register use around held-item lookups | Every caller of `GetItemHeldEffect` checked for using `b`/`c` from before the call (it returns the effect and parameter in `bc`) | Read each of the 25 call sites | Passed | Only BUG-019. The rest want the returned effect/parameter or save `bc` around the call. |
| TEST-047 | Move data | All 253 moves: status moves have power 0, damaging moves have power unless their effect sets the damage itself, accuracy and effect chance at most 100%; effect constants used by no move | Python over `data/moves/moves.asm` and the effect constants | Passed | No inconsistencies. 20 effect constants are used by no move (mostly pokecrystal leftovers such as the single-stat +1/-1 effects, `EFFECT_MIMIC`, `EFFECT_POISON_MULTI_HIT`); some may still be used by items or the AI. Noted for Phase 6 (ROM space). |
| TEST-048 | End-of-turn effects | Order of `HandleBetweenTurnEffects` and the faint checks around it | Code read of `HandleBetweenTurnEffects`, `FarTurnEndEffects` and `TurnEndAbilities` | Passed | Every step that can knock a Pokémon out (Solar Power, weather, binding, Perish Song) is followed by a faint check in link order. Leftovers, the far effects (Mysteryberry, stat and weather items, Snow Cloak, Safeguard/Mist/screens, Flame/Toxic Orb, Trick Room, Encore), turn-end abilities, healing items and Unburden only heal, count down or inflict a status, so they need none; status damage itself comes from `ResidualDamage` after each move (TEST-033). |
| TEST-049 | Dual-ability interactions (Mold Breaker, Neutralizing Gas) | The abilities `mold_breaker.asm` says Mold Breaker ignores (Levitate, Sturdy, Unaware, Multiscale, Flame Ward, Grounded, Waterproof, Immunity, Thick Fat, Pillow Fort, Chrysalis Hide) each checked for a Mold Breaker check where they act; the damage modifiers not on that list (Solid Rock, Fur Coat, Tinted Lens) checked against the AI's copy | Code read with a Python cross-reference | Passed | Every listed ability has its check (popup or silent), and the AI's damage estimate makes the same choices. Solid Rock and Fur Coat are deliberately not bypassed (not on the documented list, and the AI agrees). Levitate's other uses (Toxic Spikes, Sticky Web, HUD float icon) are not move-based, so Mold Breaker rightly does not apply. Neutralizing Gas interactions: TEST-036, TEST-041. |
| TEST-050 | Move effects (structure) | All 155 effect scripts in `data/moves/effects.asm`: each starts with a turn check (or pokecrystal's `checkrampage`/`checkcharge`/`checkcurl` before it) and ends with `endmove`/`endturn`/`jump`; every script is referenced; the pointer table has one entry per effect constant, in order | Python over the effect scripts, pointer table and constants | Passed | 161 constants, 161 pointers, names line up, `assert_table_length NUM_MOVE_EFFECTS` in the source; no unreferenced or open-ended scripts. Behaviour of individual effects is covered by the regression suite (Teleport, Hyper Beam recharge, set-up moves, Speed Boost, Pain Split, Counter/Mirror Coat and others) and by TEST-023-047; the rest needs play-testing. |
| TEST-051 | Fainting | Faint handling: `CheckFaint_PlayerThenEnemy`/`EnemyThenPlayer` after each damaging end-of-turn step (TEST-048), `HasUserFainted` guards in `ResidualDamage` (TEST-033), and the custom knock-out abilities (Aftermath, Moxie/Ignis/Flash Step/Blood Lust/Renewal/Life Drain) | Code read | Passed | Aftermath skips Counter/Mirror Coat and residual KOs, needs the attacker standing (`GetCurrentMon` returns `hl` = its HP), honours Magic Guard and Neutralizing Gas, and a KO it causes is picked up by the same post-move faint checks as recoil. KO abilities only fire for a standing user with their popups (Neutralizing Gas aware, TEST-036). |
| TEST-052 | Arithmetic | `test_addntimes`: hl += bc x a (mod 65536) for every a 0-255 with 8 bc values each, bc/de preserved, a = 0 after | Interpreter, baseline and new ROM | Passed | 2,048/2,048 on both. |
| TEST-053 | Arithmetic | `test_divide`: Divide for 1-4 byte dividends (zero, small, full-range values) by divisors 1-255 | Interpreter against Python and against the baseline ROM (quotient, remainder and `hMathBuffer`) | Passed | 5,200 cases, all correct and identical to the baseline. |
| TEST-054 | Battle AI | `test_ai_types_speed`: `AI_Types` scoring (immune move dismissed, super-effective encouraged, neutral unchanged, not-very-effective discouraged) and the AI's speed check (`DoesAIOutSpeedPlayer` after `CalcEnemyStats`) with and without a Choice Scarf | Interpreter | Passed | 5/6 on the baseline: the AI shared BUG-012 and thought a scarfed Speed-200 mon was slower than a Speed-250 one. 6/6 after. |
| TEST-055 | Battle AI (data and coverage) | Trainer AI flags in `data/trainers/attributes.asm` against `AIScoringPointers`; the AI regression suite | Python count of flags; review of the 15 `test_ai_*` scripts plus TEST-054 | Passed | Every class uses all six scoring layers; 45 boss classes add `AI_BOSS_SWITCH` (its table slot is `AI_None` by design: the flag is read by the switching code). The AI suite covers stat-boost answers (Haze/Roar/phazing), Contrary, entry abilities and the entry simulation, items, knock-out abilities, Hyper Beam and set-up plans, Regenerator, Speed Boost, the switch cap, end-of-turn effects, Unburden, weather and shards, and switch decisions with their frame cost; all pass. The AI's damage estimate runs the battle engine's own routines (`PlayerAttackDamage`, `BattleCommand_DamageCalc`, `BattleCommand_Stab`, `AIDamageCalc`), so the engine checks of Phase 3 apply to it too. |
| TEST-056 | Battle stats | `test_calc_battle_stats_same`: `CalcBattleStats` against the baseline ROM for random raw stats (0, small, up to $FFFF) and stages (mostly stage 0) | Interpreter, two ROMs | Passed | 250 cases identical. Needs the baseline ROM as its third argument (prints "skipped" without it). |
| TEST-057 | AI performance | Frame cost of the AI's per-turn move choice (`AI_SimMoveChoice`) and switch decision (`AI_MatchupSwitch`), baseline vs now | `perfkit.run_cycles` on three move sets and the test_ai_perf party | Passed (measured) | Move choice: Swords Dance plan 16.3 -> 11.0 frames, Recover/SD 5.7 -> 4.8, Hyper Beam set 7.6 -> 6.2. Switch decision: 25.9 -> 20.0 frames. All decisions unchanged (AI suite passes). |
| TEST-058 | Overworld CPU cost | The overworld's measured per-event costs, to decide whether they need work | Baseline measurements (Section 24) and `test_map_blocks` | Passed (measured) | `LoadBlockData` worst case 0.27 frames (map change), the overworld tilemap redraw 0.16 frames, the VBlank BG-map row ~883 M-cycles: all within a frame with room to spare. No optimisation needed; the general gains (PERF-003/004) apply to the overworld too, and the overworld comparison stays identical. |
| TEST-059 | RAM usage | Declared RAM labels referenced nowhere outside `ram/` | Python over all sources | Partially verified | 98 names; most are not really unused (union members, saved blocks with a fixed layout, arrays reached by offset such as `wMartItem2BCD`-`20BCD` and the PC item list, terminators). The one that freed space was `wBoxPartialData` (MEM-005). The rest of the list (e.g. `wUnusedBCDNumber`, `wBetaPoker*`, the `wBillsPC_*Pals3-5` slots) sit in unions or would not shrink a full section on their own; left for a later pass. |
| TEST-060 | Memory utilisation | ROM, WRAM, HRAM and SRAM free space per bank from the build map | Python over `johtofrontier.map` | Passed (measured) | ROM0 322 bytes free; ROMX 642,049 bytes free over 125 banks (43 banks have under 256 bytes free, 9 are nearly empty); WRAM0 32 (MEM-005); WRAMX bank 2: 84, bank 5: 112, banks 1/3/4/6/7: 0; HRAM 2; SRAM bank 0: 544, bank 1: 41, banks 2/3: 14 each. ROM is not a constraint; RAM is (any new RAM must come from reuse). |
| TEST-061 | Unused code | Global code labels referenced nowhere, excluding those reached by falling through from the code above and names built by macros (`MSim_\\1...`, tileset `\\1Anim`) | Python over the sources and `.sym` file, each hit read | Passed | 88 unreferenced labels, nearly all reached by fall-through. Truly dead: `IsUnawareRaw` and `SetSpecificDecorationFlag` (removed, MEM-006). |
| TEST-062 | Duplicate code and data | Routines with identical bodies (6+ instructions, local labels normalised, ending in their own `ret`/jump) | Python over `engine/` and `home/`, each group read | Passed | 15 groups. Merged: the five `FillBoxWithByte` copies (home version reachable from every bank) and four same-bank twins (MEM-007). Left as they are: copies kept in a different bank on purpose to avoid far calls (`DoubleDamage`/`MSim_DoubleDamage`, the `*WaitHBlank` helpers, `Finish_Boost`/`FinishBoost`, the Pokédex fill helpers, `ClearTilemapEtc`...), and the two stat multiplier tables (documented duplicates, one per bank that reads them). |
| TEST-063 | RAM sharing | Review of how WRAM is shared and of the remaining "unused" names from TEST-059 | Read `ram/wram.asm` sections and unions | Passed | WRAM is already shared heavily through `SECTION UNION` (battle, link, Battle Tower, time-set, mail, contest, mart and PC buffers overlap). The remaining unused names are either inside union members that are not the largest (removing them frees nothing) or inside blocks copied or saved as a whole (map header, tileset header, encounter rates, item pockets, breed and roam structs), where removing a field would shift the layout. None removed beyond MEM-005. |
| TEST-064 | Encounter and trainer data | Wild data (`data/wild/*.asm`: grass, water, swarms) levels within 1-50 (this game's cap) and valid species; trainer parties (`parties.asm` and `scaled_teams/`) parsed with their type flags: levels 1-50 or `PARTY_LV`, valid species, items and moves, 1-6 Pokémon, nicknames where flagged | Python validators (`validate_trainers.py`) | Passed | 211 trainers, 365 Pokémon: no problems. The two empty parties are the "CAL" mirror trainers (they copy your party by design). |
| TEST-065 | Pokémon data (evolutions, learnsets) | `test_evolutions`: every species' evolution list read from the ROM through `EvosAttacksPointers`: no self-evolution, only Magikarp evolves into Gyarados, the Porygon/Chansey families as their entries say; plus a source check that no evolution or learnset level exceeds 50 and learnsets are in order | Interpreter-free ROM read; Python over the source | Passed | BUG-020 found and fixed; no level above 50. |
| TEST-066 | Map warps | Every `warp_event` in all 307 maps points at an existing map and at a warp number that map has; each destination warp checked for a matching return warp | Python validator (`validate_warps.py`) | Passed | 941 warps. The 32 one-way or dynamic warps are all by design: Pokémon Centre stairs into the shared 2F, the two elevators, `-1` (back to the last warp), the Bug Contest exits, the Ruins word rooms and the Hatch Room's marked looping tile. |
| TEST-067 | Map events and blocks | Warp, coord, bg and object events lie inside their map (width x 2, height x 2); every map's `.ablk` block file is exactly width x height bytes | Python validators (`validate_bounds.py`, `validate_blk.py`) | Passed | 307 maps: nothing out of bounds, no size mismatch. |
| TEST-068 | Map connections | Every `connection` names a real map, matches its map's direction flags, has a reciprocal connection back with the opposite offset, and overlaps its neighbour | Python validator (`validate_conn.py`) | Passed | 64 connections: no problems. |
| TEST-069 | Item data, marts and shops | `ItemAttributes` checked position by position against the item constants (all 204 comment labels line up); key items untossable; mart lists (13 marts) have correct counts, no duplicates, only known items, no zero-price items for sale; bargain shop, rooftop sale and Buena prizes counts and items | Python validator | Passed | No problems. Ten non-key items have price 0, which marks them unsellable (rare items); none is sold in a mart. |
| TEST-070 | Base stats | All 252 base-stat files: include order matches the species constants; types, gender ratio, growth rate and egg groups are known constants; held items exist; catch rate 1-255; no zero stat; EV yields within 0-3 (they are packed 2 bits each); BST comments match the stats; dimensions files exist | Python validator (`validate_bs.py`); build with an EV of 4 to check the new assert | Passed | Two stale BST comments fixed (Houndoom 506, Rapidash 480). The `evs` macro now rejects a yield above 3 at build time (it would have spilled into the next stat's bits). ROM byte-identical. |
| TEST-071 | Blessing effect chance | `test_blessing_chance`: `BattleCommand_EffectChance` on both sides with a Blessing species patched into the list and fixed rolls: 30% doubles to 60%; 60% and 100% saturate at 100%; no change without Blessing; 0% never hits | Interpreter | Passed | 10/14 on the previous build (the two saturation cases fail on both sides); 14/14 after BUG-021. |
| TEST-072 | Move data | `validate_moves.py`: `Moves` order matches the move constants (253); every effect has a script pointer (161); status moves have no power and no damage commands; damaging moves have power unless their damage is computed; accuracy 1-100; PP 1-40 (also asserted at build time); effect chance non-zero exactly when the effect script rolls one (`effectchance` or `tristatuschance`) | Python validator | Passed | No data bugs. Reviewed and left: Close Combat, Earthquake, Tremor and Sucker Punch roll a 0% chance that nothing reads afterwards (one wasted RNG call; Sheer Force rightly ignores them); Swagger keeps the vanilla unused 100%. Checked that multi-hit loops jump back past `effectchance`, so a chance is never doubled twice. |
| TEST-073 | Battle Tower pool selection | `test_bt_pool_pick`: `PickRandomBattleTowerCompactMon` with a fake three-pool record (300, 50 and 700 mons in different banks) and fixed indices across every pool boundary: the right bank and base + index x 6 each time | Interpreter (pool record in WRAM; random index, pool lookup and far read hooked) | Passed | 8/9 on the previous build: smaller indices passed only because the sign error cancelled out over two steps; index 1049 went to bank 0. 9/9 after BUG-022. |
| TEST-074 | Battle Tower data | `validate_bt.py`: every `bt_mon` in the three pools has a real species, a known item and known moves, no repeated move in a set, a first move, and no duplicate records; `BattleTowerRandomLessThanDE` reviewed for uniformity (rejection on the top high byte) | Python validator; code review | Passed with one finding | 133 records. One exact duplicate: Snorlax (Leftovers, Double-Edge, Crunch, Earthquake, Rest) appears twice in a row in the Elite pool, which raises that set's odds. Teams never repeat a species, so nothing breaks. The user chose to keep it (Section 31). |
| TEST-075 | PRNG speed | `prof_random`: 1000 calls of `Random` from a fixed state, M-cycles per call and the first values | Interpreter (perfkit) | Measured | 271.0 -> 260.0 M-cycles per call; identical sequence. A repo-wide search found no other `ld` to an HRAM label. |
| TEST-076 | Save system | `validate_sram_pairs.py`: every routine scanned for returns or tail-jumps while SRAM is open and for unequal opens and closes; each of the 37 hits read by hand. Also: every field `SavePlayerData` writes is in the same SRAM bank (symbol file); save and verify checksums cover the same range, bank and byte order; the backup slot's save and load mirror the main slot's field for field; the PRNG zero-state reseed path checked | Python scan; symbol file; code review | Passed | All 37 hits are deliberate helper pairs (e.g. `OpenPokeDB`, `_PointBoxTheme`, `_GetFrontpic`, `RemoveMonFromPartyPartial` leave SRAM open for the caller, which closes it). Only the main load fixes up a Battle Tower reward state, as in vanilla. One dead `ret z` removed from `RemoveMonFromPartyPartial`. |
| TEST-077 | Hardware compatibility | Static review: the one `halt` is followed by `nop`; `stop` assembles as `10 00` with `rIF`/`rIE` cleared and `rJOYP` = $30, and every caller of `DoubleSpeed` puts `rIE` back; OAM DMA runs from HRAM, waits 40 x 4 = 160 M-cycles, and `wShadowOAM` is page-aligned by `layout.link`; no hard-coded access to echo RAM or $FEA0-$FEFF; the ROM is CGB-only (`rgbfix -C`), so DMG-only hazards do not apply. Voltorb Flip's use of `$C400-$C4xx` (inside `wShadowOAM`) as scratch RAM was checked: it turns sprite DMA off (`hOAMUpdate`), runs in VBlank mode 0 (which honours it), and `ExitAllMenus` clears palettes and rebuilds OAM after it returns | Source and ROM-byte review | Passed | No faults. Voltorb Flip's interrupt masks now use `IE_DEFAULT` (same bytes). Whether a stray sprite can flash on its exit is a timing question for MT-008. |
| TEST-078 | Audio data | `validate_audio.py`: from every channel entry (867) the data is walked to a terminator (`sound_ret`/`endchannel`, `sound_jump`/`jumpchannel`, or an infinite loop) without running into a header, table or the end of the file; every `sound_call` target (181) returns; `channel_count` matches the channel lines; the music, SFX and cry tables are length-asserted at build time | Python validator | Passed | 15 channels finish through the next channel's data (an empty channel's `sound_ret` used as a shared ending, or Thunderbolt running into Thundershock), as in vanilla. |
| TEST-079 | Music fade and WRAM bank | `test_fade_bike_bank`: `FadeMusic` with the fade ending, `wPlayerState` set differently in bank 1 and in the selected bank (1, 3, 7): bike music only if bank 1 says Bicycle, and the selected bank is the same afterwards. Also: every WRAM variable the audio engine uses is in WRAM0 apart from this one | Interpreter | Passed | 2/6 on the previous build (it followed whichever bank was selected); 6/6 after BUG-023. |
| TEST-080 | Graphics engine (VRAM banks) | `validate_vbk.py`: all 188 `rVBK` writes scanned per routine for a return or tail jump while VRAM bank 1 may still be selected; the hits read by hand. Together with TEST-077 (OAM DMA) and the Phase 2 VBlank/STAT checks | Python scan; code review | Passed | No leak: the remaining hits write bank 0 (`BANK(vBGMap0)`), restore a saved value, or run inside `CallInSafeGFXMode`, which saves and restores `rVBK` and `rSVBK`. Palette and VRAM write timing during active display can only be judged on hardware or an emulator (Section 32). |
| TEST-081 | Scripts (event flags) | `validate_events.py`: all 915 event flags traced through map scripts, engine code (`EventFlagAction` with `SET_FLAG`/`RESET_FLAG`/`CHECK_FLAG`), object visibility flags and data tables; reports flags that are checked but can never be set | Python validator; each hit read by hand | Passed with one open question | 4 flags unused. 7 checked but never set: Radio Tower cleared / Clear Bell (the takeover storyline is cut; Tin Tower opens through Koji in the Wise Trio's room), Mahogany Mart staircase (check inverted on purpose, with a comment), Pokécom Center welcome (vanilla), Lance's room exit (the door is opened by script, as in vanilla), Battle Points (nothing awards BP yet, so the card hides the row), and the GS Ball (see Section 31). |
| TEST-082 | Text rendering (line widths) | `validate_text_width.py`: every `text`/`line`/`cont`/`para`/`next` string in maps, data and engine measured in tiles (`#` = 4, `<PLAYER>`/`<RIVAL>` at their 7-letter maximum, contractions like `'s` as one tile, `{d:...}` as 4 digits); lines with run-time battle names skipped | Python validator | Passed | No line wider than the 18-tile textbox (credits use the 20-tile screen). |
| TEST-083 | Shops (purchase arithmetic) | Review of `GetDiscountedPrice` and `CalculateMaximumQuantity`: price x quantity (at most 65535 x 100) fits the 3-byte multiplicand that the second `Multiply` reuses; the second product stays under 2^32; the quotient fits the 3-byte price; the binary search relies on the price never falling as quantity rises (stated and tested by `test_mart_discount`); `GiveMoney` caps at 999,999 and the 3-byte sum cannot overflow first | Code review; existing `test_mart_discount`, `test_sell_limit`, `test_item_stack_99` | Passed | No faults. |
| TEST-084 | Wild encounters | Review of `ChooseWildEncounter` and `CheckRepelEffect`: the 1-100 roll always ends inside the grass and water probability tables (both end at 100); the +0 to +3 level bonus is uncapped, so listed levels were checked across every encounter type: grass and water up to 37, fishing 5-40, headbutt trees 15-25, so no wild Pokémon can pass level 50; Repel compares against the first party Pokémon that has HP | Code review; Python over `data/wild/*.asm` | Passed | Note for future data edits: a listed grass or water level above 47 would let the bonus pass the level cap. |
| TEST-085 | PC storage (encoding) | `test_pc_encode_roundtrip`: 40 random Pokémon (species, item, moves, ID, experience, EVs, caught ball, Unown form, DVs, PP Up bits, happiness, Pokérus, caught data, level, alt species, nickname and OT with spaces and terminators) through `EncodeBufferMon` and `DecodeBufferMon`: every stored field comes back and the checksum is valid; a flipped bit in the encoded experience is caught (Bad Egg, carry) | Interpreter | Passed | 41/41. Confirms the hack's changed box layout (EVs, caught ball and Unown form instead of stat experience) still lines up with the encoder. |
| TEST-086 | NPC and scripted movement | `validate_movement.py`: every movement script used by `applymovement`, `applymovementlasttalked` or `applyonemovement` (234) reaches `step_end` or `step_resume` before any other data | Python validator | Passed | No problems. |
| TEST-087 | Options (menus) | `validate_option_bits.py`: the 42 option bit constants mapped to their byte (`wOptions`, `wTextboxFlags`, `wOptions2`-`wOptions5`); every `bit`/`set`/`res` on an option constant (159 uses) checked against the byte loaded into `a` or `hl` | Python validator | Passed | No option tested on the wrong byte. `wExpShareToggle` reuses the `EXP_SHARE` bit number on purpose, and every reader and writer agrees. |
| TEST-088 | Inventory and party management | Review of `PutItemInPocket` and `RemoveItemFromPocket` (pocket capacity per pocket, stacks split at 99, the list shifted down when a stack empties, nothing changed when an item does not fit) and of the party/PC paths (`RemoveMonFromParty` mail shift, SRAM pairing from TEST-076, storage encoding from TEST-085) | Code review; existing `test_item_stack_99`, `test_sell_limit`, `test_quantity_text`, `test_start_menu_order`, `test_popup_screen` | Passed | No faults; the item routines are vanilla. Menus are otherwise covered by the existing menu tests and the manual checklist. |
| TEST-089 | Pokédex, input and movement | Pokédex: both dex orders (new and alphabetical) hold all 252 species exactly once, the alphabetical one sorted by the displayed names (Porygon-Z before Porygon2 follows the game's character order), and the entry table is length-asserted. Input and movement: covered by the existing targeted tests (`test_voltorb_turbo_b`, `test_teleport`, `test_spinner_trainer_run`, `test_suction_cups_fishing`, the dex screen tests) and the movement-script check (TEST-086) | Python over the dex data; existing tests | Passed | Feel and timing (turbo buttons, bike turning, running shoes) can only be judged by playing (Section 32). |
| TEST-090 | Party switching | `test_party_switch`: `_SwitchPartyMons.SwapMonAndMail` on a random six-mon party for six pairs of slots (both orders, first and last): exactly those two slots swap their species entry, party struct, nickname, OT and mail, all other slots are unchanged, and `bc`/`de`/`hl` are preserved | Interpreter | Passed | 12/12 on the old code and on the merged code (MEM-008). |
| TEST-091 | Type chart matrices (equivalence) | `test_type_chart_scan` against a snapshot of the previous build: all 19 x 19 single-type matchups, 250 random dual-type, inverse and typeless cases with and without Foresight, the Ghost cases, and 150 random `BattleCommand_Stab` runs (damage, `wTypeModifier`, `wAttackMissed`, `wTypeMatchup`) | Interpreter, old vs new | Passed | 769/769 identical. |
| TEST-092 | Type chart order (Stab rounding) | `test_type_chart_stab_order`: every attacking type against pairs of defending types that both have an entry (120 pairs from the normal and inverse charts, both type orders, odd damage values), compared with the previous build. 59 of the 120 pairs have a damage value whose result depends on the order | Interpreter, old vs new | Passed | 240/240 identical. Needs the old build as a third argument, like the other comparison tests. |
| TEST-093 | AI move choice speed | `prof_ai_movechoice`: frames for `AI_SimMoveChoice` with three move sets | Interpreter (perfkit) | Measured | 6.1 -> 5.5, 5.2 -> 4.7, 7.9 -> 7.1 frames with PERF-008. |
| TEST-094 | AI hot spots | `prof_flat`: exclusive M-cycles per routine for `AI_SimMoveChoice`, used to pick PERF-009 to PERF-011 | Interpreter (flat profile) | Measured | Before: `_Divide` 8.5%, `Bankswitch` 6.3%, `_Multiply` 5.7%, `GetFarByte` 4.8%, `IsSideSuppressed` 4.4%, far-call stubs ~8%, `GetBattleVarAddr` 3.5%, `IsSpeciesSuppressed` 3.4%. With PERF-008 to PERF-011: move choice 6.1 / 5.2 / 7.9 -> 4.9 / 4.2 / 6.3 frames; worst-case switch decision 20.0 -> 15.4 frames. |
| TEST-095 | Far list lookup | `test_far_byte_list`: `IsInFarByteList` on the longest ability list in a ROMX bank: every listed value matches (carry, z, a = e = value, hl just past it) and unlisted ones do not (no carry, nz, a = $ff, hl past the terminator); bc and d preserved; the ROM bank restored | Interpreter | Passed | 10/10. |
| TEST-096 | AI knockout scoring | Run AI_Basic with one, two and four moves, at 24/25/26 of 100 HP, with Recover, Slack Off or no healing, against awake and sleeping targets. Check scores and the last move slot read. | Interpreter, test_ai_basic_ko | Passed | 23/40 before, 40/40 after. Iron Dukes (14), Contrary (5), Magic Bounce (26) and Leaf Guard (35) also passed. |
| TEST-097 | Smart AI recoil | Dispatch Tackle and Double-Edge through AI_Smart at 49/50/51 of 100 HP. Check all four scores and trap writes to $4000–$7fff for an ordinary species, Aerodactyl and suppressed Aerodactyl. | Interpreter, test_ai_smart_recoil | Passed | 8/18 before, including writes to $6180 on the old build. 18/18 after. TEST-096 (40) and Iron Dukes (14) still pass. |
| TEST-098 | Release and debug regression | Clean Linux build of archived `184ec0a2d` with RGBDS 0.7.0, then all 136 local test scripts with their required inputs. | Build, interpreter, ROM and file comparisons | Passed | The incremental and clean release images are identical. Both configurations linked. Eleven graphics warnings match the reconstructed baseline exactly. Zero assembler warnings. The debug-only animation test covered 252 moves on both sides (10/10). |
| TEST-099 | Data, overworld, battle and facilities | All 15 available `validate_*.py` scripts, raw metatile and collision comparison, screen comparison, type-chart equivalence, storage encoding and facility generation. | Validators, linked ROM data and interpreter | Passed | 307 maps matched for both rendered screens (1,941,120 cells) and map blocks including collision (6,385,600 cells). 971 compressed assets matched source. Chart 769/769 and rounding order 240/240. Storage 41/41, Tower pool boundaries 9/9 and opponent load 6/6. |
| TEST-100 | Cross-version battery saves | Boot the baseline to a new game in PyBoy 2.9.0 in CGB mode. Save a known party, inventory and player state. Boot the release through Continue, resave and load in the baseline. Repeat with the primary checksum damaged. | Headless emulator, real save routines, disposable in-memory cartridge RAM | Passed | Both directions reached the overworld and Start menu. Checked trainer ID, name, money, options, items, party, map and event flags. The damaged primary took the backup path and recovered a valid primary checksum. |
| TEST-101 | Free-space report | Run the tool on the Cygwin CRLF and Linux LF release and debug maps. Check each total against the linker summary. Relink both Cygwin targets and compare their images with clean Linux builds. | Both build hosts and linked ROMs | Passed | Before the fix Cygwin reported 637,539 and 636,071 free. Both formats now report 670,307 and 668,839. Both ROM hashes match across hosts. |
| TEST-102 | Event script dispatch | Match the ordered command constants to their handler labels and read all 199 little-endian pointers from each linked ROM. Check the two sets of opcode annotations. | Source and both linked ROMs | Passed | All 398 pointers matched. Corrected 131 numeric comments in the macro definitions and 129 in the dispatch table. Release and debug images are byte-identical to their previous builds. |
| TEST-103 | Stats, gift naming and PC withdrawal | In PyBoy CGB, use joypad input to open the unlocked EV page. Separately queue a gift script with a full party, nickname Cyndaquil and Unown, open Bill's PC and withdraw each gift after making room. | Emulator with disposable party and event fixtures | Passed | The three EV cases displayed the expected numbers or stars in all six fields and closed normally. Both naming screens used the correct species and gender display. Both PC pictures rendered and both withdrawals preserved species, nickname and form. Both runs returned to the overworld and Start menu. |
| TEST-104 | Banking, lookup equivalence and save layouts | Trace the 115 direct-call conversions in PERF-001/002 against both symbol files. Build expected matrices independently from the baseline ROM's ordered lists. Compare all battle variables and saved field locations. | Linked data and SM83 execution | Passed | All targets share the caller bank or reside in ROM0. Both raw charts and all 4,096 multiplier/order cells matched. All 21 variables on both turns returned the original field and value and preserved BC, DE, stack and bank. All 11,158 SRAM symbol locations matched. All 1,365 field offsets matched in the three WRAM blocks copied on save. |
| TEST-105 | End-to-end AI performance | Run identical switching, move-choice and Random fixtures on the rebuilt baseline and final release using the same interpreter. | SM83 M-cycle counter | Passed | All four switching decisions matched. The Meganium switch fell from 909,606 to 541,034 M-cycles. Table in Section 33 gives the other fixtures. Random kept the sampled sequence. |
| TEST-106 | Taunt at move selection | Boot a disposable game in PyBoy. Start a wild battle through the overworld event queue, set the player's Taunt counter, select Growl from FIGHT, then select Tackle. | CGB emulator and joypad | Passed | Growl took the disabled-text path and reopened the move screen before turn execution. Tackle was accepted as the current player move and the turn executed. |
| TEST-107 | Battle Tower room (MT-003) | Replay the real room script in PyBoy at three streak positions. Compare the player and receptionist pixels every frame during arrival, check the opponent's live sprite against its trainer class, and proceed into battle. | CGB emulator, release and buildable baseline | Passed | Baseline attempted to load sprite 0 before the opponent appeared. The release avoided that load. Trainers 33, 12 and 49 entered with sprites 38, 38 and 62. Nearby sprites stayed intact across 143 frames per arrival. |

Use unique identifiers such as TEST-001, TEST-002 and TEST-003.

Record actual testing methods.

Results must be classified as:

- Passed.
- Failed.
- Partially verified.
- Not performed.
- Manual testing required.
- Blocked.

Never mark an unperformed test as passed.

## 30. Completed Work Log

For each completed logical batch, record:

### Task ID and Description

- Date:
- AI agent:
- Audit phase:
- System:
- Files modified:
- Problem identified:
- Root cause:
- Solution implemented:
- Behaviour preserved:
- Performance impact:
- Memory impact:
- Build result:
- Tests performed:
- Test results:
- Remaining risks:
- Git commit message:
- Next task:

Maintain entries in chronological order.

Use Git history to identify the corresponding commit. Do not repeatedly amend commits merely to insert their own commit hashes into this document.

### BUILD-001 — Make the repository build from a clean case-sensitive checkout

- Date: 2026-11-24
- AI agent: Claude (Claude Code)
- Audit phase: Phase 1 (baseline build)
- System: Build system
- Files modified: `gfx/pokemon/{golisopod,victini,wimpod}/*` (renamed from capitalised directories), `tools/sub_2bpp.sh`, `tools/free_space.awk` (file mode only)
- Problem identified: a fresh clone could not be built on Linux.
- Root cause: BUG-001 (three graphics directories tracked with capital letters, referenced in lowercase) and BUG-002 (two Makefile tools tracked without the executable bit). Both are invisible on the Windows/Cygwin working copy (case-insensitive filesystem, executable bits not enforced).
- Solution implemented: case-only `git mv` (through a temporary name) to the lowercase paths the code uses; `git update-index --chmod=+x` for the two tools.
- Behaviour preserved: no source or data changes; the ROM is unchanged.
- Performance impact: none. Memory impact: none.
- Build result: clean clone builds, 0 warnings.
- Tests performed: TEST-001.
- Test results: passed.
- Remaining risks: none known. Other tracked scripts without the executable bit are only ever run through `python3`.
- Git commit message: `build: fix case-sensitive graphics paths and tool permissions`
- Next task: record the baseline measurements (Phase 1).

### TEST-003 — Resolve the partly passing baseline tests

- Date: 2026-11-24
- AI agent: Claude (Claude Code)
- Audit phase: Phase 2 (making the regression suite trustworthy before the stability audit)
- System: Interpreter test harness
- Files modified: none in the repository (test scripts are git-excluded); this document
- Problem identified: four tests partly failed against the baseline ROM (TEST-002).
- Root cause: stale expectations (`test_nevermelt_ice2`, `test_dex_option_no_color`) and a shared harness fault: `perfkit.Battle.setup` copied a fixed $20 bytes of the battle struct, which is $21 bytes since `UnownForm` was added, leaving the player's `Type2` as Normal.
- Solution implemented: tests corrected; the harness copies `wBattleMonStructEnd - wBattleMon` bytes; two `test_ai_recharge_setup` cases rescaled.
- Behaviour preserved: no ROM change.
- Performance impact: none. Memory impact: none.
- Build result: not rebuilt (no source change).
- Tests performed: the four tests, plus all 14 tests that use the shared battle setup, before and after the harness fix.
- Test results: all four pass fully; the 14 shared-setup tests match the baseline except the two rescaled cases (now 14/14). `test_lzp` still crashes as before (stale, next task).
- Remaining risks: AI behaviour itself was not changed, so in-game AI is unaffected by this finding.
- Git commit message: `docs: record the resolution of the partly passing tests`
- Next task: update or retire the 12 tests that crash on missing symbols.

### TEST-004 — Repair or retire the stale crashing tests

- Date: 2026-11-24
- AI agent: Claude (Claude Code)
- Audit phase: Phase 2
- System: Interpreter test harness
- Files modified: none in the repository (test scripts are git-excluded); this document
- Problem identified: 12 tests crashed before testing anything (TEST-002).
- Root cause: they named routines, constants or data that were renamed or removed by later features, or needed an extra argument.
- Solution implemented: five repaired to the current code, five whose feature no longer exists moved to `romtest/retired/`, two reclassified (need extra input).
- Behaviour preserved: no ROM change.
- Performance impact: none. Memory impact: none.
- Build result: not rebuilt (no source change).
- Tests performed: the full suite against the baseline ROM.
- Test results: 103 scripts, 93 fully passing, none partly passing, 10 with other output formats (see TEST-004).
- Remaining risks: none for the ROM. The retired tests documented features that are gone; they can be restored from `retired/` if a feature returns.
- Git commit message: `docs: record the repaired regression test suite`
- Next task: Phase 2 stability audit (crashes, freezes, banking and stack safety).

### STAB-001 — Far-call return values lost (`farcall` returns a = c)

- Date: 2026-11-24
- AI agent: Claude (Claude Code)
- Audit phase: Phase 2 (register corruption)
- System: Battle move selection; gift Pokémon generation
- Files modified: `engine/battle/core.asm`
- Problem identified: two callers read a value in a after `farcall`, which comes back with a = c (`ReturnFarCall` restores bc through a).
- Root cause: BUG-003 (`GetMovePower`), BUG-004 (`GenerateUnownForm`). Both callees return their result in a; `newfarcall` (rst `BetterFarCall`) passes a, bc, de and hl through both ways.
- Solution implemented: both calls changed to `newfarcall`.
- Behaviour preserved: Taunt now behaves as its own code and comment intend; the rest of move selection is unchanged. Gift Unown get a random letter as designed; other gifts get form 0.
- Performance impact: negligible (shorter far-call path). Memory impact: 4 bytes of ROM freed.
- Build result: builds, 0 assembler warnings, 674,666 bytes free.
- Tests performed: TEST-005, TEST-006, full suite.
- Test results: new test 6/6 (2/6 on the baseline ROM); all other tests unchanged.
- Remaining risks: none known. Gift Pokémon already in a save keep their stored form (the save layout is not affected).
- Git commit message: `fix: keep far-call results for Taunt's move check and gift Unown forms`
- Next task: BUG-005 (Battle Tower opponent sprite load), then continue the register and banking audit.

### STAB-002 — Battle Tower opponent sprite load with bad inputs

- Date: 2026-11-24
- AI agent: Claude (Claude Code)
- Audit phase: Phase 2 (invalid memory accesses, register corruption)
- System: Battle Tower / Battle Factory battle room
- Files modified: `engine/events/battle_tower/battle_tower.asm`
- Problem identified: BUG-005.
- Root cause: the vanilla `wUsedSprites` code was swapped for a `GetSpriteVTile` call during the dynamic-sprite port, with a wrong base address and a far call that drops the input in a.
- Solution implemented: the routine only sets the map object's sprite; the stray load and the unused `de` set-up are removed. The map object address is the same as before.
- Behaviour preserved: the opponent still appears with its class's sprite (loaded by `appear` as for every other object).
- Performance impact: one sprite lookup and VRAM request fewer per opponent. Memory impact: 28 bytes of ROM freed.
- Build result: builds, 0 assembler warnings, 674,694 bytes free.
- Tests performed: TEST-007, full suite.
- Test results: new test 6/6 (3/6 on the baseline ROM); all other tests unchanged.
- Remaining risks: the visual result in the battle room should be confirmed in an emulator (Section 32).
- Git commit message: `fix: drop the Battle Tower opponent sprite load with bad inputs`
- Next task: continue the register and banking audit.

### PERF-001 — Direct calls to home-bank routines

- Date: 2026-11-24
- AI agent: Claude (Claude Code)
- Audit phase: Phase 2 (ROM banking), with a small Phase 5/6 gain
- System: Abilities, move effects, item effects, link trade, move learning
- Files modified: `engine/abilities/neutralizing_gas.asm`, `engine/abilities/turn_end_abilities.asm`, `engine/battle/move_effects/curse.asm`, `engine/battle/move_effects/pain_split.asm`, `engine/items/item_effects.asm`, `engine/link/link_trade.asm`, `engine/pokemon/learn.asm`
- Problem identified: nine far calls to routines that live in ROM0 (TEST-008).
- Root cause: the routines are in the home bank, so a far call only adds a pointless switch to bank 0 (bank 1 on MBC3) and costs 3 extra bytes.
- Solution implemented: `call`/`jmp` instead. Each callee was checked: none takes a or hl, and none of the callers read a after the call.
- Behaviour preserved: yes; the callees do the same work.
- Performance impact: calculated about 30 M-cycles per call (not measured). Memory impact: 25 bytes of ROM freed (MEM-001).
- Build result: builds, 0 assembler warnings, 674,719 bytes free.
- Tests performed: TEST-008, full suite.
- Test results: full suite unchanged (105 scripts).
- Remaining risks: none known.
- Git commit message: `perf: call home-bank routines directly instead of through farcall`
- Next task: continue the Phase 2 audit (stack balance and interrupt safety).

### PERF-002 — Direct calls inside one section

- Date: 2026-11-24
- AI agent: Claude (Claude Code)
- Audit phase: Phase 2 (ROM banking), with a Phase 5/6 gain
- System: 37 files across the battle engine, AI, events, menus, Pokégear and Pokédex
- Files modified: the 37 files listed by `git show --stat` for this commit
- Problem identified: 106 far calls between routines in the same SECTION (TEST-009). A section is never split across banks, so these always run in the current bank.
- Root cause: far calls kept from code that once lived in other banks, or written defensively.
- Solution implemented: plain `call`/`jmp` (and `jr` where the assembler's `jmp` check said it reaches). Only calls inside one section were changed, so the result stays valid however the linker moves sections later.
- Behaviour preserved: yes. `farcall`/`callfar` callees got a = bank and hl = address before and never read them; no caller reads a after the call. `newfarcall`/`farjp` already passed all registers.
- Performance impact: calculated about 30-60 M-cycles per call; not measured. Memory impact: 267 bytes of ROM freed (MEM-002).
- Build result: builds, 0 assembler warnings, 674,986 bytes free.
- Tests performed: TEST-009, TEST-010, full suite.
- Test results: full suite unchanged (105 scripts); overworld comparison identical on all 307 maps.
- Remaining risks: low; every site was checked by script and the flagged ones by hand.
- Git commit message: `perf: use direct calls for far calls within the same section`
- Next task: continue the Phase 2 audit (stack balance, interrupt safety).

### STAB-003 — Stack imbalance on the stats screen EV page

- Date: 2026-11-24
- AI agent: Claude (Claude Code)
- Audit phase: Phase 2 (stack corruption, crashes)
- System: Stats screen
- Files modified: `engine/pokemon/stats_screen.asm`
- Problem identified: BUG-006, found by the push/pop balance check (TEST-013).
- Root cause: per-stat `push bc`/`pop bc` on some branches only, carrying an unused value; Attack at 252 skipped the push.
- Solution implemented: the six blocks became one `.PrintEV` helper (number, or three stars at `MAX_EV`), with no stack use; the unused value is gone.
- Behaviour preserved: same text at the same places; tilemaps identical to the baseline wherever the baseline did not crash.
- Performance impact: fewer instructions. Memory impact: 228 bytes of ROM freed (MEM-003).
- Build result: builds, 0 assembler warnings, 675,214 bytes free.
- Tests performed: TEST-013, TEST-014, full suite.
- Test results: all pass; nothing else changed.
- Remaining risks: none known.
- Git commit message: `fix: stop the stats screen EV page corrupting the stack at 252 Attack EVs`
- Next task: finish the Phase 2 checklist (freezes and softlocks, interrupt safety, invalid accesses).

### STAB-004 — Stray MBC register write after NPC trades

- Date: 2026-11-24
- AI agent: Claude (Claude Code)
- Audit phase: Phase 2 (invalid memory accesses)
- System: NPC trades
- Files modified: `engine/pokemon/move_mon.asm`
- Problem identified: BUG-007 (TEST-015).
- Root cause: an offset constant used as an address.
- Solution implemented: `ld [wCurPartyLevel], a`, as the code's own comment said.
- Behaviour preserved: the traded Pokémon's stats are unchanged (the variable already held this level); only the stray register write is gone.
- Performance impact: none. Memory impact: none.
- Build result: builds, 0 assembler warnings, 675,214 bytes free.
- Tests performed: TEST-015, TEST-016, full suite.
- Test results: all pass; nothing else changed.
- Remaining risks: none known.
- Git commit message: `fix: stop NPC trades writing the level to the save RAM enable register`
- Next task: freezes and softlocks, interrupt safety.

### STAB-005 — Softlock nicknaming a gift Pokémon sent to the PC

- Date: 2026-11-24
- AI agent: Claude (Claude Code)
- Audit phase: Phase 2 (freezes, softlocks)
- System: Gift Pokémon, naming screen, gender
- Files modified: `engine/pokemon/mon_stats.asm`
- Problem identified: BUG-008 (found while reviewing the `di` / `jr @` traps, TEST-017).
- Root cause: the storage-system rewrite left `GetGender`'s box branch as a crash trap, but `GivePoke` still passes `BOXMON` to the naming screen.
- Solution implemented: `BOXMON` reads the DVs from `wBufferMon`, where the storage system keeps the box Pokémon being handled (the naming screen already reads that Pokémon's form and DVs from there). The trap is removed.
- Behaviour preserved: every other `wMonType` is unchanged; the gender shown is the stored Pokémon's.
- Performance impact: none. Memory impact: none (same size).
- Build result: builds, 0 assembler warnings, 675,214 bytes free.
- Tests performed: TEST-017, TEST-018, full suite.
- Test results: all pass; nothing else changed.
- Remaining risks: the naming screen itself was not run end to end in the interpreter; see MT-005.
- Git commit message: `fix: stop the game freezing when nicknaming a gift Pokemon sent to the PC`
- Next task: finish Phase 2 (freezes and softlocks beyond the traps), then Phase 3.

### PHASE2-CLOSE — Buffer lengths, wait loops, Phase 2 summary

- Date: 2026-11-24
- AI agent: Claude (Claude Code)
- Audit phase: Phase 2 (memory corruption, freezes)
- System: Whole codebase
- Files modified: this document only
- Problem identified: none (TEST-019, TEST-020).
- Root cause: n/a.
- Solution implemented: none needed; the LCD-on precondition of the wait loops is recorded.
- Behaviour preserved: no ROM change.
- Performance impact: none. Memory impact: none.
- Build result: unchanged (675,214 bytes free).
- Tests performed: TEST-019, TEST-020.
- Test results: passed.
- Remaining risks: Phase 2 overall fixed six bugs (BUG-003 to BUG-008), two of them able to crash or freeze the game; timing-dependent faults need the manual checklist.
- Git commit message: `docs: close Phase 2 with the buffer-length and wait-loop checks`
- Next task: Phase 3, battle engine correctness.

### BATTLE-001 — Super Luck ignored on Slash and Leaf Blade

- Date: 2026-11-24
- AI agent: Claude (Claude Code)
- Audit phase: Phase 3 (critical hits)
- System: Battle engine
- Files modified: `engine/battle/effect_commands_far.asm`
- Problem identified: BUG-009, found reading `_BattleCommand_Critical` while auditing critical hits.
- Root cause: a value assumed to survive `IsInByteArray` (its own comment says it wipes the registers).
- Solution implemented: the species is pushed again before the Slash Crits / Leaf Blade Crits lookup; on a hit it is dropped before `.AbilityHit`.
- Behaviour preserved: every other path unchanged (Tackle, Focus Energy, Scope Lens, Crit Lock tested on both sides).
- Performance impact: negligible. Memory impact: 3 bytes more (675,211 free).
- Build result: builds, 0 assembler warnings.
- Tests performed: TEST-025, TEST-023/024 (damage), full suite.
- Test results: all pass.
- Remaining risks: none known; no species has the affected abilities yet.
- Git commit message: `fix: keep Super Luck's critical stage on Slash and Leaf Blade`
- Next task: Phase 3, accuracy and evasion.

### BATTLE-002 — Link-battle RNG and Quick Draw's rate

- Date: 2026-11-24
- AI agent: Claude (Claude Code)
- Audit phase: Phase 3 (speed and priority, abilities)
- System: Turn order, end-of-turn abilities
- Files modified: `engine/battle/move_order.asm`, `engine/abilities/turn_end_abilities.asm`
- Problem identified: BUG-010, BUG-011 (TEST-028), found reading `DetermineMoveOrder`.
- Root cause: `Random` used for outcome rolls; one inverted branch.
- Solution implemented: `BattleRandom` in Quick Draw (both sides) and Tenacity; Quick Draw skips on `nc`, so it fires on the low third.
- Behaviour preserved: single-player rolls are the same RNG as before; Quick Draw now matches the 1/3 its data documents.
- Performance impact: negligible. Memory impact: none (675,211 bytes free).
- Build result: builds, 0 assembler warnings.
- Tests performed: TEST-028, full suite.
- Test results: all pass.
- Remaining risks: link battles cannot be tested here (two Game Boys); see MT-006.
- Git commit message: `fix: use the shared battle RNG for Tenacity and Quick Draw, and fix Quick Draw's rate`
- Next task: Phase 3, the rest of speed and priority (Trick Room, Quick Claw, weather speed abilities).

### BATTLE-003 — Choice Scarf Speed boost lost a carry

- Date: 2026-11-24
- AI agent: Claude (Claude Code)
- Audit phase: Phase 3 (stat calculations, held items)
- System: Battle stats
- Files modified: `engine/battle/core.asm`
- Problem identified: BUG-012, found reading the stat modifiers while writing TEST-031.
- Root cause: a hand-written 16-bit add done high byte first.
- Solution implemented: `add hl, de` with de = Speed / 2, stored big-endian.
- Behaviour preserved: Speed x1.5 (rounded down), uncapped as before; nothing else in the stat chain changed.
- Performance impact: negligible. Memory impact: 2 bytes more (675,209 free).
- Build result: builds, 0 assembler warnings.
- Tests performed: TEST-030, TEST-031, full suite.
- Test results: all pass.
- Remaining risks: none known.
- Git commit message: `fix: stop Choice Scarf losing 256 Speed when its boost carries`
- Next task: Phase 3, status conditions.

### BATTLE-004 — Solar Beam not weakened in hail

- Date: 2026-11-24
- AI agent: Claude (Claude Code)
- Audit phase: Phase 3 (weather)
- System: Battle weather
- Files modified: `data/battle/weather_modifiers.asm`
- Problem identified: BUG-013, found reading the weather tables.
- Root cause: a move-effect entry placed in the move-type table.
- Solution implemented: the hail entry moved to `WeatherMoveModifiers`, next to the rain one.
- Behaviour preserved: every other weather modifier unchanged (tested).
- Performance impact: none. Memory impact: none.
- Build result: builds, 0 assembler warnings, 675,212 bytes free.
- Tests performed: TEST-038, full suite.
- Test results: all pass.
- Remaining risks: none known.
- Git commit message: `fix: weaken Solar Beam in hail as the weather table intends`
- Next task: Phase 3, rest of weather (end-of-turn damage, duration), then entry hazards.

### BATTLE-005 — Magic Guard took hail damage

- Date: 2026-11-24
- AI agent: Claude (Claude Code)
- Audit phase: Phase 3 (weather, abilities)
- System: Battle weather
- Files modified: `engine/battle/core3.asm`
- Problem identified: BUG-014, found comparing the sandstorm and hail paths of `HandleWeather`.
- Root cause: the Magic Guard check was only written for sandstorm.
- Solution implemented: the same `IsInAbilityList` Magic Guard check (which respects Neutralizing Gas) before hail damage.
- Behaviour preserved: hail and sandstorm otherwise unchanged (tested); the battle now matches what the AI already assumed.
- Performance impact: negligible. Memory impact: 10 bytes more (675,202 free).
- Build result: builds, 0 assembler warnings.
- Tests performed: TEST-039, full suite.
- Test results: all pass.
- Remaining risks: none known.
- Git commit message: `fix: let Magic Guard block hail damage as it does sandstorm`
- Next task: Phase 3, entry hazards.

### BATTLE-006 — Neutralizing Gas and the passive abilities; Spikes immunity list

- Date: 2026-11-24
- AI agent: Claude (Claude Code)
- Audit phase: Phase 3 (abilities, entry hazards)
- System: Abilities, entry hazards, battle stats
- Files modified: `engine/battle/core.asm`, `engine/abilities/neutralizing_gas.asm`, `data/residual_damage/spike_immune_mons.asm`
- Problem identified: BUG-015, BUG-016 (TEST-036, TEST-040); both decided by the user.
- Root cause: lists and checks written before Neutralizing Gas, and an ability-list change not carried over to the Spikes list.
- Solution implemented: `IsInAbilityList` for Guts, Resilience and the Spikes immunity; `UpdateNeutralizingGas` recalculates both sides' stats when the suppressed side changes (`CalcPlayerStats`/`CalcEnemyStats` with `hBattleTurn` set for each, then restored); Spikes list matches Levitate + Magic Guard.
- Behaviour preserved: no stats change unless Neutralizing Gas starts or stops suppressing a side; stat stages, items and statuses are reapplied exactly as after any stat change.
- Performance impact: one stat recalculation when the suppression changes. Memory impact: 15 bytes more (675,197 free).
- Build result: builds, 0 assembler warnings.
- Tests performed: TEST-041, full suite.
- Test results: all pass.
- Remaining risks: see MT-007.
- Git commit message: `fix: let Neutralizing Gas switch off Guts, Resilience and the Spikes immunity, and match the Spikes list to the abilities`
- Next task: Phase 3, switching and fainting.

### BATTLE-007 — Experience overflow with scaled experience

- Date: 2026-11-24
- AI agent: Claude (Claude Code)
- Audit phase: Phase 3 (experience, level scaling)
- System: Experience
- Files modified: `engine/battle/core.asm`
- Problem identified: BUG-017, found reading `GiveExperiencePoints` while auditing experience.
- Root cause: a 16-bit value read from a 32-bit result without a check; a 16-bit add without a carry check.
- Solution implemented: `CapExpAt65535` after the scaling step; `BoostExp` saturates at 65535.
- Behaviour preserved: every result under 65536 is exactly as before (tested); Chansey/Blissey stay unscaled; the rest of the formula is unchanged.
- Performance impact: negligible. Memory impact: 30 bytes more (675,167 free).
- Build result: builds, 0 assembler warnings.
- Tests performed: TEST-043, full suite.
- Test results: all pass.
- Remaining risks: none known.
- Git commit message: `fix: cap scaled experience at 65535 instead of wrapping`
- Next task: Phase 3, capture mechanics.

### BATTLE-008 — Catch rate status bonus and the Catch Charm

- Date: 2026-11-24
- AI agent: Claude (Claude Code)
- Audit phase: Phase 3 (capture mechanics)
- System: Poké Balls
- Files modified: `engine/items/item_effects.asm`
- Problem identified: BUG-018, BUG-019 (TEST-044), found reading `PokeBallEffect`.
- Root cause: operator precedence in a bit mask; a register used across a far call that returns its own value in it.
- Solution implemented: `and ALL_STATUS`; the status bonus kept in `e` for the Catch Charm.
- Behaviour preserved: no status gives no bonus; ball multipliers, the HP factor, critical capture and the 255 cap are unchanged.
- Performance impact: none. Memory impact: 1 byte more (675,166 free).
- Build result: builds, 0 assembler warnings.
- Tests performed: TEST-044, full suite.
- Test results: all pass.
- Remaining risks: none known.
- Git commit message: `fix: give every status its catch bonus and make the Catch Charm add it again`
- Next task: Phase 3, move effects, fainting, end-of-turn effects, dual abilities.

### PHASE3-CLOSE — Battle engine correctness summary

- Date: 2026-11-24
- AI agent: Claude (Claude Code)
- Audit phase: Phase 3 (complete)
- System: Battle engine
- Files modified: this document (fixes are in their own commits)
- Problem identified: Phase 3 found and fixed BUG-009 to BUG-019 (Super Luck, Tenacity/Quick Draw link RNG, Choice Scarf carry, Solar Beam in hail, Magic Guard and hail, Spikes list, Neutralizing Gas passives, experience overflow, catch-rate status mask, Catch Charm).
- Root cause: see each bug.
- Solution implemented: see each bug; 18 new reference tests (TEST-023 to TEST-051).
- Behaviour preserved: every fix tested against the baseline ROM; full suite unchanged otherwise.
- Performance impact: negligible. Memory impact: net about -40 bytes of ROM free since Phase 2 (fixes added a little code).
- Build result: builds, 0 assembler warnings.
- Tests performed: the full suite after every fix (122 scripts at the end).
- Test results: all pass.
- Remaining risks: individual move effects and link battles need play-testing (Section 32).
- Git commit message: `docs: close Phase 3`
- Next task: Phase 4, battle AI.

### PERF-003 — Faster AddNTimes

- Date: 2026-11-24
- AI agent: Claude (Claude Code)
- Audit phase: Phase 4/5 (AI execution speed; arithmetic routines)
- System: Home bank arithmetic (used everywhere)
- Files modified: `home/array.asm`
- Problem identified: profiling `AI_MatchupSwitch` showed `AddNTimes` at ~15% (265 calls, ~514 M-cycles each), from move-table lookups with large indexes.
- Root cause: one loop pass per unit of the multiplier.
- Solution implemented: shift-and-add for multipliers of 16 or more; the plain loop for smaller ones (faster there).
- Behaviour preserved: identical result, bc and de preserved, a = 0 on return (no caller uses the flags; checked).
- Performance impact: measured 13% off the AI's switch decision; every table lookup with a large index gains too. Memory impact: 17 bytes more in ROM0 (still ~300 free).
- Build result: builds, 0 assembler warnings.
- Tests performed: TEST-052, full suite, overworld comparison (307 maps identical).
- Test results: all pass.
- Remaining risks: none known.
- Git commit message: `perf: shift-and-add AddNTimes for large counts`
- Next task: PERF-004 (Divide).

### PERF-004 — Faster Divide

- Date: 2026-11-24
- AI agent: Claude (Claude Code)
- Audit phase: Phase 4/5 (AI execution speed; arithmetic routines)
- System: Generic division (damage, stats, experience, AI, everywhere)
- Files modified: `engine/math/math.asm`
- Problem identified: `Divide` was ~17% of the AI's switch decision (161 calls).
- Root cause: eight bit-steps for every dividend byte, including the leading zero bytes of small 4-byte values; a separate quotient register with an extra compare per bit.
- Solution implemented: skip zero bytes while the remainder is zero; build the quotient in the dividend byte as it shifts out.
- Behaviour preserved: identical quotient, remainder and scratch buffer to the baseline on 5,200 cases.
- Performance impact: Divide about 2x faster on these inputs; the AI's switch decision 20.4 frames (was 25.9 before PERF-003). Memory impact: 6 bytes fewer (675,152 free).
- Build result: builds, 0 assembler warnings.
- Tests performed: TEST-053, full suite, overworld comparison.
- Test results: all pass.
- Remaining risks: none known.
- Git commit message: `perf: skip zero bytes and simplify the bit loop in Divide`
- Next task: Phase 4, the AI audit; further AI speed (type chart scan, far-call overhead) noted.

### PERF-005 — Stage-0 fast path in CalcBattleStats

- Date: 2026-11-24
- AI agent: Claude (Claude Code)
- Audit phase: Phase 5 (battle routines)
- System: Battle stats (battle engine and AI simulation)
- Files modified: `engine/battle/effect_commands.asm`
- Problem identified: the AI move-choice profile showed `CalcEnemyStats` at ~17% (14 calls, ~5,150 M-cycles each), most of it Multiply/Divide by 1/1 for unboosted stats.
- Root cause: the stage table's x1 entry still went through the generic multiply and divide.
- Solution implemented: stage 0 copies the stat and joins the existing min/max checks.
- Behaviour preserved: identical output to the baseline on 250 cases; the HRAM math registers are scratch (no caller reads them after).
- Performance impact: TEST-057. Memory impact: 14 bytes more (675,138 free).
- Build result: builds, 0 assembler warnings.
- Tests performed: TEST-056, TEST-031, full suite.
- Test results: all pass.
- Remaining risks: none known.
- Git commit message: `perf: skip the multiply and divide for unboosted battle stats`
- Next task: Phase 5, overworld routines.

### MEM-005 — 32 bytes of WRAM0 back

- Date: 2026-11-24
- AI agent: Claude (Claude Code)
- Audit phase: Phase 6 (RAM)
- System: WRAM0 layout
- Files modified: `ram/wram.asm`
- Problem identified: WRAM0 was completely full; the 480-byte box save buffer that set the size of the "Miscellaneous" union is no longer used (TEST-059).
- Root cause: left behind when the storage system replaced the old box code.
- Solution implemented: the buffer is removed; the union shrinks to its largest live member (battle data, 448 bytes).
- Behaviour preserved: nothing referenced it; full suite and overworld comparison unchanged.
- Performance impact: none. Memory impact: 32 bytes of WRAM0 free.
- Build result: builds, 0 assembler warnings.
- Tests performed: full suite, overworld comparison.
- Test results: all pass.
- Remaining risks: none known.
- Git commit message: `memory: drop the unused box save buffer from WRAM0`
- Next task: Phase 6, more RAM and ROM savings.

### DATA-001 — Evolution fall-through into Magikarp's entry

- Date: 2026-11-25
- AI agent: Claude (Claude Code)
- Audit phase: Phase 8 (Pokémon data)
- System: Evolutions
- Files modified: `data/pokemon/evos_attacks.asm`
- Problem identified: BUG-020, found while validating evolution data.
- Root cause: entries that did not end their evolution list ran into the next family's.
- Solution implemented: as approved by the user (see BUG-020).
- Behaviour preserved: learnsets unchanged (the same shared default); every other species' evolutions unchanged.
- Performance impact: none. Memory impact: 12 bytes more (675,252 free).
- Build result: builds, 0 assembler warnings.
- Tests performed: TEST-064, TEST-065, full suite.
- Test results: all pass.
- Remaining risks: none known.
- Git commit message: `fix: stop Porygon, Chansey and Blissey evolving into Gyarados`
- Next task: more data validators (base stats, items, marts, maps).

### DATA-002 — Map, item and base-stat data validation

- Date: 2026-11-25
- AI agent: Claude (Claude Code)
- Audit phase: Phase 8 (Pokémon, item and map data)
- System: Maps, items, marts, base stats
- Files modified: `data/pokemon/base_stats.asm`, `data/pokemon/base_stats/houndoom.asm`, `data/pokemon/base_stats/rapidash.asm`
- Problem identified: no data bugs found. The `evs` macro packs each yield into 2 bits without a range check, so a yield of 4 or more would silently corrupt the neighbouring stat's yield. Two BST comments were wrong.
- Root cause: missing build-time check; comments not updated after stat edits.
- Solution implemented: the `evs` macro asserts each yield is 0-3; the two comments corrected.
- Behaviour preserved: ROM byte-identical to the previous build.
- Performance impact: none. Memory impact: none.
- Build result: builds, 0 assembler warnings; a deliberate EV of 4 now stops the build with "EV yield must be 0-3".
- Tests performed: TEST-066 to TEST-070. The full suite was not rerun because the ROM did not change.
- Test results: all pass.
- Remaining risks: none known.
- Git commit message: `build: reject out-of-range EV yields and fix two BST comments`
- Next task: move data review, then battle facilities and the save system.

### BATTLE-009 — Blessing effect-chance overflow; move data validation

- Date: 2026-11-25
- AI agent: Claude (Claude Code)
- Audit phase: Phase 8 (move data)
- System: Secondary-effect chance, move data
- Files modified: `engine/battle/effect_commands.asm`
- Problem identified: BUG-021, found while checking how move effect chances are used.
- Root cause: an 8-bit doubling without a carry check.
- Solution implemented: after `sla [hl]`, a carry caps the chance at 100%.
- Behaviour preserved: chances up to 50% double exactly as before; Neutralizing Gas suppression unchanged; no effect without Blessing.
- Performance impact: none. Memory impact: 4 bytes (675,248 free).
- Build result: builds, 0 assembler warnings.
- Tests performed: TEST-071, TEST-072, full suite (128 scripts).
- Test results: all pass; the full suite matches the previous run apart from the new test.
- Remaining risks: none known.
- Git commit message: `fix: cap Blessing's doubled effect chance at 100%`
- Next task: battle facilities and the save system (Phase 8).

### FAC-001 — Battle Tower pool index past 256 mons; facility data

- Date: 2026-11-25
- AI agent: Claude (Claude Code)
- Audit phase: Phase 8 (battle facilities)
- System: Battle Tower and Battle Factory team generation
- Files modified: `engine/events/battle_tower/load_trainer.asm`
- Problem identified: BUG-022 (latent); one duplicate pool record (awaiting a decision).
- Root cause: operands of a 16-bit subtraction swapped in the high byte.
- Solution implemented: `ld a, d` / `sbc [hl]` instead of `ld a, [hl]` / `sbc d`.
- Behaviour preserved: identical results for today's pools (all challenges below 256 mons); selection stays uniform.
- Performance impact: none. Memory impact: none.
- Build result: builds, 0 assembler warnings.
- Tests performed: TEST-073, TEST-074, full suite (129 scripts). Scope: pool data, mon selection and the shared generation path the Factory also uses; the facility menus are covered by manual test MT-003.
- Test results: all pass; the full suite matches the previous run apart from the new test.
- Remaining risks: none known.
- Git commit message: `fix: correct the Battle Tower pool index past 256 mons`
- Next task: save system (Phase 8).

### SAVE-001 — Save system review

- Date: 2026-11-25
- AI agent: Claude (Claude Code)
- Audit phase: Phase 8 (save system)
- System: SRAM access, save and load, checksums, backup slot
- Files modified: `engine/pokemon/move_mon.asm`
- Problem identified: no save bugs. A duplicated `ret z` in `RemoveMonFromPartyPartial` could never run.
- Root cause: leftover line.
- Solution implemented: removed it.
- Behaviour preserved: same code path (the second `ret z` was unreachable).
- Performance impact: none. Memory impact: 1 byte.
- Build result: builds, 0 assembler warnings, 675,266 bytes free.
- Tests performed: TEST-076, full suite (130 scripts).
- Test results: all pass; the full suite matches the previous run.
- Remaining risks: behaviour on power loss mid-save is as in vanilla (main slot, then backup) and can only be checked by hand.
- Git commit message: `refactor: drop an unreachable ret in RemoveMonFromPartyPartial`
- Next task: Phase 8 graphics, audio and hardware compatibility; then Phase 7.

### HW-001 — Hardware and audio review; music fade WRAM bank

- Date: 2026-11-25
- AI agent: Claude (Claude Code)
- Audit phase: Phase 8 (audio engine, hardware compatibility)
- System: Audio engine, interrupts and DMA, Voltorb Flip
- Files modified: `audio/engine.asm`, `engine/games/voltorb_flip.asm`
- Problem identified: BUG-023. Voltorb Flip's interrupt masks were magic numbers.
- Root cause: an interrupt-time read of a banked WRAM variable without selecting its bank.
- Solution implemented: `FadeMusic` selects bank 1 for the read and restores the previous bank; Voltorb Flip uses `IE_DEFAULT` (same bytes).
- Behaviour preserved: identical when bank 1 is selected; song choice otherwise now follows the real player state.
- Performance impact: a few cycles once per finished fade. Memory impact: 12 bytes (675,254 free).
- Build result: builds, 0 assembler warnings.
- Tests performed: TEST-077, TEST-078, TEST-079, full suite (131 scripts).
- Test results: all pass; the full suite matches the previous run apart from the new test.
- Remaining risks: timing-dependent behaviour needs MT-008.
- Git commit message: `fix: read the player state from the right WRAM bank when a fade ends`
- Next task: Phase 8 graphics engine (TEST-080: no faults; Phase 8 complete); then Phase 7.

### QUAL-001 — Party switch merged; misleading comments

- Date: 2026-11-25
- AI agent: Claude (Claude Code)
- Audit phase: Phases 7 and 9
- System: Party menu, battle RAM comments, Phases 7 reviews
- Files modified: `engine/pokemon/switchpartymons.asm`, `engine/pc/bills_pc.asm`, `ram/wram.asm`
- Problem identified: two copies of the party slot swap; `wPlayerMinimized`/`wEnemyMinimized` marked "unused - can be removed" although Minimize depends on them; Phase 7 reviews (TEST-081 to TEST-089) found no further faults.
- Root cause: code ported from two sources; stale comments.
- Solution implemented: the party menu calls `SwapPartyMons`; the RAM comments say what the flags do; the TODO in `SwapPartyMons` replaced by a note on its second caller.
- Behaviour preserved: identical swap (TEST-090); the comment edits leave the ROM unchanged.
- Performance impact: none that matters (one far call per switch). Memory impact: 198 bytes (675,452 free).
- Build result: builds, 0 assembler warnings.
- Tests performed: TEST-085 to TEST-090, full suite (133 scripts).
- Test results: all pass; the full suite matches the previous run apart from the two new tests.
- Remaining risks: none known.
- Git commit message: `memory: reuse SwapPartyMons for the party menu switch`
- Next task: rest of Phase 9, then Phases 10-11.

### PERF-008 — Type chart matrices

- Date: 2026-11-25
- AI agent: Claude (Claude Code)
- Audit phase: Phase 4 (eliminate redundant calculations)
- System: Type effectiveness (damage and AI)
- Files modified: `data/types/type_matchups.asm`, `engine/battle/type_chart_scan.asm`, `engine/battle/effect_commands.asm`
- Problem identified: every type lookup walked the whole chart list; the AI does many per decision.
- Root cause: list format only.
- Solution implemented: see PERF-008. The lists are unchanged (entries now go through `type_matchup`, which also asserts no pair is listed twice in a chart); `GetTypeChart` returns a small descriptor per chart.
- Behaviour preserved: identical results, including the Stab rounding order and `wTypeModifier` (TEST-091, TEST-092).
- Performance impact: -12% AI switch decision, -10% AI move choice. Memory impact: 4,104 bytes of ROM (671,150 free); the section moved to a bank with room.
- Build result: builds, 0 assembler warnings.
- Tests performed: TEST-091 to TEST-093, `test_ai_perf`, full suite (135 scripts).
- Test results: all pass; the full suite matches the previous run apart from the new scripts.
- Remaining risks: none known. A new chart entry needs no extra step: the matrices are rebuilt from the list.
- Git commit message: `perf: look up type matchups in matrices built from the charts`
- Next task: Phase 5 register usage; rest of Phase 9; Phases 10-11.

### PERF-009-011 — Hot AI helpers

- Date: 2026-11-25
- AI agent: Claude (Claude Code)
- Audit phase: Phase 5 (register usage)
- System: Ability suppression checks, battle variables, far list lookups
- Files modified: `home/extra_functions.asm`, `home/battle_vars.asm`, `constants/battle_constants.asm`, `home/array.asm`, `engine/battle/ai/matchup.asm`
- Problem identified: the flat profile (TEST-094) showed small helpers called thousands of times per AI decision spending most of their time saving registers, double lookups and bank switches.
- Root cause: general-purpose code paths for the common case.
- Solution implemented: PERF-009, PERF-010, PERF-011.
- Behaviour preserved: same results and carry outputs (every caller of the suppression checks reads only carry; checked); the far list routine returns the same registers and flags as before.
- Performance impact: AI move choice -11% to -12% beyond PERF-008; worst-case switch decision 17.6 -> 15.4 frames. Memory impact: 40 bytes saved (671,190 free).
- Build result: builds, 0 assembler warnings.
- Tests performed: TEST-094, TEST-095, full suite (137 scripts).
- Test results: all pass; only profiler figures changed.
- Remaining risks: none known.
- Git commit message: `perf: speed up the hottest AI helpers`
- Next task: rest of Phase 9; Phases 10-11.

### BUG-024 — Keep the candidate and loop count during knockout scoring

- 2026-11-25, Phase 9. The starting tree at `cd5155d01` was clean. Tracing the discarded Rock Head check in `engine/battle/ai/layers/ai_basic.asm` exposed two live values that the following healing search overwrote.
- Saved the slot count across both searches. On a miss, reload the candidate using the outer move cursor before reading accuracy or power. Removed the discarded lookup. The scoring bonuses, thresholds and healing effects are unchanged. The local regression is in the existing romtest harness.
- TEST-096 passed. All paths balance the stack, restoring BC preserves the search carry, and AIGetEnemyMove preserves the cursor and score pointer. Release ROM gained 7 free bytes versus the same-host starting build (670,305 to 670,312). RAM layout unchanged.
- The initial Cygwin build encountered a stale Linux executable in the shared tools directory. Verification used isolated Linux builds and bundled RGBDS 0.7.0. Both the reconstructed baseline and starting HEAD have 885 fewer free bytes than the historical figures. Phase 11 will report same-toolchain deltas.
- Commit: `fix: preserve the candidate when scoring low-HP knockouts`. Next: correct the separate AI_Smart recoil lookup and score pointer.

### BUG-025 — Apply the recoil penalty to the scored move

- 2026-11-25, Phase 9. The dispatch table supplies the handler with HL pointing at the slot's score. The recoil handler reused HL for the Rock Head list and assumed A already contained the enemy species.
- In `engine/battle/ai/layers/ai_smart.asm`, check HP first, load the active enemy species, and save HL across the ability lookup. Documented how the dispatcher's temporary return address and move cursor work. The four recoil effects still use the same handler. The existing half-HP comparison includes equality.
- TEST-097 reproduced the stray write with the previous ROM. The fix preserves the Rock Head exemption and Neutralizing Gas interaction. Release ROM costs five bytes with identical RAM usage. Rebuilt and reran TEST-096 and the Iron Dukes score checks. The regression script lives in the local romtest harness.
- Commit: `fix: apply the recoil AI penalty to the selected move`. Next: Phase 10.

### PHASE10-CLOSE — Release and debug regression gate

- 2026-11-25. Build from fresh source with `make -j3 all d` (the debug target is `d`). TEST-098–100 passed. The historical suite count was 137. This checkout contained 134 scripts before adding TEST-096/097. The final run counts the 136 actually present.
- Ran the release tests in the populated build directory so asset checks could find the generated files. Supplied the buildable audit baseline to comparisons, the debug image and its symbols to the animation test, and Pillow for graphics checks. For the contest size assertion, built the baseline with the judging routine from before `24a7acb60`. The comparison passed all 300 contests and measured 747 to 692 bytes. The audit-baseline comparison independently matched the same 300 outcomes.
- Updated two local harness checks. The map comparison now reads the linked little-endian length and raw metatile/attribute bytes instead of decompressing them. The base-stat validator obtains item IDs from the repository constants instead of a previous session's temporary JSON file. The existing reviewed content exceptions remain in the validators.
- Added `tools/test_save_compat.py` so the emulator test can run in a fresh checkout with PyBoy and matching symbol files. Run `python tools/test_save_compat.py OLD/johtofrontier.gbc NEW/johtofrontier.gbc`. It boots through the normal menus and calls the save routine on the emulated CPU. ROM, SRAM and RTC writes are private to the test.
- Section 32 remains the play-test list. The emulator results cover boot, the overworld, menus and saving. Link play, the visual cases and physical timing are still open. Commit: `test: verify cross-version saves and close the regression phase`. Next: the final independent review.

### BUG-026 — Count empty banks in CRLF linker maps

- 2026-11-25, Codex, Phase 11. The Cygwin and Linux release images matched byte for byte, but the Cygwin build reported 32,768 fewer free bytes. Both maps marked two banks empty. The Cygwin map ended those lines with CRLF, and the `EMPTY` pattern in `tools/free_space.awk` required the word to end the record immediately.
- Allowed trailing whitespace on the empty-bank marker. TEST-101 passed on all four real maps. Relinking both targets via `make -j4 -W layout.link all d` reproduced the clean reference ROMs. Game code, runtime cost and memory usage are identical.
- The local checkout also had eight ignored Linux build executables alongside their Cygwin equivalents. Moving the Linux copies into the disposable verification directory restored the normal Cygwin build. Use separate build directories when switching hosts.
- Commit: `fix: count empty ROM banks in Windows linker maps`. Next: reconcile the final report.

### Event-command references and interactive regression checks

- 2026-11-25, Codex, Phase 11. Replaying the boxed gift using the numeric opcode comments led to the wrong script commands. For example, the compiled `givepoke` opcode is $2e and the comment still said $2d. Insertions in the ordered command list had left subsequent comments out of date.
- Corrected the inaccurate numeric comments in `macros/scripts/events.asm` and `engine/overworld/scripting.asm`. Preserved the command order, script data and emitted instructions. TEST-102 checks the linked targets and rebuild hashes. The change costs zero bytes and zero cycles.
- TEST-103 used the game's gift event, naming screen and PC menus. The Unown fixture displayed form 18 in the PC and retained it in the party after withdrawal. For the EV page, the emulator checked one mixed spread with maxed Attack, all six values at 252, and all six at zero. See Section 32 for the remaining play-throughs.
- Commit: `docs: correct event opcode references against the linked handlers`. Next: complete the independent review.

### PHASE11-CLOSE — Independent review and final measurements

- 2026-11-25, Codex. Reviewed the optimisation and fix history from the buildable baseline, the final linker maps and the regression coverage for each changed system. Reconstructed the expected lookup tables from the old ROM, executed the old and new battle-variable routines for both turns, and compared linked SRAM addresses and saved field offsets (TEST-104).
- Reran the performance fixtures on both revisions (TEST-105) and replayed Taunt through the battle menu (TEST-106). Checked all 4,877 tracked working files against the Git index, allowing for checkout line endings. The final report commit changes this audit only.
- Both configurations built and the measured ROMs match across Cygwin and Linux. Sections 24, 31–33 record the baseline discrepancy, speed/space trade-off and remaining play-tests. Commit: `docs: close the optimisation audit with verified results`.

### Follow-up — Battle Tower room replay

- Codex, 2026-11-25. Added `tools/test_tower_arrival.py` to reproduce MT-003 with disposable party and streak data. Run `python tools/test_tower_arrival.py johtofrontier.gbc` with PyBoy and matching symbols. The baseline reproduces BUG-005. All three release entries reached FIGHT with the expected trainer class, with 429 rendered frames compared (TEST-107).
- Release and debug builds passed. This test changes no game bytes. Commit: `test: replay Battle Tower opponent arrivals on CGB`. Next: the remaining link, ability and audiovisual play-tests.

## 31. Outstanding Issues

Maintain a list of:

- Potential bugs requiring further investigation.
- Confirmed bugs awaiting fixes.
- Ambiguous gameplay behaviour.
- Unfinished modifications.
- Unavailable testing tools.
- Hardware compatibility concerns.
- Performance concerns.
- Memory limitations.
- Issues requiring user approval.

Do not silently ignore unresolved issues.

- Resolved: the four partly passing tests were test-side faults, not ROM bugs (TEST-003).
- The interpreter tests live in the git-excluded `.claude-tools/romtest` folder, so fixes to them are recorded here but are not part of the repository history.
- Use the buildable baseline with the map, overworld-screen and type-chart comparison tests. The contest size assertion requires the judging routine from before `24a7acb60`. The animation test requires a debug ROM and matching symbols. Phase 10 corrected the raw metatile/attribute reader in `test_map_render_same` and reran it across all 307 maps.
- Phase 2 is complete as far as static checks and the interpreter can take it (TEST-005, 009, 011-020; BUG-003 to BUG-008). Crashes or freezes that depend on real-hardware timing can only be found with the manual checklist (Section 32).
- Phase 4: the type-chart index is done (PERF-008: matrices built from the unchanged lists). The worst-case AI switch decision is now 15.4 frames (after PERF-009 to PERF-011). Comparison tests (`test_type_chart_scan`, `test_type_chart_stab_order`) need the previous build as a third argument.
- Tooling note: on the mounted Windows working copy, `core.checkStat=minimal` lets `git status`/`git diff` miss edits made from Linux. Stage edited files explicitly (`git add <file>`) and take diffs with `git diff --cached`; a byte comparison of the tree against a fresh clone of HEAD (2026-11-25) found nothing uncommitted.
- Work in progress (author's): most species in `data/pokemon/evos_attacks.asm` share a placeholder entry (no evolution, only Splash learned); comments mark planned levels. Left as it is.
- PyBoy CGB runs covered the cases listed in Section 32 and the cross-version battery saves in TEST-100. Physical CGB display timing, DMA and link play still need external verification. The two ROMs built on each host agree. The 885-byte difference from the historical reference remains unexplained (Section 24).
- WRAM0 now has 32 bytes free (MEM-005); WRAMX banks 1, 3, 4, 6 and 7 are full; HRAM has 2 bytes free. Any feature or optimisation needing new RAM must reuse existing space.

- Decided by the user (2026-11-25): keep it. The Battle Tower Elite pool lists the Snorlax set (Leftovers, Double-Edge, Crunch, Earthquake, Rest) twice in a row (`data/battle_tower/parties.asm`, lines 115-116). It looks like a copy slip, but removing it changes how often that set appears, so it was left as it is (TEST-074).

- Decided by the user (2026-11-25): intended, keep it. The Victory Road GS Ball item uses `EVENT_CAN_GIVE_GS_BALL_TO_KURT` as its visibility flag (`disappear` sets it). Kurt clears that flag after checking the ball, so the ball reappears in Victory Road and can be picked up again, which lets the Celebi event be repeated. The Ilex Forest script keeps the GS Ball on purpose "to repeat this event", so this may be intended (TEST-081).

## 32. Manual Testing Checklist

Maintain a checklist of behaviours that require manual emulator or physical hardware testing.

For each test, provide:

- The system being tested.
- Required setup.
- Exact reproduction steps.
- Expected behaviour.
- Potential failure conditions.
- Relevant modifications.

Make manual testing instructions sufficiently clear for the user to perform without reading assembly code.

| Status on 2026-11-25 | Cases | Evidence or outstanding observation |
|---|---|---|
| Passed in PyBoy CGB | MT-001, MT-002, MT-004, MT-005 | Taunt move rejection and retry (TEST-106), boxed gift display and withdrawal, EV page, and gift nickname entry (TEST-103). |
| Passed in PyBoy CGB | MT-003 | Three scripted Battle Tower arrivals, player and attendant pixels, live trainer sprites and subsequent battles (TEST-107). |
| Awaiting full play-through | MT-008 | Voltorb Flip exit and the music heard when crossing maps on foot or by bicycle. Routine, map and audio checks are recorded separately. |
| Awaiting a linked pair | MT-006 | Both peers must agree through the battle. TEST-028 checked the RNG path. |
| Awaiting a configured battle | MT-007 | The shipped Neutralizing Gas list is empty. Use a disposable test build with an opponent assigned that ability for the switch sequence. TEST-041 covers the underlying suppression and hazard behaviour. |

- **MT-001 Taunt at the move menu (BUG-003).** Setup: any battle where the foe can use Taunt (or a save where your Pokémon gets Taunted). Steps: after your Pokémon is Taunted, open FIGHT and pick a status move (Growl, Swords Dance and the like). Expected: "The move is disabled" is shown and you choose again; damaging moves can still be picked. Failure: the status move is accepted and then fails during the turn.
- **MT-002 Gift Pokémon sent to the PC (BUG-004).** Setup: a full party. Steps: receive a gift Pokémon (any `givepoke` event) so it goes to a box, then view it in Bill's PC and withdraw it. Expected: it looks and behaves normally; a gift Unown shows a valid letter. Failure: wrong or garbled icon/picture.
- **MT-003 Battle Tower / Factory opponent (BUG-005).** Setup: enter a Battle Tower or Battle Factory challenge. Steps: watch each opponent warp in, and look at the other sprites on screen (you, the attendant). Expected: the opponent appears with the right sprite and nothing else on screen changes. Failure: a wrong or broken opponent sprite, or other sprites corrupted.

- **MT-004 EV page with maxed Attack (BUG-006).** Setup: a save with the EV page unlocked (`EVENT_UNLOCK_STAT_SCREEN_EFFORT_VALUES`) and a Pokémon with 252 Attack EVs (train it, or set it with a debug tool). Steps: open its stats screen and go to the page with the Effort Values; also try one with every EV at 252 and one with none. Expected: stars for each 252 value, numbers otherwise, and the screen closes normally. Failure (old build): crash or freeze on that page.

- **MT-005 Nickname a gift Pokémon that goes to the PC (BUG-008).** Setup: a full party of six. Steps: receive any gift Pokémon that offers a nickname (a `givepoke` event without a fixed OT, e.g. an Egg or starter-style gift); answer YES to the nickname prompt. Expected: the naming screen opens with the Pokémon's icon and gender symbol; finishing returns to the game and the message says it was sent to the PC. Failure (old build): the game freezes as the naming screen opens.

- **MT-006 Link battle with Haxorus (BUG-010).** Setup: two copies of the game linked (two emulators with link support, or two consoles), one player with a Haxorus. Steps: in a link battle, get Haxorus a status (burn, poison, paralysis) and play several turns. Expected: both screens always agree on whether Tenacity cured the status, and the battle continues in sync to the end. Failure (old build): the screens disagree and the battle desyncs.

- **MT-007 Neutralizing Gas and Spikes (BUG-015, BUG-016).** Setup: a battle with Spikes on your side, and an opponent with a Neutralizing Gas Pokémon. Steps: send in Gengar or Clefable (should now take Spikes damage); send in a Guts Pokémon that is burned, then let the foe's Neutralizing Gas Pokémon come in. Expected: Spikes damage the former Levitate/Magic Guard species; the burned Guts Pokémon's Attack drops while the gas is out and comes back when it leaves. Failure: no Spikes damage, or Guts still active under the gas.
- **MT-008 Leaving Voltorb Flip and finishing a music fade (BUG-023, TEST-077).** Setup: Goldenrod Game Corner with coins and the Coin Case; separately, a route where you can get on the Bicycle next to a map change. Steps: play Voltorb Flip and quit with Select; then ride and walk across map borders whose music differs. Expected: no stray sprites for even a frame when the game closes; the bike tune plays only while riding and the map's music while walking. Failure: garbage sprites on exit, or the bike tune after a fade while walking (or the reverse).

## 33. Final Deliverables

Upon completion, provide:

- A comprehensive summary of all modifications.
- A list of confirmed bugs fixed.
- A list of performance improvements.
- A list of memory improvements.
- Before-and-after ROM usage.
- Before-and-after WRAM usage.
- Before-and-after HRAM usage.
- Before-and-after SRAM usage.
- CPU cycle improvements for important routines.
- Build results.
- Automated testing results.
- Emulator testing results.
- Hardware testing results, if available.
- Remaining known issues.
- Systems that could not be fully verified.
- Outstanding risks.
- A manual testing checklist.
- A summary of Git commits.
- Recommendations for future maintenance.

Do not declare the audit complete while known critical issues remain unresolved.

Clearly distinguish between verified results and unverified assumptions.

### Final report · 2026-11-25

The final release builds on Linux and Cygwin and has 670,307 bytes of ROM free. Against the baseline rebuilt on the same host, the measured Meganium switching decision used 40.5% fewer CPU cycles. The release uses 3,470 additional ROM bytes overall and frees 32 bytes of WRAM0. The normal and inverse type-chart indexes account for 4,104 bytes of ROM in exchange for faster damage and AI calculations. ROM0 gained 21 free bytes.

#### Changes and confirmed fixes

| Area | Outcome | Detailed record |
|---|---|---|
| Build and tooling | Fixed case-sensitive graphics paths, tool permissions and empty-bank accounting on Windows. Corrected event-command opcode comments and restored the local comparison and validation tools. | BUG-001, 002, 026 and TEST-098–102 |
| Menus, Pokémon and facilities | Fixed Taunt's move-menu check, boxed gift forms and naming, the max-Attack EV crash, the NPC trade cartridge write and the invalid opponent sprite load. Corrected evolution list boundaries and the Tower pool index above 255. | BUG-003–008, 020, 022 |
| Battle engine and abilities | Fixed critical stages, link RNG, Quick Draw's rate, Choice Scarf overflow, Solar Beam and Magic Guard in hail, gas suppression and Spikes immunity, experience saturation, capture status bonuses, Catch Charm and Blessing's chance cap. | BUG-009–019, 021 |
| AI and audio | Preserved the candidate move and loop bounds during low-HP knockout scoring. Made the recoil penalty apply to the selected move and use the actual species. Fixed the WRAM bank used to select music when a fade ends. | BUG-023–025 |
| CPU and memory | Converted 115 banked calls and jumps, improved arithmetic and neutral-stage stat handling, indexed the type charts, and reduced work in ability, battle-variable and far-list lookups. Removed unused storage and shared duplicate routines, including the party/PC swap. | PERF-001–011 and MEM-001–008 |

The review also covered maps, events, graphics, audio, menus, storage, facilities and content tables. The duplicate Elite Snorlax set and repeatable GS Ball event retain the user's chosen behaviour. The author's unfinished evolution and learnset data remains a separate content project.

#### Measured CPU cost

Both columns use the same fixtures and SM83 M-cycle counter. Frame equivalents use 35,112 M-cycles per double-speed CGB frame. These figures measure the named routines under the harness's UI hooks.

| Fixture | Rebuilt baseline, M-cycles | Final, M-cycles | Baseline → final frames |
|---|---:|---:|---:|
| Switch with Meganium active | 909,606 | 541,034 | 25.9 → 15.4 |
| Switch with Feraligatr active | 151,651 | 97,031 | 4.3 → 2.8 |
| Choose a move, Swords Dance set | 265,152 | 170,603 | 7.6 → 4.9 |
| Choose a move, Recover/Swords Dance set | 224,858 | 146,819 | 6.4 → 4.2 |
| Choose a move, Hyper Beam set | 350,020 | 220,440 | 10.0 → 6.3 |

The Random fixture fell from 271 to 260 M-cycles per call and retained its sampled output sequence. Section 27 gives individual measurements, including 152,266 to 75,952 M-cycles across 161 Divide calls at the point of that optimisation. Its per-call estimates for direct bank-call conversions are labelled separately.

#### Build and test evidence

| Artifact | Free ROM | SHA-256 on both hosts |
|---|---:|---|
| `johtofrontier.gbc` | 670,307 bytes | `323b668ac6d02bf64cb0fc0ff77c76e631d2aa55e29a2dd09407121d618f5f67` |
| `johtofrontier_debug.gbc` | 668,839 bytes | `92550c30948fb85e53176e2b88cfb23d60e1bd6d2d3f10cf86382df076e11a28` |

All 136 available interpreter/regression scripts and 15 data validators passed. The two map comparisons matched all 307 maps. Decompression matched the source for 971 assets. The clean Linux build emitted zero assembler warnings and the same eleven graphics warnings as the rebuilt baseline. Section 24 gives before-and-after figures for all RAM regions.

In PyBoy, a baseline save loaded in the final ROM, a damaged primary recovered from the backup, and a resaved game loaded back in the baseline. The emulator also passed MT-001, 002, 004 and 005. Independent checks covered bank targets, the chart data and ordering, variable addressing, and save layouts (TEST-104). The physical console and two-peer link checks remain open. Section 32 records the four outstanding play-tests and their prerequisites.

#### Git history and future maintenance

From `aa0134723` through `aa50c4784`, 75 commits comprise 20 fix, 9 performance, 4 memory, 2 refactor, 2 build, 2 test and 36 documentation commits. The two AI fixes are `39098ece6` and `184ec0a2d`. Commit `91a30f955` adds the tracked save test, `8c5a9772b` fixes free-space reporting, and `aa50c4784` verifies event-command references. The individual work logs and Git history identify the earlier changes.

For future changes to battle calculations, rerun the same switching and move-choice fixtures and compare both outcomes and cycles. Retain matching older ROMs and symbols for graphics and save comparisons. Use separate host build directories, and check both linked maps before allocating ROM0, WRAM0 or HRAM. For changes involving interrupts, DMA or link timing, repeat the relevant Section 32 play-through on the target hardware.

## 34. Final Directive

Be rigorous, methodical, conservative and autonomous.

The objective is not to change as much code as possible.

The objective is to produce the fastest, most stable, reliable, memory-efficient and maintainable version of Johto Frontier reasonably possible while preserving its intended functionality.

Do not merely analyse the repository.

Do not merely provide recommendations.

Implement verified fixes and optimisations directly.

Build, test, document and commit each successful logical batch.

Maintain this document continuously.

Ensure another AI can resume the project at any time.

Continue until every major system has been comprehensively audited or a genuine blocker prevents further progress.

Begin by inspecting the repository, establishing the baseline and completing Phase 1. Then proceed systematically through all remaining phases.
