# CLAUDE.md

Standing rules for Claude Code in this repo. Decisions live in `docs/DECISIONS.md`;
status lives in `docs/PROGRESS.md`; work items live in `tasks/`.

## 1. Project
Online 1v1 arcade football for Android.
- Flutter + Flame app at the repo root (Flutter menus, Flame match).
- `/shared_physics`: pure-Dart deterministic physics, shared by client and server.
- `/server`: headless authoritative Dart server, 60 ticks/s.
- Nakama (guest auth, matchmaking, match records) comes later.
- Root `pubspec.yaml` is a pub workspace root; `shared_physics` and `server` are members.
- Versions: Flutter 3.38.5, Dart 3.10.4, Flame 1.35.1.

## 2. Roles
- **Human:** product owner and playtester. Runs all builds, emulators and devices.
  Commits, merges and releases.
- **Orchestrator chat:** writes tasks in `/tasks`.
- **Claude Code:** executes one task at a time.

## 3. Running a task
- Read the whole task file before doing anything.
- Inspect before coding: `git status`, the files you will touch, installed versions.
- Stay inside Scope. Out of scope means untouched, even if it looks broken; report it instead.
- Stop when "Done when" is met. Never start the next task.
- Do not edit `docs/PROGRESS.md` or `docs/DECISIONS.md` unless the task says so.

## 4. Hard rules
- `shared_physics` imports nothing from `flutter`, `dart:ui`, `flame` or `forge2d`.
- No `forge2d` or `flame_forge2d` anywhere (D-002).
- No new packages beyond the task's Constraints without asking.
- No secrets, keystores, `key.properties` or `.env*` files in git.
- Debug helpers (overlays, cheats, logging) are gated out of release builds
  (e.g. behind `kDebugMode` / `assert`).

## 5. Never build or run (D-012)
Do not run `flutter build`, `flutter run`, `flutter install`, `adb`, or start emulators.

When a task needs runtime, visual, device or feel checks, end the report with a
**Manual checks** list:
- Numbered; one action and one expected result per line.
- Include the exact commands for the human to run, e.g.:

```bash
flutter build apk --debug
flutter run
```

## 6. Testing
- Tests first for `shared_physics` and `server`.
- Name the verification level reached:
  1. Static (format, analyze)
  2. Pure rules
  3. Game system (engine contacts, input, restart)
  4. Runtime visual
  5. Human gameplay
  6. Real device
  7. Packaged release
- Claude Code reaches at most level 3. Levels 4–7 go in Manual checks.
- Flame tests pump a bounded number of frames (`tester.pump(duration)` in a fixed loop);
  never rely on `pumpAndSettle` (a running game never settles).

## 7. Commands
Root app (run from repo root):

```bash
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
```

`shared_physics` (run from `shared_physics/`):

```bash
dart format --output=none --set-exit-if-changed .
dart analyze
dart test
```

`server` (run from `server/`):

```bash
dart format --output=none --set-exit-if-changed .
dart analyze
dart test
dart run
```

To apply formatting, drop `--output=none --set-exit-if-changed`.
Dependencies resolve once for the whole workspace: `flutter pub get` at the root.
Root `flutter test` runs only root `test/`; package tests run from their own folders.

## 8. Stop and ask when
- The task conflicts with `docs/DECISIONS.md`.
- An installed API or version differs from what the task assumes.
- A check fails and the fix is outside Scope.
- Credentials are needed.

## 9. Report format
1. Files changed
2. Commands and results
3. Verification level reached
4. Decisions made
5. Open questions
6. Left undone
7. Manual checks (if any)

## 10. Commit policy
Never commit, branch, merge or push unless the task says so (D-008).
