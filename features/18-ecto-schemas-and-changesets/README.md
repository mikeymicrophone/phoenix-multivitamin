# Ecto schemas and changesets

schema, field, embeds, associations, and changesets that cast, validate, and refuse a card that is not ready to write.

Official reference: [Ecto schemas and changesets](https://hexdocs.pm/ecto/Ecto.Schema.html)

## Examples (0 of 13 bottled)

01. Debrecen puszta schema — planned
02. Košice Tatra schema — planned
03. Poprad High Tatras entry — planned
04. Brno Moravian assignment — planned
05. Plzeň pilsner timing — planned
06. Karlovy Vary spa drawer — planned
07. Memmingen Allgäu schema — planned
08. Altenburg Nobitz bill — planned
09. Wangerooge dune correction — planned
10. Borkum paint batch — planned
11. Emden Ems reading — planned
12. Liège cargo pass — planned
13. Luxembourg Findel order — planned

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | schema/2 with fields that match the cook card |
| 02 | changeset/2 casting a known set of keys |
| 03 | validate_required/3 on the fields the cook must fill |
| 04 | validate_number/3 and validate_length/3 |
| 05 | unique_constraint/3 after a race at the apron |
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
