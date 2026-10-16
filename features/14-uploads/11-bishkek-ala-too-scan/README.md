# Uploads · 11 · Bishkek Ala-Too scan

Aida compares an Ala-Too rescue landing overview with its touchdown detail before accepting the pair.

**What it teaches**

- Two independent upload configurations in one form with live_img_preview.
- A named detail slot receives each entry with :let; with requires both queues.

**Files**

| File | Role |
| --- | --- |
| [`ala_too_scan_live.ex`](ala_too_scan_live.ex) | Upload configuration, callbacks, and form |
| [`ala_too_scan_live_test.exs`](ala_too_scan_live_test.exs) | Upload workflow and rejected-input scaffolding |

Uses the feature's [shared upload helpers](../upload_helpers.ex) and the catalog's `assign_scenario/4` and `<.scenario_identity>`.

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/14-uploads/11-bishkek-ala-too-scan](http://localhost:4000/features/14-uploads/11-bishkek-ala-too-scan).

Select a PNG in each input. Previews use the browser file, before server consumption. Submitting with one missing view leaves the other available. The pair is read only after both transfers finish; this sample does not decode images or offer durable storage.

Run the scenario tests:

```sh
mix test features/14-uploads/11-bishkek-ala-too-scan/ala_too_scan_live_test.exs
```
