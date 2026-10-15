# Verified routes · 09 · Point Robinson bell relay

Keeper Leda takes the bell watch at Point Robinson Light on Maury Island.
Relaying the watch mails her `url(~p"/features/.../09-point-robinson-bell-relay")`.
The LiveView and the mailer share that one path.

**What it teaches**

- A mailer has no `%Plug.Conn{}`. `use Phoenix.VerifiedRoutes` still lets
  it call `url(~p"/path")`, which reads the endpoint host.
- Email needs a URL, not a path. `~p` alone would be `/features/...`,
  which is not clickable off the box.
- The HEEx mail body interpolates `{@board_url}` onto an `<a href>`. The
  same string appears in the text part.
- Delivering from a LiveView event uses that shared helper, so the board
  and the letter cannot drift apart.

**Files**

| File | Role |
| --- | --- |
| [`bell_relay_live.ex`](bell_relay_live.ex) | The LiveView: relay button |
| [`bell_relay_mailer.ex`](bell_relay_mailer.ex) | Swoosh mailer with `url(~p)` |
| [`bell_relay_html.ex`](bell_relay_html.ex) | HEEx body for the letter |
| [`bell_relay_live_test.exs`](bell_relay_live_test.exs) | Mail body and the relay click |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/02-verified-routes/09-point-robinson-bell-relay](http://localhost:4000/features/02-verified-routes/09-point-robinson-bell-relay).
Relay the watch. In dev, the letter lands in `/dev/mailbox`.

```sh
mix test features/02-verified-routes/09-point-robinson-bell-relay/bell_relay_live_test.exs
```
