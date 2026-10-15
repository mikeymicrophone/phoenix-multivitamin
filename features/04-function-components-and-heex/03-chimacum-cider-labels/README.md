# Function components and HEEx · 03 · Chimacum cider labels

Soren prints bottle labels at Finnriver in Chimacum. Kingston Black and
Yarlington Mill are each a `.html.heex` file. `embed_templates/1` compiles
them into function components. Bodyless function heads declare the attrs
those templates receive.

**What it teaches**

- `embed_templates "*.html"` turns sibling HEEx files into `kingston_black/1`
  and `yarlington_mill/1`.
- Attrs declared on a bodyless `def kingston_black(assigns)` apply to the
  embedded template the same way they apply to a `~H` function.
- The LiveView chooses which label to print. Defaults fill bushels and
  sweetness until the cellarer overrides them.

**Files**

| File | Role |
| --- | --- |
| [`cider_label_live.ex`](cider_label_live.ex) | LiveView, `embed_templates/1`, and attr heads |
| [`kingston_black.html.heex`](kingston_black.html.heex) | Kingston Black label markup |
| [`yarlington_mill.html.heex`](yarlington_mill.html.heex) | Yarlington Mill label markup |
| [`cider_label_live_test.exs`](cider_label_live_test.exs) | LiveViewTest for both sheets |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/03-chimacum-cider-labels](http://localhost:4000/features/04-function-components-and-heex/03-chimacum-cider-labels).
Print Yarlington Mill, then Kingston Black.

```sh
mix test features/04-function-components-and-heex/03-chimacum-cider-labels/cider_label_live_test.exs
```
