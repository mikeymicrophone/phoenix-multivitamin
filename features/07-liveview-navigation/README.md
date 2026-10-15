# LiveView navigation

patch, navigate, live_redirect, handle_params/3 on an already-mounted view, and the difference between a dead render and a live patch.

Official reference: [LiveView navigation](https://hexdocs.pm/phoenix_live_view/live-navigation.html)

## Examples (0 of 13 bottled)

01. Pilot boarding ladder — planned
02. Port Angeles harbor rounds — planned
03. Victoria Clipper gate — planned
04. Coho ferry turnaround — planned
05. Black Ball vehicle rows — planned
06. Kenmore floatplane dock — planned
07. Friday Harbor seaplane slip — planned
08. Roche Harbor customs float — planned
09. Orcas landing queue — planned
10. Shaw Island freight bell — planned
11. Lopez ferry pitfalls — planned
12. Anacortes terminal lanes — planned
13. Sidney berth rotation — planned

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | patch/2 that reuses the process and calls handle_params/3 |
| 02 | navigate/2 that mounts a different LiveView |
| 03 | A live_patch link in HEEx |
| 04 | A live_redirect link across boards |
| 05 | replace: true so the watch does not stack history |
| 06 | handle_params/3 after a patch versus after mount |
| 07 | push_patch from an event, not a link |
| 08 | push_navigate from an event |
| 09 | Query params that survive a patch |
| 10 | A back link that is a patch to the parent board |
| 11 | Navigating from a LiveComponent through the parent |
| 12 | The dead render of the destination, then the live connect |
| 13 | Capstone: patch inside a watch, navigate to the relief board |

Planned titles are proposals, not commitments. See
[CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot.
