# JS commands · 01 · Qaarsut frost toggle

Clerk Paniloo toggles the frost drawer on a Sikorsky S-76 without a hook.

**What it teaches**

- `JS.toggle/1` targets the frost drawer.
- Entrance and exit transition tuples use `time: 200`.
- A chained `JS.toggle_attribute/2` keeps `aria-expanded` in step with the drawer.

**Files**

| File | Role |
| --- | --- |
| [`frost_toggle_live.ex`](frost_toggle_live.ex) | toggle to #frost-drawer |
| [`frost_toggle_live_test.exs`](frost_toggle_live_test.exs) | The command is on the button |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/12-js-commands/01-qaarsut-frost-toggle](http://localhost:4000/features/12-js-commands/01-qaarsut-frost-toggle).

Run the test with the rest of the bottle:

```sh
mix test features/12-js-commands/01-qaarsut-frost-toggle/frost_toggle_live_test.exs
```
