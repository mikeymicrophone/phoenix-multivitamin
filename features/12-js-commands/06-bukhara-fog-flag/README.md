# JS commands · 06 · Bukhara fog flag

Clerk Nodira sets a fog attribute on an Antonov An-140 flag.

**What it teaches**

- `JS.set_attribute/1` writes `data-fog` on the flag.

**Files**

| File | Role |
| --- | --- |
| [`fog_flag_live.ex`](fog_flag_live.ex) | set_attribute thick |
| [`fog_flag_live_test.exs`](fog_flag_live_test.exs) | The command names data-fog |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/12-js-commands/06-bukhara-fog-flag](http://localhost:4000/features/12-js-commands/06-bukhara-fog-flag).

Run the test with the rest of the bottle:

```sh
mix test features/12-js-commands/06-bukhara-fog-flag/fog_flag_live_test.exs
```
