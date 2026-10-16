# Uploads · 09 · Tashkent Registan scan

Aziza watches byte-weighted progress as Tashkent crew briefing bundles arrive, then files the completed packet.

**What it teaches**

- Named progress callback with explicit UploadEntry struct matching.
- Map updates and Enum.reduce/3 compute byte-weighted progress instead of counting files.

**Files**

| File | Role |
| --- | --- |
| [`registan_scan_live.ex`](registan_scan_live.ex) | Upload configuration, callbacks, and form |
| [`registan_scan_live_test.exs`](registan_scan_live_test.exs) | Upload workflow and rejected-input scaffolding |

Uses the feature's [shared upload helpers](../upload_helpers.ex) and the catalog's `assign_scenario/4` and `<.scenario_identity>`.

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/14-uploads/09-tashkent-registan-scan](http://localhost:4000/features/14-uploads/09-tashkent-registan-scan).

Progress is weighted by declared byte size across the current queue. Files remain temporary until submit. Selecting files is not the same as transferring them; manual uploads start on submit in a browser.

Run the scenario tests:

```sh
mix test features/14-uploads/09-tashkent-registan-scan/registan_scan_live_test.exs
```
