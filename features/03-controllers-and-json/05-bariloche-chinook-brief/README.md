# Controllers and JSON · 05 · Bariloche Chinook brief

Officer Sofía accepts a CH-47 Chinook mountain brief at San Carlos de
Bariloche, threading the Catedral saddle. The controller calls
`put_status(:accepted)` and then `render/3`. The client sees 202 and the
brief body together.

**What it teaches**

- `put_status/2` then `render/3` still sends a body.
- 202 Accepted is not an empty response.
- Status and template are independent.

**Files**

| File | Role |
| --- | --- |
| [`chinook_brief_live.ex`](chinook_brief_live.ex) | Catalog page |
| [`chinook_brief_controller.ex`](chinook_brief_controller.ex) | 202 then the brief |
| [`chinook_brief_html.ex`](chinook_brief_html.ex) | The accepted brief |
| [`chinook_brief_test.exs`](chinook_brief_test.exs) | Asserts 202 and the body |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/03-controllers-and-json/05-bariloche-chinook-brief](http://localhost:4000/features/03-controllers-and-json/05-bariloche-chinook-brief).

```sh
mix test features/03-controllers-and-json/05-bariloche-chinook-brief/chinook_brief_test.exs
```
