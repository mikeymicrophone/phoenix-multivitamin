# Controllers and JSON · 08 · Zanzibar spice-run ticket

Clerk Asha lists Let L-410 clove, cinnamon, and nutmeg tickets at Abeid
Amani Karume. `index/2` answers with `json/2` and a collection. There is
no HTML view for the list.

**What it teaches**

- A JSON index is a list of domain maps.
- `json/2` does not need a view module.
- The catalog page stays HTML; the working list is JSON.

**Files**

| File | Role |
| --- | --- |
| [`spice_run_ticket_live.ex`](spice_run_ticket_live.ex) | Catalog page |
| [`spice_run_ticket_controller.ex`](spice_run_ticket_controller.ex) | JSON index |
| [`spice_run_ticket_test.exs`](spice_run_ticket_test.exs) | Three tickets in one payload |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/03-controllers-and-json/08-zanzibar-spice-run-ticket](http://localhost:4000/features/03-controllers-and-json/08-zanzibar-spice-run-ticket).

```sh
mix test features/03-controllers-and-json/08-zanzibar-spice-run-ticket/spice_run_ticket_test.exs
```
