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
- [ ] Audit stat calculations.
- [ ] Audit status conditions.
- [ ] Audit abilities.
- [ ] Audit dual-ability interactions.
- [ ] Audit held items.
- [ ] Audit weather.
- [ ] Audit entry hazards.
- [ ] Audit switching.
- [ ] Audit fainting.
- [ ] Audit end-of-turn effects.
- [ ] Audit move effects.
- [ ] Audit experience.
- [ ] Audit level scaling.
- [ ] Audit capture mechanics.
- [x] Audit battle state initialisation and cleanup.

### Phase 4 — Battle AI

- [ ] Audit move scoring.
- [ ] Audit switching decisions.
- [ ] Audit damage estimation.
- [ ] Audit KO detection.
- [ ] Audit AI speed calculations.
- [ ] Audit ability awareness.
- [ ] Audit item awareness.
- [ ] Audit trainer AI flags.
- [ ] Eliminate redundant calculations.
- [ ] Optimise AI execution speed.
- [ ] Verify AI decision quality.

### Phase 5 — CPU Performance

- [ ] Identify frequently executed routines.
- [ ] Optimise battle routines.
- [ ] Optimise overworld routines.
- [ ] Optimise arithmetic routines.
- [ ] Optimise loops.
- [ ] Optimise memory operations.
- [ ] Optimise register usage.
- [ ] Optimise banked calls.
- [ ] Investigate safe tail calls.
- [ ] Record measurable cycle savings.

### Phase 6 — ROM and RAM Optimisation

- [ ] Audit ROM bank utilisation.
- [ ] Audit WRAM bank utilisation.
- [ ] Audit HRAM utilisation.
- [ ] Audit SRAM utilisation.
- [ ] Investigate duplicate routines.
- [ ] Investigate duplicate data.
- [ ] Investigate unused code.
- [ ] Investigate unused variables.
- [ ] Investigate safe memory sharing.
- [ ] Record memory savings.

### Phase 7 — Overworld and Interface

- [ ] Audit movement.
- [ ] Audit map loading.
- [ ] Audit map transitions.
- [ ] Audit wild encounters.
- [ ] Audit NPC behaviour.
- [ ] Audit scripts.
- [ ] Audit menus.
- [ ] Audit inventory.
- [ ] Audit shops.
- [ ] Audit Pokédex.
- [ ] Audit party management.
- [ ] Audit PC storage.
- [ ] Audit input handling.
- [ ] Audit text rendering.

### Phase 8 — Data and Remaining Systems

- [ ] Audit Pokémon data.
- [ ] Audit move data.
- [ ] Audit item data.
- [ ] Audit trainer data.
- [ ] Audit encounter data.
- [ ] Audit battle facilities.
- [ ] Audit save system.
- [ ] Audit graphics engine.
- [ ] Audit audio engine.
- [ ] Audit hardware compatibility.
- [ ] Create data-validation tools where practical.

### Phase 9 — Code Quality

- [ ] Investigate duplicated logic.
- [ ] Simplify unnecessarily complicated routines.
- [ ] Improve misleading comments.
- [ ] Document complex custom routines.
- [ ] Remove confirmed obsolete code.
- [ ] Verify all refactoring changes.

### Phase 10 — Comprehensive Regression Testing

- [ ] Perform full repository build.
- [ ] Run available automated tests.
- [ ] Run available data-validation scripts.
- [ ] Perform available emulator tests.
- [ ] Test custom battle mechanic interactions.
- [ ] Test battle AI.
- [ ] Test overworld systems.
- [ ] Test menus.
- [ ] Test save compatibility.
- [ ] Test battle facilities.
- [ ] Review hardware compatibility.
- [ ] Document outstanding manual testing requirements.

### Phase 11 — Final Independent Review

- [ ] Review all optimisation commits.
- [ ] Review all bug-fix commits.
- [ ] Review potential regressions.
- [ ] Verify final build.
- [ ] Verify final memory usage.
- [ ] Verify performance improvements.
- [ ] Review outstanding risks.
- [ ] Produce final audit report.

Additional tasks may be added when necessary.

Do not mark a task complete merely because its files have been read. Record the actual verification performed.

## 24. Baseline Measurements

Populate this section during the initial audit.

| Measurement | Baseline | Current | Final |
|---|---|---|---|
| Git commit | `aa0134723` (+ BUG-001/002 build fixes, ROM unchanged) | `936e0c1c1` | Pending |
| RGBDS version | 0.7.0 (rgbasm/rgblink/rgbfix/rgbgfx) | 0.7.0 | Pending |
| Build status | Fails on a clean case-sensitive checkout (BUG-001/002); builds after the fixes | Builds | Pending |
| Total ROM size | 2,097,152 bytes (2 MiB, 128 banks, MBC3+RAM+battery+timer) | Same | Pending |
| Used ROM space | 1,422,490 bytes (ROM0 16,042 + ROMX 1,406,448) | Same | Pending |
| Free ROM space | 674,662 bytes (32.17%; ROM0 342, ROMX 674,320) | Same | Pending |
| WRAM usage | WRAM0 4,096/4,096 (0 free); WRAMX 28,476/28,672 (196 free: bank 2 $54, bank 5 $70, banks 1/3/4/6/7 full) | Same | Pending |
| HRAM usage | 125/127 bytes (2 free) | Same | Pending |
| SRAM usage | 32,155/32,768 bytes (613 free: bank 0 $220, bank 1 $29, banks 2/3 $0E each) | Same | Pending |
| Compiler warnings | 0 (full build log) | 0 | Pending |
| Automated tests | 108 interpreter test scripts: 84 fully pass, 4 partly pass, 12 crash on renamed/removed symbols, 8 report in other formats (see TEST-002) | Same | Pending |

