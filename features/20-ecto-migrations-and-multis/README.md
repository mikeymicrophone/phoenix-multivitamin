# Ecto migrations and multis

change/0, up/down, indexes, and Ecto.Multi so two writes either both land or neither does.

Official reference: [Ecto migrations and multis](https://hexdocs.pm/ecto_sql/Ecto.Migration.html)

## Examples (0 of 13 bottled)

01. Retort floor migration — planned
02. Watch log migration — planned
03. Berth ledger migration — planned
04. Seed vault migration — planned
05. Lens cabinet migration — planned
06. Hatchery tray migration — planned
07. Moorage invoice multi — planned
08. Fog signal multi — planned
09. Chart correction multi — planned
10. Pilot order multi — planned
11. Cannery pass multi — planned
12. Lockage ticket multi — planned
13. Overnight handover multi — planned

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | change/0 that is reversible |
| 02 | up/0 and down/0 when change/0 is not enough |
| 03 | add/3 with a default and a null constraint |
| 04 | create index/unique_index |
| 05 | alter table and a warning about SQLite limits |
| 06 | execute/1 for a data backfill |
| 07 | Ecto.Multi.insert/3 then insert/3 |
| 08 | Multi.run/3 for a step that is not a schema |
| 09 | Repo.transaction/1 wrapping the multi |
| 10 | A failed step that rolls the earlier inserts back |
| 11 | timestamps() and utc_datetime |
| 12 | prefix and comments on a table |
| 13 | Capstone: migration, unique index, and a two-step multi |

Planned titles are proposals, not commitments. See
[CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot.
