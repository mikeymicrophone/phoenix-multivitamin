# Uploads · 01 · Centrair Tokoname plate scan

Aiko checks one engine plate scan before the Centrair maintenance handover.

**What it teaches**

- allow_upload/3 with keyword options held in a module attribute.
- Pattern matching completed and pending upload tuples before consumption.

**Files**

| File | Role |
| --- | --- |
| [`plate_scan_live.ex`](plate_scan_live.ex) | Upload configuration, callbacks, and form |
| [`plate_scan_live_test.exs`](plate_scan_live_test.exs) | Upload workflow and rejected-input scaffolding |

Uses the feature's [shared upload helpers](../upload_helpers.ex) and the catalog's `assign_scenario/4` and `<.scenario_identity>`.

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/14-uploads/01-centrair-tokoname-plate-scan](http://localhost:4000/features/14-uploads/01-centrair-tokoname-plate-scan).

Select a PNG or PDF up to 200,000 bytes. Filing reads the temporary file size; it does not retain the scan.

Run the scenario tests:

```sh
mix test features/14-uploads/01-centrair-tokoname-plate-scan/plate_scan_live_test.exs
```
