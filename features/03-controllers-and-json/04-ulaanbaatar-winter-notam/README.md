# Controllers and JSON · 04 · Ulaanbaatar winter NOTAM

Clerk Oyuna files winter ice NOTAMs at Chinggis Khaan for a Fokker 100.
A known series is JSON from the action. A missing series returns
`{:error, :not_found}` and the fallback paints 404. Exploding a runway
letter raises `ArgumentError`; the rescued clause answers 422 and the
fallback never runs.

**What it teaches**

- `action_fallback/1` handles tagged error tuples, not exceptions.
- A `rescue` clause that returns a conn short-circuits the fallback.
- `via` on the payload shows which door answered.

**Files**

| File | Role |
| --- | --- |
| [`winter_notam_live.ex`](winter_notam_live.ex) | Catalog page |
| [`winter_notam_controller.ex`](winter_notam_controller.ex) | Show and rescued explode |
| [`notam_fallback.ex`](notam_fallback.ex) | `{:error, :not_found}` |
| [`winter_notam_test.exs`](winter_notam_test.exs) | Action versus fallback versus rescue |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/03-controllers-and-json/04-ulaanbaatar-winter-notam](http://localhost:4000/features/03-controllers-and-json/04-ulaanbaatar-winter-notam).

```sh
mix test features/03-controllers-and-json/04-ulaanbaatar-winter-notam/winter_notam_test.exs
```
