# Routing and plugs · 10 · Ballard lock house

Keeper Soren works the two chambers at the Hiram M. Chittenden Locks, the
Ballard lock house on the Lake Washington Ship Canal. `plug BallardLockPlug,
chambers: 2` still turns the keyword list into a map in `init/1`. This app
sets `config :phoenix, :plug_init_mode, :runtime` in `config/test.exs` and
`config/dev.exs`, so `init/1` runs on every lockage under `mix test`.
Production defaults to `:compile`, where `init/1` would be captured once.

**What it teaches**

- `init/1` transforms options; `call/2` receives that map, not the keyword
  list.
- `Phoenix.plug_init_mode/0` is `:runtime` in this bottle's test and dev
  configs, so two requests get two `init/1` timestamps.
- Production defaults to `:compile`. Do not treat a passing uniqueness
  assertion in `mix test` as proof of compile-time init.

**Files**

| File | Role |
| --- | --- |
| [`lock_house_live.ex`](lock_house_live.ex) | Catalog page |
| [`lock_plug.ex`](lock_plug.ex) | init/1 compiled_at versus call/2 called_at |
| [`lock_house_controller.ex`](lock_house_controller.ex) | `plug ..., chambers: 2` |
| [`lock_house_html.ex`](lock_house_html.ex) | The lock house board |
| [`lock_house_test.exs`](lock_house_test.exs) | Same compiled_at, different called_at |

**Try it**

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/10-ballard-lock-house](http://localhost:4000/features/01-routing-and-plugs/10-ballard-lock-house).

```sh
mix test features/01-routing-and-plugs/10-ballard-lock-house/lock_house_test.exs
```
