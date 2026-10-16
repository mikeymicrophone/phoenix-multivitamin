# Controllers and JSON · 01 · Queenstown METAR desk

Observer Kahu posts the Queenstown METAR for a King Air 200 threading the Shotover. The paper card is a LiveView. The working desk is one controller: `show/2` renders HTML and `export/2` answers with `json/2`.

**What it teaches**

- One controller can `render/3` HTML and `json/2` a map.
- The JSON action never looks up an HTML template.
- `json/2` sets the content type and encodes the domain map.

**Files**

| File | Role |
| --- | --- |
| [`metar_desk_live.ex`](metar_desk_live.ex) | Catalog page and the two desk links |
| [`metar_desk_controller.ex`](metar_desk_controller.ex) | HTML show and JSON export |
| [`metar_desk_html.ex`](metar_desk_html.ex) | The METAR board |
| [`metar_desk_test.exs`](metar_desk_test.exs) | HTML board and JSON payload |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/03-controllers-and-json/01-queenstown-metar-desk](http://localhost:4000/features/03-controllers-and-json/01-queenstown-metar-desk).

```sh
mix test features/03-controllers-and-json/01-queenstown-metar-desk/metar_desk_test.exs
```
