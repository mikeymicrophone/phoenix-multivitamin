# Controllers and JSON · 03 · Marrakech ATIS feed

Clerk Youssef posts information Bravo at Marrakech Menara. A full info line
is 201 JSON from the action. A two-letter stub is `{:error, changeset}` —
`action_fallback` paints the 422, and the action never builds a conn.

**What it teaches**

- `action_fallback/1` runs when the action returns an error tuple.
- A valid create returns the conn; only the error tuple is delegated.
- Changeset errors become a JSON map, not an HTML 500.

**Files**

| File | Role |
| --- | --- |
| [`atis_feed_live.ex`](atis_feed_live.ex) | Catalog page |
| [`atis_feed_controller.ex`](atis_feed_controller.ex) | Show and create, with fallback |
| [`atis_fallback.ex`](atis_fallback.ex) | `call/2` for invalid ATIS |
| [`atis_feed_html.ex`](atis_feed_html.ex) | The current Bravo board |
| [`atis_feed_test.exs`](atis_feed_test.exs) | 201 versus 422 |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/03-controllers-and-json/03-marrakech-atis-feed](http://localhost:4000/features/03-controllers-and-json/03-marrakech-atis-feed).

```sh
mix test features/03-controllers-and-json/03-marrakech-atis-feed/atis_feed_test.exs
```
