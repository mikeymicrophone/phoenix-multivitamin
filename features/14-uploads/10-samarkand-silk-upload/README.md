# Uploads · 10 · Samarkand silk upload

Madina sends Samarkand cabin inventory logs through a signed archive endpoint while LiveView tracks the external transfer.

**What it teaches**

- external presigning returns uploader metadata and a short-lived signed URL.
- External consumption receives archive metadata, not a local temporary path.

**Files**

| File | Role |
| --- | --- |
| [`silk_upload_live.ex`](silk_upload_live.ex) | Upload configuration, callbacks, and form |
| [`archive.ex`](archive.ex) | Signed capabilities and private object storage |
| [`archive_controller.ex`](archive_controller.ex) | Bounded signed PUT endpoint |
| [`silk_upload_live_test.exs`](silk_upload_live_test.exs) | Upload workflow and rejected-input scaffolding |

The [FlightArchive transport](../../../assets/js/uploaders/flight_archive.js) is registered in `assets/js/app.js`.

Uses the feature's [shared upload helpers](../upload_helpers.ex) and the catalog's `assign_scenario/4` and `<.scenario_identity>`.

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/14-uploads/10-samarkand-silk-upload](http://localhost:4000/features/14-uploads/10-samarkand-silk-upload).

The bundled FlightArchive uploader performs a real PUT to a local, signed object-store stand-in, so this runs offline without cloud credentials. LiveView carries only metadata. Tokens expire in 60 seconds; files live under the system temporary directory, not public static assets. In production, replace presigning and this endpoint with a private storage service and its lifecycle policy. The scaffold tests cover signing and HTTP acceptance; browser XHR progress and abort require a browser check.

Run the scenario tests:

```sh
mix test features/14-uploads/10-samarkand-silk-upload/silk_upload_live_test.exs
```
