# PROGRESS
_Last updated: 2026-10-03_

## Current milestone: M0 — Setup
| # | Task | Status |
|---|------|--------|
| P1–P5 | Toolchain, GitHub repo, Flutter app created at repo root, git init, Claude Code | done |
| P6 | Bootstrap tracking files | done (manual check pending: human builds APK and launches app) |
| 001 | Monorepo scaffold (app at root) | done (manual check pending: human builds APK and launches app) |
| 002 | Root CLAUDE.md | in progress |
| 003 | docs/ARCHITECTURE.md | todo |
| 004 | CI: format, analyze, test, import guard | todo |

## Roadmap
| Milestone | Week | Gate | Status |
|---|---|---|---|
| M0 Setup | 0 | CI green on a real push | in progress |
| M1 Physics prototype | 1 | Human playtest rates named tuning configs; one is fun | todo |
| M2 Match loop + bot | 2 | Full 60 s match vs bot; uncoached comprehension | todo |
| M3 Online netcode | 3–5 | Playable at 150 ms / 5% loss; checkpoint end wk 4 | todo |
| M4 Backend | 6 | Guest auth, quick match, bot fallback ~10 s, stored results | todo |
| M5 Polish + instrumentation | 7 | Internal track build on a real device | todo |
| M6 Closed test | 8–9 | 50–100 players; go/no-go | todo |

## Open decisions
- D-007 number representation in shared_physics (before M1)
- Network transport (before M3)
- Server hosting + budget (before M3)

## Blockers
None.

## Backlog (do not build)
Power-up draft, roguelike run mode, live arenas, match modifiers, shop, IAP, ads, leagues, social.
