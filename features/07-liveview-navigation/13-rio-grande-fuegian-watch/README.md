# LiveView navigation · 13 · Rio Grande Fuegian watch

Clerk Belén patches a Beech 1900 watch at Rio Grande, then navigates to relief. Clicks survive the patch. Relief is a new process.

**What it teaches**

- Capstone: patch inside a watch, navigate to the relief board.
- Watch clicks survive a patch and die on navigate.

**Files**

| File | Role |
| --- | --- |
| [`fuegian_watch_live.ex`](fuegian_watch_live.ex) | Patch and navigate |
| [`fuegian_relief_live.ex`](fuegian_relief_live.ex) | Relief LiveView |
| [`fuegian_watch_live_test.exs`](fuegian_watch_live_test.exs) | Clicks then follow_redirect |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/07-liveview-navigation/13-rio-grande-fuegian-watch](http://localhost:4000/features/07-liveview-navigation/13-rio-grande-fuegian-watch).

```sh
mix test features/07-liveview-navigation/13-rio-grande-fuegian-watch/fuegian_watch_live_test.exs
```
