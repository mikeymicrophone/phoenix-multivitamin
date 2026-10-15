# Function components and HEEx · 02 · Totten Inlet nursery tags

Nara hangs oyster seed bags at Taylor Shellfish on Totten Inlet. The
husbandry note is the default `inner_block`. Mesh sizes are a named `:mesh`
slot with `size` and `week` attrs. Grading is optional. The Olympia bag
leaves the footer off, so the tag prints a fallback hauler line.

**What it teaches**

- `slot :inner_block` is the default slot: everything not in a named slot.
- Named slots (`:mesh`, `:grade`, `:footer`) take attrs declared in the
  `slot/3` block. Multiple `<:mesh>` entries become a list.
- `render_slot(@footer) || "No hauler noted."` uses the documented `nil`
  return when the optional slot was not passed.
- `:if={@show_grading?}` on `<:grade>` omits that entry. The component sees
  `@grade == []`, not a blank grade.

**Files**

| File | Role |
| --- | --- |
| [`nursery_tag_live.ex`](nursery_tag_live.ex) | LiveView and the `nursery_tag/1` component |
| [`nursery_tag_live_test.exs`](nursery_tag_live_test.exs) | LiveViewTest for slots, attrs, and `:if` |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/02-totten-inlet-nursery-tags](http://localhost:4000/features/04-function-components-and-heex/02-totten-inlet-nursery-tags).
Skip grading. Add the 3 mm mesh.

```sh
mix test features/04-function-components-and-heex/02-totten-inlet-nursery-tags/nursery_tag_live_test.exs
```
