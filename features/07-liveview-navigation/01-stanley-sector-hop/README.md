# LiveView navigation · 01 · Stanley sector hop

Clerk Kezia hops a DHC-6 Twin Otter between Stanley sectors. `push_patch/2` keeps the same process. `handle_params/3` swaps the sector wind.

**What it teaches**

- `push_patch/2` reuses the LiveView process.
- `handle_params/3` runs again after the patch.
- Mount count stays 1 while hops increment.

**Files**

| File | Role |
| --- | --- |
| [`sector_hop_live.ex`](sector_hop_live.ex) | Patch between east and west sectors |
| [`sector_hop_live_test.exs`](sector_hop_live_test.exs) | Process reuse and handle_params |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/07-liveview-navigation/01-stanley-sector-hop](http://localhost:4000/features/07-liveview-navigation/01-stanley-sector-hop).

```sh
mix test features/07-liveview-navigation/01-stanley-sector-hop/sector_hop_live_test.exs
```
