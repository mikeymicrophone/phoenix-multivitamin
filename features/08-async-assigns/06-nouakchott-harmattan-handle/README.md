# Async assigns · 06 · Nouakchott harmattan handle

Clerk Mariem starts a harmattan task for a Boeing 737-500 at Nouakchott. `handle_async/3` receives the metres and `AsyncResult.ok/2` fills the assign.

**What it teaches**

- `handle_async/3` receives `{:ok, result}`.
- `AsyncResult.ok/2` is how the assign is filled by hand.

**Files**

| File | Role |
| --- | --- |
| [`harmattan_handle_live.ex`](harmattan_handle_live.ex) | start_async and handle_async |
| [`harmattan_handle_live_test.exs`](harmattan_handle_live_test.exs) | 800 metres after render_async |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/08-async-assigns/06-nouakchott-harmattan-handle](http://localhost:4000/features/08-async-assigns/06-nouakchott-harmattan-handle).

```sh
mix test features/08-async-assigns/06-nouakchott-harmattan-handle/harmattan_handle_live_test.exs
```
