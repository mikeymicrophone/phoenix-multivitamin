# Streams

stream/4, stream_insert, stream_delete, stream_reset, and rendering collections that grow without holding every row in assigns.

Official reference: [Streams](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#stream/4)

## Examples (0 of 13 bottled)

01. Harbor tide board — planned
02. County bus route card — planned
03. Marina moorage bill — planned
04. Garden work day signups — planned
05. Rehearsal dinner seating — planned
06. Costume shop pull list — planned
07. Bakery oven queue — planned
08. Apartment meter bank — planned
09. Archive request desk — planned
10. Clinic intake sections — planned
11. Trail work crew — planned
12. Orchestra seating chart — planned
13. Netshed mend flags — planned

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | stream/4 replacing an assign list |
| 02 | stream_insert/4 appending a row |
| 03 | stream_insert/4 at the front of the board |
| 04 | stream_delete/3 removing a finished row |
| 05 | phx-update="stream" on the container |
| 06 | dom_id for a row that is not a schema |
| 07 | stream_reset/3 after a filter changes |
| 08 | Limit and the row that falls off the end |
| 09 | Empty state when the stream has no rows |
| 10 | A stream of nested LiveComponents |
| 11 | Insert after a given id |
| 12 | Don't consume the stream twice in one render |
| 13 | Capstone: insert, delete, reset, and an empty dock |

Planned titles are proposals, not commitments. See
[CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot.
