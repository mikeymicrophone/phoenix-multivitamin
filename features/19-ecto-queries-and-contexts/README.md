# Ecto queries and contexts

from, where, preload, compose, and a context module that is the only door the web layer uses to reach the Repo.

Official reference: [Ecto queries and contexts](https://hexdocs.pm/ecto/Ecto.Query.html)

## Examples (0 of 13 bottled)

01. Strasbourg Rhine context — planned
02. Mulhouse EuroAirport query — planned
03. Samedan Engadin context — planned
04. Zermatt heliport query — planned
05. Megève altiport context — planned
06. Alpe-d-Huez altiport query — planned
07. Chambéry Savoie context — planned
08. Nice Cote-d-Azur query — planned
09. Monaco heliport context — planned
10. Andorra La Seu query — planned
11. Reus Gaudí context — planned
12. Jerez sherry query — planned
13. Almería Tabernas context — planned

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | A context function that lists the posted board |
| 02 | where/3 on a named binding |
| 03 | preload/3 of associations |
| 04 | compose query functions that pipe |
| 05 | Repo.aggregate/3 for a count on the apron |
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
