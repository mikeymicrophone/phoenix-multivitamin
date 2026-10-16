# LiveView navigation · 11 · Labuan Bajo Komodo cell

Clerk Wayan parks a Cessna 208 at Labuan Bajo from a LiveComponent. The cell sends the stand. The parent `push_patch`es.

**What it teaches**

- A LiveComponent does not patch itself.
- The parent receives the stand and patches.

**Files**

| File | Role |
| --- | --- |
| [`komodo_cell_live.ex`](komodo_cell_live.ex) | Parent LiveView |
| [`komodo_cell.ex`](komodo_cell.ex) | Cell that sends {:open_stand, stand} |
| [`komodo_cell_live_test.exs`](komodo_cell_live_test.exs) | Rinca patch through the parent |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/07-liveview-navigation/11-labuan-bajo-komodo-cell](http://localhost:4000/features/07-liveview-navigation/11-labuan-bajo-komodo-cell).

```sh
mix test features/07-liveview-navigation/11-labuan-bajo-komodo-cell/komodo_cell_live_test.exs
```
