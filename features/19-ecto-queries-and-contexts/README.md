# Ecto queries and contexts

from, where, preload, compose, and a context module that is the only door the web layer uses to reach the Repo.

Official reference: [Ecto queries and contexts](https://hexdocs.pm/ecto/Ecto.Query.html)

## Examples (0 of 13 bottled)

01. Harbor tide context — planned
02. Cannery floor context — planned
03. Lens cabinet context — planned
04. Ferry sailing context — planned
05. Lock chamber context — planned
06. Hatchery round context — planned
07. Seed press context — planned
08. Pilot station context — planned
09. Net loft context — planned
10. Buoy depot context — planned
11. Chart desk context — planned
12. Foghorn tender context — planned
13. Watch log context — planned

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | A context function that lists the posted board |
| 02 | where/3 on a named binding |
| 03 | preload/3 of associations |
| 04 | compose query functions that pipe |
| 05 | Repo.aggregate/3 for a count on the dock |
| 06 | select/3 of a map, not a struct |
| 07 | dynamic/2 for optional filters |
| 08 | join/5 versus preload after the fact |
| 09 | prefix and a named binding collision |
| 10 | Repo.stream/2 for a long ledger |
| 11 | A context that does not leak query internals |
| 12 | put_queryable versus from/2 |
| 13 | Capstone: composed filters, preload, and a context door |

Planned titles are proposals, not commitments. See
[CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot.
