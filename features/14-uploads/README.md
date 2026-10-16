# Uploads

allow_upload, live_file_input, progress, validation/errors, consumption, and external transfers for flight crews handing over real files.

Official reference: [Uploads](https://hexdocs.pm/phoenix_live_view/uploads.html)

## Examples (13 of 13 bottled)

01. [Centrair Tokoname plate scan](01-centrair-tokoname-plate-scan/) — available
02. [Macau Taipa logbook upload](02-macau-taipa-logbook-upload/) — available
03. [Shenzhen Baoan weight scan](03-shenzhen-baoan-weight-scan/) — available
04. [Chengdu panda chart upload](04-chengdu-panda-chart-upload/) — available
05. [Ürümqi silk-road scan](05-urumqi-silk-road-scan/) — available
06. [Harbin ice-city upload](06-harbin-ice-city-upload/) — available
07. [Kai Tak checkerboard scan](07-kai-tak-checkerboard-scan/) — available
08. [Almaty Tian Shan upload](08-almaty-tien-shan-upload/) — available
09. [Tashkent Registan scan](09-tashkent-registan-scan/) — available
10. [Samarkand silk upload](10-samarkand-silk-upload/) — available
11. [Bishkek Ala-Too scan](11-bishkek-ala-too-scan/) — available
12. [Dushanbe Pamir upload](12-dushanbe-pamir-upload/) — available
13. [Ashgabat Karakum scan](13-ashgabat-karakum-scan/) — available

## What each scenario adds

| Slot | What it adds |
| --- | --- |
| 01 | allow_upload/3 with keyword options held in a module attribute; Pattern matching completed and pending upload tuples before consumption |
| 02 | live_file_input/1 beside a changeset-backed captain input; Guarded function heads, with/else, and rejected captain behavior |
| 03 | consume_uploaded_entries/3 transforms temporary files into enforced receipt structs; A filtered comprehension, Integer.parse/1, Enum.reduce/3, and String.Chars |
| 04 | cancel_upload/3 removes one referenced entry; Guarded payloads and a pinned reference in a membership predicate |
| 05 | max_entries produces a configuration error separately from entry errors; Keyword.merge/2 specializes limits; names are sorted before a receipt is built |
| 06 | MIME accept lists populate the file input and validate entries; Enum.frequencies_by/2 and a map-oriented receipt pipeline |
| 07 | max_file_size rejects a file before consumption; cancellation enables a replacement; cond separates invalid, unfinished, empty, and completed states |
| 08 | auto_upload and phx-drop-target start transfers without submit; A progress function capture consumes only the completed entry, then streams its receipt |
| 09 | Named progress callback with explicit UploadEntry struct matching; Map updates and Enum.reduce/3 compute byte-weighted progress instead of counting files |
| 10 | external presigning returns uploader metadata and a short-lived signed URL; External consumption receives archive metadata, not a local temporary path |
| 11 | Two independent upload configurations in one form with live_img_preview; A named detail slot receives each entry with :let; with requires both queues |
| 12 | Content validation inside consume_uploaded_entries/3 returns {:postpone, receipt}; with/else maps read failures and bad headers to an error beside the entry |
| 13 | A bounded multi-file queue, cancellation, and streamed storage receipts; A per-mount archive batch, safe server-generated filenames, and fallible copy with postponed failures |

[UploadHelpers](upload_helpers.ex) shares changeset-backed empty forms, readiness checks,
queue presentation, progress bars, and upload error messages. Each scenario owns
its configuration, domain validation, consumption, and content. Upload entries
are maintained by LiveView; consumed collections are streamed where needed.

The Samarkand external uploader is bundled through `assets/js/app.js`. Its signed
PUT endpoint runs locally and needs no network service. Its tests cover the
server contract; actual XHR progress, abort, drag/drop, and image preview rendering
need a browser. Accepted extensions/MIME types do not prove file contents are safe.
The local examples read files before their temporary paths are removed; only
Samarkand and Ashgabat retain bytes. Their READMEs describe storage and cleanup.

Tests are scaffolding written for Phoenix 1.8.15 / LiveView 1.2. Elixir and Mix
were unavailable while bottling this feature; CI must compile, format, and run them.

```sh
mix test features/14-uploads
mix precommit
```
