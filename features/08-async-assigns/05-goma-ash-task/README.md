# Async assigns · 05 · Goma ash task

Clerk Amani starts an ash task for a Mil Mi-8 at Goma. `start_async/3` is not an assign key. `handle_async/3` writes a plain line.

**What it teaches**

- `start_async/3` for a task that is not an `assign_async` key.
- `handle_async/3` writes a plain assign.

**Files**

| File | Role |
| --- | --- |
| [`ash_task_live.ex`](ash_task_live.ex) | start_async plus handle_async |
| [`ash_task_live_test.exs`](ash_task_live_test.exs) | Nyiragongo line after render_async |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/08-async-assigns/05-goma-ash-task](http://localhost:4000/features/08-async-assigns/05-goma-ash-task).

```sh
mix test features/08-async-assigns/05-goma-ash-task/ash_task_live_test.exs
```
