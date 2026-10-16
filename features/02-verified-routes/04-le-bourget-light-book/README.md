# Verified routes · 04 · Le Bourget light book

Archivist Colette copies the characteristic plate for the Blériot XI at
the Le Bourget archive. The plate, the archive favicon, and `robots.txt`
are static `~p` paths — they match `static_paths/0`, not a router route.

**What it teaches**

- `~p"/images/logo.svg"` is verified as a static prefix. Phoenix then
  calls `Endpoint.static_path/1`, not the router.
- Without `mix phx.digest`, `static_path` equals the logical path and
  `static_integrity/2` is `nil`. A digest would rewrite the filename.
- A missing file under `/images` does **not** warn as `no route path`.
  The statics prefix short-circuits router verification.
- `favicon.ico` and `robots.txt` are listed in `static_paths/0`, so `~p`
  accepts them as static files.

**Files**

| File | Role |
| --- | --- |
| [`light_book_live.ex`](light_book_live.ex) | The LiveView: plate, favicon, robots, integrity |
| [`light_book_live_test.exs`](light_book_live_test.exs) | Static ~p, missing-file compile, and the page |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/02-verified-routes/04-le-bourget-light-book](http://localhost:4000/features/02-verified-routes/04-le-bourget-light-book).
The characteristic plate is the catalog logo served through `~p`.

```sh
mix test features/02-verified-routes/04-le-bourget-light-book/light_book_live_test.exs
```
