# Forms and changesets

to_form, phx-change, phx-submit, Ecto changesets on the way in, and validation that runs before anything is written.

Official reference: [Forms and changesets](https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html#form/1)

## Examples (0 of 13 bottled)

01. Maastricht slot form — planned
02. Ostend cargo changeset — planned
03. Bern alpine weight card — planned
04. Lugano lakeside fuel slip — planned
05. Interlaken glider-tow form — planned
06. Chamonix heliski manifest — planned
07. Grenoble Alpe weight — planned
08. Annecy seaplane log — planned
09. Cannes bizjet slot — planned
10. Girona Costa Brava card — planned
11. Menorca Maó changeset — planned
12. Ibiza night-slot form — planned
13. Faro Algarve fuel card — planned

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
