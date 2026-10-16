# Streams

stream/4, stream_insert, stream_delete, stream_reset, and rendering collections that grow without holding every row in assigns.

Official reference: [Streams](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#stream/4)

## Examples (0 of 13 bottled)

01. Porto Douro departure stream — planned
02. Bilbao Nervión stand stream — planned
03. San Sebastián La Concha stream — planned
04. Mendoza Andes reset stream — planned
05. El Calafate Perito stream — planned
06. Puerto Williams Cape Horn stream — planned
07. Puerto Montt Reloncaví stream — planned
08. Antofagasta Atacama stream — planned
09. Bogotá El Dorado stream — planned
10. Quito Cotopaxi stream — planned
11. Lima Pisco stream — planned
12. Iquitos Amazon stream — planned
13. Manaus Negro stream — planned

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
| 13 | Capstone: insert, delete, reset, and an empty apron |

Planned titles are proposals, not commitments. See
[CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot.
