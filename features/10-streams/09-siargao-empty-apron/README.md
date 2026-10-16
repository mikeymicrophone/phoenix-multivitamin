# Streams · 09 · Siargao empty apron

Clerk Ligaya opens an empty Quest Kodiak 100 apron at Siargao until Cloud 9 parks.

**What it teaches**

- A `hidden only:block` empty state sits beside the stream for-comprehension.

**Files**

| File | Role |
| --- | --- |
| [`empty_apron_live.ex`](empty_apron_live.ex) | Empty stream then insert |
| [`empty_apron_live_test.exs`](empty_apron_live_test.exs) | Cloud 9 fills the apron |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/10-streams/09-siargao-empty-apron](http://localhost:4000/features/10-streams/09-siargao-empty-apron).

Run the test with the rest of the bottle:

```sh
mix test features/10-streams/09-siargao-empty-apron/empty_apron_live_test.exs
```
