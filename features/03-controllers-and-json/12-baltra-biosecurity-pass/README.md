# Controllers and JSON · 12 · Baltra biosecurity pass

Inspector Paz stamps Avro RJ100 arrivals at Seymour. `show/2` has a
clause for a Galápagos pass (boots scrubbed, fruit refused) and a clause
for transit (boots stay on, fruit sealed). An unknown kind hits the last
clause as JSON 404.

**What it teaches**

- Multiple clauses of the same action match different params.
- Clause order matters.
- The last clause is the unknown-kind fallback.

**Files**

| File | Role |
| --- | --- |
| [`biosecurity_pass_live.ex`](biosecurity_pass_live.ex) | Catalog page |
| [`biosecurity_pass_controller.ex`](biosecurity_pass_controller.ex) | Three `show/2` clauses |
| [`biosecurity_pass_html.ex`](biosecurity_pass_html.ex) | Known-kind board |
| [`biosecurity_pass_test.exs`](biosecurity_pass_test.exs) | Galápagos, transit, unknown |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/03-controllers-and-json/12-baltra-biosecurity-pass](http://localhost:4000/features/03-controllers-and-json/12-baltra-biosecurity-pass).

```sh
mix test features/03-controllers-and-json/12-baltra-biosecurity-pass/biosecurity_pass_test.exs
```
