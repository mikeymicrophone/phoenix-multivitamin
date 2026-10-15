# Uploads

allow_upload, consume_uploaded_entries, progress, max_entries, accept, and auto_upload for files a keeper actually hands over.

Official reference: [Uploads](https://hexdocs.pm/phoenix_live_view/uploads.html)

## Examples (0 of 13 bottled)

01. Permit photo uploader — planned
02. Lens cabinet plate scans — planned
03. Retort cook card photos — planned
04. Chart correction overlays — planned
05. Foghorn timing strips — planned
06. Seed packet press proofs — planned
07. Hatchery tray photos — planned
08. Wharf damage plates — planned
09. Keeper log page scans — planned
10. Buoy paint swatches — planned
11. Net loft mend photos — planned
12. Tide staff rubbings — planned
13. Fresnel prism inspections — planned

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | allow_upload/3 in mount |
| 02 | live_file_input/1 in the form |
| 03 | consume_uploaded_entries/3 after submit |
| 04 | cancel_upload/3 for a chart the keeper withdraws |
| 05 | max_entries and the extra file that is refused |
| 06 | accept: a MIME list the station actually wants |
| 07 | max_file_size and the oversize plate |
| 08 | auto_upload: true on a drop |
| 09 | progress callback on each chunk |
| 10 | External uploader versus local consume |
| 11 | A preview from upload_entries |
| 12 | An error on the entry, not the form |
| 13 | Capstone: several plates, a cancel, and a consume into priv |

Planned titles are proposals, not commitments. See
[CONTRIBUTING.md](../../CONTRIBUTING.md) before filling a slot.
