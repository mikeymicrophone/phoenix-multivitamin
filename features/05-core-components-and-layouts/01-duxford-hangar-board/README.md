# Core components and layouts · 01 · Duxford hangar board

Curator Gwendolen hangs a Hawker Hurricane at IWM Duxford. The catalog
card uses `Layouts.catalog`. The hangar path is the same LiveView with
`live_action: :app`, wrapped in `Layouts.app`. The root layout still owns
the HTML shell.

**What it teaches**

- The root layout is the HTML document.
- `Layouts.catalog` and `Layouts.app` are inner layouts you invoke.
- `live_action` can pick which inner layout wraps the page.

**Files**

| File | Role |
| --- | --- |
| [`hangar_board_live.ex`](hangar_board_live.ex) | Catalog card and app hangar |
| [`hangar_board_live_test.exs`](hangar_board_live_test.exs) | Catalog chrome versus app chrome |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/05-core-components-and-layouts/01-duxford-hangar-board](http://localhost:4000/features/05-core-components-and-layouts/01-duxford-hangar-board).

```sh
mix test features/05-core-components-and-layouts/01-duxford-hangar-board/hangar_board_live_test.exs
```
