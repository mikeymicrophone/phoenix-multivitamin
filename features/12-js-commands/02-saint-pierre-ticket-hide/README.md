# JS commands · 02 · Saint-Pierre ticket hide

Clerk Léonie shows and hides a Reims F406 drift ticket.

**What it teaches**

- `JS.show/1` and `JS.hide/1` target the same ticket.

**Files**

| File | Role |
| --- | --- |
| [`ticket_hide_live.ex`](ticket_hide_live.ex) | Show and hide buttons |
| [`ticket_hide_live_test.exs`](ticket_hide_live_test.exs) | Both commands name the ticket |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/12-js-commands/02-saint-pierre-ticket-hide](http://localhost:4000/features/12-js-commands/02-saint-pierre-ticket-hide).

Run the test with the rest of the bottle:

```sh
mix test features/12-js-commands/02-saint-pierre-ticket-hide/ticket_hide_live_test.exs
```
