# LiveView lifecycle and events

mount/3, handle_params/3, handle_event/3, handle_info/2, connected?/1, and terminate/2: the life of a socket from the static render through events and messages.

Official reference: [LiveView lifecycle and events](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html)

## Examples (1 of 13 bottled)

01. [New Dungeness watch log](01-new-dungeness-watch-log/) — available
02. Point Wilson fog signal card — planned
03. Cape Disappointment lamp round — planned
04. Friday Harbor berth slate — planned
05. Port Townsend hoist log — planned
06. Tatoosh weather round — planned
07. Destruction Island relief board — planned
08. Ediz Hook current table — planned
09. Slip Point bell book — planned
10. Cattle Point range log — planned
11. Marrowstone horn events — planned
12. Lime Kiln hydrophone watch — planned
13. Admiralty Inlet night board — planned

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | Disconnected then connected mount, and a clock armed only when connected?/1 is true |
| 02 | handle_event/3 with a named event and no payload |
| 03 | handle_event/3 reading values out of the event map |
| 04 | Several event names on one view, each appending a different line |
| 05 | handle_info/2 from Process.send_after/3 |
| 06 | handle_params/3 switching the watch from the URL |
| 07 | terminate/2 when the keeper leaves the socket |
| 08 | Mount loading the posted board from params |
| 09 | An event that starts or stops the ticker |
| 10 | {:reply, map, socket} from handle_event/3 |
| 11 | Flash set from an event, cleared on the next render path |
| 12 | handle_info/2 from a second process, not the clock |
| 13 | Capstone: params, events, info, and connected mount on one night board |

Planned titles are proposals, not commitments. See
[CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot.
