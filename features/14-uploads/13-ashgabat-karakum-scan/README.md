# Uploads · 13 · Ashgabat Karakum scan

Mähriban assembles Karakum dispatch plates, withdraws outdated scans, and stores the remaining packet in a private archive.

**What it teaches**

- A bounded multi-file queue, cancellation, and streamed storage receipts.
- A per-mount archive batch, safe server-generated filenames, and fallible copy with postponed failures.

**Files**

| File | Role |
| --- | --- |
| [`karakum_scan_live.ex`](karakum_scan_live.ex) | Upload configuration, callbacks, and form |
| [`archive.ex`](archive.ex) | Scenario support |
| [`karakum_scan_live_test.exs`](karakum_scan_live_test.exs) | Upload workflow and rejected-input scaffolding |

Uses the feature's [shared upload helpers](../upload_helpers.ex) and the catalog's `assign_scenario/4` and `<.scenario_identity>`.

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/14-uploads/13-ashgabat-karakum-scan](http://localhost:4000/features/14-uploads/13-ashgabat-karakum-scan).

Select up to three PNG/PDF plates, withdraw an outdated plate, and store the rest. The archive copies bytes into `priv/uploads/karakum/<batch>/` under the application directory, outside `priv/static`. Original filenames are labels only. Each successful copy is consumed independently; failures remain queued, so the packet is not an atomic transaction. There is no public download route. Remove old batches manually; a production archive needs a retention policy and writable durable storage.

Run the scenario tests:

```sh
mix test features/14-uploads/13-ashgabat-karakum-scan/karakum_scan_live_test.exs
```
