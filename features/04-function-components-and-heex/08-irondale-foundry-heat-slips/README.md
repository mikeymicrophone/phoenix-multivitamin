# Function components and HEEx · 08 · Irondale foundry heat slips

Bessa charges the east-stack cupola at the Irondale Furnace. A heat slip
renders pour rows. Each pour row renders an alloy chip. The chip never sees
the cupola name: assigns do not leak through the call stack.

**What it teaches**

- Function components call other function components in the same module.
- Each child is invoked with explicit attrs. A chip given `label={@alloy}`
  cannot read `@heat.cupola`.
- Adding a keel-block pour appends another nested row without rewriting the
  slip component.

**Files**

| File | Role |
| --- | --- |
| [`foundry_heat_live.ex`](foundry_heat_live.ex) | LiveView and the nested slip / row / chip |
| [`foundry_heat_live_test.exs`](foundry_heat_live_test.exs) | LiveViewTest for nested composition |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/08-irondale-foundry-heat-slips](http://localhost:4000/features/04-function-components-and-heex/08-irondale-foundry-heat-slips).
Add the keel-block pour.

```sh
mix test features/04-function-components-and-heex/08-irondale-foundry-heat-slips/foundry_heat_live_test.exs
```
