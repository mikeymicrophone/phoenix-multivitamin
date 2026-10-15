# Function components and HEEx · 12 · Hoko River smolt tags

Wren tags coho smolts at Hoko Falls Hatchery. Fin-clip notes look like
markup: `<adipose-clip lot="HK-24-8">`. Interpolating the note escapes it.
Printing it raw injects a tag. The hatchery glyph is a trusted `{:safe, _}`
tuple and is not escaped.

**What it teaches**

- `{@note}` HTML-escapes `<` and quotes in the tag body.
- The same note in `data-note={@note}` is escaped inside the attribute, so a
  quote in the lot number cannot break out of the attribute.
- `raw(@note)` and `{@glyph}` when glyph is `{:safe, html}` skip escaping.
  Only trusted hatchery glyphs belong in `{:safe, _}`.

**Files**

| File | Role |
| --- | --- |
| [`smolt_tag_live.ex`](smolt_tag_live.ex) | LiveView and the `smolt_tag/1` component |
| [`smolt_tag_live_test.exs`](smolt_tag_live_test.exs) | LiveViewTest for escaped vs raw vs safe |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/12-hoko-river-smolt-tags](http://localhost:4000/features/04-function-components-and-heex/12-hoko-river-smolt-tags).
Print the note raw, then escaped.

```sh
mix test features/04-function-components-and-heex/12-hoko-river-smolt-tags/smolt_tag_live_test.exs
```
