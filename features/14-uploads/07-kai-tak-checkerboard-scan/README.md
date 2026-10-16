# Uploads · 07 · Kai Tak checkerboard scan

Wai loads a compact historical Checkerboard briefing caption into the Kai Tak training archive.

**What it teaches**

- max_file_size rejects a file before consumption; cancellation enables a replacement.
- cond separates invalid, unfinished, empty, and completed states.

**Files**

| File | Role |
| --- | --- |
| [`checkerboard_scan_live.ex`](checkerboard_scan_live.ex) | Upload configuration, callbacks, and form |
| [`checkerboard_scan_live_test.exs`](checkerboard_scan_live_test.exs) | Upload workflow and rejected-input scaffolding |

Uses the feature's [shared upload helpers](../upload_helpers.ex) and the catalog's `assign_scenario/4` and `<.scenario_identity>`.

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/14-uploads/07-kai-tak-checkerboard-scan](http://localhost:4000/features/14-uploads/07-kai-tak-checkerboard-scan).

This is a deliberately tiny 128-byte training caption limit. Try 129 ASCII characters, withdraw the refused caption, then file a shorter .txt caption. The limit measures bytes, including UTF-8 multibyte characters.

Run the scenario tests:

```sh
mix test features/14-uploads/07-kai-tak-checkerboard-scan/checkerboard_scan_live_test.exs
```
