# Function components and HEEx · 03 · Filton Concorde labels

Isolde prints frame labels at Aerospace Bristol in Filton. G-BOAC and
F-BTSD are each a `.html.heex` file. `embed_templates/1` compiles them into
function components. Bodyless function heads declare the attrs those
templates receive.

**What it teaches**

- `embed_templates "*.html"` turns sibling HEEx files into `g_boac/1` and
  `f_btsd/1`.
- Attrs declared on a bodyless `def g_boac(assigns)` apply to the embedded
  template the same way they apply to a `~H` function.
- The LiveView chooses which label to print. Defaults fill hours and stance
  until the curator overrides them.

**Files**

| File | Role |
| --- | --- |
| [`concorde_label_live.ex`](concorde_label_live.ex) | LiveView, `embed_templates/1`, and attr heads |
| [`g_boac.html.heex`](g_boac.html.heex) | G-BOAC label markup |
| [`f_btsd.html.heex`](f_btsd.html.heex) | F-BTSD label markup |
| [`concorde_label_live_test.exs`](concorde_label_live_test.exs) | LiveViewTest for both sheets |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/03-filton-concorde-labels](http://localhost:4000/features/04-function-components-and-heex/03-filton-concorde-labels).
Print F-BTSD, then G-BOAC.

```sh
mix test features/04-function-components-and-heex/03-filton-concorde-labels/concorde_label_live_test.exs
```
