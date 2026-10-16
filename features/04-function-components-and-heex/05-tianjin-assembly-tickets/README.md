# Function components and HEEx · 05 · Tianjin assembly tickets

Wei scales A320neo wing, fuselage, and empennage joins at Airbus Final
Assembly in Tianjin. Each ticket declares `attr :rest, :global` with a
default class and `include: ~w(disabled form)` so the gate can hold a
ticket.

**What it teaches**

- `:global` rest accepts `id`, `class`, `data-*`, and `phx-*` without listing
  them. `include:` adds `disabled` and `form`.
- `default: %{class: "join-ticket"}` applies only when the caller omits
  `class`. A caller `class="rush-load"` **replaces** that default. The two
  class names are not concatenated.
- A static `class="bay-slip"` on the same tag as `{@rest}` is a second
  class attribute. The HTML parser keeps the first, so the empennage ticket
  never shows `join-ticket`.

**Files**

| File | Role |
| --- | --- |
| [`assembly_ticket_live.ex`](assembly_ticket_live.ex) | LiveView and the `join_ticket/1` component |
| [`assembly_ticket_live_test.exs`](assembly_ticket_live_test.exs) | LiveViewTest for rest, class replace, disabled |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/05-tianjin-assembly-tickets](http://localhost:4000/features/04-function-components-and-heex/05-tianjin-assembly-tickets).
Mark the wing rush. Hold the fuselage ticket.

```sh
mix test features/04-function-components-and-heex/05-tianjin-assembly-tickets/assembly_ticket_live_test.exs
```
