# Uploads · 02 · Macau Taipa logbook upload

Inês pairs a Taipa night-sector logbook with its captain before counting the written sectors.

**What it teaches**

- live_file_input/1 beside a changeset-backed captain input.
- Guarded function heads, with/else, and rejected captain behavior.

**Files**

| File | Role |
| --- | --- |
| [`logbook_upload_live.ex`](logbook_upload_live.ex) | Upload configuration, callbacks, and form |
| [`logbook_upload_live_test.exs`](logbook_upload_live_test.exs) | Upload workflow and rejected-input scaffolding |

Uses the feature's [shared upload helpers](../upload_helpers.ex) and the catalog's `assign_scenario/4` and `<.scenario_identity>`.

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/14-uploads/02-macau-taipa-logbook-upload](http://localhost:4000/features/14-uploads/02-macau-taipa-logbook-upload).

Use a UTF-8 .txt logbook with one sector per nonblank line. A blank captain leaves the uploaded file available for correction.

Run the scenario tests:

```sh
mix test features/14-uploads/02-macau-taipa-logbook-upload/logbook_upload_live_test.exs
```
