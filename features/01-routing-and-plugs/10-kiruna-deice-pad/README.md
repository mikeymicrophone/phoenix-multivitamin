# Routing and plugs · 10 · Kiruna de-ice pad

Pad lead Astrid works the two pads at Kiruna, spraying a Boeing 737-800
on the iron-ore apron. `plug KirunaDeicePlug, pads: 2` still turns the
keyword list into a map in `init/1`. This app
sets `config :phoenix, :plug_init_mode, :runtime` in `config/test.exs` and
`config/dev.exs`, so `init/1` runs on every spray under `mix test`.
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
| [`deice_pad_live.ex`](deice_pad_live.ex) | Catalog page |
| [`deice_plug.ex`](deice_plug.ex) | init/1 compiled_at versus call/2 called_at |
| [`deice_pad_controller.ex`](deice_pad_controller.ex) | `plug ..., pads: 2` |
| [`deice_pad_html.ex`](deice_pad_html.ex) | The de-ice pad board |
| [`deice_pad_test.exs`](deice_pad_test.exs) | Two init timestamps under :runtime |

**Try it**

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/10-kiruna-deice-pad](http://localhost:4000/features/01-routing-and-plugs/10-kiruna-deice-pad).

```sh
mix test features/01-routing-and-plugs/10-kiruna-deice-pad/deice_pad_test.exs
```
