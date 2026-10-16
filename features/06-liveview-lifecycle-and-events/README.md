# LiveView lifecycle and events

mount/3, handle_params/3, handle_event/3, handle_info/2, connected?/1, and terminate/2: the life of a socket from the static render through events and messages.

Official reference: [LiveView lifecycle and events](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html)

## Examples (13 of 13 bottled)

01. [Akureyri night watch](01-akureyri-night-watch/) — available
02. [Kota Kinabalu monsoon card](02-kota-kinabalu-monsoon-card/) — available
03. [Overberg lamp round](03-overberg-lamp-round/) — available
04. [Tivat stand slate](04-tivat-stand-slate/) — available
05. [Gifu autoclave card](05-gifu-autoclave-card/) — available
06. [Vágar weather round](06-vagar-weather-round/) — available
07. [St Helena relief board](07-st-helena-relief-board/) — available
08. [Keflavik jet-stream table](08-keflavik-jetstream-table/) — available
09. [Juist windsock book](09-juist-windsock-book/) — available
10. [Ämari range log](10-amari-range-log/) — available
11. [Andøya rocket events](11-andoya-rocket-events/) — available
12. [Rarotonga ATIS watch](12-rarotonga-atis-watch/) — available
13. [Nuuk night board](13-nuuk-night-board/) — available

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | Disconnected then connected mount, and a clock armed only when connected?/1 is true |
| 02 | phx-click with phx-value-*; values arrive as strings |
| 03 | phx-change and the "_target" field that names the lamp that moved |
| 04 | phx-change vs phx-submit on one form; submit has no "_target" |
| 05 | phx-blur posting a cure reading when the field loses focus |
| 06 | phx-keydown with phx-key; LiveViewTest does not apply the client filter |
| 07 | phx-debounce="500" and phx-debounce="blur"; render_change does not wait |
| 08 | phx-throttle on repeated clicks; render_click still counts every one |
| 09 | send(self()) from handle_event/3, handled in handle_info/2 after that render |
| 10 | Regular assigns vs temporary_assigns that reset the socket but not the last DOM node |
| 11 | push_event/3 and {:reply, map, socket} to a colocated hook |
| 12 | on_mount hooks, including attach_hook/4 that can halt handle_event/3 |
| 13 | Capstone: params, events, info, connected mount, and terminate/2 |

See [CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot in another feature.
