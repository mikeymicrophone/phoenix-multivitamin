# LiveView lifecycle and events

mount/3, handle_params/3, handle_event/3, handle_info/2, connected?/1, and terminate/2: the life of a socket from the static render through events and messages.

Official reference: [LiveView lifecycle and events](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html)

## Examples (13 of 13 bottled)

01. [New Dungeness watch log](01-new-dungeness-watch-log/) — available
02. [Point Wilson fog signal card](02-point-wilson-fog-signal-card/) — available
03. [Cape Disappointment lamp round](03-cape-disappointment-lamp-round/) — available
04. [Friday Harbor berth slate](04-friday-harbor-berth-slate/) — available
05. [Pacific American Cannery retort card](05-pacific-american-cannery-retort-card/) — available
06. [Tatoosh weather round](06-tatoosh-weather-round/) — available
07. [Destruction Island relief board](07-destruction-island-relief-board/) — available
08. [Ediz Hook current table](08-ediz-hook-current-table/) — available
09. [Slip Point bell book](09-slip-point-bell-book/) — available
10. [Cattle Point range log](10-cattle-point-range-log/) — available
11. [Marrowstone horn events](11-marrowstone-horn-events/) — available
12. [Lime Kiln hydrophone watch](12-lime-kiln-hydrophone-watch/) — available
13. [Admiralty Inlet night board](13-admiralty-inlet-night-board/) — available

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | Disconnected then connected mount, and a clock armed only when connected?/1 is true |
| 02 | phx-click with phx-value-*; values arrive as strings |
| 03 | phx-change and the "_target" field that names the lamp that moved |
| 04 | phx-change vs phx-submit on one form; submit has no "_target" |
| 05 | phx-blur posting a retort reading when the field loses focus |
| 06 | phx-keydown with phx-key; LiveViewTest does not apply the client filter |
| 07 | phx-debounce="500" and phx-debounce="blur"; render_change does not wait |
| 08 | phx-throttle on repeated clicks; render_click still counts every one |
| 09 | send(self()) from handle_event/3, handled in handle_info/2 after that render |
| 10 | Regular assigns vs temporary_assigns that reset the socket but not the last DOM node |
| 11 | push_event/3 and {:reply, map, socket} to a colocated hook |
| 12 | on_mount hooks, including attach_hook/4 that can halt handle_event/3 |
| 13 | Capstone: params, events, info, connected mount, and terminate/2 |

See [CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot in another feature.
