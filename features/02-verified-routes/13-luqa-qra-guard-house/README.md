# Verified routes · 13 · Luqa QRA guard house

Guard Luca posts the board at the Luqa QRA guard house for the AW139.
The gate controller, this LiveView, the relief walk, QRA hangar passes,
the characteristic plate, `url/1`, and the mailer all cite the same `~p`
helpers.

**What it teaches**

- One board path (`board_path/0`) is the shared `~p`. The gate redirects
  to it with query params. The mailer wraps it in `url/1`. The template
  patches and navigates with it.
- `push_patch` to evening keeps the process. `push_navigate` to relief
  remounts. Issuing a QRA pass mails Luca and navigates to
  `pass_path("qra")`.
- Interpolated passes, optional query keys, a static plate, and a
  controller redirect are the earlier slots on one post.
- Named functions keep every surface honest: if the board path changes,
  the gate, the letter, and the links fail to compile together.

**Files**

| File | Role |
| --- | --- |
| [`guard_house_live.ex`](guard_house_live.ex) | Board, relief, and pass LiveView |
| [`guard_house_controller.ex`](guard_house_controller.ex) | Gate redirect onto the board |
| [`guard_house_mailer.ex`](guard_house_mailer.ex) | Letter with board and pass URLs |
| [`guard_house_html.ex`](guard_house_html.ex) | HEEx body for the letter |
| [`guard_house_live_test.exs`](guard_house_live_test.exs) | Redirect, patch, navigate, mail |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/02-verified-routes/13-luqa-qra-guard-house](http://localhost:4000/features/02-verified-routes/13-luqa-qra-guard-house).
Patch evening. Open the gate. Issue a QRA pass.

```sh
mix test features/02-verified-routes/13-luqa-qra-guard-house/guard_house_live_test.exs
```
