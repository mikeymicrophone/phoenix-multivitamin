# Uploads · 06 · Harbin ice-city upload

Yun sorts Harbin wing inspection photographs into JPEG and PNG handover bundles.

**What it teaches**

- MIME accept lists populate the file input and validate entries.
- Enum.frequencies_by/2 and a map-oriented receipt pipeline.

**Files**

| File | Role |
| --- | --- |
| [`ice_city_upload_live.ex`](ice_city_upload_live.ex) | Upload configuration, callbacks, and form |
| [`ice_city_upload_live_test.exs`](ice_city_upload_live_test.exs) | Upload workflow and rejected-input scaffolding |

Uses the feature's [shared upload helpers](../upload_helpers.ex) and the catalog's `assign_scenario/4` and `<.scenario_identity>`.

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/14-uploads/06-harbin-ice-city-upload](http://localhost:4000/features/14-uploads/06-harbin-ice-city-upload).

Choose JPEG or PNG photographs. The accept list is a selection constraint, not content inspection; this sample does not decode or authenticate image bytes.

Run the scenario tests:

```sh
mix test features/14-uploads/06-harbin-ice-city-upload/ice_city_upload_live_test.exs
```
