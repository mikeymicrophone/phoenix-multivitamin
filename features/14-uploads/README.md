# Uploads

allow_upload, consume_uploaded_entries, progress, max_entries, accept, and auto_upload for files a controller actually hands over.

Official reference: [Uploads](https://hexdocs.pm/phoenix_live_view/uploads.html)

## Examples (0 of 13 bottled)

01. Centrair Tokoname plate scan — planned
02. Macau Taipa logbook upload — planned
03. Shenzhen Baoan weight scan — planned
04. Chengdu panda chart upload — planned
05. Ürümqi silk-road scan — planned
06. Harbin ice-city upload — planned
07. Kai Tak checkerboard scan — planned
08. Almaty Tian Shan upload — planned
09. Tashkent Registan scan — planned
10. Samarkand silk upload — planned
11. Bishkek Ala-Too scan — planned
12. Dushanbe Pamir upload — planned
13. Ashgabat Karakum scan — planned

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | allow_upload/3 in mount |
| 02 | live_file_input/1 in the form |
| 03 | consume_uploaded_entries/3 after submit |
| 04 | cancel_upload/3 for a chart the controller withdraws |
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
