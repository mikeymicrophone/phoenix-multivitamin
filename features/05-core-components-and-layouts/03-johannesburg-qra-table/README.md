# Core components and layouts · 03 · Johannesburg QRA table

Clerk Thandi keeps the Atlas Oryx quick-reaction table at AFB Waterkloof.
`<.table>` and `<.button>` are used as-is. Their default classes stay on
the markup.

**What it teaches**

- Core table and button work without extra classes.
- `row_id` stamps each pair.
- The scramble button is the same `<.button>` the generator ships.

**Files**

| File | Role |
| --- | --- |
| [`qra_table_live.ex`](qra_table_live.ex) | Table and scramble button |
| [`qra_table_live_test.exs`](qra_table_live_test.exs) | Default classes and the click |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/05-core-components-and-layouts/03-johannesburg-qra-table](http://localhost:4000/features/05-core-components-and-layouts/03-johannesburg-qra-table).

```sh
mix test features/05-core-components-and-layouts/03-johannesburg-qra-table/qra_table_live_test.exs
```
