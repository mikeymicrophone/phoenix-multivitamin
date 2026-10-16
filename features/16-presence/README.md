# Presence

Phoenix.Presence track, list, diffs, and metas for who is on the watch without inventing a presence table of your own.

Official reference: [Presence](https://hexdocs.pm/phoenix/Phoenix.Presence.html)

## Examples (0 of 13 bottled)

01. Nicosia Green Line floor — planned
02. Heraklion Knossos presence — planned
03. Santorini caldera desk — planned
04. Dubrovnik walls crew — planned
05. Split Diocletian watch — planned
06. Ljubljana Triple Bridge relief — planned
07. Kraków Wawel night staff — planned
08. Gdańsk Motława presence — planned
09. Riga Daugava operators — planned
10. Tallinn Toompea round — planned
11. Helsinki Malmi menders — planned
12. Turku archipelago crew — planned
13. Visby Gotland radio — planned

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | track/4 when the socket connects |
| 02 | list/2 of controllers on the topic |
| 03 | handle_metas and the joins/leaves diff |
| 04 | A meta map with the watch name, not a user id integer |
| 05 | Presence in a LiveView via handle_info |
| 06 | Presence on a Channel |
| 07 | Untrack when the controller leaves |
| 08 | Same key, two metas, two tabs |
| 09 | fetch/2 overlaying profile data |
| 10 | simple_presence_diff versus a custom serializer |
| 11 | Counting controllers without listing every meta |
| 12 | A ghost that stays after a crashed tab |
| 13 | Capstone: track, list, join, leave, and two tabs for one controller |

Planned titles are proposals, not commitments. See
[CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot.
