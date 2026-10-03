# DECISIONS
| ID | Date | Decision | Reason | Rejected |
|----|------|----------|--------|----------|
| D-001 | 2026-10-03 | Client: Flutter + Flame (Flutter menus, Flame match) | Existing stack | Unity, Godot |
| D-002 | 2026-10-03 | Custom deterministic physics in pure-Dart shared_physics; no Forge2D anywhere | Same code on client and server | Forge2D |
| D-003 | 2026-10-03 | Headless Dart server, authoritative, 60 ticks/s; client predicts self, interpolates opponent + ball | Fairness | P2P, lockstep |
| D-004 | 2026-10-03 | Nakama (Dart SDK) for guest auth, matchmaking, match records | Off-the-shelf backend | Custom backend |
| D-005 | 2026-10-03 | Monorepo (superseded by D-009) | Shared code, one source of truth | Multi-repo |
| D-006 | 2026-10-03 | Roles: orchestrator chat writes tasks; Claude Code executes one task at a time; human owns scope, playtests, merges, releases | Factory roles mapped | — |
| D-007 | 2026-10-03 | PROPOSED: doubles with + − × ÷ sqrt only in the step; fixed-point only if M3 shows drift | Server correction absorbs drift | Fixed-point now |
| D-008 | 2026-10-03 | Claude Code never commits, merges or pushes unless the task says so | Safety | Auto-commit |
| D-009 | 2026-10-03 | Flutter app is the repo root; /shared_physics, /server, /tasks, /docs are subfolders. Supersedes D-005 layout | Project was created at root; moving it adds no value | Separate /game folder |
| D-012 | 2026-10-03 | Claude Code never builds APKs, launches emulators or installs/runs the app. Where a task needs that, Code writes a "Manual checks" list for the human instead | Human verifies runtime and device behavior personally | Code self-verifies on emulator |
