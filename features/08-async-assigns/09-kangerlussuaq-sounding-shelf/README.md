# Async assigns · 09 · Kangerlussuaq sounding shelf

Clerk Malik reads the last Airbus A330-200 sounding from the Repo at Kangerlussuaq. Mount does not wait on the query.

**What it teaches**

- `assign_async` reads the Repo without blocking render.
- The dead render is loading; the row arrives after connect.

**Files**

| File | Role |
| --- | --- |
| [`sounding_shelf_live.ex`](sounding_shelf_live.ex) | Repo.one inside assign_async |
| [`sounding.ex`](sounding.ex) | KangerlussuaqSounding schema |
| [`sounding_shelf_live_test.exs`](sounding_shelf_live_test.exs) | Inserted -31 arrives after render_async |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/08-async-assigns/09-kangerlussuaq-sounding-shelf](http://localhost:4000/features/08-async-assigns/09-kangerlussuaq-sounding-shelf).

```sh
mix test features/08-async-assigns/09-kangerlussuaq-sounding-shelf/sounding_shelf_live_test.exs
```
