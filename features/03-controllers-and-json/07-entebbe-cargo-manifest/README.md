# Controllers and JSON · 07 · Entebbe cargo manifest

Clerk Kato files an Ilyushin Il-76 relief pallet at Entebbe toward Brussels.
`create/2` redirects to the show path. It does not render a "created"
template. The test follows `redirected_to/1`.

**What it teaches**

- A successful write redirects rather than rendering create.
- `redirect/2` is the response; the show action paints the pallet later.
- `redirected_to/1` is the verified show path.

**Files**

| File | Role |
| --- | --- |
| [`cargo_manifest_live.ex`](cargo_manifest_live.ex) | Catalog page |
| [`cargo_manifest_controller.ex`](cargo_manifest_controller.ex) | new, create, show |
| [`cargo_manifest_html.ex`](cargo_manifest_html.ex) | File form and pallet board |
| [`cargo_manifest_test.exs`](cargo_manifest_test.exs) | Redirect then show |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/03-controllers-and-json/07-entebbe-cargo-manifest](http://localhost:4000/features/03-controllers-and-json/07-entebbe-cargo-manifest).

```sh
mix test features/03-controllers-and-json/07-entebbe-cargo-manifest/cargo_manifest_test.exs
```
