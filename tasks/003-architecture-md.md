# Task 003 — docs/ARCHITECTURE.md

## Goal
Write docs/ARCHITECTURE.md describing the locked architecture and boundaries, so later tasks can cite it.

## Context
CLAUDE.md, docs/DECISIONS.md (source of truth; do not add or change decisions), the current repo layout.

## Scope
Write docs/ARCHITECTURE.md only, with these sections:
1. Repo layout — Flutter app at root (lib/, test/, android/); /shared_physics; /server; /tasks; /docs; pub workspace with one lockfile. Dependency direction: app → shared_physics, server → shared_physics. Never the reverse; app and server never import each other.
2. Simulation model — fixed 60 Hz tick; state advances only through step(state, inputs) → state; inputs are per player per tick (move axis, jump, kick); gameplay time counts ticks, not wall clock; the client render loop uses an accumulator with capped catch-up (cap value: TBD (M1)).
3. Determinism rules (provisional, D-007) — doubles with only + − × ÷ and sqrt in the step; no dart:math trig, exp or pow in the step; no Random without a seed stored in state; no iteration over unordered collections in the step.
4. Units — meters; origin and axis directions; pitch dimensions as named constants in one config file (values: TBD (M1)).
5. Rule events — collisions produce queued events (goal, kick contact) tagged with match id and tick; rules consume them; restart replaces the whole state.
6. Online model (target for M3, not built yet) — server authoritative at 60 ticks/s; client predicts its own player and reconciles; opponent and ball are interpolated; Nakama handles auth, matchmaking and records and hands players to the match server.
7. Out of scope for MVP — the backlog from docs/PROGRESS.md.

Mark every unknown value as TBD (milestone). Do not touch code.

## Done when
- The file exists, all 7 sections are present, and nothing contradicts DECISIONS.md.
- Only docs/ARCHITECTURE.md is new (plus the edits from steps 1–2 of this prompt).

## Report back
Path; anywhere the repo disagrees with the document; open questions.

## Commit policy
Do not commit.
