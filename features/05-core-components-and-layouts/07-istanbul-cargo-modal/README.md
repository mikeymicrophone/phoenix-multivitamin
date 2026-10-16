# Core components and layouts · 07 · Istanbul cargo modal

Clerk Deniz weighs a Boeing 747-400F at Istanbul Airport. Kilograms is a
core input. Confirm is a core modal. The hold note is a flash the layout
paints.

**What it teaches**

- Modal, flash, and input come from `core_components`.
- The page does not call `flash_group`.
- Confirming the modal can `put_flash/3`.

**Files**

| File | Role |
| --- | --- |
| [`cargo_modal_live.ex`](cargo_modal_live.ex) | Input, modal, and flash |
| [`cargo_modal_live_test.exs`](cargo_modal_live_test.exs) | Confirm paints the toast |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/05-core-components-and-layouts/07-istanbul-cargo-modal](http://localhost:4000/features/05-core-components-and-layouts/07-istanbul-cargo-modal).

```sh
mix test features/05-core-components-and-layouts/07-istanbul-cargo-modal/cargo_modal_live_test.exs
```
