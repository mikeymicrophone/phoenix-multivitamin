# Async assigns · 13 · Balmaceda capstone desk

Clerk Pascual keeps wind and icing on a BAe 146 at Balmaceda. Wind lands. Icing fails until retry.

**What it teaches**

- Capstone: two boards, a failure, and a retry on one desk.
- Wind can succeed while icing stays failed until retry.

**Files**

| File | Role |
| --- | --- |
| [`capstone_desk_live.ex`](capstone_desk_live.ex) | Wind plus icing with retry |
| [`capstone_desk_live_test.exs`](capstone_desk_live_test.exs) | Wind stays; icing flips |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/08-async-assigns/13-balmaceda-capstone-desk](http://localhost:4000/features/08-async-assigns/13-balmaceda-capstone-desk).

```sh
mix test features/08-async-assigns/13-balmaceda-capstone-desk/capstone_desk_live_test.exs
```
