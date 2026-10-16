# Controllers and JSON

Controller actions, HTML and JSON formats, fallback controllers, status codes, and rendering maps without a view module getting in the way of the payload.

Official reference: [Controllers and JSON](https://hexdocs.pm/phoenix/controllers.html)

## Examples (13 of 13 bottled)

01. [Queenstown METAR desk](01-queenstown-metar-desk/) — available
02. [Cusco load sheet](02-cusco-load-sheet/) — available
03. [Marrakech ATIS feed](03-marrakech-atis-feed/) — available
04. [Ulaanbaatar winter NOTAM](04-ulaanbaatar-winter-notam/) — available
05. [Bariloche Chinook brief](05-bariloche-chinook-brief/) — available
06. [Dakar harmattan METAR](06-dakar-harmattan-metar/) — available
07. [Entebbe cargo manifest](07-entebbe-cargo-manifest/) — available
08. [Zanzibar spice-run ticket](08-zanzibar-spice-run-ticket/) — available
09. [Malé atoll slot list](09-male-atoll-slot-list/) — available
10. [Leh density-altitude card](10-leh-density-altitude-card/) — available
11. [Lhasa oxygen plan](11-lhasa-oxygen-plan/) — available
12. [Baltra biosecurity pass](12-baltra-biosecurity-pass/) — available
13. [Punta Arenas austral load](13-punta-arenas-austral-load/) — available

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
