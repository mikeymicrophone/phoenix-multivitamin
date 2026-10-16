# Forms and changesets

to_form, phx-change, phx-submit, Ecto changesets on the way in, and validation that runs before anything is written.

Official reference: [Forms and changesets](https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html#form/1)

## Examples (13 of 13 bottled)

01. [Oymyakon frost form](01-oymyakon-frost-form/) — available
02. [Gwadar cargo changeset](02-gwadar-cargo-changeset/) — available
03. [Maun delta weight](03-maun-delta-weight/) — available
04. [Skardu fuel slip](04-skardu-fuel-slip/) — available
05. [Hiva Oa tow embed](05-hiva-oa-tow-embed/) — available
06. [Khasab fjord manifest](06-khasab-fjord-manifest/) — available
07. [Ivalo recover desk](07-ivalo-recover-desk/) — available
08. [Dili controller slip](08-dili-controller-slip/) — available
09. [Kashgar empty nil](09-kashgar-empty-nil/) — available
10. [Tanna ash validate](10-tanna-ash-validate/) — available
11. [Kuujjuaq disabled submit](11-kuujjuaq-disabled-submit/) — available
12. [Aitutaki reset form](12-aitutaki-reset-form/) — available
13. [Magadan capstone card](13-magadan-capstone-card/) — available

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
