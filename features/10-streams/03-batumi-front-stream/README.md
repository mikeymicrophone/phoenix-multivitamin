# Streams · 03 · Batumi front stream

Clerk Nino prepends a Caucasus wave ahead of the Yakovlev Yak-40 sea swell at Batumi.

**What it teaches**

- `stream_insert/4` with `at: 0` puts the row at the front.
- `%BatumiNotam{}` enforces its keys and implements the `String.Chars` protocol.
- `phx-value-id` supplies the identifier; `with` handles an unsuccessful lookup before insertion.

**Files**

| File | Role |
| --- | --- |
| [`notam.ex`](notam.ex) | NOTAM struct with enforced keys |
| [`notam_label.ex`](notam_label.ex) | String.Chars implementation |
| [`front_stream_live.ex`](front_stream_live.ex) | Prepend Caucasus |
| [`front_stream_live_test.exs`](front_stream_live_test.exs) | Caucasus is first |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/10-streams/03-batumi-front-stream](http://localhost:4000/features/10-streams/03-batumi-front-stream).

Run the test with the rest of the bottle:

```sh
mix test features/10-streams/03-batumi-front-stream/front_stream_live_test.exs
```
