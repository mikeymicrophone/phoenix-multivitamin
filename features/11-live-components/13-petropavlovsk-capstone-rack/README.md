# LiveComponents · 13 · Petropavlovsk capstone rack

Clerk Yegor coordinates two Kamov Ka-27 hoist cells. One batch fills the sites. A hail lands on the parent.

**What it teaches**

- Capstone: several components, `update_many/1`, and a parent that coordinates.

**Files**

| File | Role |
| --- | --- |
| [`rack_cell.ex`](rack_cell.ex) | Batch plus hail |
| [`capstone_rack_live.ex`](capstone_rack_live.ex) | Parent last_hail |
| [`capstone_rack_live_test.exs`](capstone_rack_live_test.exs) | Avacha hails the parent |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/11-live-components/13-petropavlovsk-capstone-rack](http://localhost:4000/features/11-live-components/13-petropavlovsk-capstone-rack).

Run the test with the rest of the bottle:

```sh
mix test features/11-live-components/13-petropavlovsk-capstone-rack/capstone_rack_live_test.exs
```
