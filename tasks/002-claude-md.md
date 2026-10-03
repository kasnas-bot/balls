# Task 002 — Root CLAUDE.md

## Goal
Write /CLAUDE.md: the standing rules Claude Code follows in this repo.

## Context
docs/DECISIONS.md (all), docs/PROGRESS.md, task 001 results (commands that work here).

## Scope
Write /CLAUDE.md only, under ~120 lines, with these sections:
1. Project — online 1v1 arcade football for Android. Flutter + Flame app at repo root; pure-Dart /shared_physics; headless Dart /server at 60 ticks/s; Nakama later. Flutter 3.38.5, Dart 3.10.4, Flame 1.35.1.
2. Roles — human: product owner, playtester, runs all builds and devices, commits and releases. Orchestrator chat: writes tasks in /tasks. Claude Code: executes one task at a time.
3. Running a task — read the whole task file; inspect before coding; stay inside Scope; stop at "Done when"; never start the next task; don't edit PROGRESS/DECISIONS unless the task says so.
4. Hard rules — shared_physics imports nothing from flutter, dart:ui, flame or forge2d; no forge2d anywhere; no new packages beyond the task's Constraints without asking; no secrets or keystores in git; debug helpers gated out of release builds.
5. Never build or run (D-012) — do not run `flutter build`, `flutter run`, `flutter install`, adb, or start emulators. When a task needs runtime, visual, device or feel checks, end the report with a "Manual checks" list: numbered, one action and one expected result per line, plus the exact commands for the human to run.
6. Testing — tests first for shared_physics and server. Name the verification level reached, using this ladder: 1 static (format, analyze), 2 pure rules, 3 game system (engine contacts, input, restart), 4 runtime visual, 5 human gameplay, 6 real device, 7 packaged release. Code reaches at most level 3; 4–7 go in Manual checks. Flame tests pump a bounded number of frames and never rely on pumpAndSettle.
7. Commands — the exact format, analyze and test commands for the root, shared_physics and server, as they worked in task 001.
8. Stop and ask when — the task conflicts with DECISIONS.md; an installed API differs from what the task assumes; a check fails and the fix is outside Scope; credentials are needed.
9. Report format — files changed; commands and results; verification level reached; decisions made; open questions; left undone; Manual checks (if any).
10. Commit policy — never commit, branch, merge or push unless the task says so.

Touch no other files.

## Done when
- /CLAUDE.md exists and covers all 10 sections.
- Every command in section 7 has been run once and works.
- git status shows only CLAUDE.md as new or changed (apart from the doc edits in this prompt).

## Report back
Path, line count, any command that failed, open questions.

## Commit policy
Do not commit.
