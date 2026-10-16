# Controllers and JSON · 09 · Malé atoll slot list

Clerk Mariyam looks up Airbus A321 water slots at Velana. Hulhulé 14 is
JSON. A missing id is `put_status(:not_found)` then `json/2` — an error
map, not ErrorHTML's plain "Not Found" page.

**What it teaches**

- A 404 can be a JSON error map.
- That body is not the HTML error page.
- `json_response/2` reads the map; the resp body is not `"Not Found"`.

**Files**

| File | Role |
| --- | --- |
| [`atoll_slot_list_live.ex`](atoll_slot_list_live.ex) | Catalog page |
| [`atoll_slot_list_controller.ex`](atoll_slot_list_controller.ex) | Known slot and JSON 404 |
| [`atoll_slot_list_test.exs`](atoll_slot_list_test.exs) | 200 map versus 404 map |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/03-controllers-and-json/09-male-atoll-slot-list](http://localhost:4000/features/03-controllers-and-json/09-male-atoll-slot-list).

```sh
mix test features/03-controllers-and-json/09-male-atoll-slot-list/atoll_slot_list_test.exs
```
