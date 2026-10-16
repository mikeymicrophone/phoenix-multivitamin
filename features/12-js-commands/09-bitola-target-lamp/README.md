# JS commands · 09 · Bitola target lamp

Clerk Iskra clicks a switch that lights a different Piper PA-31 Navajo lamp.

**What it teaches**

- `to:` aims the command at another element.

**Files**

| File | Role |
| --- | --- |
| [`target_lamp_live.ex`](target_lamp_live.ex) | add_class to #pelister-lamp |
| [`target_lamp_live_test.exs`](target_lamp_live_test.exs) | The button is not the target |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/12-js-commands/09-bitola-target-lamp](http://localhost:4000/features/12-js-commands/09-bitola-target-lamp).

Run the test with the rest of the bottle:

```sh
mix test features/12-js-commands/09-bitola-target-lamp/target_lamp_live_test.exs
```
