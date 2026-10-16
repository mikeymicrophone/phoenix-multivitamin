# Core components and layouts · 05 · Oaxaca bare plate

Printer Itzel stamps a Cessna 182 plate at Xoxocotlán. The LiveView
renders a bare `<main>`. It does not call `Layouts.app` or
`Layouts.catalog`. The root layout still supplies `<html>`, the title,
and the asset tags.

**What it teaches**

- Inner layouts are optional.
- Skipping them skips the catalog shell and the app navbar.
- The root layout still wraps the document.

**Files**

| File | Role |
| --- | --- |
| [`bare_plate_live.ex`](bare_plate_live.ex) | Bare main, no inner layout |
| [`bare_plate_live_test.exs`](bare_plate_live_test.exs) | No catalog-shell, still `<html>` |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/05-core-components-and-layouts/05-oaxaca-bare-plate](http://localhost:4000/features/05-core-components-and-layouts/05-oaxaca-bare-plate).

```sh
mix test features/05-core-components-and-layouts/05-oaxaca-bare-plate/bare_plate_live_test.exs
```