Baseline ROM (`johtofrontier.gbc` MD5 `3142da94d2e5cde28cb9df2c79ff8d8b`, built on Linux from the fixed clean clone), its `.sym` and `.map` are kept outside the repository for before/after comparisons.

### Build Environment

- Build command: `make -j4` (RGBDS 0.7.0 on `PATH`, or `make RGBDS=<dir>/`). Builds `johtofrontier.gbc` and prints the free space (`tools/free_space.awk`).
- Clean build command: `make clean && make -j4`, or a fresh `git clone` followed by `make -j4` (as done for the baseline).
- Debug ROM: `make debug` (`johtofrontier_debug.gbc`).
- Testing commands: `python3 .claude-tools/romtest/<test>.py .claude-tools/romtest <dir with johtofrontier.gbc/.sym>`. The tests load the built ROM and symbol file and run real routines on a Python SM83 interpreter (`sm83.py`, `romlib.py`). `gbrender.py` renders screens built by the routines (tilemap, attrmap, VRAM, palettes) to PNG files. `.claude-tools/` is excluded from Git (`.git/info/exclude`), so the tools live only in the working copy.
- Emulator tools: none available in the build environment (no headless emulator). Interpreter tests and renders are not an emulator: VBlank/HBlank and DMA are emulated by hooks, not by real timing.
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

- Overall status: In progress
- Current phase: Phase 3 (battle engine correctness)
- Current task: Phase 3: battle engine correctness
- Current AI agent: Claude (Claude Code)
- Current Git branch: `000-Johto-Frontier`
- Last verified build: clone of `d007b16f8`, Linux, RGBDS 0.7.0, 0 assembler warnings, 674,986 bytes free
- Last completed task: BATTLE-001 (BUG-009)
- Last verified commit: `d007b16f8` (full suite: 105 scripts, 95 fully passing, the rest profilers/comparisons)
- Outstanding blockers: none
- Next task: Phase 3 checklist

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
- The suite is a usable regression gate again (TEST-004). The four comparison tests (`test_bug_contest_judging`, `test_map_render_same`, `test_overworld_screen_same`, `test_type_chart_scan`) should be run with the baseline ROM as the older build after any change to those systems. `test_view_animations` needs a debug build. `test_map_render_same` is stale (written for the removed LZP format) and should be rewritten or retired; `test_overworld_screen_same` covers the same ground (TEST-010).
- Phase 2 is complete as far as static checks and the interpreter can take it (TEST-005, 009, 011-020; BUG-003 to BUG-008). Crashes or freezes that depend on real-hardware timing can only be found with the manual checklist (Section 32).
- No emulator or physical hardware is available here: VBlank/HBlank timing, DMA and real-hardware behaviour can only be checked in the interpreter with emulated hooks. Anything timing-sensitive needs manual emulator testing (Section 32).
- WRAM0 and WRAMX banks 1, 3, 4, 6 and 7 are full; HRAM has 2 bytes free. Any feature or optimisation needing new RAM must reuse existing space.

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

- **MT-001 Taunt at the move menu (BUG-003).** Setup: any battle where the foe can use Taunt (or a save where your Pokémon gets Taunted). Steps: after your Pokémon is Taunted, open FIGHT and pick a status move (Growl, Swords Dance and the like). Expected: "The move is disabled" is shown and you choose again; damaging moves can still be picked. Failure: the status move is accepted and then fails during the turn.
- **MT-002 Gift Pokémon sent to the PC (BUG-004).** Setup: a full party. Steps: receive a gift Pokémon (any `givepoke` event) so it goes to a box, then view it in Bill's PC and withdraw it. Expected: it looks and behaves normally; a gift Unown shows a valid letter. Failure: wrong or garbled icon/picture.
- **MT-003 Battle Tower / Factory opponent (BUG-005).** Setup: enter a Battle Tower or Battle Factory challenge. Steps: watch each opponent warp in, and look at the other sprites on screen (you, the attendant). Expected: the opponent appears with the right sprite and nothing else on screen changes. Failure: a wrong or broken opponent sprite, or other sprites corrupted.

- **MT-004 EV page with maxed Attack (BUG-006).** Setup: a save with the EV page unlocked (`EVENT_UNLOCK_STAT_SCREEN_EFFORT_VALUES`) and a Pokémon with 252 Attack EVs (train it, or set it with a debug tool). Steps: open its stats screen and go to the page with the Effort Values; also try one with every EV at 252 and one with none. Expected: stars for each 252 value, numbers otherwise, and the screen closes normally. Failure (old build): crash or freeze on that page.

- **MT-005 Nickname a gift Pokémon that goes to the PC (BUG-008).** Setup: a full party of six. Steps: receive any gift Pokémon that offers a nickname (a `givepoke` event without a fixed OT, e.g. an Egg or starter-style gift); answer YES to the nickname prompt. Expected: the naming screen opens with the Pokémon's icon and gender symbol; finishing returns to the game and the message says it was sent to the PC. Failure (old build): the game freezes as the naming screen opens.

- **MT-006 Link battle with Haxorus (BUG-010).** Setup: two copies of the game linked (two emulators with link support, or two consoles), one player with a Haxorus. Steps: in a link battle, get Haxorus a status (burn, poison, paralysis) and play several turns. Expected: both screens always agree on whether Tenacity cured the status, and the battle continues in sync to the end. Failure (old build): the screens disagree and the battle desyncs.

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
