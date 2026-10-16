# Function components and HEEx · 12 · Woomera telemetry tags

Darcy tags Black Brant sounding rockets at Woomera. Range-stamp notes look
like markup: `<range-stamp lot="WO-24-8">`. Interpolating the note escapes
it. Printing it raw injects a tag. The range glyph is a trusted `{:safe, _}`
tuple and is not escaped.

**What it teaches**

- `{@note}` HTML-escapes `<` and quotes in the tag body.
- The same note in `data-note={@note}` is escaped inside the attribute, so a
  quote in the lot number cannot break out of the attribute.
- `raw(@note)` and `{@glyph}` when glyph is `{:safe, html}` skip escaping.
  Only trusted range glyphs belong in `{:safe, _}`.

**Files**

| File | Role |
| --- | --- |
| [`telemetry_tag_live.ex`](telemetry_tag_live.ex) | LiveView and the `telemetry_tag/1` component |
| [`telemetry_tag_live_test.exs`](telemetry_tag_live_test.exs) | LiveViewTest for escaped vs raw vs safe |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/12-woomera-telemetry-tags](http://localhost:4000/features/04-function-components-and-heex/12-woomera-telemetry-tags).
Print the note raw, then escaped.

```sh
mix test features/04-function-components-and-heex/12-woomera-telemetry-tags/telemetry_tag_live_test.exs
```
