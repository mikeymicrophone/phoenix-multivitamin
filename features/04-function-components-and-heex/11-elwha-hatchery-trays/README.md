# Function components and HEEx · 11 · Elwha hatchery trays

Leni loads Heath trays at the Lower Elwha Hatchery. `values:` lists chinook,
coho, and steelhead. Loading chum is a dynamic assign, not a literal, so
the compiler never sees it and the tray still prints.

**What it teaches**

- `attr :species, :atom, values: [:chinook, :coho, :steelhead]` warns at
  compile time for a **literal** outside the list.
- A runtime assign of `:chum` is not rejected. LiveView does not validate
  `values:` at runtime.
- Calling `incubation_tray/1` directly without `:species` raises `KeyError`
  from `@species`, not an `ArgumentError` from `attr/3`. Defaults still
  apply on that direct call.

**Files**

| File | Role |
| --- | --- |
| [`hatchery_tray_live.ex`](hatchery_tray_live.ex) | LiveView and the `incubation_tray/1` component |
| [`hatchery_tray_live_test.exs`](hatchery_tray_live_test.exs) | LiveViewTest for dynamic values: and KeyError |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/11-elwha-hatchery-trays](http://localhost:4000/features/04-function-components-and-heex/11-elwha-hatchery-trays).
Load chum. The tray prints "unlisted chum".

```sh
mix test features/04-function-components-and-heex/11-elwha-hatchery-trays/hatchery_tray_live_test.exs
```
