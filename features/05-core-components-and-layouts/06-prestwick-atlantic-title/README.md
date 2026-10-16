# Core components and layouts · 06 · Prestwick Atlantic title

Clerk Mhairi titles an Airbus A380 transatlantic crossing at Prestwick. The
LiveView assigns `page_title`. The root layout's `<.live_title>` owns the
suffix ` · Phoenix`.

**What it teaches**

- `page_title` is only the prefix.
- The suffix lives in the root layout.
- Retitling the assign does not move the suffix.

**Files**

| File | Role |
| --- | --- |
| [`atlantic_title_live.ex`](atlantic_title_live.ex) | page_title and a retitle click |
| [`atlantic_title_live_test.exs`](atlantic_title_live_test.exs) | Suffix on the static render |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/05-core-components-and-layouts/06-prestwick-atlantic-title](http://localhost:4000/features/05-core-components-and-layouts/06-prestwick-atlantic-title).

```sh
mix test features/05-core-components-and-layouts/06-prestwick-atlantic-title/atlantic_title_live_test.exs
```
