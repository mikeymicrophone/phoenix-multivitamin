# PubSub

Phoenix.PubSub subscribe, broadcast, broadcast_from, and topics that keep two watches on the same board without sharing a socket.

Official reference: [PubSub](https://hexdocs.pm/phoenix/Phoenix.PubSub.html)

## Examples (0 of 13 bottled)

01. Point Wilson spoken handover — planned
02. Cape Disappointment horn relief — planned
03. New Dungeness watch relay — planned
04. Tatoosh storm wire — planned
05. Ediz Hook current alert — planned
06. Ballard lock chamber call — planned
07. Anacortes retort floor bell — planned
08. Friday Harbor berth call — planned
09. Port Townsend hoist hail — planned
10. Mukilteo sailing board — planned
11. Colman Dock hold wire — planned
12. Neah Bay entrance hail — planned
13. Admiralty Inlet storm warning — planned

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | subscribe/2 in connected mount |
| 02 | broadcast/3 from an event |
| 03 | broadcast_from/4 so the sender skips its own echo |
| 04 | A topic named for the station, not a generic channel |
| 05 | handle_info/2 receiving the broadcast |
| 06 | Unsubscribe on terminate, or not, and why |
| 07 | Local versus Postgres/Redis adapter (documented, local here) |
| 08 | Two LiveViews on one topic |
| 09 | A context that broadcasts after a write |
| 10 | Payload size and what you actually send |
| 11 | node-local versus cluster (single node in this bottle) |
| 12 | A topic per watch versus a topic per station |
| 13 | Capstone: two desks, one broadcast, no echo on the sender |

Planned titles are proposals, not commitments. See
[CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot.
