# Function components and HEEx · 08 · Derby Trent heat slips

Gareth fits the Trent XWB at Rolls-Royce in Derby. A heat slip renders
stage rows. Each stage row renders an alloy chip. The chip never sees the
cell name: assigns do not leak through the call stack.

**What it teaches**

- Function components call other function components in the same module.
- Each child is invoked with explicit attrs. A chip given `label={@alloy}`
  cannot read `@heat.cell`.
- Adding a fan-case stage appends another nested row without rewriting the
  slip component.

**Files**

| File | Role |
| --- | --- |
| [`trent_heat_live.ex`](trent_heat_live.ex) | LiveView and the nested slip / row / chip |
| [`trent_heat_live_test.exs`](trent_heat_live_test.exs) | LiveViewTest for nested composition |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/08-derby-trent-heat-slips](http://localhost:4000/features/04-function-components-and-heex/08-derby-trent-heat-slips).
Add the fan-case stage.

```sh
mix test features/04-function-components-and-heex/08-derby-trent-heat-slips/trent_heat_live_test.exs
```
