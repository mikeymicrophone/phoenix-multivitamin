# Controllers and JSON

Controller actions, HTML and JSON formats, fallback controllers, status codes, and rendering maps without a view module getting in the way of the payload.

Official reference: [Controllers and JSON](https://hexdocs.pm/phoenix/controllers.html)

## Examples (0 of 13 bottled)

01. Cape Disappointment blast card — planned
02. Grays Harbor retort shift — planned
03. Westport crab ticket — planned
04. Ilwaco end labeler — planned
05. Nahcotta barge watch — planned
06. Bay Center ticket load — planned
07. Willapa oyster tally — planned
08. Tokeland smokehouse rack — planned
09. Ocean Park cranberry dock — planned
10. Long Beach razor ledger — planned
11. Chinook net loft — planned
12. Altoona cannery pass — planned
13. Puget Island ferry slip — planned

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
