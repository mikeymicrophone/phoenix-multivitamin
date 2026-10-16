# Streams

stream/4, stream_insert, stream_delete, stream_reset, and rendering collections that grow without holding every row in assigns.

Official reference: [Streams](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#stream/4)

## Examples (13 of 13 bottled)

01. [Resolute departure stream](01-resolute-departure-stream/) — available
02. [Lüderitz stand stream](02-luderitz-stand-stream/) — available
03. [Batumi front stream](03-batumi-front-stream/) — available
04. [Jomsom delete stream](04-jomsom-delete-stream/) — available
05. [Nadi stream container](05-nadi-stream-container/) — available
06. [Inuvik map rows](06-inuvik-map-rows/) — available
07. [Osh filter reset](07-osh-filter-reset/) — available
08. [Mohe limit tape](08-mohe-limit-tape/) — available
09. [Siargao empty apron](09-siargao-empty-apron/) — available
10. [Tiksi component stream](10-tiksi-component-stream/) — available
11. [Calama insert after](11-calama-insert-after/) — available
12. [Funafuti once stream](12-funafuti-once-stream/) — available
13. [Alert capstone stream](13-alert-capstone-stream/) — available

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | stream/4 replacing an assign list |
| 02 | stream_insert/4 appending a row |
| 03 | stream_insert/4 at the front of the board |
| 04 | stream_delete/3 removing a finished row |
| 05 | phx-update="stream" on the container |
| 06 | dom_id for a row that is not a schema |
| 07 | stream/4 with reset: true after a filter changes |
| 08 | Limit and the row that falls off the end |
| 09 | Empty state when the stream has no rows |
| 10 | A stream of nested LiveComponents |
| 11 | Insert after a given id |
| 12 | Don't consume the stream twice in one render |
| 13 | Capstone: insert, delete, reset, and an empty apron |
