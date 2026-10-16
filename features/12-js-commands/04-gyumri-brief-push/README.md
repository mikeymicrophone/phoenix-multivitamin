# JS commands · 04 · Gyumri brief push

Clerk Ani opens an Ilyushin Il-62 brief on the client and pushes the log to the server.

**What it teaches**

- `JS.show/1` pipes into `JS.push/1` on one click.
- `JS.push` sends a stand in `value:`, selects the owning LiveView with `target:`, and locks the loading button.
- The event head matches the payload and guards the Shirak stand.

**Files**

| File | Role |
| --- | --- |
| [`brief_push_live.ex`](brief_push_live.ex) | show then push |
| [`brief_push_live_test.exs`](brief_push_live_test.exs) | The server logs Shirak wave |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/12-js-commands/04-gyumri-brief-push](http://localhost:4000/features/12-js-commands/04-gyumri-brief-push).

Run the test with the rest of the bottle:

```sh
mix test features/12-js-commands/04-gyumri-brief-push/brief_push_live_test.exs
```
