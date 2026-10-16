# Function components and HEEx · 06 · Cranfield SAF sachets

Iona fills fuel-sample sachets at the Cranfield SAF lab. HEFA and FT share
one component. Alcohol-to-jet is the blank-class sheet. The class attr is a
list: nested lists flatten, and `nil` / `false` entries drop. Sample
metadata is spread from a map.

**What it teaches**

- `class={[ "sachet", ["saf", grade == :drop_in && "drop-in"], certified? && "certified", nil, false ]}`
  keeps only the truthy binaries.
- `{@dynamic}` spreads a map of attributes onto the article. Keys may be
  atoms or strings. A `nil` value omits that attribute.
- `class={false}` still renders a `class=""` attribute. Other boolean attrs
  with `false` are omitted; `class` and `style` are the exception.

**Files**

| File | Role |
| --- | --- |
| [`saf_sachet_live.ex`](saf_sachet_live.ex) | LiveView and the `sachet/1` component |
| [`saf_sachet_live_test.exs`](saf_sachet_live_test.exs) | LiveViewTest for class lists and spreads |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/06-cranfield-saf-sachets](http://localhost:4000/features/04-function-components-and-heex/06-cranfield-saf-sachets).
Certify HEFA. Drop the aria label.

```sh
mix test features/04-function-components-and-heex/06-cranfield-saf-sachets/saf_sachet_live_test.exs
```
