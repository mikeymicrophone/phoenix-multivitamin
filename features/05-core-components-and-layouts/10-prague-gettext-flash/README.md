# Core components and layouts · 10 · Prague gettext flash

Clerk Jana posts a hold-short at Václav Havel. The flash string is
`gettext/1`. `Layouts.flash_group` already gettexts its reconnect copy
("We can't find the internet").

**What it teaches**

- Core flash copy goes through gettext.
- `put_flash/3` can carry a gettext msgid.
- The layout is what paints both.

**Files**

| File | Role |
| --- | --- |
| [`gettext_flash_live.ex`](gettext_flash_live.ex) | gettext hold-short |
| [`gettext_flash_live_test.exs`](gettext_flash_live_test.exs) | Reconnect copy and the toast |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/05-core-components-and-layouts/10-prague-gettext-flash](http://localhost:4000/features/05-core-components-and-layouts/10-prague-gettext-flash).

```sh
mix test features/05-core-components-and-layouts/10-prague-gettext-flash/gettext_flash_live_test.exs
```
