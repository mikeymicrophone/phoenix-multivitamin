# Ecto schemas and changesets

schema, field, embeds, associations, and changesets that cast, validate, and refuse a card that is not ready to write.

Official reference: [Ecto schemas and changesets](https://hexdocs.pm/ecto/Ecto.Schema.html)

## Examples (0 of 13 bottled)

01. Retort cook schema — planned
02. Seed packet schema — planned
03. Watch log entry schema — planned
04. Berth assignment schema — planned
05. Fog signal timing schema — planned
06. Lens cabinet drawer schema — planned
07. Hatchery tray schema — planned
08. Moorage bill schema — planned
09. Chart correction schema — planned
10. Buoy paint batch schema — planned
11. Tide gate reading schema — planned
12. Cannery pass schema — planned
13. Pilot order schema — planned

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | schema/2 with fields that match the cook card |
| 02 | changeset/2 casting a known set of keys |
| 03 | validate_required/3 on the fields the cook must fill |
| 04 | validate_number/3 and validate_length/3 |
| 05 | unique_constraint/3 after a race at the dock |
| 06 | embeds_one and embeds_many |
| 07 | belongs_to and has_many on a station and its watches |
| 08 | virtual fields that never hit the table |
| 09 | Redact on a credential field |
| 10 | cast_assoc/3 for nested watches |
| 11 | change/2 versus cast/3 |
| 12 | validate_change/3 with a custom function |
| 13 | Capstone: embed, assoc, required, and a unique cook number |

Planned titles are proposals, not commitments. See
[CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot.
