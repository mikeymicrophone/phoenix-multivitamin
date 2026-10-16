# Controllers and JSON · 13 · Punta Arenas austral load

Loadmaster Cristóbal stages a Lockheed C-130 toward Teniente Marsh and
Rothera from Carlos Ibáñez del Campo. One controller lists JSON, shows a
pallet, creates a valid load, and falls back on a missing id or a short
destination.

**What it teaches**

- Capstone: create, show, error fallback, and a JSON index together.
- `action_fallback` handles both `:not_found` and a changeset.
- HTML show and JSON index share the same domain map.

**Files**

| File | Role |
| --- | --- |
| [`austral_load_live.ex`](austral_load_live.ex) | Catalog page |
| [`austral_load_controller.ex`](austral_load_controller.ex) | Index, show, create |
| [`load_fallback.ex`](load_fallback.ex) | Missing load and invalid create |
| [`austral_load_html.ex`](austral_load_html.ex) | Teniente pallet |
| [`austral_load_test.exs`](austral_load_test.exs) | All four doors |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/03-controllers-and-json/13-punta-arenas-austral-load](http://localhost:4000/features/03-controllers-and-json/13-punta-arenas-austral-load).

```sh
mix test features/03-controllers-and-json/13-punta-arenas-austral-load/austral_load_test.exs
```
