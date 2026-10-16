# LiveView navigation · 10 · Narsarsuaq parent patch

Clerk Naja walks a Dash 7 onto the east pad at Narsarsuaq, then patches back to the parent board. Same process.

**What it teaches**

- A child pad path patches back to the parent board.
- The same LiveView handles both live_actions.

**Files**

| File | Role |
| --- | --- |
| [`parent_patch_live.ex`](parent_patch_live.ex) | Board and pad live_actions |
| [`parent_patch_live_test.exs`](parent_patch_live_test.exs) | Back patch keeps the mount |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/07-liveview-navigation/10-narsarsuaq-parent-patch](http://localhost:4000/features/07-liveview-navigation/10-narsarsuaq-parent-patch).

```sh
mix test features/07-liveview-navigation/10-narsarsuaq-parent-patch/parent_patch_live_test.exs
```
