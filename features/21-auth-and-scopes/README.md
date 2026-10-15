# Auth and scopes

current_scope, assign_scope, scoped routes, and the Phoenix 1.8 scope pattern that keeps a keeper's data from leaking across stations.

Official reference: [Auth and scopes](https://hexdocs.pm/phoenix/scopes.html)

## Examples (0 of 13 bottled)

01. Station keeper scope — planned
02. Cannery clerk scope — planned
03. Pilot dispatcher scope — planned
04. Ferry terminal scope — planned
05. Lock master scope — planned
06. Hatchery biologist scope — planned
07. Seed press operator scope — planned
08. Lens keeper scope — planned
09. Foghorn tender scope — planned
10. Chart corrector scope — planned
11. Net loft foreman scope — planned
12. Buoy depot lead scope — planned
13. Strait radio operator scope — planned

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | A scope struct for the keeper and the station |
| 02 | assign_scope in a plug |
| 03 | live_session that requires a scope |
| 04 | Context functions that take the scope as the first argument |
| 05 | Queries scoped by station_id, never a raw all/1 |
| 06 | A hook that redirects when the scope is missing |
| 07 | on_mount {Scope, :require} |
| 08 | Public versus authenticated live_session |
| 09 | A token that becomes a scope, not a user assign |
| 10 | Scope in verified routes (optional segments) |
| 11 | Testing with a scope in ConnCase |
| 12 | A keeper who can read one station and not the next |
| 13 | Capstone: plug, live_session, scoped context, and a refused board |

Planned titles are proposals, not commitments. See
[CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot.
