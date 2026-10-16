# JS commands · 08 · Trabzon dispatch bell

Clerk Aylin dispatches a chime event toward an Airbus A310 bell.

**What it teaches**

- `JS.dispatch/1` fires a custom `fuel-chime` event.

**Files**

| File | Role |
| --- | --- |
| [`dispatch_bell_live.ex`](dispatch_bell_live.ex) | dispatch to #chime-bell |
| [`dispatch_bell_live_test.exs`](dispatch_bell_live_test.exs) | The command names fuel-chime |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/12-js-commands/08-trabzon-dispatch-bell](http://localhost:4000/features/12-js-commands/08-trabzon-dispatch-bell).

Run the test with the rest of the bottle:

```sh
mix test features/12-js-commands/08-trabzon-dispatch-bell/dispatch_bell_live_test.exs
```
