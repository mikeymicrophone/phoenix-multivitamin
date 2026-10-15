# Forms and changesets

to_form, phx-change, phx-submit, Ecto changesets on the way in, and validation that runs before anything is written.

Official reference: [Forms and changesets](https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html#form/1)

## Examples (0 of 13 bottled)

01. Cannery retort cook card — planned
02. Maple sugar shack batch — planned
03. Cider press tally sheet — planned
04. Creamery vat card — planned
05. Assay office slips — planned
06. Apiary super stack — planned
07. Sail loft bolt ticket — planned
08. Cooperage hoop log — planned
09. Ridge kite log — planned
10. Lock gauge house card — planned
11. Pilot boat mess slate — planned
12. Icehouse brine tags — planned
13. Alder damper board — planned

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | to_form/1 wrapping a changeset |
| 02 | phx-change validating on every keystroke |
| 03 | phx-submit persisting only a valid card |
| 04 | Field errors rendered next to the input |
| 05 | A nested embed in the form |
| 06 | select, checkbox, and textarea from core inputs |
| 07 | phx-auto-recover after a dropped socket |
| 08 | A form that posts through a controller, not a LiveView |
| 09 | Casting empty strings to nil |
| 10 | Action :validate versus :save on the changeset |
| 11 | Disabled submit until the changeset is valid |
| 12 | A form that resets after a successful save |
| 13 | Capstone: live validation, nested fields, and a save that writes |

Planned titles are proposals, not commitments. See
[CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot.
