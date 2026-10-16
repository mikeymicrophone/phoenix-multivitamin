# Ecto migrations and multis

change/0, up/down, indexes, and Ecto.Multi so two writes either both land or neither does.

Official reference: [Ecto migrations and multis](https://hexdocs.pm/ecto_sql/Ecto.Migration.html)

## Examples (0 of 13 bottled)

01. Granada Sierra Nevada migration — planned
02. Beja Alentejo migration — planned
03. Vigo Rías Baixas migration — planned
04. Santiago Compostela vault — planned
05. A Coruña Hercules cabinet — planned
06. Asturias Picos migration — planned
07. Santander Cantabria multi — planned
08. Pamplona San Fermín multi — planned
09. Zaragoza Ebro multi — planned
10. Salamanca Plaza Mayor multi — planned
11. León Camino multi — planned
12. Vitoria Basque multi — planned
13. Logroño Rioja handover — planned

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
