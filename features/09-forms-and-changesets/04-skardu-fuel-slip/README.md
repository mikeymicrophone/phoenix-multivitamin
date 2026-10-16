# Forms and changesets · 04 · Skardu fuel slip

Clerk Nazeer files litres for a Pilatus PC-24 at Skardu. A fat slip paints the error beside the litres box.

**What it teaches**

- `<.input>` renders field errors next to the litres box.

**Files**

| File | Role |
| --- | --- |
| [`fuel_slip.ex`](fuel_slip.ex) | Litres changeset |
| [`fuel_slip_live.ex`](fuel_slip_live.ex) | Errors ride with the input |
| [`fuel_slip_live_test.exs`](fuel_slip_live_test.exs) | 4000 litres is rejected beside the box |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/09-forms-and-changesets/04-skardu-fuel-slip](http://localhost:4000/features/09-forms-and-changesets/04-skardu-fuel-slip).

Run the test with the rest of the bottle:

```sh
mix test features/09-forms-and-changesets/04-skardu-fuel-slip/fuel_slip_live_test.exs
```
