# Uploads · 08 · Almaty Tian Shan upload

Aigerim drops Tian Shan rescue-track logs onto the Almaty desk; each completed transfer gets its own digest.

**What it teaches**

- auto_upload and phx-drop-target start transfers without submit.
- A progress function capture consumes only the completed entry, then streams its receipt.

**Files**

| File | Role |
| --- | --- |
| [`tien_shan_upload_live.ex`](tien_shan_upload_live.ex) | Upload configuration, callbacks, and form |
| [`tien_shan_upload_live_test.exs`](tien_shan_upload_live_test.exs) | Upload workflow and rejected-input scaffolding |

Uses the feature's [shared upload helpers](../upload_helpers.ex) and the catalog's `assign_scenario/4` and `<.scenario_identity>`.

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/14-uploads/08-almaty-tien-shan-upload](http://localhost:4000/features/14-uploads/08-almaty-tien-shan-upload).

Choose or drop up to three .txt track logs. There is no submit button: each done progress callback reads and consumes its own entry. A second unfinished track remains queued.

Run the scenario tests:

```sh
mix test features/14-uploads/08-almaty-tien-shan-upload/tien_shan_upload_live_test.exs
```
