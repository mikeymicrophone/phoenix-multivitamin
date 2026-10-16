# LiveView navigation · 04 · Iqaluit medevac navigate

Clerk Aput sends a Dash 8-300 from the Iqaluit pad to the hold board with a `<.link navigate>`.

**What it teaches**

- `<.link navigate={~p}>` is the HEEx live_redirect.
- The hold board is a different LiveView.

**Files**

| File | Role |
| --- | --- |
| [`medevac_navigate_live.ex`](medevac_navigate_live.ex) | Pad and navigate link |
| [`medevac_hold_live.ex`](medevac_hold_live.ex) | Hold board |
| [`medevac_navigate_live_test.exs`](medevac_navigate_live_test.exs) | follow_redirect onto the hold |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/07-liveview-navigation/04-iqaluit-medevac-navigate](http://localhost:4000/features/07-liveview-navigation/04-iqaluit-medevac-navigate).

```sh
mix test features/07-liveview-navigation/04-iqaluit-medevac-navigate/medevac_navigate_live_test.exs
```
