# Controllers and JSON · 02 · Cusco load sheet

Loader Inti accepts a Boeing 737-700 load sheet at Alejandro Velasco Astete, where density altitude sits above 11,000 ft. The controller answers with `put_status(:created)` and `json/2` — the body is the sheet, the status is 201.

**What it teaches**

- `json/2` encodes a domain map.
- `put_status/2` before `json/2` is the HTTP status the client sees.
- 201 Created is not implied by `json/2` alone; the default is 200.

**Files**

| File | Role |
| --- | --- |
| [`load_sheet_live.ex`](load_sheet_live.ex) | Catalog page |
| [`load_sheet_controller.ex`](load_sheet_controller.ex) | Accepted JSON load sheet |
| [`load_sheet_test.exs`](load_sheet_test.exs) | Asserts 201 and the sheet fields |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/03-controllers-and-json/02-cusco-load-sheet](http://localhost:4000/features/03-controllers-and-json/02-cusco-load-sheet).

```sh
mix test features/03-controllers-and-json/02-cusco-load-sheet/load_sheet_test.exs
```
