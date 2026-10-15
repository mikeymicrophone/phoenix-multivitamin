# Function components and HEEx · 04 · Dungeness crab pot tags

Skipper Harlan works Dungeness Bay from the troller *Ceto*. Each pot tag is
a function component. `:for` walks the string. `:key` is the pot id. `:if`
hides a short soak when the board is set to legal pots only. `:let` receives
the pot map from `render_slot/2`.

**What it teaches**

- `:for={pot <- @pots}` and `:key={pot.id}` on a function component.
- `:if={@show_soaking? or pot.legal?}` omits a component, not just a CSS hide.
- `:let={tagged}` binds the second argument of `render_slot(@inner_block, @pot)`.
- Nested `:if` inside the slot marks a legal soak versus a short one.

**Files**

| File | Role |
| --- | --- |
| [`crab_pot_live.ex`](crab_pot_live.ex) | LiveView and the `pot_tag/1` component |
| [`crab_pot_live_test.exs`](crab_pot_live_test.exs) | LiveViewTest for `:for`, `:if`, and `:let` |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/04-dungeness-crab-pot-tags](http://localhost:4000/features/04-function-components-and-heex/04-dungeness-crab-pot-tags).
Hide soaking pots. Pull pot 19.

```sh
mix test features/04-function-components-and-heex/04-dungeness-crab-pot-tags/crab_pot_live_test.exs
```
