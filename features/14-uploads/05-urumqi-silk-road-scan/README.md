# Uploads · 05 · Ürümqi silk-road scan

Dilnur keeps the Ürümqi dispatch packet to two releases and withdraws the extra sector sheet.

**What it teaches**

- max_entries produces a configuration error separately from entry errors.
- Keyword.merge/2 specializes limits; names are sorted before a receipt is built.

**Files**

| File | Role |
| --- | --- |
| [`silk_road_scan_live.ex`](silk_road_scan_live.ex) | Upload configuration, callbacks, and form |
| [`silk_road_scan_live_test.exs`](silk_road_scan_live_test.exs) | Upload workflow and rejected-input scaffolding |

Uses the feature's [shared upload helpers](../upload_helpers.ex) and the catalog's `assign_scenario/4` and `<.scenario_identity>`.

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/14-uploads/05-urumqi-silk-road-scan](http://localhost:4000/features/14-uploads/05-urumqi-silk-road-scan).

Queue three .txt releases to see the configuration-level limit, then withdraw one. No file is consumed while the packet exceeds two entries.

Run the scenario tests:

```sh
mix test features/14-uploads/05-urumqi-silk-road-scan/silk_road_scan_live_test.exs
```
