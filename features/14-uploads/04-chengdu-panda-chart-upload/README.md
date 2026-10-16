# Uploads · 04 · Chengdu panda chart upload

Lin withdraws superseded Chengdu diversion charts without disturbing the charts still queued.

**What it teaches**

- cancel_upload/3 removes one referenced entry.
- Guarded payloads and a pinned reference in a membership predicate.

**Files**

| File | Role |
| --- | --- |
| [`chart_upload_live.ex`](chart_upload_live.ex) | Upload configuration, callbacks, and form |
| [`chart_upload_live_test.exs`](chart_upload_live_test.exs) | Upload workflow and rejected-input scaffolding |

Uses the feature's [shared upload helpers](../upload_helpers.ex) and the catalog's `assign_scenario/4` and `<.scenario_identity>`.

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/14-uploads/04-chengdu-panda-chart-upload](http://localhost:4000/features/14-uploads/04-chengdu-panda-chart-upload).

Queue up to three PDFs, then withdraw one. Cancel also accepts an unfinished entry. A stale reference produces a flash without changing the remaining queue.

Run the scenario tests:

```sh
mix test features/14-uploads/04-chengdu-panda-chart-upload/chart_upload_live_test.exs
```
