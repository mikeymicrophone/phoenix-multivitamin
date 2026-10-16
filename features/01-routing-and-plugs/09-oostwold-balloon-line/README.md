# Routing and plugs · 09 · Oostwold balloon line

Crew chief Bram holds the Cameron balloon Polder Groen off the Oostwold
meadow in Groningen. The pipeline plug `assign`s the field, the balloon, and the
crew chief — those print on the board. It `put_private`s the launch code
`polder-green` and the radio channel. Those stay off the template assigns
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
| [`balloon_line_live.ex`](balloon_line_live.ex) | Catalog page |
| [`balloon_plug.ex`](balloon_plug.ex) | Assigns the balloon; privates the launch code |
| [`balloon_line_controller.ex`](balloon_line_controller.ex) | Copies private fields for the board |
| [`balloon_line_html.ex`](balloon_line_html.ex) | Shows assigns versus copied private |
| [`balloon_line_test.exs`](balloon_line_test.exs) | Assign missing, private present |

**Try it**

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/09-oostwold-balloon-line](http://localhost:4000/features/01-routing-and-plugs/09-oostwold-balloon-line).

```sh
mix test features/01-routing-and-plugs/09-oostwold-balloon-line/balloon_line_test.exs
```
