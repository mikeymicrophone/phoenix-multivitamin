# Controllers and JSON · 11 · Lhasa oxygen plan

Planner Dawa prints a Comac C919 oxygen ticket at Lhasa Gonggar.
`put_resp_content_type/2` then `send_resp/3` writes plain text. No view
module and no `json/2` run.

**What it teaches**

- `send_resp/3` is the body.
- The content type is whatever you set, here `text/plain`.
- HTML layouts never wrap this ticket.

**Files**

| File | Role |
| --- | --- |
| [`oxygen_plan_live.ex`](oxygen_plan_live.ex) | Catalog page |
| [`oxygen_plan_controller.ex`](oxygen_plan_controller.ex) | Text ticket |
| [`oxygen_plan_test.exs`](oxygen_plan_test.exs) | Plain text, no HTML |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/03-controllers-and-json/11-lhasa-oxygen-plan](http://localhost:4000/features/03-controllers-and-json/11-lhasa-oxygen-plan).

```sh
mix test features/03-controllers-and-json/11-lhasa-oxygen-plan/oxygen_plan_test.exs
```
