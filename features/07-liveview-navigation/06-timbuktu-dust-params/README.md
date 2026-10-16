# LiveView navigation · 06 · Timbuktu dust params

Clerk Aissata posts a CASA C-212 dust lane at Timbuktu. The first `handle_params/3` is after mount. Patching to sahel is a second run.

**What it teaches**

- The first `handle_params/3` runs after mount.
- A later patch runs it again with a different via.

**Files**

| File | Role |
| --- | --- |
| [`dust_params_live.ex`](dust_params_live.ex) | params_via after mount vs patch |
| [`dust_params_live_test.exs`](dust_params_live_test.exs) | via flips on the sahel patch |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/07-liveview-navigation/06-timbuktu-dust-params](http://localhost:4000/features/07-liveview-navigation/06-timbuktu-dust-params).

```sh
mix test features/07-liveview-navigation/06-timbuktu-dust-params/dust_params_live_test.exs
```
