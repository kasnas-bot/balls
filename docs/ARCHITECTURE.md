# ARCHITECTURE
_Last updated: 2026-10-03_

How the game is put together and where the boundaries are. `docs/DECISIONS.md` is the
source of truth; this document explains it and never overrides it. Unknown values are
marked **TBD (milestone)**.

## 1. Repo layout
Monorepo, Flutter app at the root (D-009, superseding the D-005 layout).

| Path | What | Depends on |
|---|---|---|
| `/` (`lib/`, `test/`, `android/`) | Flutter + Flame client, Android only (D-001) | `shared_physics` |
| `/shared_physics` | Pure-Dart deterministic simulation (D-002) | nothing in this repo |
| `/server` | Headless authoritative Dart server (D-003) | `shared_physics` |
| `/tasks` | One file per task, written by the orchestrator (D-006) | — |
| `/docs` | PROGRESS, DECISIONS, ARCHITECTURE | — |

- The root `pubspec.yaml` is a pub workspace root; `shared_physics` and `server` are
  members. One lockfile (`/pubspec.lock`) for the whole repo, so client and server always
  run identical dependency versions.
- Dependency direction:

  ```
  app (root) ──► shared_physics ◄── server
  ```

  Never the reverse: `shared_physics` imports neither the app nor the server. The app and
  the server never import each other.
- `shared_physics` imports nothing from `flutter`, `dart:ui`, `flame` or `forge2d`, so it
  runs unchanged on the Dart VM server. No Forge2D anywhere (D-002).

## 2. Simulation model
- Fixed tick rate: 60 Hz (`physicsTickHz` in `shared_physics`).
- State advances only through one pure function:

  ```
  step(state, inputs) → state
  ```

  No other code mutates simulation state. The same `step` runs on client and server.
- Inputs are per player, per tick: move axis, jump, kick.
- Gameplay time is counted in ticks, never wall-clock time (match length, cooldowns,
  timers are all tick counts; a 60 s match is 3600 ticks).
- Client render loop: an accumulator collects frame time and runs whole ticks; catch-up
  per frame is capped so a long stall cannot trigger a spiral of steps.
  Cap value: **TBD (M1)**. Rendering may interpolate between the last two states.

## 3. Determinism rules (provisional, D-007)
D-007 is PROPOSED, not locked; these rules hold until it is decided (before M1).
Inside `step` and everything it calls:
- Numbers are `double`, using only `+ − × ÷` and `sqrt`.
- No `dart:math` trig, `exp` or `pow`.
- No `Random` unless its seed is stored in the state.
- No iteration over unordered collections (e.g. `Set`, hash-ordered `Map` iteration where
  order is not guaranteed); use lists or fixed ordering.

Fixed-point arithmetic is adopted only if M3 shows drift that server correction cannot
absorb (D-007).

## 4. Units
- Distances in meters, velocities in m/s, time in ticks.
- Origin and axis directions: **TBD (M1)**.
- Pitch dimensions (width, height, goal size, ball and player radii, etc.) are named
  constants in one config file inside `shared_physics`. Values: **TBD (M1)**.
  File name: **TBD (M1)**.

## 5. Rule events
- Collision handling inside `step` does not apply game rules directly; it queues events,
  e.g. `goal`, `kickContact`.
- Every event is tagged with the match id and the tick it happened on.
- Rules (scoring, kickoff, match end) consume the queued events.
- A restart (kickoff after a goal, new match) replaces the whole state; nothing is reset
  field by field.
- Event type list and payloads: **TBD (M1/M2)**.

## 6. Online model (target for M3, not built yet)
- The server is authoritative and runs `step` at 60 ticks/s (D-003).
- The client predicts its own player from local inputs and reconciles when server
  state arrives.
- Opponent and ball are interpolated from server snapshots.
- Nakama (Dart SDK) handles guest auth, matchmaking and match records, and hands matched
  players to the match server (D-004).
- Network transport: **TBD (before M3)**. Server hosting and budget: **TBD (before M3)**.
- Snapshot rate, interpolation delay, reconciliation details: **TBD (M3)**.

## 7. Out of scope for MVP
From the PROGRESS backlog; do not build: power-up draft, roguelike run mode, live arenas,
match modifiers, shop, IAP, ads, leagues, social.
