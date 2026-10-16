# Core components and layouts · 09 · Oslo theme desk

Controller Ingrid keeps a Boeing 737 MAX 8 night desk at Gardermoen. The
theme toggle sits in `Layouts.catalog`. The page does not render a second
one.

**What it teaches**

- Theme chrome belongs to the layout.
- The page can stay a desk without owning the toggle.
- Tests assert the toggle is outside `#desk-surface`.

**Files**

| File | Role |
| --- | --- |
| [`theme_desk_live.ex`](theme_desk_live.ex) | Desk copy, no toggle |
| [`theme_desk_live_test.exs`](theme_desk_live_test.exs) | Toggle in the nav only |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/05-core-components-and-layouts/09-oslo-theme-desk](http://localhost:4000/features/05-core-components-and-layouts/09-oslo-theme-desk).

```sh
mix test features/05-core-components-and-layouts/09-oslo-theme-desk/theme_desk_live_test.exs
```
