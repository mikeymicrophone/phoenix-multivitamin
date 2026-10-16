# Core components and layouts · 08 · Kathmandu breadcrumb

Dispatcher Bina walks a Harbin Y-12 onto the Tribhuvan bowl. A local
layout exposes a `:crumb` slot. The shared `Layouts.catalog` still names
no station.

**What it teaches**

- A layout slot can hold a station breadcrumb.
- Scenario names stay in the page (and this local layout), not in `layouts.ex`.
- The catalog shell still wraps the desk.

**Files**

| File | Role |
| --- | --- |
| [`breadcrumb_layout.ex`](breadcrumb_layout.ex) | Local layout with a crumb slot |
| [`breadcrumb_live.ex`](breadcrumb_live.ex) | Fills the slot |
| [`breadcrumb_live_test.exs`](breadcrumb_live_test.exs) | `#station-crumb` is present |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/05-core-components-and-layouts/08-kathmandu-breadcrumb](http://localhost:4000/features/05-core-components-and-layouts/08-kathmandu-breadcrumb).

```sh
mix test features/05-core-components-and-layouts/08-kathmandu-breadcrumb/breadcrumb_live_test.exs
```
