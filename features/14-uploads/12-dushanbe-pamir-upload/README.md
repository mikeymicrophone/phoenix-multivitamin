# Uploads · 12 · Dushanbe Pamir upload

Farzona checks the PAMIR header inside a mountain strip report and keeps a rejected report visible for withdrawal.

**What it teaches**

- Content validation inside consume_uploaded_entries/3 returns {:postpone, receipt}.
- with/else maps read failures and bad headers to an error beside the entry.

**Files**

| File | Role |
| --- | --- |
| [`pamir_upload_live.ex`](pamir_upload_live.ex) | Upload configuration, callbacks, and form |
| [`pamir_upload_live_test.exs`](pamir_upload_live_test.exs) | Upload workflow and rejected-input scaffolding |

Uses the feature's [shared upload helpers](../upload_helpers.ex) and the catalog's `assign_scenario/4` and `<.scenario_identity>`.

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/14-uploads/12-dushanbe-pamir-upload](http://localhost:4000/features/14-uploads/12-dushanbe-pamir-upload).

Upload a UTF-8 .txt report whose first line is exactly `PAMIR` followed by a newline. A missing header postpones consumption and attaches a domain error to that entry. Withdraw it and select a corrected report; the form itself remains usable.

Run the scenario tests:

```sh
mix test features/14-uploads/12-dushanbe-pamir-upload/pamir_upload_live_test.exs
```
