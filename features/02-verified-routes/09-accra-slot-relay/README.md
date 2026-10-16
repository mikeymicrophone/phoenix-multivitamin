# Verified routes · 09 · Accra slot relay

Slot clerk Kwame takes the slot watch at Accra Kotoka for the Boeing
777-300ER. Relaying the watch mails him `url(~p"/features/.../09-accra-slot-relay")`.
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
| [`slot_relay_live.ex`](slot_relay_live.ex) | The LiveView: relay button |
| [`slot_relay_mailer.ex`](slot_relay_mailer.ex) | Swoosh mailer with `url(~p)` |
| [`slot_relay_html.ex`](slot_relay_html.ex) | HEEx body for the letter |
| [`slot_relay_live_test.exs`](slot_relay_live_test.exs) | Mail body and the relay click |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/02-verified-routes/09-accra-slot-relay](http://localhost:4000/features/02-verified-routes/09-accra-slot-relay).
Relay the watch. In dev, the letter lands in `/dev/mailbox`.

```sh
mix test features/02-verified-routes/09-accra-slot-relay/slot_relay_live_test.exs
```
