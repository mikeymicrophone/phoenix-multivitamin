# LiveView lifecycle and events · 02 · Kota Kinabalu monsoon card

ATCO Farah posts the monsoon mode at Kota Kinabalu International, looking
out over the ATR 72 stands. Each button sends the mode on `phx-value-*`
attributes: two cells every 15 seconds, one cell every 10, or clear.

**What it teaches**

- `phx-click` with `phx-value-*` puts those attributes into the
  `handle_event/3` payload. `phx-value-mode="two-cells"` arrives
  as `%{"mode" => "two-cells"}`.
- Every `phx-value-*` is a string. `"15"` is not `15`. Hyphenated names such
  as `phx-value-mode` keep the hyphen out of the key because the
  suffix after `phx-value-` is the key; `mode` is the key here.
- A click with no `phx-value-*` still fires the event, with an empty map.
  Clear is the fallback.

**Files**

| File | Role |
| --- | --- |
| [`monsoon_card_live.ex`](monsoon_card_live.ex) | The LiveView: monsoon buttons and the posted card |
| [`monsoon_card_live_test.exs`](monsoon_card_live_test.exs) | LiveViewTest for string payloads and the empty map |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/06-liveview-lifecycle-and-events/02-kota-kinabalu-monsoon-card](http://localhost:4000/features/06-liveview-lifecycle-and-events/02-kota-kinabalu-monsoon-card).
Post two cells, then clear the card.

```sh
mix test features/06-liveview-lifecycle-and-events/02-kota-kinabalu-monsoon-card/monsoon_card_live_test.exs
```
