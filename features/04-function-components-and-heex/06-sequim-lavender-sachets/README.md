# Function components and HEEx · 06 · Sequim lavender sachets

Mireille fills sachets at Purple Haze Lavender in Sequim. Grosso and Hidcote
Super share one component. The class attr is a list: nested lists flatten,
and `nil` / `false` entries drop. Harvest metadata is spread from a map.

**What it teaches**

- `class={[ "sachet", ["lavender", grade == :super && "super-blue"], cured? && "cured", nil, false ]}`
  keeps only the truthy binaries.
- `{@dynamic}` spreads a map of attributes onto the article. Keys may be
  atoms or strings. A `nil` value omits that attribute.
- `class={false}` still renders a `class=""` attribute. Other boolean attrs
  with `false` are omitted; `class` and `style` are the exception.

**Files**

| File | Role |
| --- | --- |
| [`lavender_sachet_live.ex`](lavender_sachet_live.ex) | LiveView and the `sachet/1` component |
| [`lavender_sachet_live_test.exs`](lavender_sachet_live_test.exs) | LiveViewTest for class lists and spreads |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/06-sequim-lavender-sachets](http://localhost:4000/features/04-function-components-and-heex/06-sequim-lavender-sachets).
Cure Grosso. Drop the aria label.

```sh
mix test features/04-function-components-and-heex/06-sequim-lavender-sachets/lavender_sachet_live_test.exs
```
