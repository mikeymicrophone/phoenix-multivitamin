# Routing and plugs · 09 · La Push skiff line

Skipper Tobin holds the Quileute surf skiff Three Sisters off Rialto Beach
at La Push. The pipeline plug `assign`s the beach, the skiff, and the
skipper — those print on the board. It `put_private`s the launch code
`riptide-west` and the radio channel. Those stay off the template assigns
until the controller copies them for the test to see.

**What it teaches**

- `assign/3` writes `conn.assigns`, which become template assigns.
- `put_private/3` writes `conn.private`. A template cannot read
  `@launch_code` from that.
- The action can still read `conn.private` and copy a value if the board
  must show it.

**Files**

| File | Role |
| --- | --- |
| [`skiff_line_live.ex`](skiff_line_live.ex) | Catalog page |
| [`skiff_plug.ex`](skiff_plug.ex) | Assigns the skiff; privates the launch code |
| [`skiff_line_controller.ex`](skiff_line_controller.ex) | Copies private fields for the board |
| [`skiff_line_html.ex`](skiff_line_html.ex) | Shows assigns versus copied private |
| [`skiff_line_test.exs`](skiff_line_test.exs) | Assign missing, private present |

**Try it**

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/09-la-push-skiff-line](http://localhost:4000/features/01-routing-and-plugs/09-la-push-skiff-line).

```sh
mix test features/01-routing-and-plugs/09-la-push-skiff-line/skiff_line_test.exs
```
