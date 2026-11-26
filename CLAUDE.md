# Project Instructions

- Use `jmp` instead of `jp`. Prefer `jr` whenever safely within range.
- Preserve native `jp` instructions required by macros or indirect jumps.
- Optimise `farcall` followed by `ret` to `farjp` whenever safe.
- Prioritise correctness, execution speed and ROM efficiency.
- Keep changes focused. Avoid unnecessary scans and unrelated refactoring.
- Build and verify changes before committing.
- Automatically commit each completed, verified change.
- Keep commit messages short and descriptive.
- Keep responses concise. Avoid unnecessary explanations.
- Do not add links, AI attribution, signatures or co-author trailers to code, documentation or commits.
