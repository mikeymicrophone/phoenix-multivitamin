# JS commands · 11 · Ittoqqortoormiit ignore

Clerk Aputsiaq keeps the icing dialog open on a Bell 412 through a patch by ignoring the open attribute.

**What it teaches**

- `JS.ignore_attributes/1` keeps `open` off the next patch.

**Files**

| File | Role |
| --- | --- |
| [`ignore_live.ex`](ignore_live.ex) | phx-mounted ignore open |
| [`ignore_live_test.exs`](ignore_live_test.exs) | A tick keeps the dialog |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/12-js-commands/11-ittoqqortoormiit-ignore](http://localhost:4000/features/12-js-commands/11-ittoqqortoormiit-ignore).

Run the test with the rest of the bottle:

```sh
mix test features/12-js-commands/11-ittoqqortoormiit-ignore/ignore_live_test.exs
```
