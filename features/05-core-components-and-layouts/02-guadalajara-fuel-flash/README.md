# Core components and layouts · 02 · Guadalajara fuel flash

Bowser Luz posts Jet A-1 at Miguel Hidalgo. The page calls `put_flash/3`.
`Layouts.catalog` is the only place that renders `<.flash_group>`. The
page never draws the toast itself.

**What it teaches**

- Flash messages travel through the layout.
- `put_flash/3` is enough; the page does not call `flash_group`.
- Info and error kinds share that group.

**Files**

| File | Role |
| --- | --- |
| [`fuel_flash_live.ex`](fuel_flash_live.ex) | Bowser buttons and put_flash |
| [`fuel_flash_live_test.exs`](fuel_flash_live_test.exs) | Info and error toasts |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/05-core-components-and-layouts/02-guadalajara-fuel-flash](http://localhost:4000/features/05-core-components-and-layouts/02-guadalajara-fuel-flash).

```sh
mix test features/05-core-components-and-layouts/02-guadalajara-fuel-flash/fuel_flash_live_test.exs
```
