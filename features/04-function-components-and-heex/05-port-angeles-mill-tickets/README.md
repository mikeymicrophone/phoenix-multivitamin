# Function components and HEEx · 05 · Port Angeles mill tickets

Edie scales Western hemlock and Douglas-fir at Interfor in Port Angeles.
Each ticket declares `attr :rest, :global` with a default class and
`include: ~w(disabled form)` so the gate can hold a ticket.

**What it teaches**

- `:global` rest accepts `id`, `class`, `data-*`, and `phx-*` without listing
  them. `include:` adds `disabled` and `form`.
- `default: %{class: "mill-ticket"}` applies only when the caller omits
  `class`. A caller `class="rush-load"` **replaces** that default. The two
  class names are not concatenated.
- A static `class="scale-slip"` on the same tag as `{@rest}` is a second
  class attribute. The HTML parser keeps the first, so the cedar ticket
  never shows `mill-ticket`.

**Files**

| File | Role |
| --- | --- |
| [`mill_ticket_live.ex`](mill_ticket_live.ex) | LiveView and the `mill_ticket/1` component |
| [`mill_ticket_live_test.exs`](mill_ticket_live_test.exs) | LiveViewTest for rest, class replace, disabled |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/05-port-angeles-mill-tickets](http://localhost:4000/features/04-function-components-and-heex/05-port-angeles-mill-tickets).
Mark the hemlock rush. Hold the fir ticket.

```sh
mix test features/04-function-components-and-heex/05-port-angeles-mill-tickets/mill_ticket_live_test.exs
```
