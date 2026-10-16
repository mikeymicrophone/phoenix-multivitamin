# LiveView navigation · 08 · Banjul hold navigate

Clerk Fatou sends a CRJ200 to the Banjul hold stack from a button. `push_navigate/2` mounts a new LiveView.

**What it teaches**

- `push_navigate` from an event, not a link.
- Desk assigns do not travel to the stack.

**Files**

| File | Role |
| --- | --- |
| [`hold_navigate_live.ex`](hold_navigate_live.ex) | Desk and push_navigate |
| [`hold_stack_live.ex`](hold_stack_live.ex) | Stack LiveView |
| [`hold_navigate_live_test.exs`](hold_navigate_live_test.exs) | follow_redirect onto the stack |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/07-liveview-navigation/08-banjul-hold-navigate](http://localhost:4000/features/07-liveview-navigation/08-banjul-hold-navigate).

```sh
mix test features/07-liveview-navigation/08-banjul-hold-navigate/hold_navigate_live_test.exs
```
