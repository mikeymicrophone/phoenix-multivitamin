# Function components and HEEx · 04 · Tekapo glider tags

Tow-pilot Miriama works Lake Tekapo with ASK-21s on the line. Each glider
tag is a function component. `:for` walks the string. `:key` is the glider
id. `:if` hides a short wait when the board is set to released gliders only.
`:let` receives the glider map from `render_slot/2`.

**What it teaches**

- `:for={glider <- @gliders}` and `:key={glider.id}` on a function component.
- `:if={@show_holding? or glider.released?}` omits a component, not just a CSS hide.
- `:let={tagged}` binds the second argument of `render_slot(@inner_block, @glider)`.
- Nested `:if` inside the slot marks a released wait versus a short one.

**Files**

| File | Role |
| --- | --- |
| [`glider_tag_live.ex`](glider_tag_live.ex) | LiveView and the `glider_tag/1` component |
| [`glider_tag_live_test.exs`](glider_tag_live_test.exs) | LiveViewTest for `:for`, `:if`, and `:let` |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/04-tekapo-glider-tags](http://localhost:4000/features/04-function-components-and-heex/04-tekapo-glider-tags).
Hide holding gliders. Pull glider 19.

```sh
mix test features/04-function-components-and-heex/04-tekapo-glider-tags/glider_tag_live_test.exs
```
