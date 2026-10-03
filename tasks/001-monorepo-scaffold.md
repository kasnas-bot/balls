# Task 001 — Monorepo scaffold (app at root)

## Goal
Add /shared_physics and /server packages inside the root Flutter app, wired together, each with a passing test.

## Context (read first)
docs/PROGRESS.md, docs/DECISIONS.md (D-002, D-009). Run `git status`, `flutter --version`, `dart --version`; inspect the root pubspec.yaml and /android before changing anything.

## Scope
- Root Flutter app: do NOT change its package id. Remove non-Android platform folders if present (list them first). Add `flame`. Replace the counter demo with a screen showing a GameWidget with an empty FlameGame. Add a dependency on shared_physics. Update the default widget test so it passes.
- /shared_physics: pure Dart package. Export `const physicsTickHz = 60;` plus one test.
- /server: Dart console package depending on shared_physics; `dart run` prints the tick rate. One test.
- .gitignore: make sure it covers build output and .dart_tool/ in all three packages, plus *.jks, *.keystore, key.properties, .env*.
- Linking: use a pub workspace with the root app as workspace root if the installed Dart SDK supports it, otherwise path dependencies. Explain the choice.
- Make sure root `flutter analyze` and `flutter test` do not fail because of the nested packages (exclude them in analysis_options.yaml or rely on the workspace — explain).

Out of scope: gameplay, physics, networking, Nakama, CI, CLAUDE.md, ARCHITECTURE.md.

## Constraints
- No forge2d or flame_forge2d anywhere (D-002).
- shared_physics must not depend on flutter, dart:ui or flame.
- Use the latest Flame release compatible with the installed Flutter; record the resolved version from the lockfile.

## Done when
- `flutter analyze` clean at root; `dart analyze` clean in shared_physics and server.
- `flutter test` passes at root; `dart test` passes in shared_physics and server.
- `dart run` in /server prints 60.
- `flutter build apk --debug` succeeds (packaging proof only).
- App launches on the emulator showing the empty Flame screen (state if you could not check this).

## Report back
Files changed; commands and results; resolved Flutter, Dart and Flame versions; workspace vs path-dep choice; how nested packages are kept out of root analyze/test; open questions; anything left undone.

## Commit policy
Do not commit.
