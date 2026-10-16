# LiveView lifecycle and events · 05 · Gifu autoclave card

Tech Yuto keeps the autoclave card at Kawasaki Gifu Works. Temperature and
cure time post on `phx-blur`, when he leaves the field. Closing the vent
is a click.

**What it teaches**

- `phx-blur` fires when the field loses focus, not on every keystroke.
  `render_blur/2` in LiveViewTest is the stand-in for that focus loss.
- The blur payload is the value you pass plus any `phx-value-*` on that
  field. It is not a form change: the rest of the cure card is not sent.
- A later blur can complete a cure that an earlier blur started. Click
  events on the same view stay separate.

**Files**

| File | Role |
| --- | --- |
| [`autoclave_card_live.ex`](autoclave_card_live.ex) | The LiveView: blur readings and the vent click |
| [`autoclave_card_live_test.exs`](autoclave_card_live_test.exs) | LiveViewTest for blur vs click |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/06-liveview-lifecycle-and-events/05-gifu-autoclave-card](http://localhost:4000/features/06-liveview-lifecycle-and-events/05-gifu-autoclave-card).
Enter 242, tab off the field, then close the vent.

```sh
mix test features/06-liveview-lifecycle-and-events/05-gifu-autoclave-card/autoclave_card_live_test.exs
```
