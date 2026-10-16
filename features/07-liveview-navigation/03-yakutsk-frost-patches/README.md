# LiveView navigation · 03 · Yakutsk frost patches

Clerk Sardaana patches a Sukhoi Superjet 100 between Yakutsk frost stands with a `<.link patch>` in HEEx.

**What it teaches**

- `<.link patch={~p}>` is the HEEx live_patch.
- The process stays; `handle_params/3` reads the stand.

**Files**

| File | Role |
| --- | --- |
| [`frost_patches_live.ex`](frost_patches_live.ex) | Patch link between stands |
| [`frost_patches_live_test.exs`](frost_patches_live_test.exs) | assert_patch keeps the mount |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/07-liveview-navigation/03-yakutsk-frost-patches](http://localhost:4000/features/07-liveview-navigation/03-yakutsk-frost-patches).

```sh
mix test features/07-liveview-navigation/03-yakutsk-frost-patches/frost_patches_live_test.exs
```
