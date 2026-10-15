# Presence

Phoenix.Presence track, list, diffs, and metas for who is on the watch without inventing a presence table of your own.

Official reference: [Presence](https://hexdocs.pm/phoenix/Phoenix.Presence.html)

## Examples (0 of 13 bottled)

01. Lighthouse watch floor — planned
02. Retort shift presence — planned
03. Ferry terminal dispatch desk — planned
04. Lock house chamber crew — planned
05. Pilot station on watch — planned
06. Cannery floor relief — planned
07. Chart desk night staff — planned
08. Foghorn tender presence — planned
09. Seed press operators — planned
10. Hatchery round keepers — planned
11. Net loft menders on shift — planned
12. Buoy depot paint crew — planned
13. Strait radio watch — planned

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | track/4 when the socket connects |
| 02 | list/2 of keepers on the topic |
| 03 | handle_metas and the joins/leaves diff |
| 04 | A meta map with the watch name, not a user id integer |
| 05 | Presence in a LiveView via handle_info |
| 06 | Presence on a Channel |
| 07 | Untrack when the keeper leaves |
| 08 | Same key, two metas, two tabs |
| 09 | fetch/2 overlaying profile data |
| 10 | simple_presence_diff versus a custom serializer |
| 11 | Counting keepers without listing every meta |
| 12 | A ghost that stays after a crashed tab |
| 13 | Capstone: track, list, join, leave, and two tabs for one keeper |

Planned titles are proposals, not commitments. See
[CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot.
