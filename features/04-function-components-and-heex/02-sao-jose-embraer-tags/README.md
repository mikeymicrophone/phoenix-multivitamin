# Function components and HEEx · 02 · São José Embraer tags

Caio inspects E175 skins at Embraer in São José dos Campos. The inspector
note is the default `inner_block`. Ply sizes are a named `:ply` slot with
`size` and `week` attrs. Grading is optional. The nose tag leaves the footer
off, so the card prints a fallback inspector line.

**What it teaches**

- `slot :inner_block` is the default slot: everything not in a named slot.
- Named slots (`:ply`, `:grade`, `:footer`) take attrs declared in the
  `slot/3` block. Multiple `<:ply>` entries become a list.
- `render_slot(@footer) || "No inspector noted."` uses the documented `nil`
  return when the optional slot was not passed.
- `:if={@show_grading?}` on `<:grade>` omits that entry. The component sees
  `@grade == []`, not a blank grade.

**Files**

| File | Role |
| --- | --- |
| [`embraer_tag_live.ex`](embraer_tag_live.ex) | LiveView and the `embraer_tag/1` component |
| [`embraer_tag_live_test.exs`](embraer_tag_live_test.exs) | LiveViewTest for slots, attrs, and `:if` |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/02-sao-jose-embraer-tags](http://localhost:4000/features/04-function-components-and-heex/02-sao-jose-embraer-tags).
Skip grading. Add the 3 mm ply.

```sh
mix test features/04-function-components-and-heex/02-sao-jose-embraer-tags/embraer_tag_live_test.exs
```
