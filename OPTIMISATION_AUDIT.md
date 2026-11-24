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

- [ ] Understand repository architecture.
- [ ] Inspect build system.
- [ ] Establish baseline build.
- [ ] Record ROM usage.
- [ ] Record WRAM usage.
- [ ] Record HRAM usage.
- [ ] Record SRAM usage.
- [ ] Record compiler warnings.
- [ ] Identify available testing tools.
- [ ] Identify major performance bottlenecks.
- [ ] Establish audit infrastructure.
- [ ] Commit baseline documentation.

### Phase 2 — Critical Stability Issues

- [ ] Audit crashes.
- [ ] Audit freezes.
- [ ] Audit softlocks.
- [ ] Audit memory corruption.
- [ ] Audit stack corruption.
- [ ] Audit register corruption.
- [ ] Audit ROM banking.
- [ ] Audit RAM banking.
- [ ] Audit interrupt safety.
- [ ] Audit invalid memory accesses.

### Phase 3 — Battle Engine Correctness

- [ ] Audit damage calculations.
- [ ] Audit critical hits.
- [ ] Audit accuracy and evasion.
- [ ] Audit speed and priority.
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
- [ ] Audit battle state initialisation and cleanup.

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
| Git commit | Pending | Pending | Pending |
| RGBDS version | Pending | Pending | Pending |
| Build status | Pending | Pending | Pending |
| Total ROM size | Pending | Pending | Pending |
| Used ROM space | Pending | Pending | Pending |
| Free ROM space | Pending | Pending | Pending |
| WRAM usage | Pending | Pending | Pending |
| HRAM usage | Pending | Pending | Pending |
| SRAM usage | Pending | Pending | Pending |
| Compiler warnings | Pending | Pending | Pending |
| Automated tests | Pending | Pending | Pending |

### Build Environment

- Build command: Pending
- Clean build command: Pending
- Testing commands: Pending
- Emulator tools: Pending
- Profiling tools: Pending
- Validation tools: Pending

## 25. Current Project Status

- Overall status: Not started
- Current phase: Phase 1
- Current task: Initial repository analysis
- Current AI agent: Pending
- Current Git branch: Pending
- Last verified build: Pending
- Last completed task: None
- Last verified commit: Pending
- Outstanding blockers: None recorded
- Next task: Establish repository baseline

Update this section continuously.

## 26. Confirmed Bug Tracker

Maintain the following table throughout the project.

| ID | System | Bug | Severity | Status | Verification |
|---|---|---|---|---|---|

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

Use unique identifiers such as PERF-001, PERF-002 and PERF-003.

Record machine-cycle savings, measured execution time or other relevant performance measurements.

Distinguish between measured improvements and calculated estimates.

Do not invent performance figures.

## 28. Memory Optimisation Tracker

Maintain the following table.

| ID | Memory Region | Modification | Before | After | Bytes Saved | Verification |
|---|---|---|---|---|---|---|

Use unique identifiers such as MEM-001, MEM-002 and MEM-003.

Record negative savings when a justified performance improvement increases memory usage.

Document significant speed-versus-memory trade-offs.

## 29. Testing Tracker

Maintain the following table.

| Test ID | System | Test Description | Test Method | Result | Notes |
|---|---|---|---|---|---|

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
