# Controllers and JSON

Controller actions, HTML and JSON formats, fallback controllers, status codes, and rendering maps without a view module getting in the way of the payload.

Official reference: [Controllers and JSON](https://hexdocs.pm/phoenix/controllers.html)

## Examples (0 of 13 bottled)

01. Queenstown METAR desk — planned
02. Cusco load sheet — planned
03. Marrakech ATIS feed — planned
04. Ulaanbaatar winter NOTAM — planned
05. Bariloche Chinook brief — planned
06. Dakar harmattan METAR — planned
07. Entebbe cargo manifest — planned
08. Zanzibar spice-run ticket — planned
09. Malé atoll slot list — planned
10. Leh density-altitude card — planned
11. Lhasa oxygen plan — planned
12. Baltra biosecurity pass — planned
13. Punta Arenas austral load — planned

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | HTML and JSON from one controller |
| 02 | json/2 with a domain map and an explicit status |
| 03 | A fallback controller for changeset-style errors |
| 04 | action_fallback versus a rescued clause |
| 05 | put_status and the body that still renders |
| 06 | Accept headers picking html versus json |
| 07 | A redirect after a successful write |
| 08 | Rendering a collection with a JSON index |
| 09 | A 404 that is a JSON error map, not an HTML page |
| 10 | Params nested under a domain key |
| 11 | Plug.Conn.send_resp for a short text ticket |
| 12 | Multiple clauses of the same action |
| 13 | Capstone: create, show, error fallback, and JSON index together |

Planned titles are proposals, not commitments. See
[CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot.
