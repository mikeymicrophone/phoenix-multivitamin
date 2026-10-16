# Routing and plugs · 05 · Shannon avgas office

Clerk Orla posts 100LL loads at Shannon, where bowser Avgas 1
rolls the GA apron. The controller declares
`plug ShannonAvgasPlug, apron: ..., grade: ..., bowser: ...`. Those
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
| [`avgas_live.ex`](avgas_live.ex) | Catalog page |
| [`avgas_plug.ex`](avgas_plug.ex) | init/1 to a map, call/2 assigns the apron |
| [`avgas_controller.ex`](avgas_controller.ex) | Plug options and the office action |
| [`avgas_html.ex`](avgas_html.ex) | The office board |
| [`avgas_test.exs`](avgas_test.exs) | Options on the page, and the init/1 map |

**Try it**

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/05-shannon-avgas-office](http://localhost:4000/features/01-routing-and-plugs/05-shannon-avgas-office).

```sh
mix test features/01-routing-and-plugs/05-shannon-avgas-office/avgas_test.exs
```
