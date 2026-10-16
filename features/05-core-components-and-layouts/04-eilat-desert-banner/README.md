# Core components and layouts · 04 · Eilat desert banner

Marshal Noa stamps QNH for a King Air 350 at Ramon. The QNH `<.input>`
passes its own class. Default `w-full input` classes are not inherited.
The field still posts.

**What it teaches**

- Overriding a core component class replaces the defaults.
- The custom class must fully style the input.
- The field assign still works.

**Files**

| File | Role |
| --- | --- |
| [`desert_banner_live.ex`](desert_banner_live.ex) | Overridden QNH input |
| [`desert_banner_live_test.exs`](desert_banner_live_test.exs) | Defaults gone, value still posts |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/05-core-components-and-layouts/04-eilat-desert-banner](http://localhost:4000/features/05-core-components-and-layouts/04-eilat-desert-banner).

```sh
mix test features/05-core-components-and-layouts/04-eilat-desert-banner/desert_banner_live_test.exs
```
