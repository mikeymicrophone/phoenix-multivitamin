# JS commands · 07 · Sinop focus pad

Clerk Elif focuses the Cessna Citation CJ3 slot box, then the first pad field.

**What it teaches**

- `JS.focus/1` and `JS.focus_first/1` take a `to:` selector.

**Files**

| File | Role |
| --- | --- |
| [`focus_pad_live.ex`](focus_pad_live.ex) | Two focus buttons |
| [`focus_pad_live_test.exs`](focus_pad_live_test.exs) | Both commands are present |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/12-js-commands/07-sinop-focus-pad](http://localhost:4000/features/12-js-commands/07-sinop-focus-pad).

Run the test with the rest of the bottle:

```sh
mix test features/12-js-commands/07-sinop-focus-pad/focus_pad_live_test.exs
```
