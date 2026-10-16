# Core components and layouts · 13 · Copenhagen capstone desk

Clerk Freja keeps the Kastrup stand desk for an Airbus A220-300. One
board uses the catalog layout, a core table, a modal, and a flash.

**What it teaches**

- Capstone: layout, flash, core table, and a modal on one desk.
- The page still does not call `flash_group`.
- Confirming the modal is enough to toast.

**Files**

| File | Role |
| --- | --- |
| [`capstone_desk_live.ex`](capstone_desk_live.ex) | Table, modal, flash |
| [`capstone_desk_live_test.exs`](capstone_desk_live_test.exs) | All four pieces |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/05-core-components-and-layouts/13-copenhagen-capstone-desk](http://localhost:4000/features/05-core-components-and-layouts/13-copenhagen-capstone-desk).

```sh
mix test features/05-core-components-and-layouts/13-copenhagen-capstone-desk/capstone_desk_live_test.exs
```
