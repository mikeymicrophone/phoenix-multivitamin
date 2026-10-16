# Controllers and JSON · 06 · Dakar harmattan METAR

Observer Awa posts the harmattan METAR at Blaise Diagne for a Boeing 777-200ER
in the Sahel dust. One path sits behind `plug :accepts, ["html", "json"]`.
A browser Accept draws HTML. `Accept: application/json` draws JSON.
XML is 406.

**What it teaches**

- `get_format/1` follows the Accept header after `accepts/2`.
- HTML and JSON share one action and one path.
- An Accept outside the list is 406 before the action.

**Files**

| File | Role |
| --- | --- |
| [`harmattan_metar_live.ex`](harmattan_metar_live.ex) | Catalog page |
| [`harmattan_metar_controller.ex`](harmattan_metar_controller.ex) | Format switch in `show/2` |
| [`harmattan_metar_html.ex`](harmattan_metar_html.ex) | The haze board |
| [`harmattan_metar_test.exs`](harmattan_metar_test.exs) | HTML, JSON, and 406 |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/03-controllers-and-json/06-dakar-harmattan-metar](http://localhost:4000/features/03-controllers-and-json/06-dakar-harmattan-metar).

```sh
mix test features/03-controllers-and-json/06-dakar-harmattan-metar/harmattan_metar_test.exs
```
