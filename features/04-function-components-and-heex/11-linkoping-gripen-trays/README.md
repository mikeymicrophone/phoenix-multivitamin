# Function components and HEEx · 11 · Linköping Gripen trays

Liv inspects JAS 39 Gripen trays at Saab in Linköping. `values:` lists marks
C, D, and E. Loading naval is a dynamic assign, not a literal, so the
compiler never sees it and the tray still prints.

**What it teaches**

- `attr :mark, :atom, values: [:c, :d, :e]` warns at compile time for a
  **literal** outside the list.
- A runtime assign of `:naval` is not rejected. LiveView does not validate
  `values:` at runtime.
- Calling `mark_tray/1` directly without `:mark` raises `KeyError` from
  `@mark`, not an `ArgumentError` from `attr/3`. Defaults still apply on
  that direct call.

**Files**

| File | Role |
| --- | --- |
| [`gripen_tray_live.ex`](gripen_tray_live.ex) | LiveView and the `mark_tray/1` component |
| [`gripen_tray_live_test.exs`](gripen_tray_live_test.exs) | LiveViewTest for dynamic values: and KeyError |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/11-linkoping-gripen-trays](http://localhost:4000/features/04-function-components-and-heex/11-linkoping-gripen-trays).
Load naval. The tray prints "unlisted naval".

```sh
mix test features/04-function-components-and-heex/11-linkoping-gripen-trays/gripen_tray_live_test.exs
```
