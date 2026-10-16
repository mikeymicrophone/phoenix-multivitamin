# LiveView lifecycle and events · 04 · Tivat stand slate

Clerk Ivana assigns the Global 6000 and visiting tails at Tivat.
`phx-change` previews the stand. `phx-submit` posts it onto the slate.
A second tail on an occupied stand is refused.

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
| [`stand_slate_live.ex`](stand_slate_live.ex) | The LiveView: preview, submit, and occupied-stand checks |
| [`stand_slate_live_test.exs`](stand_slate_live_test.exs) | LiveViewTest for change vs submit and the refusal |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/06-liveview-lifecycle-and-events/04-tivat-stand-slate](http://localhost:4000/features/06-liveview-lifecycle-and-events/04-tivat-stand-slate).
Name 9H-TIV, post A-12, then try B-3 twice.

```sh
mix test features/06-liveview-lifecycle-and-events/04-tivat-stand-slate/stand_slate_live_test.exs
```
