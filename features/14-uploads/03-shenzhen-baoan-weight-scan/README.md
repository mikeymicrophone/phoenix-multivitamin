# Uploads · 03 · Shenzhen Baoan weight scan

Mei totals positive pallet weights from Baoan cargo CSVs and posts typed receipts to the loading board.

**What it teaches**

- consume_uploaded_entries/3 transforms temporary files into enforced receipt structs.
- A filtered comprehension, Integer.parse/1, Enum.reduce/3, and String.Chars.

**Files**

| File | Role |
| --- | --- |
| [`weight_scan_live.ex`](weight_scan_live.ex) | Upload configuration, callbacks, and form |
| [`weight_receipt.ex`](weight_receipt.ex) | Scenario support |
| [`weight_receipt_label.ex`](weight_receipt_label.ex) | Scenario support |
| [`weight_scan_live_test.exs`](weight_scan_live_test.exs) | Upload workflow and rejected-input scaffolding |

Uses the feature's [shared upload helpers](../upload_helpers.ex) and the catalog's `assign_scenario/4` and `<.scenario_identity>`.

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/14-uploads/03-shenzhen-baoan-weight-scan](http://localhost:4000/features/14-uploads/03-shenzhen-baoan-weight-scan).

Each CSV row is a pallet label and integer kilograms, such as `PMC7632,418`. Headers, malformed rows, zero, and negative weights are ignored. Nothing is stored on disk after consumption.

Run the scenario tests:

```sh
mix test features/14-uploads/03-shenzhen-baoan-weight-scan/weight_scan_live_test.exs
```
