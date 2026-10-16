# JS commands · 12 · Grytviken exec brief

Clerk Kirsten execs a server-rendered show command on an Aerospatiale Alouette III whale-bird brief.

**What it teaches**

- `JS.exec/1` runs the command the server put in `data-open-brief`.

**Files**

| File | Role |
| --- | --- |
| [`exec_brief_live.ex`](exec_brief_live.ex) | exec data-open-brief |
| [`exec_brief_live_test.exs`](exec_brief_live_test.exs) | exec and show are both present |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/12-js-commands/12-grytviken-exec-brief](http://localhost:4000/features/12-js-commands/12-grytviken-exec-brief).

Run the test with the rest of the bottle:

```sh
mix test features/12-js-commands/12-grytviken-exec-brief/exec_brief_live_test.exs
```
