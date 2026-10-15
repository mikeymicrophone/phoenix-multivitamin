# Routing and plugs · 05 · Willapa seed barge office

Clerk Nadine posts seed loads at Nahcotta, where the barge Oyster Queen
carries Pacific oyster spat onto Willapa Bay. The controller declares
`plug WillapaSeedBargePlug, landing: ..., crop: ..., barge: ...`. Those
options stay in this folder. `init/1` turns the keyword list into a map;
`call/2` receives that map, not the original keyword list.

**What it teaches**

- `plug Module, opts` on a controller passes a keyword list into `init/1`.
- `init/1` may transform the options. `call/2` receives whatever `init/1`
  returned.
- Domain options belong next to the scenario, not in the shared router.

**Files**

| File | Role |
| --- | --- |
| [`seed_barge_live.ex`](seed_barge_live.ex) | Catalog page |
| [`seed_barge_plug.ex`](seed_barge_plug.ex) | init/1 to a map, call/2 assigns the landing |
| [`seed_barge_controller.ex`](seed_barge_controller.ex) | Plug options and the office action |
| [`seed_barge_html.ex`](seed_barge_html.ex) | The office board |
| [`seed_barge_test.exs`](seed_barge_test.exs) | Options on the page, and the init/1 map |

**Try it**

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/05-willapa-seed-barge-office](http://localhost:4000/features/01-routing-and-plugs/05-willapa-seed-barge-office).

```sh
mix test features/01-routing-and-plugs/05-willapa-seed-barge-office/seed_barge_test.exs
```
