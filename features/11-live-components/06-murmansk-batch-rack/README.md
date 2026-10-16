# LiveComponents · 06 · Murmansk batch rack

Clerk Lyudmila loads three Tupolev Tu-154 QNH cells in one update_many/1.

**What it teaches**

- `update_many/1` is the batch callback.
- `preload/1` is gone in LiveView 1.2.

**Files**

| File | Role |
| --- | --- |
| [`batch_cell.ex`](batch_cell.ex) | One batch of three readings |
| [`batch_rack_live.ex`](batch_rack_live.ex) | Three pads on one rack |
| [`batch_rack_live_test.exs`](batch_rack_live_test.exs) | Each cell reports batch size 3 |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/11-live-components/06-murmansk-batch-rack](http://localhost:4000/features/11-live-components/06-murmansk-batch-rack).

Run the test with the rest of the bottle:

```sh
mix test features/11-live-components/06-murmansk-batch-rack/batch_rack_live_test.exs
```
