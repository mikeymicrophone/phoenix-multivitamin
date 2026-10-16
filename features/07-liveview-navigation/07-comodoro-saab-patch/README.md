# LiveView navigation · 07 · Comodoro Saab patch

Clerk Facundo gusts a Saab 340 south at Comodoro Rivadavia from a button. The event bumps the gust count, then `push_patch/2`.

**What it teaches**

- `push_patch` from an event, not a link.
- The event can bump an assign before the patch.

**Files**

| File | Role |
| --- | --- |
| [`saab_patch_live.ex`](saab_patch_live.ex) | Event then push_patch |
| [`saab_patch_live_test.exs`](saab_patch_live_test.exs) | Gust count and south pad |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/07-liveview-navigation/07-comodoro-saab-patch](http://localhost:4000/features/07-liveview-navigation/07-comodoro-saab-patch).

```sh
mix test features/07-liveview-navigation/07-comodoro-saab-patch/saab_patch_live_test.exs
```
