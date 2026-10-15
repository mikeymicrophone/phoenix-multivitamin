# LiveView lifecycle and events · 04 · Friday Harbor berth slate

Harbormaster Nell assigns packets and fish buyers at Friday Harbor.
`phx-change` previews the berth. `phx-submit` posts it onto the slate.
A second vessel on an occupied slip is refused.

**What it teaches**

- `phx-change` and `phx-submit` are different events on the same form.
  Change can validate without posting. Submit is the write.
- Submit params do not include `"_target"`. Change params do, naming the
  field that moved.
- A `type="submit"` button fires `phx-submit`. It does not need a
  `phx-click`.

**Files**

| File | Role |
| --- | --- |
| [`berth_slate_live.ex`](berth_slate_live.ex) | The LiveView: preview, submit, and occupied-slip checks |
| [`berth_slate_live_test.exs`](berth_slate_live_test.exs) | LiveViewTest for change vs submit and the refusal |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/06-liveview-lifecycle-and-events/04-friday-harbor-berth-slate](http://localhost:4000/features/06-liveview-lifecycle-and-events/04-friday-harbor-berth-slate).
Name the M/V Kirkland, post A-12, then try B-3 twice.

```sh
mix test features/06-liveview-lifecycle-and-events/04-friday-harbor-berth-slate/berth_slate_live_test.exs
```
