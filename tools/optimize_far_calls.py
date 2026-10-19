
#!/usr/bin/env python3
"""
Find and optionally optimize far tail calls in RGBDS assembly.

Transforms:
    farcall SomeRoutine
    ret

    callfar SomeRoutine
    ret

Into:
    farjp SomeRoutine

By default, performs a dry run. Use --write to modify files.
"""

import argparse
import re
from pathlib import Path

EXTENSIONS = {".asm", ".inc", ".mac"}

# Match direct far-call instructions.
CALL_RE = re.compile(
    r"^(?P<indent>[ \t]*)(?:farcall|callfar)[ \t]+"
    r"(?P<target>[A-Za-z_.$@][\w.$@]*)"
    r"(?P<tail>[ \t]*(?:;.*)?)$",
    re.IGNORECASE,
)

# Match only an unconditional RET, optionally with a comment.
RET_RE = re.compile(
    r"^[ \t]*ret[ \t]*(?:;.*)?$",
    re.IGNORECASE,
)


def is_ignorable(line):
    """Return True for blank lines and full-line comments."""
    stripped = line.strip()
    return not stripped or stripped.startswith(";") or stripped.startswith("*")


def optimize_file(path, write=False):
    """Find and optionally replace far-call + RET tail calls."""
    original = path.read_text(encoding="utf-8")
    lines = original.splitlines(keepends=True)

    changes = []
    i = 0

    while i < len(lines):
        line = lines[i].rstrip("\r\n")
        match = CALL_RE.match(line)

        if not match:
            i += 1
            continue

        # Find the next instruction, skipping blank lines and comments.
        j = i + 1
        while j < len(lines) and is_ignorable(lines[j]):
            j += 1

        # Only optimize when the next instruction is an unconditional RET.
        if j >= len(lines):
            i += 1
            continue

        ret_line = lines[j].split(";", 1)[0].strip()
        if not RET_RE.fullmatch(ret_line):
            i += 1
            continue

        target = match.group("target")
        indent = match.group("indent")
        tail = match.group("tail")

        # Preserve the original line-ending style.
        if lines[i].endswith("\r\n"):
            newline = "\r\n"
        elif lines[i].endswith("\n"):
            newline = "\n"
        else:
            newline = ""

        # Replace the far call with farjp.
        lines[i] = f"{indent}farjp {target}{tail}{newline}"

        # Remove the unconditional RET.
        del lines[j]

        changes.append((i + 1, target))
        i += 1

    if changes and write:
        with path.open("w", encoding="utf-8", newline="") as f:
            f.write("".join(lines))

    return changes


def main():
    parser = argparse.ArgumentParser(
        description="Find and optimize far-call + RET tail calls."
    )

    parser.add_argument(
        "--write",
        action="store_true",
        help="Apply changes. Without this option, only report matches.",
    )

    parser.add_argument(
        "--path",
        default=".",
        help="Repository directory to scan (default: current directory).",
    )

    args = parser.parse_args()
    root = Path(args.path).resolve()

    excluded_dirs = {
        ".git",
        ".hg",
        ".svn",
        "build",
        "node_modules",
        "__pycache__",
    }

    total = 0
    files_changed = 0

    for path in sorted(root.rglob("*")):
        if not path.is_file() or path.suffix.lower() not in EXTENSIONS:
            continue

        if any(part in excluded_dirs for part in path.relative_to(root).parts):
            continue

        changes = optimize_file(path, write=args.write)

        if not changes:
            continue

        files_changed += 1
        total += len(changes)

        for line_number, target in changes:
            action = "Replaced" if args.write else "Would replace"
            print(
                f"{path.relative_to(root)}:{line_number}: "
                f"{action}: farcall/callfar {target} + ret -> farjp {target}"
            )

    print()
    print(
        f"{'Optimized' if args.write else 'Found'} "
        f"{total} far tail calls in {files_changed} files."
    )

    if not args.write:
        print("Dry run only. No files were modified.")
        print("Run with --write to apply the changes.")


if __name__ == "__main__":
    main()
