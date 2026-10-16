# Forms and changesets · 06 · Khasab fjord manifest

Clerk Thuraya logs a Let L-410 into a Musandam fjord with a select, a night-vision box, and a remarks pad.

**What it teaches**

- Core `<.input>` covers select, checkbox, and textarea from one changeset.

**Files**

| File | Role |
| --- | --- |
| [`fjord_manifest.ex`](fjord_manifest.ex) | Fjord, night vision, remarks |
| [`fjord_manifest_live.ex`](fjord_manifest_live.ex) | Three core input types |
| [`fjord_manifest_live_test.exs`](fjord_manifest_live_test.exs) | Select, checkbox, and textarea are present |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/09-forms-and-changesets/06-khasab-fjord-manifest](http://localhost:4000/features/09-forms-and-changesets/06-khasab-fjord-manifest).

Run the test with the rest of the bottle:

```sh
mix test features/09-forms-and-changesets/06-khasab-fjord-manifest/fjord_manifest_live_test.exs
```
